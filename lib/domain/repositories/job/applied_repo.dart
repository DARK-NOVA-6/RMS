import 'package:dartz/dartz.dart';
import 'package:untitled/domain/entities/job/evaluated_job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/applied_job.dart';
import '../../entities/job/job_application_states.dart';

abstract class AppliedRepo {
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit});

  Future<Either<Failure, AppliedJob>> detailed({required String id});

  Future<Either<Failure, void>> cancel({required String id});

  Future<List<Failure>> apply({required EvaluatedJob evaluatedJob});

  void refresh();

  bool get noMoreData;
}
