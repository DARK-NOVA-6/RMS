import '../../entities/user.dart' as user_ent;
import '../../repositories/authentication_repo.dart';

class GetConnectedUser {
  final AuthenticationRepo authenticationRepo;

  GetConnectedUser(this.authenticationRepo);

  Stream<user_ent.User> get connectedUser => authenticationRepo.connectedUser;

  String? get userId => authenticationRepo.userId;
}
