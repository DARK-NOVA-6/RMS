import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/unavailable_job.dart';
import '../../../domain/repositories/job/unavailable_repo.dart';

class UnavailableRepoImp implements UnavailableRepo {
  final FirebaseFirestore firebaseFirestore;

  UnavailableRepoImp({required this.firebaseFirestore});

  @override
  Future<Either<Failure, UnavailableJob>> detailed({required String id}) {
    // TODO: implement detailed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UnavailableJob>>> fetch(
      {required int limit}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
