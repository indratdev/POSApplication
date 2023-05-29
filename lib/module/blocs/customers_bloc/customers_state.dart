part of 'customers_bloc.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {}

class FailureCustomers extends CustomersState {
  String messageError;

  FailureCustomers({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// Get all customers
class LoadingGetAllCustomers extends CustomersState {}

class FailureGetAllCustomers extends FailureCustomers {
  FailureGetAllCustomers({required super.messageError});
}

class SuccessGetAllCustomers extends CustomersState {
  List<CustomersModel> resultModel;

  SuccessGetAllCustomers({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get all customers

// Add new customers
class LoadingAddNewCustomer extends CustomersState {}

class FailureAddNewCustomer extends FailureCustomers {
  FailureAddNewCustomer({required super.messageError});
}

class SuccessAddNewCustomer extends CustomersState {
  String result;

  SuccessAddNewCustomer({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END add new customers

// update customers

class LoadingUpdateCustomer extends CustomersState {}

class FailureUpdateCustomer extends FailureCustomers {
  FailureUpdateCustomer({required super.messageError});
}

class SuccessUpdateCustomer extends CustomersState {
  String result;

  SuccessUpdateCustomer({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// end update customers

// delete customers
class LoadingDeleteCustomers extends CustomersState {}

class FailureDeleteCustomers extends FailureCustomers {
  FailureDeleteCustomers({required super.messageError});
}

class SuccessDeleteCustomers extends CustomersState {
  String result;

  SuccessDeleteCustomers({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// END delete customers
