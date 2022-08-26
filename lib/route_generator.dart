import 'package:flutter/material.dart';
import 'package:music_search_app/src/models/album.dart';
import 'package:music_search_app/src/models/artist.dart';
import 'package:music_search_app/src/screens/main_screen.dart';
import 'package:music_search_app/src/widgets/album_list_widget.dart';
import 'package:music_search_app/src/widgets/artist_list_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/mainScreen':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case '/ArtistDetails':
        return MaterialPageRoute(
            builder: (_) => ArtistListWidget(artist: args as Artist));
      case '/AlbumDetails':
        return MaterialPageRoute(
            builder: (_) => AlbumListWidget(album: args as Album));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
