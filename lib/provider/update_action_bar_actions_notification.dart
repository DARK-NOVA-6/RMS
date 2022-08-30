import 'package:flutter/material.dart';

class UpdateActionBarActions extends ChangeNotifier {
  bool edit = false;

  changeEditMode(value) {
    edit = value;
    notifyListeners();
  }
}
