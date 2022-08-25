import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/recommended_job.dart';
import '../../../domain/repositories/job/recommended_repo.dart';
import '../../models/job/recommended_job_model.dart';

class RecommendedRepoImp implements RecommendedRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  QueryDocumentSnapshot? _last;

  RecommendedRepoImp({required this.firebaseFirestore})
      : collection = firebaseFirestore.collection('jobs');

  @override
  Future<Either<Failure, RecommendedJob>> detailed({required String id}) async {
    try {
      var docSnapshot = await collection.doc(id).get();
      if (docSnapshot.exists) {
        print(docSnapshot.data());
        final result = RecommendedJobModel.fromSnapshot(docSnapshot.data());
        if (result != null) {
          return Future.value(Right(result));
        } else {
          return Future.value(const Left(Unexpected(message: 'wrong format')));
        }
      } else {
        return Future.value(const Left(Unexpected(message: 'un')));
      }
    } catch (e) {
      print(e.toString());
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }

  @override
  Future<Either<Failure, List<RecommendedJob>>> fetch(
      {required int limit}) async {
    try {
      var temp = collection.orderBy('ds').limit(limit);
      if (_last != null) temp = temp.startAfterDocument(_last!);
      final tempData = await temp.get();
      if (tempData.docs.isNotEmpty) {
        _last = tempData.docs[tempData.docs.length - 1];
      }
      List<RecommendedJob> result = [];
      for (var doc in tempData.docs) {
        var data = RecommendedJobModel.fromSnapshot(doc.data());
        if (data != null) result.add(data);
      }
      return Future.value(Right(result));
    } catch (e) {
      print(e.toString());
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }
}
