import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart' as user_ent;

class UserModel extends user_ent.User {
  const UserModel({required super.id});

  static user_ent.User fromFirebaseUserCredential(
      UserCredential userCredential) {
    return user_ent.User(id: userCredential.user!.uid);
  }

  static user_ent.User fromFirebaseUser(User? user) {
    return user_ent.User(id: user == null ? '' : user.uid);
  }
}
