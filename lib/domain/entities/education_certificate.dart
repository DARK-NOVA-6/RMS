import 'package:equatable/equatable.dart';

class EducationCertificate extends Equatable {
  final String university;
  final String degree;
  final DateTime graduationDate;

  const EducationCertificate({
    required this.university,
    required this.degree,
    required this.graduationDate,
  });

  @override
  List<Object?> get props => [
        university,
        degree,
        graduationDate,
      ];
}
