import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences prefs;
  late bool _darkTheme;

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool get darkTheme => _darkTheme; //Getter

  ThemeNotifier() {
    _darkTheme = true;
    loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    saveToPrefs();
    notifyListeners();
  }

  loadFromPrefs() async {
    await getSharedPreferences();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  saveToPrefs() async {
    await getSharedPreferences();
    prefs.setBool(key, darkTheme);
  }
}
