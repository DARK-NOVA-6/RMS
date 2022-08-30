import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/job/recommended_job.dart';
import '../../../domain/repositories/job/recommended_repo.dart';
import '../../datasources/remote/evaluator_api.dart';
import '../../models/job/evaluated_job_model.dart';
import '../../models/job/recommended_job_model.dart';

class RecommendedRepoImp implements RecommendedRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final EvaluatorApi evaluatorApi;
  final Future<Map<String, dynamic>> recommendedAPi;
  late List<String> jobsId = [];
  late Map<String, dynamic>? evaluatedApi = null;

  int currentIdx = 0;

  RecommendedRepoImp({
    required this.firebaseFirestore,
    required this.evaluatorApi,
    required String userId,
  })  : collection = firebaseFirestore.collection('jobs'),
        recommendedAPi = evaluatorApi.getRecommended(userId);

  @override
  Future<Either<Failure, EvaluatedJob>> detailed({required String id}) async {
    try {
      var tempData = await collection.doc(id).get();
      if (tempData.exists) {
        var data = EvaluatedJobModel.fromJsonAndSnapshot(
          jsonData: evaluatedApi![id],
          documentSnapshot: tempData.data(),
        );
        if (data != null) {
          return Future.value(Right(data));
        } else {
          return Future.value(const Left(Unexpected(message: 'wrong format')));
        }
      } else {
        return Future.value(const Left(Unexpected(message: 'no job!')));
      }
    } catch (e) {
      print(e.toString());
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }

  @override
  Future<Either<Failure, List<EvaluatedJob>>> fetch(
      {required int limit}) async {
    if (evaluatedApi == null) {
      evaluatedApi = await recommendedAPi;
      jobsId.addAll(evaluatedApi!.keys);
    }
    print(currentIdx);
    List<EvaluatedJob> result = [];
    while (result.length < limit && currentIdx < jobsId.length) {
      try {
        var tempData = await collection.doc(jobsId[currentIdx]).get();
        if (tempData.exists) {
          var data = EvaluatedJobModel.fromJsonAndSnapshot(
            jsonData: evaluatedApi![jobsId[currentIdx]],
            documentSnapshot: tempData.data(),
          );
          if (data != null) result.add(data);
        }
        currentIdx++;
      } catch (e) {
        print(e.toString());
        // return Future.value(const Left(Unexpected(message: 'un')));
      }
    }
    return Future.value(Right(result));
  }
}
