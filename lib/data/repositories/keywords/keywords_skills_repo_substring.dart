import '../../../domain/repositories/keywords/keywords_skills_repo.dart';
import 'keywords_repo_substring.dart';
import '../../../injection_container.dart';

class KeywordsSkillsRepoSubstring implements KeywordsSkillsRepo {
  final KeywordsRepoSubstring keywordsRepoSubstring;

  @override
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact ,
  }) {
    return keywordsRepoSubstring.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }

  KeywordsSkillsRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(
          autocompleteSubstringApi: sl(),
          type: 'skill',
        );
}
