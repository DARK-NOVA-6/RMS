import '../../../domain/repositories/keywords/keywords_job_titles_repo.dart';
import '../../../injection_container.dart';
import 'keywords_repo_substring.dart';

class KeywordsJobTitlesRepoSubstring implements KeywordsJobTitlesRepo {
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

  KeywordsJobTitlesRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(
          autocompleteSubstringApi: sl(),
          type: 'job-title',
        );
}
