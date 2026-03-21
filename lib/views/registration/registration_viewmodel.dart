import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_firebase_error_mapper.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/services/firebase_authentication_service.dart';

enum RegistrationStatus { idle, loading, success, error }

class RegistrationViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  RegistrationStatus status = RegistrationStatus.idle;
  String? message;
  bool get isLoading => status == RegistrationStatus.loading;

  Future<void> registerUser(UserModel user) async {
    status = RegistrationStatus.loading;
    message = null;
    notifyListeners();

    try {
      await _authService.register(user.email, user.password);
      status = RegistrationStatus.success;
      message = 'Registration Successful!';
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      status = RegistrationStatus.error;
      message = FirebaseErrorHelper.getMessage(e);
      notifyListeners();
    } catch (e) {
      status = RegistrationStatus.error;
      message = 'Something went wrong. Please try again.2';
      notifyListeners();
    }
  }
}
