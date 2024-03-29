import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/domain/usecases/authentication/get_connected_user.dart';

import '../../domain/entities/user/user_info.dart';
import 'controllers.dart';

class UserController {
  final List<EduControllers> eduControllers;
  final List<ExpControllers> expControllers;
  final List<LanguagesControllers> languagesControllers;
  final List<SkillsControllers> skillsControllers;
  final PersonalControllers personalControllers;

  UserController({
    required this.eduControllers,
    required this.expControllers,
    required this.languagesControllers,
    required this.skillsControllers,
    required this.personalControllers,
  });
}

class TransformerUserController {
  static UserController fromUserInfo(UserInfo? userInfo) {
    userInfo = GetConnectedUser().connectedUser;
    return UserController(
      eduControllers: _convertEdu(userInfo!.eduQualifications),
      expControllers: _convertExp(userInfo.experiences),
      languagesControllers: _convertLan(userInfo.languages),
      skillsControllers: _convertSkill(userInfo.skills),
      personalControllers: _convertPersonal(userInfo),
    );
  }

  static List<EduControllers> _convertEdu(List<EducationCertificate> list) {
    return list.map((e) {
      EduControllers edu = EduControllers();
      edu.certificateName.text = e.field;
      edu.degree.text = e.degree;
      edu.university.text = e.university;
      edu.graduation.text = e.graduationDate == null
          ? ''
          : DateFormat.yMMMd().format(e.graduationDate!.toDate());
      return edu;
    }).toList();
  }

  static List<ExpControllers> _convertExp(List<PastJob> list) {
    return list.map((e) {
      ExpControllers exp = ExpControllers();
      exp.title.text = e.title;
      exp.start.text =
          e.start == null ? '' : DateFormat.yMMMd().format(e.start!.toDate());
      exp.duration.text = e.start == null || e.start == null
          ? ''
          : ((e.end!.toDate().difference(e.start!.toDate())).inDays / 365)
              .toString();
      return exp;
    }).toList();
  }

  static List<LanguagesControllers> _convertLan(List<String> list) {
    return list.map((e) {
      LanguagesControllers lan = LanguagesControllers();
      lan.title.text = e;
      return lan;
    }).toList();
  }

  static List<SkillsControllers> _convertSkill(List<String> list) {
    return list.map((e) {
      SkillsControllers sk = SkillsControllers();
      sk.title.text = e;
      return sk;
    }).toList();
  }

  static PersonalControllers _convertPersonal(UserInfo userInfo) {
    return PersonalControllers(
      rating: userInfo.rating.toString(),
      fName: TextEditingController(text: userInfo.firstName),
      mName: TextEditingController(text: userInfo.middleName),
      lName: TextEditingController(text: userInfo.lastName),
      email: TextEditingController(text: userInfo.email),
      freeSpace: TextEditingController(text: userInfo.summary),
      tempGender: userInfo.gender,
      tempPhones:
          userInfo.phones.map((e) => TextEditingController(text: e)).toList(),
      tempEmails:
          userInfo.emails.map((e) => TextEditingController(text: e)).toList(),
    );
  }

  static UserInfo fromUserController(UserController userController) {
    return UserInfo(
      rating: GetConnectedUser().connectedUser!.rating,
      id: GetConnectedUser().connectedUser!.id,
      location: GetConnectedUser().connectedUser!.location,
      nationality: GetConnectedUser().connectedUser!.nationality,
      companies: GetConnectedUser().connectedUser!.companies,
      summary: userController.personalControllers.freeSpace.text,
      email: GetConnectedUser().connectedUser!.email,
      skills:
          userController.skillsControllers.map((c) => c.title.text).toList(),
      languages:
          userController.languagesControllers.map((c) => c.title.text).toList(),
      firstName: userController.personalControllers.fName.text,
      gender: userController.personalControllers.gender,
      lastName: userController.personalControllers.lName.text,
      middleName: userController.personalControllers.mName.text,
      phones:
          userController.personalControllers.phones.map((c) => c.text).toList(),
      emails:
          userController.personalControllers.emails.map((c) => c.text).toList(),
      experiences: userController.expControllers
          .map(
            (c) => PastJob(
              title: c.title.text,
              start: (c.start.text == '')
                  ? null
                  : Timestamp.fromDate(DateFormat.yMMMd().parse(c.start.text)),
              end: (c.start.text == '')
                  ? Timestamp.fromDate(DateTime.now())
                  : Timestamp.fromDate(DateFormat.yMMMd()
                      .parse(c.start.text)
                      .add(Duration(
                          days:
                              (365 * double.parse(c.duration.text)).toInt()))),
            ),
          )
          .toList(),
      eduQualifications: userController.eduControllers
          .map(
            (c) => EducationCertificate(
              university: c.university.text,
              degree: c.degree.text,
              field: c.certificateName.text,
              graduationDate: (c.graduation.text == '')
                  ? null
                  : Timestamp.fromDate(
                      DateFormat.yMMMd().parse(c.graduation.text),
                    ),
            ),
          )
          .toList(),
    );
  }
}
