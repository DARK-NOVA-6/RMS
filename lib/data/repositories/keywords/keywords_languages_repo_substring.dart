import '../../../domain/repositories/keywords/keywords_languages_repo.dart';
import '../../../injection_container.dart';
import 'keywords_repo_substring.dart';

class KeywordsLanguagesRepoSubstring implements KeywordsLanguagesRepo {
  final KeywordsRepoSubstring keywordsRepoSubstring;

  @override
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  }) {
    return keywordsRepoSubstring.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }

  KeywordsLanguagesRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(
          autocompleteSubstringApi: sl(),
          type: 'language',
        );
}
