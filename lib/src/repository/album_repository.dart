import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../helpers/helper.dart';
import '../models/album.dart';

Future<Stream<Album>> getByAlbum(
    String searchQuery, int page, int limit) async {
  Uri uri = Helper.getUri('${GlobalConfiguration().getValue('api_base_url')}');

  Map<String, dynamic> _queryParams = {};
  _queryParams['limit'] = limit.toString();
  _queryParams['page'] = page.toString();
  _queryParams['album'] = searchQuery;
  _queryParams['api_key'] = '${GlobalConfiguration().getValue('api_key')}';
  _queryParams['method'] = Album.method;
  _queryParams['format'] = "json";

  uri = uri.replace(queryParameters: _queryParams);

  final client = http.Client();
  final streamedRest = await client.send(http.Request('get', uri));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getAlbumData(data as Map<String, dynamic>))
      .expand((data) => (data as List))
      .map((data) {
    return Album.fromJSON(data);
  });
}
