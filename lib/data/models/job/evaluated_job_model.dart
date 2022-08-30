import '../../../domain/entities/job/evaluated_job.dart';

class EvaluatedJobModel extends EvaluatedJob {
  const EvaluatedJobModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.companyName,
    required super.publishedTime,
    required super.skills,
    required super.eduQualifications,
    required super.experiences,
    required super.languages,
    required super.score,
  });

  static EvaluatedJob? fromJsonAndSnapshot({
    required Map<String, dynamic>? jsonData,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {

    } catch (e) {
      return null;
    }
  }
}
