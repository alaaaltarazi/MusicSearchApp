class Image {

  String text = "";
  String size = "";

  Image.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      text = jsonMap['#text'] ?? "";
      size = jsonMap['size'] ?? "";
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map =  Map<String, dynamic>();
    map["text"] = text;
    map["size"] = size;
    return map;
  }
}
