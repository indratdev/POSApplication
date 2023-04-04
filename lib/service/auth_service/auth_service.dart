import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posapplication/shared/utils/failure/authexception_handler.dart';

import '../../shared/utils/failure/exception.dart';
import '../../shared/utils/failure/failure.dart';
import '../signInSignUp.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String role = "";
  static bool get isOwner => role == "Owner";
  static bool get isAdmin => role == "Admin";
  static bool get isCashier => role == "Cashier";
  static bool get isChef => role == "Chef";

  // Future<Either<String, SignInSignUpResult>> registerUser2(
  //     String email, String password, String role) async {
  //   // User? result;
  //   // String message = "";

  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // The user has been created successfully
  //     var result = userCredential.user;

  //     print(">>> ${result}");
  //     return right(SignInSignUpResult(user: result));
  //   } on FirebaseAuthException catch (e) {
  //     // Handle any errors that occur during the user creation process
  //     if (e.code == 'weak-password') {
  //       message = "The password provided is too weak.";
  //       return left(message);
  //     } else if (e.code == 'email-already-in-use') {
  //       message = "The account already exists for that email.";
  //       return left(message);
  //     }
  //   } catch (e) {
  //     message = e.toString();
  //     return left(message);
  //   }
  //   // return right(SignInSignUpResult(user: result));

  //   // return SignInSignUpResult(user: result, message: message);
  // }

  Future<Either<Failure, SignInSignUpResult>> registerUser(
      String email, String password, String role) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var result = userCredential.user;
      return Right(SignInSignUpResult(
          user: result,
          message: "Pendaftaran User Baru Berhasil \n Silahkan Login"));
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }
      return Left(GeneralFailure(message));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  // reset password
  static Future<Either<String, AuthStatus>> forgotPassword(
      {required String email}) async {
    late Either<String, AuthStatus> myEither;
    await _auth
        .sendPasswordResetEmail(email: email)
        // .then((value) =>  Right(AuthStatus.successful))
        .then((value) {
      myEither = Right(AuthStatus.successful);
    })
        // .catchError((e) => Left(AuthExceptionHandler.handleAuthException(e)));
        .catchError((e) {
      var err = AuthExceptionHandler.handleAuthException(e);
      myEither = Left(AuthExceptionHandler.generateErrorMessage(err));
    });

    return myEither;
  }
  // static Future<String, AuthStatus> forgotPassword(
  //     {required String email}) async {
  // try {
  //   await _auth.sendPasswordResetEmail(email: email).then((value) {
  //     return Right(AuthStatus.successful);
  //   }).catchError((e) {
  //     return Left(AuthExceptionHandler.handleAuthException(e));
  //   });
  // } on FirebaseAuthException catch (e) {
  //   return Left(AuthExceptionHandler.generateErrorMessage(e));
  // }

  // static Future<Either<Failure, AuthStatus>> forgotPassword(
  //     {required String email}) async {
  //   // late AuthStatus status;

  //   await _auth
  //       .sendPasswordResetEmail(email: email)
  //       // .then((value) => status = AuthStatus.successful)
  //       .then((value) {
  //     return const Right(AuthStatus.successful);
  //   })
  //       // .catchError((e) => status = AuthExceptionHandler.handleAuthException(e));
  //       .catchError(
  //     (e) {
  //       return Left(AuthExceptionHandler.handleAuthException(e));
  //     },
  //   );

  //   // print(">>> status : $status");

  //   // return status;
  // }

  // log out
  static void signOut() {
    _auth.signOut();
  }
}
