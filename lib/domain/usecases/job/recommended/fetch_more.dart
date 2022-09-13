import '../../../../injection_container.dart';
import '../../../entities/job/evaluated_job.dart';
import '../../../repositories/job/recommended_repo.dart';

class FetchMoreRecommended {
  final RecommendedRepo recommendedRepo;

  FetchMoreRecommended() : recommendedRepo = sl();

  Future<List<EvaluatedJob>> call({required int limit}) async {
    List<EvaluatedJob> result = [];
    (await recommendedRepo.fetch(limit: limit)).fold(
      (failure) => result = [],
      (data) => result = data,
    );
    return result;
  }

  void refresh() => recommendedRepo.refresh();
}
