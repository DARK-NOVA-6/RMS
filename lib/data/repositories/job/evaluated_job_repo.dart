import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/job/full_evaluated_job.dart';
import '../../models/job/evaluated_job_model.dart';

class EvaluatedJobRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final Future<Map<String, dynamic>> evaluatedAPiResponse;
  late List<String> jobsId = [];
  late Map<String, dynamic>? evaluatedApi;
  int currentIdx = 0;
  bool lazy = false;
  EvaluatedJobRepo({
    required this.firebaseFirestore,
    required this.evaluatedAPiResponse,
    required String userId,
  })  : collection = firebaseFirestore.collection('jobs'),
        evaluatedApi = null;

  Future<Either<Failure, FullEvaluatedJob>> detailed(
      {required String id}) async {
    if (evaluatedApi == null) {
      jobsId.clear();
      evaluatedApi = await evaluatedAPiResponse;
      jobsId.addAll(evaluatedApi!.keys);
      currentIdx = 0;
    }
    try {
      var tempData = await collection.doc(id).get();
      if (tempData.exists) {
        var data = EvaluatedJobModel.fromJsonAndSnapshot(
          jsonData: evaluatedApi![id],
          documentSnapshot: tempData.data(),
          id: id,
        );
        if (data != null) {
          return Future.value(Right(FullEvaluatedJob(evaluatedJob: data)));
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

  Future<Either<Failure, List<EvaluatedJob>>> fetch(
      {required int limit}) async {
    if (evaluatedApi == null||lazy==true) {
      lazy = false;
      jobsId.clear();
      evaluatedApi = await evaluatedAPiResponse;
      jobsId.addAll(evaluatedApi!.keys);
      currentIdx = 0;
    }
    print(currentIdx);
    print(jobsId);
    List<EvaluatedJob> result = [];
    while (result.length < limit && currentIdx < jobsId.length) {
      try {
        var tempData = await collection.doc(jobsId[currentIdx]).get();
        if (tempData.exists) {
          // print('testing..');
          // print(tempData.data());
          var data = EvaluatedJobModel.fromJsonAndSnapshot(
            jsonData: evaluatedApi![jobsId[currentIdx]],
            documentSnapshot: tempData.data(),
            id: jobsId[currentIdx],
          );
          if (data != null) result.add(data);
        }
        currentIdx++;
      } catch (e) {
        currentIdx++;
        print(e.toString());
        // return Future.value(const Left(Unexpected(message: 'un')));
      }
    }
    return Future.value(Right(result));
  }

  void refresh() => lazy = true;
}
