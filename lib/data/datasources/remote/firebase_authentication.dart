import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/exceptions/authentication_exceptions.dart';
import '../../../domain/entities/user/user_info.dart' as user_ent;
import '../../../domain/repositories/user_info_repo.dart';

abstract class AuthenticationRemote {
  Future<void> signInEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> signUp({
    required String email,
    required String password,
  });

  String? get userId;

  user_ent.UserInfo? get connectedUser;
}

class FirebaseAuthentication extends AuthenticationRemote {
  final FirebaseAuth firebaseAuth;
  final UserInfoRepo userInfoRepo;

  // ignore: unused_field
  static user_ent.UserInfo? _userInfo;
  static bool _initiated = false;

  FirebaseAuthentication({
    required this.firebaseAuth,
    required this.userInfoRepo,
  }) {
    if (_initiated == false) {
      _initiated = true;
      _userInfo = null;
      firebaseAuth.authStateChanges().forEach((element) async {
        if (element == null) {
          _userInfo = null;
        } else {
          FirebaseFirestore.instance
              .collection('user-info')
              .doc(element.uid)
              .snapshots()
              .listen((event) async {
            (await userInfoRepo.getUserInfo(userId: element.uid)).fold(
              (failure) => _userInfo = null,
              (data) => _userInfo = data,
            );
          });
          (await userInfoRepo.getUserInfo(userId: element.uid)).fold(
            (failure) => _userInfo = null,
            (data) => _userInfo = data,
          );
        }
      });
    }
  }

  @override
  Future<void> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Future<void>.value(null);
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
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userInfoRepo.updateUserInfo(
        newUserInfo: user_ent.UserInfo(
          id: userId,
          email: email,
        ),
      );
      return Future<void>.value(null);
    } on FirebaseAuthException catch (e) {
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
  String? get userId {
    // return 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2';
    if (firebaseAuth.currentUser == null) return null;
    return firebaseAuth.currentUser!.uid;
  }

  @override
  user_ent.UserInfo? get connectedUser => _userInfo;
}
