import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/utils/custom_converter.dart';
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
  // static String get uriApi => 'http://192.168.98.250:5000/api';
  static String get uriApi => 'http://192.168.137.223:5000/api';

  // static String get uriApi => 'http://192.168.102.208:5000/api';
  // static String get uriApi => 'http://192.168.12.120:5000/api';
  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=10, max=100"
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
        EncodeUri.encode('$uriApi/$type/$word$query'),
        headers: AutocompleteSubstringApiImp.headers,
      );
      return Future<List<String>>.value(
        CustomConverter().toListString(list: jsonDecode(response.body)),
      );
    } catch (e) {
      print(e);
      if (e is FormatException) return [];
      return getSimilar(type: type, word: word, limit: limit, exact: exact);
    }
  }
}
