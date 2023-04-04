part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterRestoEvent extends AuthEvent {
  String email;
  String password;
  String rePassword;

  RegisterRestoEvent({
    required this.email,
    required this.password,
    required this.rePassword,
  });
}

class ForgotPasswordEvent extends AuthEvent {
  String email;

  ForgotPasswordEvent({
    required this.email,
  });
}

class LoginUserEvent extends AuthEvent {
  String email;
  String password;

  LoginUserEvent({
    required this.email,
    required this.password,
  });
}
