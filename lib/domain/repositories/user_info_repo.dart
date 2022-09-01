import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/user/user_info.dart';

abstract class UserInfoRepo {
  Future<Either<Failure, UserInfo>> getUserInfo({required String userId});

  Future<Either<Failure, bool>> updateUserInfo({required UserInfo newUserInfo});
}
