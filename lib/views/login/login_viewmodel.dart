import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_firebase_error_mapper.dart';
import 'package:king_price_pokemon_application/models/user_model.dart';
import 'package:king_price_pokemon_application/services/firebase_authentication_service.dart';

enum LoginStatus { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  LoginStatus status = LoginStatus.idle;
  String? message;
  bool get isLoading => status == LoginStatus.loading;

  Future<void> login(UserModel user) async {
    status = LoginStatus.loading;
    message = null;
    notifyListeners();

    try {
      await _authService.login(user.email, user.password);
      status = LoginStatus.success;
      message = 'Login Successful!';
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      status = LoginStatus.error;
      message = FirebaseErrorHelper.getLoginMessage(e);
      notifyListeners();
    } catch (e) {
      status = LoginStatus.error;
      message = 'Something went wrong. Please try again.2';
      notifyListeners();
    }
  }
}
