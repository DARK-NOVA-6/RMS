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

  static JobDescription? fromSnapshot(Map<String, dynamic> documentSnapshot) {
    try {
      return JobDescription(
        title: documentSnapshot['title'],
        eduQualification:
            _convertFromSnapshot(documentSnapshot['eduQualification']),
        experience: _convertFromSnapshot(documentSnapshot['experience']),
        languages: _convertFromSnapshot(documentSnapshot['languages']),
        skills: _convertFromSnapshot(documentSnapshot['skills']),
        summary: documentSnapshot['summary'],
      );
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> toSnapshot(JobDescription jobDescription) {
    return {
      'title': jobDescription.title,
      'eduQualification': _convertToSnapshot(jobDescription.eduQualification),
      'experience': _convertToSnapshot(jobDescription.experience),
      'languages': _convertToSnapshot(jobDescription.languages),
      'skills': _convertToSnapshot(jobDescription.skills),
      'summary': jobDescription.summary,
    };
  }

  static List<DescriptionField> _convertFromSnapshot(
      List<Map<String, dynamic>> list) {
    return list.map((e) => DescriptionFieldModel.fromSnapshot(e)).toList();
  }

  static List<Map<String, dynamic>> _convertToSnapshot(
      List<DescriptionField> list) {
    return list.map((e) => DescriptionFieldModel.toSnapshot(e)).toList();
  }
}

class DescriptionFieldModel extends DescriptionField {
  const DescriptionFieldModel(
      {required super.value, required super.isRequired});

  static DescriptionField fromSnapshot(Map<String, dynamic> documentSnapshot) {
    return DescriptionField(
      value: documentSnapshot['value'],
      isRequired: documentSnapshot['isRequired'],
    );
  }

  static Map<String, dynamic> toSnapshot(DescriptionField descriptionField) {
    return {
      'value': descriptionField.value,
      'isRequired': descriptionField.isRequired,
    };
  }
}
