import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

abstract class CvParserApi {
  Future<void> upload({required File cvPdf, required String userId});
}

class CvParserApiImp implements CvParserApi {
  // static String get uriApi => 'http://192.168.98.250:5000/api';
  static String get uriApi => 'http://192.168.137.223:5000/api';

  // static String get uriApi => 'http://192.168.102.208:5000/api';
  // static String get uriApi => 'http://192.168.12.120:5000/api';
  @override
  Future<void> upload({required File cvPdf, required String userId}) async {
    var stream = http.ByteStream(Stream.castFrom(cvPdf.openRead()));

    var length = await cvPdf.length();

    var uri = Uri.parse('$uriApi/extract-cv/$userId');
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
