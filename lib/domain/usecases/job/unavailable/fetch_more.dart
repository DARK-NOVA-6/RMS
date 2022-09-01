import '../../../entities/job/evaluated_job.dart';
import '../../../repositories/job/unavailable_repo.dart';

class FetchMoreUnavailable {
  final UnavailableRepo unavailableRepo;

  FetchMoreUnavailable(this.unavailableRepo);

  Future<List<EvaluatedJob>> call({required int limit}) async {
    List<EvaluatedJob> result = [];
    (await unavailableRepo.fetch(limit: limit)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }

  void refresh() => unavailableRepo.refresh();
}
