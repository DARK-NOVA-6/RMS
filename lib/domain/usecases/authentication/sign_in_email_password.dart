import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../repositories/authentication_repo.dart';

class SignInEmailAndPassword {
  final AuthenticationRepo authenticationRepo;

  SignInEmailAndPassword(this.authenticationRepo);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.signInEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
