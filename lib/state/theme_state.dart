import 'package:flutter/material.dart';

import '/services/storage_manager.dart';

final defaultLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 188, 147, 234),
);
final defaultDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 188, 147, 234),
  brightness: Brightness.dark,
);

class ThemeState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode getThemeMode() => _themeMode;

  void setThemeMode(ThemeMode mode) {
    StorageManager.saveData('themeMode', mode.name);
    _themeMode = mode;
    notifyListeners();
  }

  bool _isUsingUserPalette = true;
  bool getIsUsingUserPalette() => _isUsingUserPalette;

  void toggleIsUsingUserPalette(bool newValue) {
    StorageManager.saveData('isUsingUserPalette', !_isUsingUserPalette);
    _isUsingUserPalette = !_isUsingUserPalette;
    notifyListeners();
  }

  ThemeState() {
    // Init
    (() async {
      final storedThemeMode =
          await StorageManager.readString('themeMode') ?? ThemeMode.system.name;
      switch (storedThemeMode) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
          break;
      }

      _isUsingUserPalette =
          await StorageManager.readBool('isUsingUserPalette') ?? true;

      notifyListeners();
    })();
  }
}
