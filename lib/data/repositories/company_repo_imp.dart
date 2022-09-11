import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/domain/entities/company.dart';
import 'package:untitled/domain/entities/user/user_info.dart' as user_ent;
import 'package:untitled/domain/repositories/company_repo.dart';

import '../../domain/repositories/authentication_repo.dart';
import '../../domain/repositories/company_repo.dart';
import '../../domain/repositories/user_info_repo.dart';
import '../models/company_model.dart';

class CompanyRepoImp implements CompanyRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final AuthenticationRepo authenticationRepo;
  final UserInfoRepo userInfoRepo;

  CompanyRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
    required this.userInfoRepo,
  }) : collection = firebaseFirestore.collection('companies');

  @override
  Future<bool> checkCompany({required String company}) async =>
      !(await collection.doc(company).get()).exists;

  @override
  Future<Company> getCompany({required String company}) async {
    return CompanyModel.fromSnapshot(
      documentSnapshot: (await collection.doc(company).get()).data(),
    )!;
  }

  @override
  Future<bool> registerCompany({required String company}) async {
    if (await checkCompany(company: company)) {
      await collection.doc(company).set(
            CompanyModel.toSnapshot(
              Company(
                adminId: authenticationRepo.userId!,
                name: company,
                address: '',
                creationDate: Timestamp.now(),
                phones: const [],
                emails: const [],
              ),
            ),
          );
      print('hi4');

      user_ent.UserInfo current = authenticationRepo.connectedUser!;

      current.companies.add(company);
      print(current.companies);
      userInfoRepo.updateUserInfo(
          newUserInfo: user_ent.UserInfo(
        id: current.id,
        companies: current.companies,
        email: current.email,
        rating: current.rating,
        firstName: current.firstName,
        middleName: current.middleName,
        lastName: current.lastName,
        imgUrl: current.imgUrl,
        gender: current.gender,
        location: current.location,
        phones: current.phones,
        emails: current.emails,
        summary: current.summary,
        nationality: current.nationality,
        skills: current.skills,
        eduQualifications: current.eduQualifications,
        experiences: current.experiences,
        languages: current.languages,
      ));
      print('hi');
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<String>> updateCompany({required Company newCompany}) async {
    await collection
        .doc(newCompany.name)
        .update(CompanyModel.toSnapshot(newCompany));
    return [];
  }
}
