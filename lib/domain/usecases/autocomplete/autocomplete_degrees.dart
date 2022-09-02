import 'package:untitled/domain/repositories/keywords/keywords_degree_edu_repo.dart';

import '../../../injection_container.dart';

class AutocompleteDegrees {
  final KeywordsDegreeEduRepo keywordsDegreeEduRepo;

  AutocompleteDegrees() : keywordsDegreeEduRepo = sl();

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsDegreeEduRepo.getSimilar(word: word);
  }
}
