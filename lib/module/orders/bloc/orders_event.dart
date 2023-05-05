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
