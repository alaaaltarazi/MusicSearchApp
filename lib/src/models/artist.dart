import 'image.dart';

class Artist {
  String? name;
  int? listeners;
  String? mbid;
  String? url;
  int? streamable;
  List<Image> image = <Image>[];

  static String method = "artist.search";

  Artist();

  Artist.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'] ?? "";
      listeners =
          jsonMap['listeners'] == null ? 0 : int.parse(jsonMap['listeners']);
      streamable =
          jsonMap['streamable'] == null ? 0 : int.parse(jsonMap['streamable']);
      mbid = jsonMap['mbid'] ?? "";
      url = jsonMap['url'] ?? "";
      image = jsonMap['image'] != null
          ? List.from(jsonMap['image'])
              .map((element) => Image.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["listeners"] = listeners;
    map["streamable"] = streamable;
    map["mbid"] = mbid;
    map["url"] = url;
    map["image"] = image.map((element) => element.toMap()).toList();
    return map;
  }
}
