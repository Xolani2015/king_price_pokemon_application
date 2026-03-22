import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHelper {
  static String getRegistrationMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Sorry Email Taken';
      case 'invalid-email':
        return 'Enter Valid Email';
      case 'weak-password':
        return 'Your password is Weak';
      case 'network-request-failed':
        return 'Network Error';
      default:
        return e.message ?? 'Registration failed';
    }
  }

  static String getLoginMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Enter Valid Email';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'network-request-failed':
        return 'Network error';
      default:
        return e.message ?? 'Login failed';
    }
  }
}
