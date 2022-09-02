import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../repositories/authentication_repo.dart';

class SignUpEmailPassword {
  final AuthenticationRepo authenticationRepo;

  SignUpEmailPassword(this.authenticationRepo);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.signUpEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
