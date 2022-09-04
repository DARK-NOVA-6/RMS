import 'dart:io';

import '../../../data/datasources/remote/cv_parser_api.dart';
import '../../repositories/authentication_repo.dart';

class UploadCv {
  final AuthenticationRepo authenticationRepo;
  final CvParserApi cvParserApi;

  const UploadCv({
    required this.cvParserApi,
    required this.authenticationRepo,
  });

  Future<void> call({required File cvPdf}) {
    return cvParserApi.upload(cvPdf: cvPdf, userId: authenticationRepo.userId!);
  }
}
