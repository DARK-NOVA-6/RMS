import '../../../entities/job/applied_job.dart';
import '../../../repositories/job/applied_repo.dart';

class FetchMoreApplied {
  final AppliedRepo appliedRepo;

  FetchMoreApplied(this.appliedRepo);

  Future<List<AppliedJob>> call({required int limit}) async {
    List<AppliedJob> result = [];
    (await appliedRepo.fetch(limit: limit)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    print(result);
    return result;
  }

  void refresh() => appliedRepo.refresh();
}
