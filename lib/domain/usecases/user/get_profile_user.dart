import '../../../injection_container.dart';
import '../../entities/user/user_info.dart';
import '../../repositories/user_info_repo.dart';

class GetProfileUser {
  final UserInfoRepo userInfoRepo;

  GetProfileUser() : userInfoRepo = sl();

  Future<UserInfo?> call({required String userId}) async {
    // String userId = GetConnectedUser(sl()).userId!;
    UserInfo? result;
    (await userInfoRepo.getUserInfo(userId: userId)).fold(
      (failure) => result = null,
      (data) => result = data,
    );
    return result;
  }
}
