import '../../../injection_container.dart';
import '../../entities/user/user_info.dart';
import '../../repositories/user_info_repo.dart';

class UpdateProfileUser {
  final UserInfoRepo userInfoRepo;

  UpdateProfileUser() : userInfoRepo = sl();

  Future<bool> call({required UserInfo newUserInfo}) async {
    bool result = false;
    (await userInfoRepo.updateUserInfo(newUserInfo: newUserInfo)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }
}
