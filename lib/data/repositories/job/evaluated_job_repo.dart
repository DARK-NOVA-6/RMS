import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/job/full_evaluated_job.dart';
import '../../models/job/evaluated_job_model.dart';

class EvaluatedJobRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final CollectionReference<Map<String, dynamic>> collection2;
  final Query query;
  final Future<Map<String, dynamic>> Function() evaluatedAPiResponse;

  late List<String> jobsId = [];
  late Map<String, dynamic>? evaluatedApi;

  bool _lazy = true;
  bool _noMoreData = false;
  int _currentIdx = 0;
  bool working = false;

  EvaluatedJobRepo({
    required this.firebaseFirestore,
    required this.evaluatedAPiResponse,
  })  : collection = firebaseFirestore.collection('jobs'),
        collection2 = firebaseFirestore.collection('jobs-applications'),
        query = firebaseFirestore
            .collection('jobs')
            .where('status', isEqualTo: 'running'),
        evaluatedApi = null;

  Future<Either<Failure, FullEvaluatedJob>> detailed(
      {required String id}) async {
    if (working) Future.value(const Left(Unexpected(message: 'bad network')));
    working = true;
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
          working = false;
          return Future.value(Right(FullEvaluatedJob(evaluatedJob: data)));
        } else {
          working = false;
          return Future.value(const Left(Unexpected(message: 'wrong format')));
        }
      } else {
        working = false;
        return Future.value(const Left(Unexpected(message: 'no job!')));
      }
    } catch (e) {
      working = false;
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }

  Future<Either<Failure, List<EvaluatedJob>>> fetch(
      {required int limit}) async {
    if (working) Future.value(const Right([]));
    working = true;
    await _clearIfRefreshed();
    List<EvaluatedJob> result = [];
    while (result.length < limit && _currentIdx < jobsId.length) {
      try {
        var jobId = jobsId[_currentIdx];
        var tempData = await collection.doc(jobId).get();
        if (tempData.exists) {
          var data = EvaluatedJobModel.fromJsonAndSnapshot(
            jsonData: evaluatedApi![jobId],
            documentSnapshot: tempData.data(),
            id: jobId,
          );
          if (data != null) result.add(data);
        }
        _currentIdx++;
      } catch (e) {
        _currentIdx++;
      }
    }
    if (result.length < limit) {
      _noMoreData = true;
    }
    working = false;
    return Future.value(Right(result));
  }

  void refresh() => _lazy = true;

  bool get noMoreData => _noMoreData;

  Future<void> _clearIfRefreshed() async {
    if (evaluatedApi == null || _lazy == true) await _clear();
  }

  Future<void> _clear() async {
    _lazy = false;
    jobsId.clear();
    evaluatedApi = await evaluatedAPiResponse();
    jobsId.addAll(evaluatedApi!.keys);
    _currentIdx = 0;
  }

// Future<bool> _check(String jobId) async {
//   var result = await collection2
//       .where('job-seeker-id', isEqualTo: userId)
//       .where('job-id', isEqualTo: jobId)
//       .limit(1)
//       .get();
//   return result.docs.isEmpty;
// }
}
