import 'job.dart';

class UnavailableJob extends Job {
  const UnavailableJob({
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

