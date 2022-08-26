import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/album.dart';

class AlbumListWidget extends StatefulWidget {
  Album album = new Album();

  AlbumListWidget({required this.album});

  @override
  _AlbumListWidgetsState createState() => _AlbumListWidgetsState();
}

class _AlbumListWidgetsState extends State<AlbumListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: NetworkImage(widget.album.image[3].text),
            ),
            const Divider(),
            Text("Album",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(
              (widget.album.name ?? ""),
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
            const Divider(),
            Text("Artist",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(
              (widget.album.artist.toString()),
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunch(widget.album.url))
                  await launch(widget.album.url);
              },
              child: Text('Album web page'),
            )
          ],
        ),
      ),
    );
  }
}
