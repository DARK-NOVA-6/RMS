import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../entities/job/recommended_job.dart';
import '../../../repositories/job/recommended_repo.dart';

class GetDetailed {
  final RecommendedRepo recommendedRepo;

  GetDetailed(this.recommendedRepo);

  Future<Either<Failure, RecommendedJob>> call({required String id}) async {
    return await recommendedRepo.detailed(id: id);
  }
}
