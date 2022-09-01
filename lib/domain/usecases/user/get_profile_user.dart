import '../../entities/user/user_info.dart';
import '../../repositories/user_info_repo.dart';

class GetProfileUser {
  final UserInfoRepo userInfoRepo;

  const GetProfileUser({required this.userInfoRepo});

  Future<UserInfo?> call({required String userId}) async {
    // String userId = GetConnectedUser(sl()).userId!;
    UserInfo? result;
    (await userInfoRepo.getUserInfo(userId: userId)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }
}
