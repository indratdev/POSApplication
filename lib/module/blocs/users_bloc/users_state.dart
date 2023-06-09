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

// Get all users from firebase
class LoadingGetAllUserFromFirebase extends UsersState {}

class FailureGetAllUserFromFirebase extends FailureUsers {
  FailureGetAllUserFromFirebase({required super.messageError});
}

class SuccessGetAllUserFromFirebase extends UsersState {
  List<UsersModel> resultModel;

  SuccessGetAllUserFromFirebase({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get all users from firebase

// Get all users from box
class LoadingGetAllUserFromBox extends UsersState {}

class FailureGetAllUserFromBox extends FailureUsers {
  FailureGetAllUserFromBox({required super.messageError});
}

class SuccessGetAllUserFromBox extends UsersState {
  List<UsersModel> resultModel;

  SuccessGetAllUserFromBox({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get all users

// Add new user
class LoadingAddNewUser extends UsersState {}

class FailureAddNewUser extends FailureUsers {
  FailureAddNewUser({required super.messageError});
}

class SuccessAddNewUser extends UsersState {
  String result;

  SuccessAddNewUser({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END Get all users

// update users
class LoadingUpdateUser extends UsersState {}

class FailureUpdateUser extends FailureUsers {
  FailureUpdateUser({required super.messageError});
}

class SuccessUpdateUser extends UsersState {
  String result;

  SuccessUpdateUser({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update users

// delete users
class LoadingDeleteUser extends UsersState {}

class FailureDeleteUser extends FailureUsers {
  FailureDeleteUser({required super.messageError});
}

class SuccessDeleteUser extends UsersState {
  String result;

  SuccessDeleteUser({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END update users

// selected users
class LoadingSelectedUser extends UsersState {}

class FailureSelectedUser extends FailureUsers {
  FailureSelectedUser({required super.messageError});
}

class SuccessSelectedUser extends UsersState {
  UsersModel user;

  SuccessSelectedUser({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
// END update users