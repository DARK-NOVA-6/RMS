import 'package:dartz/dartz.dart';
import 'package:untitled/domain/entities/job/evaluated_job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/applied_job.dart';

abstract class AppliedRepo {
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit});

  Future<Either<Failure, AppliedJob>> detailed({required String id});

  Future<Either<Failure, void>> cancel(
      {required String id, required String jobId});

  Future<List<Failure>> apply({required EvaluatedJob evaluatedJob});

  Future<void> addInquiry({required String inquiry, required String jobId});

  void refresh();

  bool get noMoreData;
}
