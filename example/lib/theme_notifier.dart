import 'package:flutter/material.dart';

final themeNotifier = ThemeNotifier();

class ThemeNotifier extends ChangeNotifier {
  ThemeMode get themeMode => _themeMode;
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    _themeMode =
        (_themeMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;

    notifyListeners();
  }
}
