import 'package:equatable/equatable.dart';
import 'package:untitled/domain/entities/user/past_job.dart';

import 'user/education_certificate.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final num rating;//
  final List<String> phones;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? imgUrl;//
  final String? gender;
  final String? location;//
  final String? summary;//
  final String? nationality;//
  //
  final List<String> skills;
  final List<EducationCertificate> eduQualification;
  final List<PastJob> experience;
  final List<String> languages;

  const User({
    required this.id,
    this.email,
    this.rating = 0.0,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imgUrl,
    this.gender,
    this.location,
    this.phones = const [],
    this.summary,
    this.nationality,
    this.skills = const [],
    this.eduQualification = const [],
    this.experience = const [],
    this.languages = const [],
  });

  @override
  List<Object?> get props => [
        id,
        email,
        rating,
        firstName,
        middleName,
        lastName,
        imgUrl,
        gender,
        location,
        phones,
        summary,
        nationality,
        skills,
        eduQualification,
        experience,
        languages,
      ];
}
