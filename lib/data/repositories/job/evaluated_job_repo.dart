import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/job/full_evaluated_job.dart';
import '../../models/job/evaluated_job_model.dart';

class EvaluatedJobRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final Query query;
  final String userId;
  final Future<Map<String, dynamic>> Function(String userId)
      evaluatedAPiResponse;
  late List<String> jobsId = [];
  late Map<String, dynamic>? evaluatedApi;

  bool lazy = true;
  bool _noMoreData = false;
  int currentIdx = 0;

  EvaluatedJobRepo({
    required this.firebaseFirestore,
    required this.evaluatedAPiResponse,
    required this.userId,
  })  : collection = firebaseFirestore.collection('jobs'),
        query = firebaseFirestore
            .collection('jobs')
            .where('status', isEqualTo: 'running'),
        evaluatedApi = null;

  Future<Either<Failure, FullEvaluatedJob>> detailed(
      {required String id}) async {
    await _clearIfRefreshed();
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
    await _clearIfRefreshed();
    print(currentIdx);
    print(jobsId.length);
    List<EvaluatedJob> result = [];
    while (result.length < limit && currentIdx < jobsId.length) {
      try {
        var tempData = await collection.doc(jobsId[currentIdx]).get();
        if (tempData.exists) {
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
      }
    }
    if (result.length < limit) _noMoreData = true;
    return Future.value(Right(result));
  }

  void refresh() => lazy = true;

  bool get noMoreData => _noMoreData;

  Future<void> _clearIfRefreshed() async {
    if (evaluatedApi == null || lazy == true) await _clear();
  }

  Future<void> _clear() async {
    lazy = false;
    jobsId.clear();
    evaluatedApi = await evaluatedAPiResponse(userId);
    jobsId.addAll(evaluatedApi!.keys);
    currentIdx = 0;
  }
}
