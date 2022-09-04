import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:untitled/data/models/job/applied_job_model.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/applied_job.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../../domain/repositories/job/applied_repo.dart';
import '../paginater_firestore.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;
  final AuthenticationRepo authenticationRepo;
  final CollectionReference<Map<String, dynamic>> collection;
  final Query query;
  final PaginaterFirestore paginaterFirestore;

  AppliedRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
  })  : collection = firebaseFirestore.collection('jobs-applications'),
        query = firebaseFirestore
            .collection('jobs-applications')
            .where('job-seeker-id', isEqualTo: authenticationRepo.userId)
            .orderBy('applied-time'),
        paginaterFirestore = PaginaterFirestore(
          query: firebaseFirestore
              .collection('jobs-applications')
              .where('job-seeker-id', isEqualTo: authenticationRepo.userId)
              .orderBy('applied-time'),
        );

  @override
  Future<List<Failure>> apply({required EvaluatedJob evaluatedJob}) async {
    collection.add(
      AppliedJobModel.toSnapshot(
        evaluatedJob: evaluatedJob,
        timestamp: Timestamp.now(),
        userInfo: authenticationRepo.connectedUser!,
      ),
    );
    return Future.value([]);
  }

  @override
  Future<Either<Failure, AppliedJob>> detailed({required String id}) async {
    try {
      return Future.value(
        Right(
          AppliedJobModel.fromSnapshot(
            id: id,
            documentSnapshot: (await collection.doc(id).get()).data(),
          )!,
        ),
      );
    } catch (e) {
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit}) async {
    var response = await paginaterFirestore.fetch(limit: limit);
    var result = response!.docs
        .map(
          (e) => AppliedJobModel.fromSnapshot(
            id: e.id,
            documentSnapshot: e.data() as Map<String, dynamic>,
          )!,
        )
        .toList();
    paginaterFirestore.commitFetching();
    return Future.value(Right(result));
  }

  @override
  Future<Either<Failure, void>> cancel({required String id}) {
    try {
      collection.doc(id).update({'state': 'canceled'});
      return Future<Either<Failure, void>>.value(const Right(null));
    } catch (e) {
      return Future<Either<Failure, void>>.value(
          const Left(Unexpected(message: 'cant cancel')));
    }
  }

  @override
  bool get noMoreData => paginaterFirestore.noMoreData;

  @override
  void refresh() => paginaterFirestore.refresh();
}
