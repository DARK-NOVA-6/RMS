import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_skills_repo.dart';

class AutocompleteSkills {
  final KeywordsSkillsRepo keywordsSkillsRepo;

  AutocompleteSkills() : keywordsSkillsRepo = sl();

  Future<List<String>> call({
    required String word,
    int? limit,
    bool? exact,
  }) {
    return keywordsSkillsRepo.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }
}
