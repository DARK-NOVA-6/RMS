import 'package:untitled/domain/repositories/keywords/keywords_degree_edu_repo.dart';
import 'package:untitled/domain/repositories/keywords/keywords_languages_repo.dart';

class AutocompleteLanguages {
  final KeywordsLanguagesRepo keywordsLanguagesRepo;

  AutocompleteLanguages({required this.keywordsLanguagesRepo});

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsLanguagesRepo.getSimilar(word: word);
  }
}
