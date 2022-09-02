import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_universities_repo.dart';

class AutocompleteUniversities {
  final KeywordsUniversitiesRepo keywordsUniversitiesRepo;

  AutocompleteUniversities() : keywordsUniversitiesRepo = sl();

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsUniversitiesRepo.getSimilar(word: word);
  }
}
