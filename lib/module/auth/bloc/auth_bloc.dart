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
            (r) => emit(SuccessRegisterResto(result: r)),
          );
        }
      } catch (e) {
        emit(FailureRegisterResto(messageError: e.toString()));
      }
    });
  }
}
