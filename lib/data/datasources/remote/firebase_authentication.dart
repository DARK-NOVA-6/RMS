import 'package:untitled/data/models/user_model.dart';

import '../../../core/errors/exceptions/authentication_exceptions.dart';
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

  Stream<user_ent.User> get connectedUser;

  String? get userId;
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
      return Future<user_ent.User>.value(
          UserModel.fromFirebaseUserCredential(userCredential));
    } on FirebaseAuthException {
      throw EmailAndPasswordNotMatchedException();
    } catch (e) {
      throw UnexpectedAuthException();
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
      final user = UserModel.fromFirebaseUserCredential(await userCredential);
      return Future<user_ent.User>.value(user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException();
      } else {
        throw UnexpectedAuthException();
      }
    } on Exception {
      throw UnexpectedAuthException();
    }
  }

  @override
  Stream<user_ent.User> get connectedUser => firebaseAuth
      .authStateChanges()
      .map((user) => UserModel.fromFirebaseUser(user));

  @override
  String? get userId {
    if (firebaseAuth.currentUser == null) return null;
    return firebaseAuth.currentUser?.uid;
  }
}
