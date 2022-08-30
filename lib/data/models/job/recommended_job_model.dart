import 'dart:convert';

import '../../../domain/entities/job/recommended_job.dart';
import '../job_description_model.dart';

class RecommendedJobModel extends RecommendedJob {
  const RecommendedJobModel({
    required super.id,
    required super.companyName,
    required super.jobDescription,
    required super.publishedTime,
  });

  static RecommendedJob? fromSnapshot(Map<String, dynamic>? documentSnapshot) {
    try {
      return RecommendedJob(
        id: 'id',
        companyName: documentSnapshot!['companyName'],
        jobDescription: JobDescriptionModel.fromSnapshot(
            documentSnapshot['JobDescription'])!,
        publishedTime: documentSnapshot['publishedTime'],
      );
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> toSnapshot(RecommendedJob job) {
    return {};
  }
}
