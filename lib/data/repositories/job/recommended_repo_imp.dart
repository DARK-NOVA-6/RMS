import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/recommended_job.dart';
import '../../../domain/repositories/job/recommended_repo.dart';

class RecommendedRepoImp implements RecommendedRepo {
  final FirebaseFirestore firebaseFirestore;

  RecommendedRepoImp({required this.firebaseFirestore});

  @override
  Future<Either<Failure, RecommendedJob>> detailed({required String id}) {
    // TODO: implement detailed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RecommendedJob>>> fetch(
      {required int skip, required int limit}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
