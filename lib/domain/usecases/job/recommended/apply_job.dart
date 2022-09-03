import 'package:untitled/domain/repositories/job/applied_repo.dart';

import '../../../../injection_container.dart';
import '../../../entities/job/evaluated_job.dart';

class ApplyJob {
  final AppliedRepo appliedRepo;

  ApplyJob() : appliedRepo = sl();

  Future<List<String>> call({required EvaluatedJob evaluatedJob}) async {
    return (await appliedRepo.apply(evaluatedJob: evaluatedJob))
        .map((e) => e.message)
        .toList();
  }
}
