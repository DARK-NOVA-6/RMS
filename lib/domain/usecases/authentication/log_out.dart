import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../repositories/authentication_repo.dart';

class LogOut {
  final AuthenticationRepo authenticationRepo;

  LogOut(this.authenticationRepo);

  Future<Either<Failure, void>> call() async {
    return await authenticationRepo.logOut();
  }
}
