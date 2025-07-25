import 'package:flutter/material.dart';
import '../../core/themes/app_theme.dart';

enum AppThemeType { light, dark, blue }

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;
  AppThemeType _themeType = AppThemeType.light;

  ThemeData get themeData => _themeData;
  AppThemeType get themeType => _themeType;

  void setTheme(AppThemeType type) {
    _themeType = type;
    switch (type) {
      case AppThemeType.light:
        _themeData = AppTheme.lightTheme;
        break;
      case AppThemeType.dark:
        _themeData = AppTheme.darkTheme;
        break;
      case AppThemeType.blue:
        _themeData = AppTheme.blueTheme;
        break;
    }
    notifyListeners();
  }
}
