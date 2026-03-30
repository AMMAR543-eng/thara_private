import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thara/Global/theme/local_storage_theme.dart';

enum AppThemeMode { light, dark, system }

class AppThemeController extends GetxController {
  AppThemeMode themeMode = AppThemeMode.system;
  final LocalStorageTheme _storage = LocalStorageTheme();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTheme();
    });
  }

  void _loadTheme() {
    final savedTheme = _storage.read();

    switch (savedTheme) {
      case 'light':
        themeMode = AppThemeMode.light;
        Get.changeThemeMode(ThemeMode.light);
        break;

      case 'dark':
        themeMode = AppThemeMode.dark;
        Get.changeThemeMode(ThemeMode.dark);
        break;

      default:
        themeMode = AppThemeMode.system;
        Get.changeThemeMode(ThemeMode.system);
    }

    update();
  }

  void changeTheme(AppThemeMode mode) {
    themeMode = mode;

    switch (mode) {
      case AppThemeMode.light:
        _storage.insert('light');
        Get.changeThemeMode(ThemeMode.light);
        break;

      case AppThemeMode.dark:
        _storage.insert('dark');
        Get.changeThemeMode(ThemeMode.dark);
        break;

      case AppThemeMode.system:
        _storage.insert('system');
        Get.changeThemeMode(ThemeMode.system);
        break;
    }

    update();
  }
}
