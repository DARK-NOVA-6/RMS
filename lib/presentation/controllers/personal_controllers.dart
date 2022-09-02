import 'package:flutter/material.dart';

class PersonalControllers {
  final TextEditingController fName, mName, lName, email, freeSpace;

  late final List<TextEditingController> phones;

  late final String gender;

  PersonalControllers({
    required this.fName,
    required this.mName,
    required this.lName,
    required this.email,
    required this.freeSpace,
    required List<TextEditingController>? tempPhones,
    required String? tempGender,
  })  : gender = tempGender ?? '',
        phones = tempPhones ?? [];
}
