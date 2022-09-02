import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_field_edu_repo.dart';

class AutocompleteFieldEdu {
  final KeywordsFieldEduRepo keywordsFieldEduRepo;

  AutocompleteFieldEdu() : keywordsFieldEduRepo = sl();

  Future<List<String>> call({
    required String degree,
    required String word,
    int? limit,
    bool? exact,
  }) {
    return keywordsFieldEduRepo.getSimilar(
      degree: degree,
      word: word,
      limit: limit,
      exact: exact,
    );
  }
}
