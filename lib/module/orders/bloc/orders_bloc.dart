import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/tables_model.dart';

import '../../../data/model/category_model.dart';
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

    // initial orders list
    on<InitialOrderListEvent>((event, emit) async {
      emit(LoadingOrdersInitial());
      try {
        // get all category
        String companyID = await userRepository.readCompanyID();
        List<CategoryModel> resultAllCategory =
            await itemsRepository.readAllCategory(companyID);

        // get all items
        List<ItemsModel> ressultAllItems =
            await itemsRepository.readAllItems(companyID);

        emit(SuccessOrdersInitial(
            categoryModel: resultAllCategory, itemsModel: ressultAllItems));
      } catch (e) {
        log(e.toString());
        emit(FailureOrdersInitial(messageError: e.toString()));
      }
    });

    //change category
    on<ChangeCategoryEvent>((event, emit) {
      emit(LoadingChangeCategory());
      try {
        //  selectedListItem =
        // listItem.where((element) => element.categoryID == categoryID).toList();
        List<ItemsModel> listDataMaster = event.listItemModel;

        List<ItemsModel> selectedItem = listDataMaster
            .where((element) => element.categoryID == event.categoryID)
            .toList();

        emit(SuccessChangeCategory(
          index: event.index,
          resultModel: selectedItem,
        ));
      } catch (e) {
        log(e.toString());
        emit(FailureChangeCategory(messageError: e.toString()));
      }
    });

    // selected customer orders
    on<SelectedCustomerOrderEvent>((event, emit) {
      emit(LoadingSelectedCustomerOrders());
      try {
        double totalOrderPrice = 0;
        List<ItemsModel>? finalCustomerOrders = event.allCustomerOrders;

        (event.isIncrement)
            ? finalCustomerOrders.add(event.selectedItemModel)
            : finalCustomerOrders.remove(event.selectedItemModel);

        finalCustomerOrders.map((e) {
          totalOrderPrice += e.sellPrice;
        });

        emit(SuccessSelectedCustomerOrders(
          resultModel: finalCustomerOrders,
          totalOrdersPrice: totalOrderPrice,
        ));
      } catch (e) {
        log(e.toString());
        emit(FailureSelectedCustomerOrders(messageError: e.toString()));
      }
    });
  }
}
