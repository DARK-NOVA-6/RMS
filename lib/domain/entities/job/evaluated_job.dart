import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'evaluated_description/evaluated_description.dart';

class EvaluatedJob extends Equatable {
  final String id;
  final String title;
  final String summary;
  final String companyName;
  final Timestamp publishedTime;
  final List<EvSkillDescription> skills;
  final List<EvEduQualificationDescription> eduQualifications;
  final List<EvExperienceDescription> experiences;
  final List<EvLanguageDescription> languages;
  final num score;

  const EvaluatedJob({
    required this.id,
    required this.title,
    required this.summary,
    required this.companyName,
    required this.publishedTime,
    required this.skills,
    required this.eduQualifications,
    required this.experiences,
    required this.languages,
    required this.score,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        companyName,
        publishedTime,
        skills,
        eduQualifications,
        experiences,
        languages,
      ];
}
