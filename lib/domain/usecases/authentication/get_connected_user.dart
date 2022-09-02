import '../../repositories/authentication_repo.dart';
import '../../entities/user/user_info.dart' as user_ent;

class GetConnectedUser {
  final AuthenticationRepo authenticationRepo;

  GetConnectedUser(this.authenticationRepo);

  String? get userId => authenticationRepo.userId;

  user_ent.UserInfo? get connectedUser => authenticationRepo.connectedUser;
}
