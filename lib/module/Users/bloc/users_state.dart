part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class FailureUsers extends UsersState {
  String messageError;

  FailureUsers({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// Get all users

class LoadingGetAllUser extends UsersState {}

class FailureGetAllUser extends FailureUsers {
  FailureGetAllUser({required super.messageError});
}

class SuccessGetAllUser extends UsersState {
  List<UsersModel> resultModel;

  SuccessGetAllUser({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}

// END Get all users