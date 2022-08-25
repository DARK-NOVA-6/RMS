import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/unavailable_job.dart';

abstract class UnavailableRepo {
  Future<Either<Failure, List<UnavailableJob>>> fetch({required int limit});

  Future<Either<Failure, UnavailableJob>> detailed({required String id});
}