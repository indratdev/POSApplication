import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/service/auth_service/auth_service.dart';
import 'package:posapplication/service/signInSignUp.dart';
import 'package:posapplication/shared/utils/validator/validator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    // register
    on<RegisterRestoEvent>((event, emit) async {
      emit(LoadingRegisterResto());
      try {
        String emailUser = event.email;
        String passwordUser = event.password;
        String rePasswordUser = event.rePassword;

        bool isValidPassword =
            Validator.isPasswordEquals(passwordUser, rePasswordUser);

        if (!isValidPassword) {
          // if password and repassword not equals
          emit(FailureRegisterResto(messageError: "Kata Sandi Tidak Sesuai"));
        } else {
          var result =
              await authService.registerUser(emailUser, passwordUser, "Owner");
          result.fold(
            (l) => emit(FailureRegisterResto(messageError: l.message)),
            (r) => emit(SuccessRegisterResto(result: r, message: r.message)),
          );
        }
      } catch (e) {
        emit(FailureRegisterResto(messageError: e.toString()));
      }
    });

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
      emit(LoadingLoginUser());
      try {
        var result = await AuthService.signInWithEmail(
            email: event.email, pass: event.password);
        result.fold((err) {
          emit(FailureLoginUser(messageError: err));
        }, (data) {
          print(">>> data : ${data.user}");
          emit(SuccessLoginUser(result: data));
        });
      } catch (e) {
        emit(FailureLoginUser(messageError: e.toString()));
      }
    });
  }
}
