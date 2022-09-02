import '../../repositories/keywords/keywords_job_titles_repo.dart';

class AutocompleteJobTitles {
  final KeywordsJobTitlesRepo keywordsJobTitlesRepo;

  AutocompleteJobTitles({required this.keywordsJobTitlesRepo});

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsJobTitlesRepo.getSimilar(word: word);
  }
}
