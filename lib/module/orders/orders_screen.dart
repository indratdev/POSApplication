import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/data/model/tables_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../shared/routes/app_routes.dart';

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
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const CustomersSelectedScreen(),
                          //   ),
                          // );
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
                              "Silahkan Pilih Pelanggan"),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // table
                      InkWell(
                        onTap: () {
                          BlocProvider.of<TablesBloc>(context)
                              .add(GetAllTablesEvent()); // call bloc customer
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const TablesSelectedScreen(),
                          //   ),
                          // );
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
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const OrdersListScreen(),
                          //   ),
                          // );
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
                                : "Pilih Pesanan",
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
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
