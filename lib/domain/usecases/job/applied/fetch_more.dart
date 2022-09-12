import 'package:untitled/data/repositories/job/applied_repo_imp.dart';

import '../../../../injection_container.dart';
import '../../../entities/job/applied_job.dart';
import '../../../repositories/job/applied_repo.dart';

class FetchMoreApplied {
  final AppliedRepo appliedRepo;

  FetchMoreApplied()
      : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          authenticationRepo: sl(),
        );

  Future<List<AppliedJob>> call({required int limit}) async {
    List<AppliedJob> result = [];
    (await appliedRepo.fetch(limit: limit)).fold(
          (failure) => result = [],
      (data) => result = data,
    );
    print(result);
    return result;
  }

  void refresh() => appliedRepo.refresh();
}
