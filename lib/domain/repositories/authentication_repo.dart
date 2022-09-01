import 'package:dartz/dartz.dart';
import 'package:untitled/core/errors/failures/failure.dart';
import 'package:untitled/domain/entities/entities.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, User>> signUpEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logOut();

  Stream<User> get connectedUser;

  String? get userId;
}
