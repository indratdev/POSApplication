import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';
import 'package:posapplication/shared/utils/failure/authexception_handler.dart';

import '../../../shared/utils/failure/exception.dart';
import '../../../shared/utils/failure/failure.dart';
import '../../../shared/utils/shared_preferences/myshared_preferences.dart';
import '../signInSignUp.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final MySharedPreferences mySharedP = MySharedPreferences();

  // static String role = "";
  // static bool get isOwner => role == "Owner";
  // static bool get isAdmin => role == "Admin";
  // static bool get isCashier => role == "Cashier";
  // static bool get isChef => role == "Chef";

  // register user
  Future<Either<Failure, SignInSignUpResult>> registerUser(
      String email, String password, RoleUsers roleUsers) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var result = userCredential.user;
      if (roleUsers.name == RoleUsers.owner.name) {
        await mySharedP
            .saveCompanyID(FirebaseAuth.instance.currentUser!.uid.toString());
      }
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

  // sign in
  static Future<Either<String, SignInSignUpResult>> signInWithEmail({
    required String email,
    required String pass,
  }) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      // return SignInSignUpResult(user: result.user);
      return Right(SignInSignUpResult(user: result.user));
    } on FirebaseAuthException catch (e) {
      // return SignInSignUpResult(message: e.toString());
      var err = AuthExceptionHandler.handleAuthException(e);
      return Left((AuthExceptionHandler.generateErrorMessage(err)));
    }
  }

  // // sign in (backup)
  // static Future<Either<String, SignInSignUpResult>> signInWithEmailNew({
  //   required String email,
  //   required String pass,
  // }) async {
  //   try {
  //     UserCredential result =
  //         await _auth.signInWithEmailAndPassword(email: email, password: pass);

  //     if (result.user!.uid.isNotEmpty) {
  //       UserService().readDataUser();
  //     }

  //     return Right(SignInSignUpResult(user: result.user));
  //   } on FirebaseAuthException catch (e) {
  //     // return SignInSignUpResult(message: e.toString());
  //     var err = AuthExceptionHandler.handleAuthException(e);
  //     return Left((AuthExceptionHandler.generateErrorMessage(err)));
  //   }
  // }

  // sign in
  static Future<Either<String, Map<String, dynamic>>> signInWithEmailNew({
    required String email,
    required String pass,
  }) async {
    Map<String, dynamic> detailUser = {};
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      if (result.user!.uid.isNotEmpty) {
        detailUser = await UserService().readDataUser();
      }

      print(">>> detailuser :: ${detailUser}");

      return Right(detailUser);

      // return Right(SignInSignUpResult(user: result.user));
    } on FirebaseAuthException catch (e) {
      // return SignInSignUpResult(message: e.toString());
      var err = AuthExceptionHandler.handleAuthException(e);
      return Left((AuthExceptionHandler.generateErrorMessage(err)));
    }
  }

  // reset password
  static Future<Either<String, AuthStatus>> forgotPassword(
      {required String email}) async {
    late Either<String, AuthStatus> myEither;
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      myEither = const Right(AuthStatus.successful);
    })
        // .catchError((e) => Left(AuthExceptionHandler.handleAuthException(e)));
        .catchError((e) {
      var err = AuthExceptionHandler.handleAuthException(e);
      myEither = Left(AuthExceptionHandler.generateErrorMessage(err));
    });

    return myEither;
  }

  // log out
  void signOut() {
    _auth.signOut();
  }
}
