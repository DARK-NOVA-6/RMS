import 'package:http/http.dart' as http;

import 'encode_uri.dart';

class DetectUriApi {
  Future<String> get uriApi async => '${await _getUriApi()}api';
  String? _uriApi;
  final List<String> _uriApiPossible;

  DetectUriApi({required List<String> uriApiPossible})
      : _uriApiPossible = uriApiPossible;

  Future<String> _getUriApi() async {
    if (_uriApi == null) {
      for (String uri in _uriApiPossible) {
        final response = await http.get(EncodeUri.encode(uri));
        if (response.statusCode == 200) _uriApi = uri;
      }
    }
    return _uriApi!;
  }
}
