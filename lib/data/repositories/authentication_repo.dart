import 'package:dartz/dartz.dart';
import 'package:untitled/core/errors/exceptions/authentication_exception.dart';

import 'package:untitled/core/errors/failures/failure.dart';
import 'package:untitled/core/errors/failures/authentication_failures.dart';

import '../../domain/repositories/authentication_repo.dart';
import '../datasources/remote/firebase_authentication.dart';

import '../../domain/entities/user.dart' as user_ent;

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
  Future<Either<Failure, user_ent.User>> signInEmailAndPassword(
      {required String email, required String password}) {
    return _signInUp(
      email: email,
      password: password,
      function: authenticationRemote.signInEmailPassword,
    );
  }

  @override
  Future<Either<Failure, user_ent.User>> signUpEmailAndPassword(
      {required String email, required String password}) {
    return _signInUp(
      email: email,
      password: password,
      function: authenticationRemote.signUp,
    );
  }

  Future<Either<Failure, user_ent.User>> _signInUp({
    required String email,
    required String password,
    required Function function,
  }) async {
    Failure failure;
    try {
      final user = function(email: email, password: password);
      return Future<Either<Failure, user_ent.User>>.value(Right(await user));
    } on AuthenticationException catch (e) {
      failure = e.failure;
    } on Exception {
      failure = const Unexpected();
    }
    return Future<Either<Failure, user_ent.User>>.value(Left(failure));
  }

  @override
  Stream<user_ent.User> get connectedUser => authenticationRemote.connectedUser;
}
