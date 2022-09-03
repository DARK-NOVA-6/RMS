import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/evaluated_job.dart';
import '../../entities/job/full_evaluated_job.dart';

abstract class RecommendedRepo {
  Future<Either<Failure, List<EvaluatedJob>>> fetch({required int limit});

  Future<Either<Failure, FullEvaluatedJob>> detailed({required String id});


  void refresh();

  bool get noMoreData;
}
