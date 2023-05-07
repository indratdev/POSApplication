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

class SelectedCustomerOrderEvent extends OrdersEvent {
  bool isIncrement;
  List<ItemsModel> allCustomerOrders;
  ItemsModel selectedItemModel;

  SelectedCustomerOrderEvent({
    required this.isIncrement,
    required this.allCustomerOrders,
    required this.selectedItemModel,
  });
}