import 'package:untitled/domain/repositories/keywords/keywords_degree_edu_repo.dart';
import 'package:untitled/domain/repositories/keywords/keywords_languages_repo.dart';

import '../../../injection_container.dart';

class AutocompleteLanguages {
  final KeywordsLanguagesRepo keywordsLanguagesRepo;

  AutocompleteLanguages() : keywordsLanguagesRepo = sl();

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsLanguagesRepo.getSimilar(word: word);
  }
}
