import '../../../injection_container.dart';
import '../../repositories/keywords/keywords_job_titles_repo.dart';

class AutocompleteJobTitles {
  final KeywordsJobTitlesRepo keywordsJobTitlesRepo;

  AutocompleteJobTitles() : keywordsJobTitlesRepo = sl();

  Future<List<String>> call({required String word, int? limit}) {
    return keywordsJobTitlesRepo.getSimilar(word: word);
  }
}
