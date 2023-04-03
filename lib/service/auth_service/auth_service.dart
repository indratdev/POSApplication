import 'package:firebase_auth/firebase_auth.dart';

import '../signInSignUp.dart';

class AuthService {
  static String role = "";
  static bool get isOwner => role == "Owner";
  static bool get isAdmin => role == "Admin";
  static bool get isCashier => role == "Cashier";
  static bool get isChef => role == "Chef";

  static Future<SignInSignUpResult> registerUser(
      String email, String password, String role) async {
    User? result;
    String message = "";

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // The user has been created successfully
      result = userCredential.user;
      print(">>> ${result}");
    } on FirebaseAuthException catch (e) {
      // Handle any errors that occur during the user creation process
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }
    } catch (e) {
      message = e.toString();
    }
    return SignInSignUpResult(user: result, message: message);
  }
}
