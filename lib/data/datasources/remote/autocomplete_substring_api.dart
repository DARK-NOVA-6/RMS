import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/utils/custom_converter.dart';

abstract class AutocompleteSubstringApi {
  Future<List<String>> getSimilar({
    required String type,
    required String word,
  });
}

class AutocompleteSubstringApiImp implements AutocompleteSubstringApi {
  // static String get uriApi => 'http://192.168.98.250:5000/api';
  static String get uriApi => 'http://192.168.137.223:5000/api';

  // static String get uriApi => 'http://192.168.12.120:5000/api';

  @override
  Future<List<String>> getSimilar({
    required String type,
    required String word,
  }) async {
    final response = await http.get(Uri.parse('$uriApi/$type/$word'));
    return Future<List<String>>.value(
      CustomConverter().toListString(list: jsonDecode(response.body)),
    );
  }
}
