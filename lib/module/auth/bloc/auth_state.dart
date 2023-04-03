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

  SuccessRegisterResto({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// register end
