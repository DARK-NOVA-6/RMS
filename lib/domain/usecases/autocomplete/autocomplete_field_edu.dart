import 'package:untitled/domain/repositories/keywords/keywords_field_edu_repo.dart';

import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_job_titles_repo.dart';

class AutocompleteFieldEdu {
  final KeywordsFieldEduRepo keywordsFieldEduRepo;

  AutocompleteFieldEdu() : keywordsFieldEduRepo = sl();

  Future<List<String>> call({
    required String degree,
    required String word,
    int? limit,
  }) {
    return keywordsFieldEduRepo.getSimilar(degree: degree, word: word);
  }
}
