import '../../../domain/repositories/keywords/keywords_field_edu_repo.dart';
import '../../../injection_container.dart';
import 'keywords_repo_substring.dart';

class KeywordsFieldEduRepoSubstring implements KeywordsFieldEduRepo {
  final Map<String, KeywordsRepoSubstring> rep = {};

  @override
  Future<List<String>> getSimilar({
    required String degree,
    required String word,
    int? limit,
  }) {
    if (rep[degree] == null) {
      rep[degree] = KeywordsRepoSubstring(
        autocompleteSubstringApi: sl(),
        type: 'field-edu-$degree',
      );
    }
    return rep[degree]!.getSimilar(word: word);
  }
}
