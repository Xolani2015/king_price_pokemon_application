import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  // Light mode colors
  static const primary = Color(0xFFBD190D);
  static const secondary = Color(0xFF8A1209);
  static const background = Colors.white;
  static const text = Colors.black;
  static const cardShadow = Colors.black12;
  static const primaryButtonBackground = primary;
  static const secondaryPrimaryBackground = Colors.white;
  static const icon = Color(0xFFBD190D);

  // Dark mode colors
  static const darkBackground = Color.fromARGB(255, 34, 34, 34);
  static const darkText = Colors.white;
  static const darkCardShadow = Color.fromARGB(31, 229, 43, 43);
  static const darkSecondaryPrimaryBackground = Color.fromARGB(255, 34, 34, 34);
  static const darkPrimaryButtonBackground = primary;
  static const darkIcon = Colors.white;
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,

  shadowColor: AppColors.cardShadow,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.text)),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.darkBackground,

  shadowColor: AppColors.darkCardShadow,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.darkText)),
);

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme(_isDarkMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }
}
