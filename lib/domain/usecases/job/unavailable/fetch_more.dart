import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../entities/job/unavailable_job.dart';
import '../../../repositories/job/unavailable_repo.dart';

class FetchMore {
  final UnavailableRepo unavailableRepo;

  FetchMore(this.unavailableRepo);

  Future<Either<Failure, List<UnavailableJob>>> call(
      {required int skip, required int limit}) async {
    return await unavailableRepo.fetch(limit: limit);
  }
}
