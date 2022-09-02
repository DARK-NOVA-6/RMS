import '../../../domain/repositories/keywords/keywords_degree_edu_repo.dart';
import '../../../injection_container.dart';
import 'keywords_repo_substring.dart';

class KeywordsDegreeEduRepoSubstring implements KeywordsDegreeEduRepo {
  final KeywordsRepoSubstring keywordsRepoSubstring;

  @override
  Future<List<String>> getSimilar({required String word, int? limit}) {
    return keywordsRepoSubstring.getSimilar(word: word);
  }

  KeywordsDegreeEduRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(
          autocompleteSubstringApi: sl(),
          type: 'degree',
        );
}
