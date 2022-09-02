import '../../../domain/repositories/keywords/keywords_job_titles_repo.dart';
import '../../../injection_container.dart';
import 'keywords_repo_substring.dart';

class KeywordsJobTitlesRepoSubstring implements KeywordsJobTitlesRepo {
  final KeywordsRepoSubstring keywordsRepoSubstring;

  @override
  Future<List<String>> getSimilar({required String word, int? limit}) {
    return keywordsRepoSubstring.getSimilar(word: word);
  }

  KeywordsJobTitlesRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(
          autocompleteSubstringApi: sl(),
          type: 'job-title',
        );
}
