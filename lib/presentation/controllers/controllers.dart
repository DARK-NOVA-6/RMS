import 'package:flutter/material.dart';
export 'edu_controllers.dart';
export 'personal_controllers.dart';
export 'exp_controllers.dart';
export 'skills_controllers.dart';
export 'lang_controllers.dart';
export 'user_controller.dart';

class Controllers {
  final TextEditingController tecEmailSignUp = TextEditingController(),
      tecPassSignUp = TextEditingController(),
      tecConfPassSignUp = TextEditingController(),
      tecEmailLogIn = TextEditingController(),
      tecPassLogIn = TextEditingController();
}
