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

// selected final orders
class LoadingSelectedFinalOrders extends OrdersState {}

class FailureSelectedFinalOrders extends FailureOrders {
  FailureSelectedFinalOrders({required super.messageError});
}

class SuccessSelectedFinalOrders extends OrdersState {
  List<OrdersModel> resultModel;

  SuccessSelectedFinalOrders({
    required this.resultModel,
  });

  @override
  List<Object> get props => [resultModel];
}

// selected user
class LoadingSelectedStaffHandle extends OrdersState {}

class FailureSelectedStaffHandle extends FailureOrders {
  FailureSelectedStaffHandle({required super.messageError});
}

class SuccessSelectedStaffHandle extends OrdersState {
  UsersModel result;

  SuccessSelectedStaffHandle({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// end selected customer

// proses orders
class LoadingProcessOrders extends OrdersState {}

class FailureProcessOrders extends FailureOrders {
  FailureProcessOrders({required super.messageError});
}

class SuccessProcessOrders extends OrdersState {
  String result;

  SuccessProcessOrders({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
// end proses orders

// get profile company from box
class LoadingConfirmationOrder extends OrdersState {}

class FailureConfirmationOrder extends FailureOrders {
  FailureConfirmationOrder({required super.messageError});
}

class SuccessConfirmationOrder extends OrdersState {
  ProfileModel profileModel;
  List<OrdersModel> requestOrder;
  // UsersModel currentUserLogin;

  SuccessConfirmationOrder({
    required this.profileModel,
    required this.requestOrder,
    // required this.currentUserLogin,
  });

  @override
  List<Object> get props => [profileModel];
}

// update status order
// get profile company from box
class LoadingUpdateStatusOrder extends OrdersState {}

class FailureUpdateStatusOrder extends FailureOrders {
  FailureUpdateStatusOrder({required super.messageError});
}

class SuccessUpdateStatusOrder extends OrdersState {
  String result;

  SuccessUpdateStatusOrder({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
