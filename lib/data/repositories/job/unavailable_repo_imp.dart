import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:untitled/domain/repositories/authentication_repo.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/job/full_evaluated_job.dart';
import '../../../domain/repositories/job/unavailable_repo.dart';
import '../../datasources/remote/evaluator_api.dart';
import 'add_inquiry_method.dart';
import 'evaluated_job_repo.dart';

class UnavailableRepoImp implements UnavailableRepo {
  final EvaluatedJobRepo evaluatedJobRepo;
  final AddInquiryMethod addInquiryMethod;

  UnavailableRepoImp({
    required FirebaseFirestore firebaseFirestore,
    required EvaluatorApi evaluatorApi,
    required AuthenticationRepo authenticationRepo,
  })  : addInquiryMethod = AddInquiryMethod(
          authenticationRepo: authenticationRepo,
          firebaseFirestore: firebaseFirestore,
        ),
        evaluatedJobRepo = EvaluatedJobRepo(
          firebaseFirestore: firebaseFirestore,
          evaluatedAPiResponse: evaluatorApi.getUnavailable,
        );

  @override
  Future<Either<Failure, FullEvaluatedJob>> detailed({required String id}) =>
      evaluatedJobRepo.detailed(id: id);

  @override
  Future<Either<Failure, List<EvaluatedJob>>> fetch({required int limit}) =>
      evaluatedJobRepo.fetch(limit: limit);

  @override
  void refresh() => evaluatedJobRepo.refresh();

  @override
  bool get noMoreData => evaluatedJobRepo.noMoreData;

  @override
  Future<void> addInquiry({required String inquiry, required String jobId}) =>
      addInquiryMethod(inquiry: inquiry, jobId: jobId);
}
