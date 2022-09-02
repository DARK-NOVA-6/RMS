import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_degree_edu_repo.dart';

class AutocompleteDegrees {
  final KeywordsDegreeEduRepo keywordsDegreeEduRepo;

  AutocompleteDegrees() : keywordsDegreeEduRepo = sl();

  Future<List<String>> call({required String word, int? limit, bool? exact}) {
    return keywordsDegreeEduRepo.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }
}
