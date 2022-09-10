import '../../../domain/entities/user/user_info.dart';
import 'education_certificate_model.dart';
import 'past_job_model.dart';

class UserInfoModel extends UserInfo {
  static UserInfo? fromSnapshot(
      {required Map<String, dynamic>? documentSnapshot,
      required String userId}) {
    if (documentSnapshot == null) return null;
    return UserInfo(
      id: userId,
      summary: documentSnapshot['summary'],
      companies: _convertToListString(documentSnapshot['companies']),
      email: documentSnapshot['email'],
      firstName: documentSnapshot['first-name'],
      middleName: documentSnapshot['middle-name'],
      lastName: documentSnapshot['last-name'],
      imgUrl: documentSnapshot['img-url'],
      gender: documentSnapshot['gender'],
      location: documentSnapshot['location'],
      nationality: documentSnapshot['nationality'],
      rating: documentSnapshot['rating'],
      emails: _convertToListString(documentSnapshot['emails']),
      phones: _convertToListString(documentSnapshot['phones']),
      languages: _convertToListString(documentSnapshot['languages']),
      skills: _convertToListString(documentSnapshot['skills']),
      experiences: PastJobModel.listFromSnapshot(
          _convertToListMap(documentSnapshot['experiences'])),
      eduQualifications: EducationCertificateModel.listFromSnapshot(
          _convertToListMap(documentSnapshot['edu-qualifications'])),
    );
  }

  static List<String> _convertToListString(List<dynamic> list) {
    return list.map((e) => e as String).toList();
  }

  static List<Map<String, dynamic>> _convertToListMap(List<dynamic> list) {
    return list.map((e) => e as Map<String, dynamic>).toList();
  }

  static Map<String, dynamic> toSnapshot(UserInfo userInfo) {
    return {
      'companies' : userInfo.companies,
      'summary': userInfo.summary,
      'email': userInfo.email,
      'first-name': userInfo.firstName,
      'middle-name': userInfo.middleName,
      'last-name': userInfo.lastName,
      'img-url': userInfo.imgUrl,
      'gender': userInfo.gender,
      'location': userInfo.location,
      'nationality': userInfo.nationality,
      'rating': userInfo.rating,
      'emails': userInfo.emails,
      'phones': userInfo.phones,
      'languages': userInfo.languages,
      'skills': userInfo.skills,
      'experiences': PastJobModel.listToSnapshot(userInfo.experiences),
      'edu-qualifications':
          EducationCertificateModel.listToSnapshot(userInfo.eduQualifications),
    };
  }
}
