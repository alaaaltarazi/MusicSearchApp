import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:music_search_app/src/models/artist.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/album.dart';
import '../repository/album_repository.dart';
import '../repository/artist_repository.dart';

class SongController extends ControllerMVC {
  List<Artist> artists = <Artist>[];
  List<Album> albums = <Album>[];
  String? searchType = "album";
  String searchWord = "";
  int pageNumber = 1;

  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 1);

  GlobalKey<ScaffoldState>? scaffoldKey;

  SongController() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  searchUpdated(String searchQuery) {
    setState(() {
      searchWord = searchQuery;
      pagingController.refresh();
    });
  }

  void listenForAlbums(String searchQuery, int page, int limit) async {
    albums.clear();
    final Stream<Album> stream = await getByAlbum(searchQuery, page, limit);
    stream.listen((Album _album) {
      setState(() => albums.add(_album));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      setState(() {
        final isLastPage = albums.length < 10;
        if (isLastPage) {
          pagingController.appendLastPage(albums);
        } else {
          final nextPageKey = pageNumber + albums.length;
          pagingController.appendPage(albums, nextPageKey);
        }
      });
    });
  }

  void listenForArtist(String searchQuery, int page, int limit) async {
    artists.clear();

    final Stream<Artist> stream = await getByArtist(searchQuery, page, limit);
    stream.listen((Artist _artist) {
      artists.add(_artist);
    }, onError: (a) {
      print(a);
    }, onDone: () {
      setState(() {
        final isLastPage = artists.length < 10;
        if (isLastPage) {
          pagingController.appendLastPage(artists);
        } else {
          final nextPageKey = pageNumber + artists.length;
          pagingController.appendPage(artists, nextPageKey);
        }
      });
    });
  }

  void changeSearchType(String value) {
    setState(() {
      searchType = value.toString();
      if (searchType == "artist")
        artists.clear();
      else
        albums.clear();
      pageNumber = 1;
      pagingController.refresh();
    });
  }

  void initData() {
    pagingController.addPageRequestListener((pageKey) {
      pageNumber = pageKey;
      if (searchType == "artist")
        listenForArtist(searchWord, pageKey, 10);
      else
        listenForAlbums(searchWord, pageKey, 10);
    });
  }
}
