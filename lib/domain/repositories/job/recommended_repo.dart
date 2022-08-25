import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/recommended_job.dart';

abstract class RecommendedRepo {
  Future<Either<Failure, List<RecommendedJob>>> fetch({required int limit});

  Future<Either<Failure, RecommendedJob>> detailed({required String id});
}
