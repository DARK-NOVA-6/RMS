import 'package:untitled/domain/repositories/keywords/keywords_degree_edu_repo.dart';

class AutocompleteDegrees {
  final KeywordsDegreeEduRepo keywordsDegreeEduRepo;

  AutocompleteDegrees({required this.keywordsDegreeEduRepo});

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsDegreeEduRepo.getSimilar(word: word);
  }
}
