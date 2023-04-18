import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/service/auth_service/auth_service.dart';
import 'package:posapplication/data/service/signInSignUp.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';
import 'package:posapplication/shared/utils/shared_preferences/myshared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  MySharedPreferences mySharedP = MySharedPreferences();
  UserService userService = UserService();

  AuthBloc() : super(AuthInitial()) {
    on<RegisterRestoEvent>((event, emit) async {
      try {
        emit(LoadingRegisterResto());
        String messageError = "";
        SignInSignUpResult userData = SignInSignUpResult();

        var regisUser = await authService.registerUser(
            event.email, event.password, RoleUsers.owner);

        regisUser.fold(
          (l) => messageError = l.message,
          (data) => userData = data,
        );

        // kalau register user berhasil
        if (regisUser.isRight()) {
          var resultSaveUser = await userService.saveUserData(RoleUsers.owner);
          resultSaveUser.fold((err) {
            emit(FailureRegisterResto(messageError: "$messageError $err"));
          }, (data) {
            emit(SuccessRegisterResto(result: userData, message: data));
          });
        } else {
          emit(FailureRegisterResto(messageError: messageError));
        }
      } catch (e) {
        log(e.toString());
        emit(FailureRegisterResto(messageError: e.toString()));
      }
    });

    // // register user
    // on<RegisterRestoEvent>(
    //   (event, emit) async {
    //     emit(LoadingRegisterResto());
    //     try {
    //       String emailUser = event.email;
    //       String passwordUser = event.password;

    //       // saveUser(SignInSignUpResult r) async {
    //       //   var resultSaveUser =
    //       //       await userService.saveUserData(RoleUsers.owner);
    //       //   resultSaveUser.fold(
    //       //       (l) => emit(FailureRegisterResto(messageError: l)),
    //       //       (data) => emit(SuccessRegisterResto(result: r, message: data)));
    //       // }

    //       var result =
    //           await authService.registerUser(emailUser, passwordUser, "Owner");

    //       result.fold((l) {
    //         emit(FailureRegisterResto(messageError: l.message));
    //       }, (r) {
    //         saveUser(r);
    //       });
    //     } catch (e) {
    //       emit(FailureRegisterResto(messageError: e.toString()));
    //     }
    //   },
    //   // transformer: sequential(),
    // );

    // forgot password
    on<ForgotPasswordEvent>((event, emit) async {
      emit(LoadingForgotPassword());
      try {
        var result = await AuthService.forgotPassword(email: event.email);
        result.fold((err) {
          emit(FailureForgotPassword(messageError: err));
        }, (data) {
          emit(SuccessForgotPassword(
              result: "Periksa email anda untuk reset password"));
        });
      } catch (e) {
        emit(FailureForgotPassword(messageError: e.toString()));
      }
    });

    // login
    on<LoginUserEvent>((event, emit) async {
      Map<String, dynamic> users = {};
      // emit(LoadingLoginUser());
      try {
        // var result = await AuthService.signInWithEmail(
        //     email: event.email, pass: event.password);
        var result = await AuthService.signInWithEmailNew(
            email: event.email, pass: event.password);

        result.fold((l) {
          emit(FailureLoginUser(messageError: l));
        }, (r) {
          print(">>> r : $r");
        });

        // result.fold((err) {
        //   emit(FailureLoginUser(messageError: err));
        // }, (values) async {
        //   // print(">>> data ::: ${data}");
        //   // print(">>> role:: ${data.data()} ");
        //   // users = data.data() ?? {};
        // });
        emit(SuccessLoginUser(result: users));
      } catch (e) {
        emit(FailureLoginUser(messageError: e.toString()));
      }
    });
  }
}
