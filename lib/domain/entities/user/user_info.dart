import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'education_certificate.dart';
part 'past_job.dart';

class UserInfo extends Equatable {
  final String? id;
  final String? email;
  final num rating;
  final List<String> phones;
  final List<String> emails;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? imgUrl;
  final String? gender;
  final String? location;
  final String? summary;
  final String? nationality;
  final List<String> skills;
  final List<EducationCertificate> eduQualifications;
  final List<PastJob> experiences;
  final List<String> languages;

  const UserInfo({
    this.id,
    this.email,
    this.rating = 0.0,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imgUrl,
    this.gender,
    this.location,
    this.phones = const [],
    this.emails = const [],
    this.summary,
    this.nationality,
    this.skills = const [],
    this.eduQualifications = const [],
    this.experiences = const [],
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
        emails,
        summary,
        nationality,
        skills,
        eduQualifications,
        experiences,
        languages,
      ];
}
