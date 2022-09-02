import '../../../domain/repositories/keywords/keywords_universities_repo.dart';
import 'keywords_repo_substring.dart';
import '../../../injection_container.dart';

class KeywordsUniversitiesRepoSubstring implements KeywordsUniversitiesRepo {
  final KeywordsRepoSubstring keywordsRepoSubstring;

  @override
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool ?exact,
  }) {
    return keywordsRepoSubstring.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }

  KeywordsUniversitiesRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(
          autocompleteSubstringApi: sl(),
          type: 'university',
        );
}
