import 'failure.dart';

class UserInfoFailure extends Failure {
  const UserInfoFailure(super.message);
}

class InvalidEmailUserInfoFailure extends UserInfoFailure {
  const InvalidEmailUserInfoFailure() : super('At least one email is invalid');
}

class InvalidPhoneUserInfoFailure extends UserInfoFailure {
  const InvalidPhoneUserInfoFailure()
      : super('At least one phone number is invalid');
}

class InvalidSkillUserInfoFailure extends UserInfoFailure {
  const InvalidSkillUserInfoFailure() : super('At least one skill is invalid');
}

class InvalidEduUserInfoFailure extends UserInfoFailure {
  const InvalidEduUserInfoFailure()
      : super('At least one certificate is invalid');
}

class InvalidLangUserInfoFailure extends UserInfoFailure {
  const InvalidLangUserInfoFailure()
      : super('At least one language is invalid');
}

class InvalidJobTitleUserInfoFailure extends UserInfoFailure {
  const InvalidJobTitleUserInfoFailure()
      : super('At least one job title is invalid');
}
