import 'job.dart';

class AppliedJob extends Job {
  const AppliedJob({
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
