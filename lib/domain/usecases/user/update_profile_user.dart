import '../../../core/utils/validation/user_info_validator.dart';
import '../../../injection_container.dart';
import '../../entities/user/user_info.dart';
import '../../repositories/user_info_repo.dart';

class UpdateProfileUser {
  final UserInfoRepo userInfoRepo;

  UpdateProfileUser() : userInfoRepo = sl();

  Future<List<String>> call({required UserInfo newUserInfo}) async {
    List<String> errors = (await UserInfoValidator.validate(newUserInfo))
        .map((e) => e.message)
        .toList();
    print(errors);
    if (errors.isNotEmpty) return Future<List<String>>.value(errors);
    (await userInfoRepo.updateUserInfo(newUserInfo: newUserInfo)).fold(
      (failure) => errors = [failure.message],
      (data) => errors = [],
    );
    return Future<List<String>>.value(errors);
  }
}
