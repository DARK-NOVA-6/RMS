import '../../../entities/job/evaluated_job.dart';
import '../../../repositories/job/recommended_repo.dart';

class FetchMoreRecommended {
  final RecommendedRepo recommendedRepo;

  FetchMoreRecommended(this.recommendedRepo);

  Future<List<EvaluatedJob>> call({required int limit}) async {
    List<EvaluatedJob> result = [];
    (await recommendedRepo.fetch(limit: limit)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }

  void refresh() => recommendedRepo.refresh();
}
