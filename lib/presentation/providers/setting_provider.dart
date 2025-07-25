import 'package:flutter/material.dart';
import '../../core/themes/app_theme.dart';

class SettingProvider with ChangeNotifier {
  AppThemeType _themeType = AppThemeType.light;

  AppThemeType get themeType => _themeType;

  ThemeData get currentTheme {
    switch (_themeType) {
      case AppThemeType.dark:
        return AppTheme.darkTheme;
      case AppThemeType.blue:
        return AppTheme.blueTheme;
      case AppThemeType.green:
        return AppTheme.greenTheme;
      case AppThemeType.red:
        return AppTheme.redTheme;
      case AppThemeType.light:
      default:
        return AppTheme.lightTheme;
    }
  }

  void setTheme(AppThemeType type) {
    _themeType = type;
    notifyListeners();
  }
}
