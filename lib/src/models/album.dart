import 'image.dart';

class Album {
  String? name;
  String? artist;
  String? url;
  List<Image> image = <Image>[];

  static String method = "album.search";

  Album();

  Album.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'] ?? "";
      url = jsonMap['url'] ?? "";
      artist = jsonMap['artist'] ?? "";
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
    map["url"] = url;
    map["image"] = image.map((element) => element.toMap()).toList();
    return map;
  }
}
