part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}

class GetAllCustomersEvent extends CustomersEvent {}

class AddNewCustomerEvent extends CustomersEvent {
  CustomersModel customersModel;

  AddNewCustomerEvent({
    required this.customersModel,
  });
}

class UpdateCustomersEvent extends CustomersEvent {
  CustomersModel customerModel;

  UpdateCustomersEvent({
    required this.customerModel,
  });
}

class deleteCustomerEvent extends CustomersEvent {
  String documentID;

  deleteCustomerEvent({
    required this.documentID,
  });
}
