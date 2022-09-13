import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/utils/custom_converter.dart';
import '../../../core/utils/detect_uri_api.dart';
import '../../../core/utils/encode_uri.dart';

abstract class AutocompleteSubstringApi {
  Future<List<String>> getSimilar({
    required String type,
    required String word,
    int? limit,
    bool? exact,
  });
}

class AutocompleteSubstringApiImp implements AutocompleteSubstringApi {
  static Future<String> get uriApi async => DetectUriApi.uriApi;


  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=10"
  };

  @override
  Future<List<String>> getSimilar({
    required String type,
    required String word,
    int? limit,
    bool? exact,
  }) async {
    try {
      final query1 = exact != null && exact == true ? 'exact=true' : '';
      final query2 = limit != null ? 'limit=$limit' : '';
      final query = (query1.isNotEmpty || query2.isNotEmpty ? '?' : '') +
          (query1.isNotEmpty ? query1 : '') +
          (query1.isNotEmpty && query2.isNotEmpty ? '&' : '') +
          (query2.isNotEmpty ? query2 : '');
      final response = await http.get(
        EncodeUri.encode('${await uriApi}/$type/$word$query'),
        headers: AutocompleteSubstringApiImp.headers,
      );
      return Future<List<String>>.value(
        CustomConverter().toListString(list: jsonDecode(response.body)),
      );
    } catch (e) {
      return [];
    }
  }
}
