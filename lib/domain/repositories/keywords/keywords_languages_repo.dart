abstract class KeywordsLanguagesRepo {
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  });
}
