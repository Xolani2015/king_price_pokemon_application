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
  Map<String, String?> fieldErrors = {};
  Map<String, String?> validateUser(UserModel user, String confirmPassword) {
    final errors = <String, String?>{};

    if (user.username.isEmpty) {
      errors['username'] = 'Name is required';
    }
    if (user.email.isEmpty) {
      errors['email'] = 'Email is required';
    } else {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(user.email)) {
        errors['email'] = 'Whoops, this email is invalid';
      }
    }
    if (user.password.isEmpty) {
      errors['password'] = 'Password is required';
    } else if (user.password.length < 6) {
      errors['password'] = 'Password must be at least 6 characters';
    }
    if (user.password != confirmPassword) {
      errors['confirmPassword'] = 'Whoops, the passwords do not match';
    }

    fieldErrors = errors;
    notifyListeners();
    return errors;
  }

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
      message = FirebaseErrorHelper.getRegistrationMessage(e);
      notifyListeners();
    } catch (e) {
      status = RegistrationStatus.error;
      message = 'Something went wrong. Please try again.';
      notifyListeners();
    }
  }
}
