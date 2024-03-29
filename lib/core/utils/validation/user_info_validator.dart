
import '../../../data/repositories/keywords/keywords_degree_edu_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_field_edu_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_job_titles_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_languages_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_skills_repo_substring.dart';
import '../../../domain/entities/user/user_info.dart';
import '../../../domain/repositories/keywords/keywords_degree_edu_repo.dart';
import '../../../domain/repositories/keywords/keywords_field_edu_repo.dart';
import '../../../domain/repositories/keywords/keywords_job_titles_repo.dart';
import '../../../domain/repositories/keywords/keywords_languages_repo.dart';
import '../../../domain/repositories/keywords/keywords_skills_repo.dart';
import '../../errors/failures/user_info_failures.dart';

class UserInfoValidator {
  static Future<List<UserInfoFailure>> validate(UserInfo userInfo) async {
    List<UserInfoFailure> errors = [];
    bool invalidPhone = _validatePhone(userInfo.phones);
    bool invalidEdu = await _validateEdu(userInfo.eduQualifications);
    bool invalidSkill = await _validateSkill(userInfo.skills);
    bool invalidLang = await _validateLang(userInfo.languages);
    bool invalidJobTitle = await _validateJobTitle(userInfo.experiences);

    if (invalidEdu) errors.add(const InvalidEduUserInfoFailure());
    if (invalidPhone) errors.add(const InvalidPhoneUserInfoFailure());
    if (invalidSkill) errors.add(const InvalidSkillUserInfoFailure());
    if (invalidLang) errors.add(const InvalidLangUserInfoFailure());
    if (invalidJobTitle) errors.add(const InvalidJobTitleUserInfoFailure());

    return Future<List<UserInfoFailure>>.value(errors);
  }


  static bool _validatePhone(List<String> phones) => false;

  static Future<bool> _validateSkill(List<String> skills) async {
    KeywordsSkillsRepo repo = KeywordsSkillsRepoSubstring();
    for (var e in skills) {
      var result = await repo.getSimilar(word: e, limit: 1, exact: true);
      if (result.isEmpty) return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  static Future<bool> _validateLang(List<String> languages) async {
    KeywordsLanguagesRepo repo = KeywordsLanguagesRepoSubstring();
    for (var e in languages) {
      var result = await repo.getSimilar(word: e, limit: 1, exact: true);
      if (result.isEmpty) return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  static Future<bool> _validateJobTitle(List<PastJob> experiences) async {
    KeywordsJobTitlesRepo repo = KeywordsJobTitlesRepoSubstring();
    for (var e in experiences) {
      var result = await repo.getSimilar(word: e.title, limit: 1, exact: true);
      if (result.isEmpty) return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  static Future<bool> _validateEdu(
      List<EducationCertificate> eduQualifications) async {
    KeywordsFieldEduRepo repoField = KeywordsFieldEduRepoSubstring();
    KeywordsDegreeEduRepo repoDegree = KeywordsDegreeEduRepoSubstring();
    for (var e in eduQualifications) {
      var result =
          await repoDegree.getSimilar(word: e.degree, limit: 1, exact: true);
      if (result.isEmpty) return Future<bool>.value(true);
    }
    for (var e in eduQualifications) {
      var result = await repoField.getSimilar(
          degree: e.degree, word: e.field, limit: 1, exact: true);
      if (result.isEmpty) return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }
}
