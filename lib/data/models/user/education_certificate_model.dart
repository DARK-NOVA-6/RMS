import '../../../domain/entities/user/user_info.dart';

class EducationCertificateModel extends EducationCertificate {
  const EducationCertificateModel({
    required super.university,
    required super.degree,
    required super.field,
    required super.graduationDate,
  });

  static EducationCertificate? fromSnapshot(
      Map<String, dynamic>? documentSnapshot) {
    try {
      return EducationCertificate(
        university: documentSnapshot!['university'],
        degree: documentSnapshot['degree'],
        field: documentSnapshot['field'],
        graduationDate: documentSnapshot['graduation-date'],
      );
    } catch (e) {
      return null;
    }
  }

  static List<EducationCertificate> listFromSnapshot(
      List<Map<String, dynamic>>? documentSnapshot) {
    if (documentSnapshot == null) return [];
    List<EducationCertificate> result = [];
    for (var element in documentSnapshot) {
      var newElement = fromSnapshot(element);
      if (newElement != null) result.add(newElement);
    }
    return result;
  }

  static List<Map<String, dynamic>> listToSnapshot(
      List<EducationCertificate> educationCertificates) {
    return educationCertificates.map((e) => toSnapshot(e)).toList();
  }

  static Map<String, dynamic> toSnapshot(
      EducationCertificate educationCertificate) {
    return {
      'university': educationCertificate.university,
      'degree': educationCertificate.degree,
      'field': educationCertificate.field,
      'graduation-date': educationCertificate.graduationDate,
    };
  }
}
