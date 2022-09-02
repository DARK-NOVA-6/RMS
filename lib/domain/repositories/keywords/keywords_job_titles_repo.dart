abstract class KeywordsJobTitlesRepo {
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  });
}
