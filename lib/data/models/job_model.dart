import '../../domain/entities/job/job.dart';
import 'job_description_model.dart';

class JobModel extends Job {
  const JobModel({
    required super.id,
    required super.companyName,
    required super.jobDescription,
    required super.publishedTime,
  });

  static Job? fromSnapshot(Map<String, dynamic>? documentSnapshot) {
    try {
      return Job(
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

  static Map<String, dynamic> toSnapshot(Job job) {
    return {
      'id': job.id,
      'companyName': job.companyName,
      'JobDescription': JobDescriptionModel.toSnapshot(job.jobDescription),
      'publishedTime': job.publishedTime,
    };
  }
}
