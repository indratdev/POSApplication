import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/customers_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    // selected customer
    on<SelectedCustomerEvent>((event, emit) {
      emit(SuccessSelectedCustomer(result: event.customersModel));
    });

    // end selected category
  }
}
