part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

// select Customer
class SelectedCustomerEvent extends OrdersEvent {
  CustomersModel customersModel;

  SelectedCustomerEvent({
    required this.customersModel,
  });
}
