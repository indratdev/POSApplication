import 'package:firebase_auth/firebase_auth.dart';

class SignInSignUpResult {
  User? user;
  final String message;

  SignInSignUpResult({
    this.user,
    this.message = "",
  });
}
