import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../entities/job/recommended_job.dart';
import '../../../repositories/job/recommended_repo.dart';

class FetchMore {
  final RecommendedRepo recommendedRepo;

  FetchMore(this.recommendedRepo);

  Future<Either<Failure, List<RecommendedJob>>> call(
      {required int skip, required int limit}) async {
    return await recommendedRepo.fetch(limit: limit, skip: skip);
  }
}
