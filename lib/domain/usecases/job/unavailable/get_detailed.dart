import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../../../entities/job/unavailable_job.dart';
import '../../../repositories/job/unavailable_repo.dart';

class GetDetailed {
  final UnavailableRepo unavailableRepo;

  GetDetailed(this.unavailableRepo);

  Future<Either<Failure, UnavailableJob>> call({required String id}) async {
    return await unavailableRepo.detailed(id: id);
  }
}
