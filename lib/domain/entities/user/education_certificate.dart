import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EducationCertificate extends Equatable {
  final String university;
  final String degree;
  final String field;
  final Timestamp graduationDate;

  const EducationCertificate({
    required this.university,
    required this.degree,
    required this.field,
    required this.graduationDate,
  });

  @override
  List<Object?> get props => [
        university,
        degree,
        field,
        graduationDate,
      ];
}
