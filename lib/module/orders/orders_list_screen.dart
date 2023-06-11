import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/export_model.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/shared/constants/constants.dart';

import '../blocs/export_bloc.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  int? groupValue = 0;
  List<CategoryModel> listCategory = [];
  List<ItemsModel> listItem = [];
  List<ItemsModel> selectedListItem = [];

  CategoryModel? selectedCategory;
  ItemsModel? selectedItems;
  int selectedIndexCategory = 0;

  // List<ItemsModel> selectedOrderCustomer = [];
  // List<OrdersModel> selectedOrderCustomer = [];
  List<OrdersModel>? selectedOrderCustomer;

  fillSelectedItemList(String categoryID) {
    selectedListItem =
        listItem.where((element) => element.categoryID == categoryID).toList();
  }

  @override
  Widget build(BuildContext context) {
    // print(">>> refresh");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Pesanan"),
        centerTitle: true,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is SuccessOrdersInitial) {
            listCategory = state.categoryModel;
            listItem = state.itemsModel;
            fillSelectedItemList(listCategory.first.categoryID);
          }

          if (state is SuccessChangeCategory) {
            selectedIndexCategory = state.index;
            selectedListItem = state.resultModel;
          }

          if (state is SuccessSelectedCustomerOrders) {
            selectedOrderCustomer = state.resultModel;
          }

          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.grey.shade100,
                  child: ListView.builder(
                    itemCount: listCategory.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      CategoryModel data = listCategory[index];
                      selectedCategory = listCategory[0];

                      return InkWell(
                        onTap: () {
                          context.read<OrdersBloc>().add(
                                ChangeCategoryEvent(
                                  index: index,
                                  categoryID: data.categoryID,
                                  listItemModel: listItem,
                                ),
                              );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: (selectedIndexCategory == index)
                                  ? sageColor
                                  : inActiveIconColor.withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Text(data.categoryName),
                        ),
                      );
                    },
                  ),
                ),
              ),
              //list data
              Expanded(
                flex: 12,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8, bottom: 4, top: 4),
                  shrinkWrap: true,
                  itemCount: selectedListItem.length,
                  itemBuilder: (context, index) {
                    ItemsModel data = selectedListItem[index];
                    // return Text(data.itemName);
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          // selectedOrderCustomer.remove(data);
                          // context
                          //     .read<OrdersBloc>()
                          //     .add(SelectedCustomerOrderEvent(
                          //       isIncrement: false,
                          //       allCustomerOrders: selectedOrderCustomer,
                          //       selectedItemModel: data,
                          //     ));
                          // setState(() {});
                          // context
                          //     .read<OrdersBloc>()
                          //     .add(SelectedCustomerOrderEvent2(
                          //       isIncrement: false,
                          //       allCustomerOrders: selectedOrderCustomer,
                          //       selectedItemModel: data,
                          //     ));
                          OrdersModel datas = OrdersModel(
                            orderID: "",
                            dataItem: [
                              ItemsModel(
                                companyID: data.companyID,
                                categoryID: data.categoryID,
                                itemID: data.itemID,
                                itemName: data.itemName,
                                categoryName: data.categoryName,
                                itemPhoto: data.itemPhoto,
                                sellBy: data.sellBy,
                                sellPrice: data.sellPrice,
                              )
                            ],
                            itemCountOrder: 1,
                            userHandleBy: "",
                            totalOrdersPrice: 0,
                            status: "",
                          );
                          context
                              .read<OrdersBloc>()
                              .add(SelectedCustomerOrderEvent(
                                isIncrement: false,
                                allCustomerOrders: selectedOrderCustomer ?? [],
                                selectedItemModel: datas,
                              ));
                        },
                        icon: Icon(Icons.remove_circle),
                      ),
                      // title: Text(data.itemName),
                      title: ListTile(
                        title: Text(data.itemName),
                        subtitle: Text(data.sellPrice.toString()),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // print(">>> selected : ${data.itemName}");
                          // selectedOrderCustomer.add(data);
                          // setState(() {});
                          // context
                          //     .read<OrdersBloc>()
                          //     .add(SelectedCustomerOrderEvent(
                          //       isIncrement: true,
                          //       allCustomerOrders: selectedOrderCustomer,
                          //       selectedItemModel: data,
                          //     ));
                          // ===================
                          // context
                          //     .read<OrdersBloc>()
                          //     .add(SelectedCustomerOrderEvent2(
                          //       isIncrement: true,
                          //       allCustomerOrders: selectedOrderCustomer,
                          //       selectedItemModel: data,
                          //     ));
                          // OrdersModel datas = OrdersModel(
                          //   orderID: "",
                          //   tableNo: "",
                          //   categoryID: data.categoryID,
                          //   categoryName: data.categoryName,
                          //   companyID: data.companyID,
                          //   itemID: data.itemID,
                          //   itemName: data.itemName,
                          //   itemPhoto: data.itemPhoto,
                          //   itemCountOrder: 1,
                          //   sellBy: data.sellBy,
                          //   sellPrice: data.sellPrice,
                          //   staffHandleBy: "",
                          //   totalOrdersPrice: 0,
                          //   status: "",
                          // );
                          OrdersModel datas = OrdersModel(
                            orderID: "",
                            dataItem: [
                              ItemsModel(
                                companyID: data.companyID,
                                categoryID: data.categoryID,
                                itemID: data.itemID,
                                itemName: data.itemName,
                                categoryName: data.categoryName,
                                itemPhoto: data.itemPhoto,
                                sellBy: data.sellBy,
                                sellPrice: data.sellPrice,
                              )
                            ],
                            itemCountOrder: 1,
                            userHandleBy: "",
                            totalOrdersPrice: 0,
                            status: "",
                          );
                          context
                              .read<OrdersBloc>()
                              .add(SelectedCustomerOrderEvent(
                                isIncrement: true,
                                allCustomerOrders: selectedOrderCustomer ?? [],
                                selectedItemModel: datas,
                              ));
                        },
                        icon: Icon(Icons.add_circle),
                      ),
                    );
                  },
                ),
              ),

              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Item : ${selectedOrderCustomer?.length ?? 0} -  Rp ${selectedOrderCustomer?.first.totalOrdersPrice ?? 0} ",
                          ),
                          OutlinedButton(
                            onPressed: () {
                              List<OrdersModel> data =
                                  selectedOrderCustomer ?? [];
                              if (data.isNotEmpty) {
                                context.read<OrdersBloc>().add(
                                    FinalCustomerOrderEvent(finalOrders: data));
                                Navigator.pop(context);
                              } else {
                                print(">>> tidak data isi");
                              }
                            },
                            child: Text("PESAN"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
