import '../../datasources/remote/autocomplete_substring_api.dart';

class KeywordsRepoSubstring {
  final AutocompleteSubstringApi autocompleteSubstringApi;
  final String type;

  const KeywordsRepoSubstring({
    required this.autocompleteSubstringApi,
    required this.type,
  });

  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool ?exact,
  }) async {
    return autocompleteSubstringApi.getSimilar(
      type: type,
      word: word,
      limit: limit,
      exact: exact,
    );
  }
}
