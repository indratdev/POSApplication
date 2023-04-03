part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterRestoEvent extends AuthEvent {
  String email;
  String password;

  RegisterRestoEvent({
    required this.email,
    required this.password,
  });
}
