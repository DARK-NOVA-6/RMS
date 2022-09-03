import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:untitled/data/models/job/applied_job_model.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/applied_job.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../../domain/repositories/job/applied_repo.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;
  final AuthenticationRepo authenticationRepo;
  final CollectionReference<Map<String, dynamic>> collection;
  final Query query;
  bool lazy = true;
  bool _noMoreData = false;
  QueryDocumentSnapshot? last;

  AppliedRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
  })  : collection = firebaseFirestore.collection('jobs-applications'),
        query = firebaseFirestore
            .collection('jobs-applications')
            .where('job-seeker-id', isEqualTo: authenticationRepo.userId);

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
      print(e);
      return Future.value(const Left(Unexpected(message: 'un')));
    }
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit}) async {
    if (noMoreData == true) return Future.value(const Right([]));
    if (lazy == true) {
      last = null;
      _noMoreData = false;
    }
    lazy = false;
    print(last?.id);
    try {
      Query pagQuery = query.limit(limit);
      if (last != null) pagQuery = pagQuery.startAfterDocument(last!);
      var response = await pagQuery.get();
      var result = Future<Either<Failure, List<AppliedJob>>>.value(
        Right(
          response.docs
              .map((e) => AppliedJobModel.fromSnapshot(
                    id: e.id,
                    documentSnapshot: e.data() as Map<String, dynamic>,
                  )!)
              .toList(),
        ),
      );
      if (response.docs.length < limit) {
        _noMoreData = true;
        last = null;
      } else {
        last = response.docs[response.docs.length - 1];
      }
      return result;
    } catch (e) {
      print(e);
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  Future<Either<Failure, void>> cancel({required String id}) {
    try {
      collection.doc(id).delete();
      return Future<Either<Failure, void>>.value(const Right(null));
    } catch (e) {
      return Future<Either<Failure, void>>.value(
          const Left(Unexpected(message: 'cant cancel')));
    }
  }

  @override
  bool get noMoreData => _noMoreData;

  @override
  void refresh() => lazy = true;
}
