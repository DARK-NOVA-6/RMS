import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart' as user_ent;

class UserModel extends user_ent.User {
  const UserModel({required super.id});

  static user_ent.User fromSnap(UserCredential userCredential) {
    return user_ent.User(id: userCredential.user!.uid);
  }
}
