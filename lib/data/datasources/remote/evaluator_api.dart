import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/utils/detect_uri_api.dart';
import '../../../core/utils/encode_uri.dart';
import '../../../domain/usecases/authentication/get_connected_user.dart';

abstract class EvaluatorApi {
  Future<Map<String, dynamic>> getRecommended();

  Future<Map<String, dynamic>> getUnavailable();
}

class EvaluatorApiImp implements EvaluatorApi {
  static const List<String> _uriApiPossible = [
    // 'http://192.168.97.229:5000/',
    // 'http://192.168.137.223:5000/',
    'http://192.168.102.208:5000/',
  ];


  static final DetectUriApi _detectUriApi = DetectUriApi(
    uriApiPossible: _uriApiPossible,
  );

  static Future<String> get uriApi async => _detectUriApi.uriApi;
  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=10"
  };

  @override
  Future<Map<String, dynamic>> getRecommended() async {
    String? userId = GetConnectedUser().userId;
    if (userId == null) return {};
    try {
      final response = await http.get(
        EncodeUri.encode('${await uriApi}/recommended/$userId'),
        headers: headers,
      );
      return Future.value(jsonDecode(response.body));
    } catch (e) {
      return {};
    }
  }

  @override
  Future<Map<String, dynamic>> getUnavailable() async {
    String? userId = GetConnectedUser().userId;
    if (userId == null) return {};
    try {
      final response = await http.get(
        EncodeUri.encode('${await uriApi}/unavailable/$userId'),
        headers: headers,
      );
      return Future.value(jsonDecode(response.body));
    } catch (e) {
      return {};
    }
  }
}
