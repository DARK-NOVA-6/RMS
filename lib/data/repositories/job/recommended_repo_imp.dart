import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/evaluated_job.dart';
import '../../../domain/entities/job/full_evaluated_job.dart';
import '../../../domain/repositories/job/recommended_repo.dart';
import '../../datasources/remote/evaluator_api.dart';
import 'evaluated_job_repo.dart';

class RecommendedRepoImp implements RecommendedRepo {
  final EvaluatedJobRepo evaluatedJobRepo;
  final FirebaseFirestore firebaseFirestore;

  RecommendedRepoImp({
    required this.firebaseFirestore,
    required EvaluatorApi evaluatorApi,
    required String userId,
  }) : evaluatedJobRepo = EvaluatedJobRepo(
          firebaseFirestore: firebaseFirestore,
          evaluatedAPiResponse: evaluatorApi.getRecommended,
          userId: userId,
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
}
