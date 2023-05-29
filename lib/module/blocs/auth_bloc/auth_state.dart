part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class FailureState extends AuthState {
  String messageError;

  FailureState({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// register
class LoadingRegisterResto extends AuthState {}

class FailureRegisterResto extends FailureState {
  FailureRegisterResto({required super.messageError});
}

class SuccessRegisterResto extends AuthState {
  SignInSignUpResult result;
  String message;

  SuccessRegisterResto({
    required this.result,
    required this.message,
  });

  @override
  List<Object> get props => [result, message];
}
// register end

// forgot password
class LoadingForgotPassword extends AuthState {}

class FailureForgotPassword extends FailureState {
  FailureForgotPassword({required super.messageError});
}

class SuccessForgotPassword extends AuthState {
  String result;

  SuccessForgotPassword({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// forgot password end

// login
class LoadingLoginUser extends AuthState {}

class FailureLoginUser extends FailureState {
  FailureLoginUser({required super.messageError});
}

class SuccessLoginUser extends AuthState {
  Map<String, dynamic> result;

  SuccessLoginUser({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// login end