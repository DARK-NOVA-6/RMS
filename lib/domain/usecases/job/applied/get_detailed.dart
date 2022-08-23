import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../entities/job/applied_job.dart';
import '../../../repositories/job/applied_repo.dart';

class GetDetailed {
  final AppliedRepo appliedRepo;

  GetDetailed(this.appliedRepo);

  Future<Either<Failure, AppliedJob>> call({required String id}) async {
    return await appliedRepo.detailed(id: id);
  }
}
