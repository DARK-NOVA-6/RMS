import 'package:dartz/dartz.dart';
import 'package:untitled/domain/repositories/authentication_repo.dart';

import '../../../core/errors/failures/failure.dart';

class LogOut {
  final AuthenticationRepo authenticationRepo;

  LogOut(this.authenticationRepo);

  Future<Either<Failure, void>> call() async {
    return await authenticationRepo.logOut();
  }
}
