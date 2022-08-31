import '../../../entities/job/full_evaluated_job.dart';
import '../../../repositories/job/recommended_repo.dart';

class GetDetailedRecommended {
  final RecommendedRepo recommendedRepo;

  GetDetailedRecommended(this.recommendedRepo);

  Future<FullEvaluatedJob> call({required String id}) async {
    FullEvaluatedJob? result;
    (await recommendedRepo.detailed(id: id)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result!;
  }
}
