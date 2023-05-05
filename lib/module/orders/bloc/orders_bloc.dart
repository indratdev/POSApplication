import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/tables_model.dart';

import '../../../data/model/customers_model.dart';
import '../../../data/model/items_model.dart';
import '../../../domain/items_repository.dart';
import '../../../domain/user_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final UserRepository userRepository = UserRepository();
  final ItemsRepository itemsRepository = ItemsRepository();

  OrdersBloc() : super(OrdersInitial()) {
    // selected customer
    on<SelectedCustomerEvent>((event, emit) {
      emit(SuccessSelectedCustomer(result: event.customersModel));
    });

    // selected customer
    on<SelectedTableEvent>((event, emit) {
      emit(SuccessSelectedTable(result: event.tablesModel));
    });

    // get item by category
    // ------- items
    on<GetItemByCategoryID>((event, emit) async {
      emit(LoadingGetItemsByCategory());
      try {
        String companyID = await userRepository.readCompanyID();
        List<ItemsModel> result = await itemsRepository.readItemsByCategoryID(
            companyID, event.categoryID);

        emit(SuccessGetItemsByCategory(resultModel: result));
      } catch (e) {
        print(e.toString());
        emit(FailureGetItemsByCategory(messageError: e.toString()));
      }
    });
  }
}
