import 'package:equatable/equatable.dart';

class JobDescription extends Equatable {
  final String title;
  final String summary;
  final List<String> skills;
  final List<String> eduQualification;
  final List<String> experience;
  final List<String> languages;

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
