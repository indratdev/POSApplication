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

// profile company
class LoadingAddProfileCompany extends OwnerState {}

class FailureAddProfileCompany extends FailureOwner {
  FailureAddProfileCompany({required super.messageError});
}

class SuccessAddProfileCompany extends OwnerState {
  String status;

  SuccessAddProfileCompany({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}

// profile company end

