part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

// initial order list
class InitialOrderListEvent extends OrdersEvent {}

// select Customer
class SelectedCustomerEvent extends OrdersEvent {
  CustomersModel customersModel;

  SelectedCustomerEvent({
    required this.customersModel,
  });
}

// select Table
class SelectedTableEvent extends OrdersEvent {
  TablesModel tablesModel;

  SelectedTableEvent({
    required this.tablesModel,
  });
}

class GetItemByCategoryID extends OrdersEvent {
  String categoryID;

  GetItemByCategoryID({
    required this.categoryID,
  });
}

class ChangeCategoryEvent extends OrdersEvent {
  int index;
  String categoryID;
  List<ItemsModel> listItemModel;

  ChangeCategoryEvent({
    required this.index,
    required this.categoryID,
    required this.listItemModel,
  });
}

// class SelectedCustomerOrderEvent extends OrdersEvent {
//   bool isIncrement;
//   List<ItemsModel> allCustomerOrders;
//   ItemsModel selectedItemModel;

//   SelectedCustomerOrderEvent({
//     required this.isIncrement,
//     required this.allCustomerOrders,
//     required this.selectedItemModel,
//   });
// }

// class SelectedCustomerOrderEvent2 extends OrdersEvent {
//   bool isIncrement;
//   List<OrdersModel> allCustomerOrders;
//   ItemsModel selectedItemModel;

//   SelectedCustomerOrderEvent2({
//     required this.isIncrement,
//     required this.allCustomerOrders,
//     required this.selectedItemModel,
//   });
// }

class SelectedCustomerOrderEvent extends OrdersEvent {
  bool isIncrement;
  List<OrdersModel> allCustomerOrders;
  OrdersModel selectedItemModel;

  SelectedCustomerOrderEvent({
    required this.isIncrement,
    required this.allCustomerOrders,
    required this.selectedItemModel,
  });
}

// select Table
class FinalCustomerOrderEvent extends OrdersEvent {
  List<OrdersModel> finalOrders;

  FinalCustomerOrderEvent({
    required this.finalOrders,
  });
}

// selected Staff Handled
class SelectedStaffHandledEvent extends OrdersEvent {
  UsersModel usersModel;

  SelectedStaffHandledEvent({
    required this.usersModel,
  });
}

class RequestOrdersEvent extends OrdersEvent {
  List<OrdersModel> requestOrder;

  RequestOrdersEvent({
    required this.requestOrder,
  });
}

class ConfirmationOrdersEvent extends OrdersEvent {
  List<OrdersModel> requestOrder;

  ConfirmationOrdersEvent({
    required this.requestOrder,
  });
}

class ProcessOrdersEvent extends OrdersEvent {
  List<OrdersModel> requestOrder;

  ProcessOrdersEvent({
    required this.requestOrder,
  });
}

class UpdateStatusOrders extends OrdersEvent {
  StatusOrder status;
  OrdersModel orderCustomer;

  UpdateStatusOrders({
    required this.status,
    required this.orderCustomer,
  });
}
