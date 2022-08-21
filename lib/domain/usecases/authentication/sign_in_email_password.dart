import 'package:dartz/dartz.dart';
import 'package:untitled/domain/repositories/authentication_repo.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/user.dart';

class SignInEmailAndPassword {
  final AuthenticationRepo authenticationRepo;

  SignInEmailAndPassword(this.authenticationRepo);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.signInEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
