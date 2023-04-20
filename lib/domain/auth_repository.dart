import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posapplication/data/service/auth_service/auth_service.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../data/model/users_model.dart';
import '../data/service/signInSignUp.dart';
import '../shared/utils/failure/failure.dart';

class AuthRepository {
  final AuthService authService = AuthService();

  String accessMenuByRole(String role) {
    String route = "";
    if (role == RoleUsers.owner.name) {
      route = AppRoutes.ownerDashboard;
    }

    return route;
  }

  // add new user
  Future<User?> addNewUser(UsersModel userProfile) async {
    User? result;
    try {
      Either<Failure, SignInSignUpResult> datas =
          await authService.registerNewUser(
        userProfile.email.toString(),
        userProfile.role.toString(),
      );
      datas.fold(
        (err) {
          throw Exception(err.message);
        },
        (dataUser) {
          result = dataUser.user;
        },
      );
    } on Exception catch (e) {
      print("------");
      log(e.toString());
      throw Exception(e);
    }
    return result;
  }
}
