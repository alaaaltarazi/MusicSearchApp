import 'package:global_configuration/global_configuration.dart';

class Helper {
  static getArtistData(Map<String, dynamic> data) {
    return data['results']['artistmatches']['artist'] ?? [];
  }

  static getAlbumData(Map<String, dynamic> data) {
    return data['results']['albummatches']['album'] ?? [];
  }

  static Uri getUri(String path) {
    Uri uri = Uri(
        scheme: Uri.parse(path).scheme,
        host: Uri.parse(path).host,
        port: Uri.parse(path).port,
        path: GlobalConfiguration().getValue('api_base_path'));

    return uri;
  }
}
