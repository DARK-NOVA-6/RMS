import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:untitled/data/models/user/user_info_model.dart';

import '../../core/errors/failures/failure.dart';
import '../../domain/entities/user/user_info.dart';
import '../../domain/repositories/authentication_repo.dart';
import '../../domain/repositories/user_info_repo.dart';

class UserInfoRepoImp implements UserInfoRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final AuthenticationRepo authenticationRepo;

  UserInfoRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
  }) : collection = firebaseFirestore.collection('user-info');

  @override
  Future<Either<Failure, UserInfo>> getUserInfo(
      {required String userId}) async {
    try {
      return Future.value(Right(UserInfoModel.fromSnapshot(
          documentSnapshot: (await collection.doc(userId).get()).data())!));
    } catch (e) {
      print('dasda WTF !!');
      print(e.toString());
      return Future.value(const Left(Unexpected(message: 'unexpected')));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserInfo(
      {required UserInfo newUserInfo}) {
    try {
      String userId = 'KWKKUrBFSAPT7sqtP24nqa2gduN2';
      collection.doc(userId).update(UserInfoModel.toSnapshot(newUserInfo));
      return Future.value(const Right(true));
    } catch (e) {
      print(e.toString());
      return Future.value(const Right(false));
    }
  }
}
