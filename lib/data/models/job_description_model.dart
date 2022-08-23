import '../../domain/entities/job_description.dart';

class JobDescriptionModel extends JobDescription {
  const JobDescriptionModel({
    required super.title,
    super.summary = '',
    super.skills = const [],
    super.eduQualification = const [],
    super.experience = const [],
    super.languages = const [],
  });

  static JobDescription fromSnapshot(Map<String, dynamic> documentSnapshot) {
    return JobDescription(
      title: documentSnapshot['title'],
      eduQualification: _convert(documentSnapshot['eduQualification']),
      experience: _convert(documentSnapshot['experience']),
      languages: _convert(documentSnapshot['languages']),
      skills: _convert(documentSnapshot['skills']),
      summary: documentSnapshot['summary'],
    );
  }

  static List<String> _convert(List<dynamic> list) {
    return list.map((e) => e as String).toList();
  }

  static Map<String, dynamic> toSnapshot(JobDescription jobDescription) {
    return {
      'title': jobDescription.title,
      'eduQualification': jobDescription.eduQualification,
      'experience': jobDescription.experience,
      'languages': jobDescription.languages,
      'skills': jobDescription.skills,
      'summary': jobDescription.summary,
    };
  }
}
