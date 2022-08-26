import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/artist.dart';

class ArtistListWidget extends StatefulWidget {
  Artist artist = Artist();

  ArtistListWidget({required this.artist});

  @override
  _ArtistListWidgetsState createState() => _ArtistListWidgetsState();
}

class _ArtistListWidgetsState extends State<ArtistListWidget> {
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
          children: [
            Image(
              image: NetworkImage(widget.artist.image[4].text),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Artist: " + (widget.artist.name ?? ""),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Column(
                  children: [
                    Text("listeners",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.artist.listeners.toString()),
                  ],
                )
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunch(widget.artist.url))
                  await launch(widget.artist.url);
              },
              child: Text('Artist web page'),
            )
          ],
        ),
      ),
    );
  }
}
