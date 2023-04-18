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

// read profile company
class LoadingReadProfileCompany extends OwnerState {}

class FailureReadProfileCompany extends FailureOwner {
  FailureReadProfileCompany({required super.messageError});
}

class SuccessReadProfileCompany extends OwnerState {
  Box dataBox;

  SuccessReadProfileCompany({
    required this.dataBox,
  });

  @override
  List<Object> get props => [dataBox];
}

// read profile company end