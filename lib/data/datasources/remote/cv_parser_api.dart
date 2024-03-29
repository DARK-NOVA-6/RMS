import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../core/utils/detect_uri_api.dart';

abstract class CvParserApi {
  Future<void> upload({required File cvPdf, required String userId});
}

class CvParserApiImp implements CvParserApi {
  static Future<String> get uriApi async => DetectUriApi.uriApi;

  @override
  Future<void> upload({required File cvPdf, required String userId}) async {
    var stream = http.ByteStream(Stream.castFrom(cvPdf.openRead()));

    var length = await cvPdf.length();

    var uri = Uri.parse('${await uriApi}/extract-cv/$userId');
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(cvPdf.path),
    );
    request.files.add(multipartFile);
    await request.send();
  }
}
