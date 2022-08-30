import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/evaluated_job.dart';

abstract class RecommendedRepo {
  Future<Either<Failure, List<EvaluatedJob>>> fetch({required int limit});

  Future<Either<Failure, EvaluatedJob>> detailed({required String id});
}
