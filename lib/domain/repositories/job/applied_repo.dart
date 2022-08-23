import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/applied_job.dart';

abstract class AppliedRepo {
  Future<Either<Failure, List<AppliedJob>>> fetch({int skip, int limit});

  Future<Either<Failure, AppliedJob>> detailed({String id});
}
