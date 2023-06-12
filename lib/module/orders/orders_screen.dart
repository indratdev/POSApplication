import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/data/model/tables_model.dart';

import 'package:posapplication/module/export.dart';

import 'package:posapplication/shared/utils/general_function.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../data/model/users_model.dart';
import '../blocs/export_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _formKeyTransaction = GlobalKey<FormState>();
  TablesModel? selectedTable;
  CustomersModel? selectedCustomer;
  List<OrdersModel> selectedOrders = [];
  UsersModel? selectedStaffHandle;

  fillEmptyData() async {
    String orderID = await GeneralFunction().generateOrderID();

    // table
    for (var element in selectedOrders) {
      if (selectedTable == null) {
        element.dataTable = TablesModel(
            companyID: "",
            tableID: "",
            shape: "",
            size: 0,
            tableName: "",
            tableNo: "");
      } else {
        element.dataTable = selectedTable;
      }
    }

    // Users
    for (var element in selectedOrders) {
      element.userHandleBy = selectedStaffHandle?.firstname ?? "";
      element.userHandleID = selectedStaffHandle?.userID ?? "";
    }

    // customer
    for (var element in selectedOrders) {
      element.dataCustomer = selectedCustomer;
    }

    //fill status
    for (var element in selectedOrders) {
      print(">>> selectedTable : ${selectedTable?.tableID}");
      // kalau staff handle atau table id masih kosong, statusnya jadi waiting
      if (selectedStaffHandle == null ||
          selectedTable?.tableID == "" ||
          selectedTable?.tableID == null) {
        element.status = StatusOrder.waiting.name.toString();
      } else {
        element.status = StatusOrder.progress.name.toString();
      }
    }

    //fill order id
    for (var element in selectedOrders) {
      element.orderID = orderID;
    }
  }

  resetAll() {
    selectedTable = null;
    selectedCustomer = null;
    selectedOrders = [];
    selectedStaffHandle = null;
  }

  @override
  void initState() {
    super.initState();
    resetAll();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transaksi"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is SuccessSelectedCustomer) {
                CustomWidgets.showSnackBarCustom(
                    context, "Pelanggan Berhasil Dipilih");
              }
              if (state is SuccessSelectedTable) {
                CustomWidgets.showSnackBarCustom(
                    context, "Meja Berhasil Dipilih");
              }
              if (state is SuccessSelectedFinalOrders) {
                CustomWidgets.showSnackBarCustom(
                    context, "Pesanan Berhasil Dipilih");
              }
              if (state is SuccessSelectedStaffHandle) {
                CustomWidgets.showSnackBarCustom(
                    context, "Staff Berhasil Dipilih");
              }
            },
            builder: (context, state) {
              if (state is SuccessSelectedCustomer) {
                selectedCustomer = state.result;
              }
              if (state is SuccessSelectedTable) {
                selectedTable = state.result;
              }

              if (state is SuccessSelectedFinalOrders) {
                selectedOrders = state.resultModel;
              }

              if (state is SuccessSelectedStaffHandle) {
                selectedStaffHandle = state.result;
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKeyTransaction,
                  child: Column(
                    children: [
                      // pelanggan
                      InkWell(
                        onTap: () {
                          BlocProvider.of<CustomersBloc>(context).add(
                              GetAllCustomersEvent()); // call bloc customer

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: CustomersSelectedScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: ListTile(
                          minLeadingWidth: 0,
                          title: Text(selectedCustomer?.fullname ??
                              "Silahkan Pilih Pelanggan *"),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // table
                      InkWell(
                        onTap: () {
                          BlocProvider.of<TablesBloc>(context)
                              .add(GetAllTablesEvent()); // call bloc customer

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: TablesSelectedScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: ListTile(
                          minLeadingWidth: 0,
                          title: Text(selectedTable?.tableName ??
                              "Silahkan Pilih Meja"),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // order
                      InkWell(
                        onTap: () {
                          BlocProvider.of<OrdersBloc>(context).add(
                              InitialOrderListEvent()); // call bloc customer

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: OrdersListScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: ListTile(
                          minLeadingWidth: 0,
                          // title: Text(
                          //     selectedTable?.tableName ?? "Silahkan Pilih Meja"),
                          // title: Text("Pilih Pesanan"),
                          title: Text(
                            (selectedOrders.isNotEmpty)
                                ? "Pesanan Sudah Dipilih"
                                : "Pilih Pesanan *",
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // staff handle
                      InkWell(
                        onTap: () {
                          // BlocProvider.of<UsersBloc>(context)
                          //     .add(GetAllUsersEvent()); // call bloc customer
                          BlocProvider.of<UsersBloc>(context)
                              .add(GetAllUsersFromBoxEvent());

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: UserSelectedScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: ListTile(
                          minLeadingWidth: 0,
                          // title: Text(selectedStaffHandle?.firstname ??
                          //     "Silahkan Pilih Staff (Optional)"),
                          title: (selectedStaffHandle == null)
                              ? const Text("Silahkan Pilih Staff")
                              : Text(
                                  "${selectedStaffHandle?.firstname} ${selectedStaffHandle?.lastname}"),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await fillEmptyData();
                          BlocProvider.of<OrdersBloc>(context)
                              .add(ConfirmationOrdersEvent(
                            requestOrder: selectedOrders,
                          ));

                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: OrdersConfirmationScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: const Text("PROSES PESANAN"),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
