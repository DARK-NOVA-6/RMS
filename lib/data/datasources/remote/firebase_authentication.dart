import 'package:untitled/data/models/user_model.dart';

import '../../../core/errors/exceptions/authentication_exception.dart';
import '../../../domain/entities/user.dart' as user_ent;

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemote {
  Future<user_ent.User> signInEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<user_ent.User> signUp({
    required String email,
    required String password,
  });
}

class FirebaseAuthentication extends AuthenticationRemote {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthentication({
    required this.firebaseAuth,
  });

  @override
  Future<user_ent.User> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Future<user_ent.User>.value(UserModel.fromSnap(userCredential));
    } on FirebaseAuthException {
      throw EmailAndPasswordNotMatchedException();
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<user_ent.User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = UserModel.fromSnap(await userCredential);
      return Future<user_ent.User>.value(user);
    } on FirebaseAuthException catch (e) {
      if (e.message == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.message == 'invalid-email') {
        throw InvalidEmailException();
      } else if (e.message == 'email-already-in-use') {
        throw EmailAlreadyExistException();
      } else {
        throw UnexpectedException();
      }
    } on Exception {
      throw UnexpectedException();
    }
  }
}
