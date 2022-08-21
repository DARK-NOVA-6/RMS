import 'package:dartz/dartz.dart';
import 'package:untitled/domain/repositories/authentication_repo.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/user.dart';

class SubmitConfCode {
  final AuthenticationRepo authenticationRepo;

  SubmitConfCode(this.authenticationRepo);

  Future<Either<Failure, User>> call({
    required String code,
  }) async {
    return await authenticationRepo.submitConfCode(code: code);
  }
}
