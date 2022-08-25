import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../entities/job/applied_job.dart';
import '../../../repositories/job/applied_repo.dart';

class FetchMore {
  final AppliedRepo appliedRepo;

  FetchMore(this.appliedRepo);

  Future<Either<Failure, List<AppliedJob>>> call(
      {required int skip, required int limit}) async {
    return await appliedRepo.fetch(limit: limit);
  }
}
