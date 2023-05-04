import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/data/model/tables_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _formKeyTransaction = GlobalKey<FormState>();
  TablesModel? selectedTable;
  CustomersModel? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          },
          builder: (context, state) {
            if (state is SuccessSelectedCustomer) {
              selectedCustomer = state.result;
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
                        BlocProvider.of<CustomersBloc>(context)
                            .add(GetAllCustomersEvent()); // call bloc customer
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const CustomersSelectedScreen(),
                          ),
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
                        // context.read<SettingsBloc>().add(GetAllCategoryEvent());
                        // Navigator.pushNamed(context, AppRoutes.categorySelected);
                      },
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(
                            selectedTable?.tableName ?? "Silahkan Pilih Meja"),
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
    );
  }
}
