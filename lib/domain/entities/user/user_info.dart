import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'education_certificate.dart';
part 'past_job.dart';

// ignore: must_be_immutable
class UserInfo extends Equatable {
  String? id;
  String? email;
  num? rating;
  num? ratingCounter;
  List<String> companies;
  List<String> phones;
  List<String> emails;
  String? firstName;
  String? middleName;
  String? lastName;
  String? imgUrl;
  String? gender;
  String? location;
  String? summary;
  String? nationality;
  List<String> skills;
  List<EducationCertificate> eduQualifications;
  List<PastJob> experiences;
  List<String> languages;

  UserInfo({
    this.id,
    this.companies = const [],
    this.email,
    this.rating = 0.0,
    this.ratingCounter = 0.0,
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
        companies,
        email,
        rating,
        ratingCounter,
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
