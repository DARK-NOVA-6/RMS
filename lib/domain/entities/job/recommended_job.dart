import 'job.dart';

class RecommendedJob extends Job {
  const RecommendedJob({
    required super.id,
    required super.companyName,
    required super.jobDescription,
    required super.publishedTime,
  });

  @override
  List<Object?> get props => [
        id,
        companyName,
        jobDescription,
        publishedTime,
      ];
}
