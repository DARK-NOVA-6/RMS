import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/utils/encode_uri.dart';

abstract class EvaluatorApi {
  Future<Map<String, dynamic>> getRecommended(userId);

  Future<Map<String, dynamic>> getUnavailable(userId);
}

class EvaluatorApiImp implements EvaluatorApi {
  // static String get uriApi => 'http://192.168.98.250:5000/api';
  static String get uriApi => 'http://192.168.137.223:5000/api';

  // static String get uriApi => 'http://192.168.102.208:5000/api';
  // static String get uriApi => 'http://192.168.12.120:5000/api';

  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=100"
  };

  @override
  Future<Map<String, dynamic>> getRecommended(userId) async {
    final response = await http.get(
      EncodeUri.encode('$uriApi/recommended/$userId'),
      headers: headers,
    );

    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> getUnavailable(userId) async {
    final response = await http.get(
      EncodeUri.encode('$uriApi/unavailable/$userId'),
      headers: headers,
    );

    return jsonDecode(response.body);
  }
}
