part of 'owner_bloc.dart';

abstract class OwnerEvent extends Equatable {
  const OwnerEvent();

  @override
  List<Object> get props => [];
}

class AddProfileCompanyEvent extends OwnerEvent {
  ProfileModel profileModel;

  AddProfileCompanyEvent({
    required this.profileModel,
  });
}

// update profile company
class UpdateProfileCompanyEvent extends OwnerEvent {
  ProfileModel profileModel;

  UpdateProfileCompanyEvent({
    required this.profileModel,
  });
}

class CheckProfileBoxAndFirebaseEvent extends OwnerEvent {}

class LogoutEvent extends OwnerEvent {}

class OpenBoxProfileEvent extends OwnerEvent {}
