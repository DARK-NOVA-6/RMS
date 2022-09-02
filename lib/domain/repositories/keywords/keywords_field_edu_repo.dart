abstract class KeywordsFieldEduRepo {
  Future<List<String>> getSimilar({
    required String degree,
    required String word,
    int? limit,
    bool? exact,
  });
}
