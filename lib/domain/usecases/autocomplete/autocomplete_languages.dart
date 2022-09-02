import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_languages_repo.dart';

class AutocompleteLanguages {
  final KeywordsLanguagesRepo keywordsLanguagesRepo;

  AutocompleteLanguages() : keywordsLanguagesRepo = sl();

  Future<List<String>> call({
    required String word,
    int? limit,
    bool? exact,
  }) {
    return keywordsLanguagesRepo.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }
}
