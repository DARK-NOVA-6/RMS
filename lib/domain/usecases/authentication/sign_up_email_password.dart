import 'package:dartz/dartz.dart';
import 'package:untitled/domain/entities/entities.dart' as user_ent;
import 'package:untitled/domain/repositories/authentication_repo.dart';

import '../../../core/errors/failures/failure.dart';

class SignUpEmailPassword {
  final AuthenticationRepo authenticationRepo;

  SignUpEmailPassword(this.authenticationRepo);

  Future<Either<Failure, user_ent.User>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.signUpEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
