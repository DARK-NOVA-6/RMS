import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:untitled/data/models/job/applied_job_model.dart';
import 'package:untitled/domain/usecases/authentication/get_connected_user.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../core/utils/custom_converter.dart';
import '../../../domain/entities/job/applied_job.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../../domain/repositories/job/applied_repo.dart';
import '../paginater_firestore.dart';
import 'add_inquiry_method.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;
  final AuthenticationRepo authenticationRepo;
  final CollectionReference<Map<String, dynamic>> collection;
  final CollectionReference<Map<String, dynamic>> collection2;
  final Query query;
  final PaginaterFirestore paginaterFirestore;
  final AddInquiryMethod addInquiryMethod;

  AppliedRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
  })  : addInquiryMethod = AddInquiryMethod(
          authenticationRepo: authenticationRepo,
          firebaseFirestore: firebaseFirestore,
        ),
        collection = firebaseFirestore.collection('jobs-applications'),
        collection2 = firebaseFirestore.collection('user-applications'),
        query = firebaseFirestore
            .collection('jobs-applications')
            .where('job-seeker-id', isEqualTo: GetConnectedUser().userId)
            .orderBy('applied-time'),
        paginaterFirestore = PaginaterFirestore(
          query: firebaseFirestore
              .collection('jobs-applications')
              .where('job-seeker-id', isEqualTo: GetConnectedUser().userId)
              .orderBy('applied-time'),
        );

  @override
  Future<List<Failure>> apply({required EvaluatedJob evaluatedJob}) async {
    collection.add(
      AppliedJobModel.toSnapshot(
        evaluatedJob: evaluatedJob,
        timestamp: Timestamp.now(),
        userInfo: GetConnectedUser().connectedUser!,
      ),
    );
    var old = await collection2.doc(GetConnectedUser().userId!).get();
    var apps = [evaluatedJob.id];
    if (old.exists) {
      apps = CustomConverter().toListString(list: old.data()!['list']);
      apps.add(evaluatedJob.id);
    }
    collection2.doc(GetConnectedUser().userId!).set({
      'list': apps,
    });
    return Future.value([]);
  }

  @override
  Future<Either<Failure, AppliedJob>> detailed({required String id}) async {
    try {
      var result = (await collection.doc(id).get()).data();
      return Future.value(
        Right(
          AppliedJobModel.fromSnapshot(
            id: id,
            documentSnapshot: result,
          )!,
        ),
      );
    } catch (e) {
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit}) async {
    List<AppliedJob> result = [];
    try {
      var response = await paginaterFirestore.fetch(limit: limit);
      result = response!.docs
          .map(
            (e) => AppliedJobModel.fromSnapshot(
              id: e.id,
              documentSnapshot: e.data() as Map<String, dynamic>,
            )!,
          )
          .toList();
      paginaterFirestore.commitFetching();
    } catch (e) {
      result = [];
    }
    return Future.value(Right(result));
  }

  @override
  Future<Either<Failure, void>> cancel(
      {required String id, required String jobId}) async {
    try {
      collection.doc(id).delete();
      var old = await collection2.doc(authenticationRepo.userId!).get();
      var apps = [];
      if (old.exists) {
        apps = CustomConverter().toListString(list: old.data()!['list']);
        apps.remove(jobId);
      }
      collection2.doc(authenticationRepo.userId!).set({
        'list': apps,
      });
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

  @override
  Future<void> addInquiry({required String inquiry, required String jobId}) =>
      addInquiryMethod(inquiry: inquiry, jobId: jobId);
}
