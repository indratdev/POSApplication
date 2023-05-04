part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class FailureOrders extends OrdersState {
  String messageError;

  FailureOrders({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

// selected customer

class SuccessSelectedCustomer extends OrdersState {
  CustomersModel result;

  SuccessSelectedCustomer({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

// end selected customer
