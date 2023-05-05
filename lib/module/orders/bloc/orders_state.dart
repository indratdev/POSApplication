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

// selected tables
class SuccessSelectedTable extends OrdersState {
  TablesModel result;

  SuccessSelectedTable({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// end selected customer

// Get Item By Category
class LoadingGetItemsByCategory extends OrdersState {}

class FailureGetItemsByCategory extends FailureOrders {
  FailureGetItemsByCategory({required super.messageError});
}

class SuccessGetItemsByCategory extends OrdersState {
  List<ItemsModel> resultModel;

  SuccessGetItemsByCategory({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END Get Item By Category
