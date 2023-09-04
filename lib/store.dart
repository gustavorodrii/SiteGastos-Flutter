import 'package:flutter/material.dart';

class AppStore extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void switchTheme(ThemeMode? value) {
    if (value != null) {
      _themeMode = value;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}
