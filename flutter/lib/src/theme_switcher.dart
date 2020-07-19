import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitcher with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _didChangeTheme = false;

  ThemeSwitcher() {
    _fetchTheme();
  }

  Future<void> _fetchTheme() async {
    final instance = await SharedPreferences.getInstance();
    final theme = instance.getString('theme');
    if (theme == null) return;
    switch (theme) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'light':
        _themeMode = ThemeMode.light;
        break;
    }
    notifyListeners();
  }

  Future<void> _saveTheme(ThemeMode theme) async {
    if (!_didChangeTheme) return;
    final instance = await SharedPreferences.getInstance();
    await instance.setString(
        'theme', theme == ThemeMode.dark ? 'dark' : 'light');
  }

  ThemeMode get themeMode => _themeMode;

  void switchTheme() {
    var newTheme;
    if (_themeMode == ThemeMode.system)
      _themeMode =
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;
    switch (_themeMode) {
      case ThemeMode.dark:
        newTheme = ThemeMode.light;
        break;
      case ThemeMode.light:
        newTheme = ThemeMode.dark;
        break;
      default:
        newTheme = _themeMode;
    }
    _themeMode = newTheme;
    _didChangeTheme = true;
    _saveTheme(_themeMode);
    notifyListeners();
  }

  void resetTheme() {
    _themeMode = ThemeMode.system;
    _didChangeTheme = false;
    _deleteTheme();
    notifyListeners();
  }

  Future<void> _deleteTheme() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('theme');
  }
}
