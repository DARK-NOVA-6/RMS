import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions/authentication_exceptions.dart';
import '../../core/errors/failures/failure.dart';
import '../../domain/entities/user/user_info.dart' as user_ent;
import '../../domain/repositories/authentication_repo.dart';
import '../datasources/remote/firebase_authentication.dart';

class AuthenticationUsingTwoSteps extends AuthenticationRepo {
  final AuthenticationRemote authenticationRemote;

  AuthenticationUsingTwoSteps({
    required this.authenticationRemote,
  });

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await authenticationRemote.signOut();
      return Future<Either<Failure, void>>.value(const Right(null));
    } catch (e) {
      return Future<Either<Failure, void>>.value(const Left(Unexpected()));
    }
  }

  @override
  Future<Either<Failure, void>> signInEmailAndPassword(
      {required String email, required String password}) {
    return _signInUp(
      email: email,
      password: password,
      function: authenticationRemote.signInEmailPassword,
    );
  }

  @override
  Future<Either<Failure, void>> signUpEmailAndPassword(
      {required String email, required String password}) {
    return _signInUp(
      email: email,
      password: password,
      function: authenticationRemote.signUp,
    );
  }

  Future<Either<Failure, void>> _signInUp({
    required String email,
    required String password,
    required Function function,
  }) async {
    Failure failure;
    try {
      await function(email: email, password: password);
      return Future<Either<Failure, void>>.value(const Right(null));
    } on AuthenticationException catch (e) {
      failure = e.failure;
    } on Exception {
      failure = const Unexpected();
    }
    return Future<Either<Failure, void>>.value(Left(failure));
  }

  @override
  String? get userId => authenticationRemote.userId;

  @override
  user_ent.UserInfo? get connectedUser => authenticationRemote.connectedUser;
}
