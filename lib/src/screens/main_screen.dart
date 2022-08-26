import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/song_controller.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends StateMVC<MainScreen> {
  SongController _controller = SongController();

  _MainScreenState() : super(SongController()) {
    _controller = controller as SongController;
  }

  @override
  void initState() {
    _controller.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
              ),
              onSubmitted: (data) {
                _controller.searchUpdated(data);
              },
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: "album",
                    groupValue: _controller.searchType,
                    onChanged: (value) {
                      _controller.changeSearchType(value.toString());
                    },
                  ),
                  Text(
                    'Search by Album',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: "artist",
                    groupValue: _controller.searchType,
                    onChanged: (value) {
                      _controller.changeSearchType(value.toString());
                    },
                  ),
                  Text(
                    'Search by Artist',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
              child: Container(
                  child: _controller.searchType == "artist"
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          child: PagedListView<int, dynamic>(
                            pagingController: _controller.pagingController,
                            builderDelegate: PagedChildBuilderDelegate<dynamic>(
                              itemBuilder: (context, item, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/ArtistDetails',
                                        arguments: item);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(item.image[0].text)),
                                      title: Text(item.name),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ))
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          child: PagedListView<int, dynamic>(
                            pagingController: _controller.pagingController,
                            builderDelegate: PagedChildBuilderDelegate<dynamic>(
                              itemBuilder: (context, item, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/AlbumDetails',
                                        arguments: item);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(item.image[0].text)),
                                      title: Text(item.name),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ))))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.pagingController.dispose();
    super.dispose();
  }
}
