import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/applied_job.dart';
import '../../../domain/repositories/job/applied_repo.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;

  AppliedRepoImp({required this.firebaseFirestore});

  @override
  Future<Either<Failure, AppliedJob>> detailed({required String id}) {
    // TODO: implement detailed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch(
      {required int skip, required int limit}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
