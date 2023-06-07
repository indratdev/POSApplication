part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersEvent extends UsersEvent {}

class GetAllUsersFromFirebaseEvent extends UsersEvent {}

class GetAllUsersFromBoxEvent extends UsersEvent {}

class AddNewUsersEvent extends UsersEvent {
  UsersModel userModel;

  AddNewUsersEvent({
    required this.userModel,
  });
}

class UpdateUsersEvent extends UsersEvent {
  UsersModel userModel;

  UpdateUsersEvent({
    required this.userModel,
  });
}

class deleteUsersEvent extends UsersEvent {
  String documentID;

  deleteUsersEvent({
    required this.documentID,
  });
}

class selectedUserEvent extends UsersEvent {
  UsersModel user;

  selectedUserEvent({
    required this.user,
  });
}
