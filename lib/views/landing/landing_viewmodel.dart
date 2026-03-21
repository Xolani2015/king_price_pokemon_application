import 'package:flutter/material.dart';

class LandingViewModel extends ChangeNotifier {
  Future<void> routeTologin() async {
    notifyListeners();
  }

  Future<void> routeToRegistration() async {
    notifyListeners();
  }
}
