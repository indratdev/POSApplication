part of 'owner_bloc.dart';

abstract class OwnerState extends Equatable {
  const OwnerState();

  @override
  List<Object> get props => [];
}

class OwnerInitial extends OwnerState {}

class FailureOwner extends OwnerState {
  String messageError;

  FailureOwner({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// add profile company
class LoadingAddProfileCompany extends OwnerState {}

class FailureAddProfileCompany extends FailureOwner {
  FailureAddProfileCompany({required super.messageError});
}

class SuccessAddProfileCompany extends OwnerState {
  ProfileModel dataProfile;

  SuccessAddProfileCompany({
    required this.dataProfile,
  });

  @override
  List<Object> get props => [dataProfile];
}

// add profile company end

// update profile company
class LoadingUpdateProfileCompany extends OwnerState {}

class FailureUpdateProfileCompany extends FailureOwner {
  FailureUpdateProfileCompany({required super.messageError});
}

class SuccessUpdateProfileCompany extends OwnerState {
  ProfileModel dataProfile;

  SuccessUpdateProfileCompany({
    required this.dataProfile,
  });

  @override
  List<Object> get props => [dataProfile];
}

// update profile company end