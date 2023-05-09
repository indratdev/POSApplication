part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class FailureOrders extends OrdersState {
  String messageError;

  FailureOrders({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class OrdersInitial extends OrdersState {}

// order initial

class LoadingOrdersInitial extends OrdersState {}

class FailureOrdersInitial extends FailureOrders {
  FailureOrdersInitial({required super.messageError});
}

class SuccessOrdersInitial extends OrdersState {
  List<CategoryModel> categoryModel;
  List<ItemsModel> itemsModel;

  SuccessOrdersInitial({
    required this.categoryModel,
    required this.itemsModel,
  });

  @override
  List<Object> get props => [categoryModel, itemsModel];
}

//  end order initial

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

// change Category
class LoadingChangeCategory extends OrdersState {}

class FailureChangeCategory extends FailureOrders {
  FailureChangeCategory({required super.messageError});
}

class SuccessChangeCategory extends OrdersState {
  int index;
  List<ItemsModel> resultModel;

  SuccessChangeCategory({
    required this.index,
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}
// END change Category

// selected customer order
class LoadingSelectedCustomerOrders extends OrdersState {}

class FailureSelectedCustomerOrders extends FailureOrders {
  FailureSelectedCustomerOrders({required super.messageError});
}

class SuccessSelectedCustomerOrders extends OrdersState {
  List<OrdersModel> resultModel;
  double totalOrdersPrice;

  SuccessSelectedCustomerOrders({
    required this.resultModel,
    this.totalOrdersPrice = 0,
  });

  @override
  List<Object> get props => [resultModel];
}

class SuccessSelectedCustomerOrders2 extends OrdersState {
  List<ItemsModel> resultModel;
  double totalOrdersPrice;

  SuccessSelectedCustomerOrders2({
    required this.resultModel,
    this.totalOrdersPrice = 0,
  });

  @override
  List<Object> get props => [resultModel];
}
// END selected customer order