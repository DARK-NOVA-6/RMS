import 'package:equatable/equatable.dart';

class JobDescription extends Equatable {
  final String title;
  final String summary;
  final List<DescriptionField> skills;
  final List<DescriptionField> eduQualification;
  final List<DescriptionField> experience;
  final List<DescriptionField> languages;

  const JobDescription({
    required this.title,
    this.summary = '',
    this.skills = const [],
    this.eduQualification = const [],
    this.experience = const [],
    this.languages = const [],
  });

  @override
  List<Object?> get props => [
        title,
        summary,
        skills,
        eduQualification,
        experience,
        languages,
      ];
}

class DescriptionField extends Equatable {
  final String value;
  final bool isRequired;

  const DescriptionField({required this.value, required this.isRequired});

  @override
  List<Object?> get props => [value, isRequired];
}
