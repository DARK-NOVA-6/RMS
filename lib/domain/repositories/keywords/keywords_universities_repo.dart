abstract class KeywordsUniversitiesRepo {
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  });
}
