abstract class KeywordsSkillsRepo {
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  });
}
