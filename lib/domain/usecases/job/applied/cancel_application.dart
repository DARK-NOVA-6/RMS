import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../repositories/job/applied_repo.dart';

class CancelApplication {
  final AppliedRepo appliedRepo;

  CancelApplication()
      : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          authenticationRepo: sl(),
        );

  Future<String> call({
    required String appliedId,
    required String jobId,
  }) async {
    String result = '';
    (await appliedRepo.cancel(id: appliedId, jobId: jobId)).fold(
      (failure) => result = failure.message,
      (data) => result = '',
    );
    return result;
  }
}
