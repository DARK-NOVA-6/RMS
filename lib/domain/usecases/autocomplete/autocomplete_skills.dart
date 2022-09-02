import '../../repositories/keywords/keywords_skills_repo.dart';

class AutocompleteSkills {
  final KeywordsSkillsRepo keywordsSkillsRepo;

  AutocompleteSkills({required this.keywordsSkillsRepo});

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsSkillsRepo.getSimilar(word: word);
  }
}
