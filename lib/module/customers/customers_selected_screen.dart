import 'package:flutter/material.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/shared/constants/constants.dart';

import 'package:posapplication/shared/routes/app_routes.dart';

import '../blocs/export_bloc.dart';

class CustomersSelectedScreen extends StatefulWidget {
  const CustomersSelectedScreen({super.key});

  @override
  State<CustomersSelectedScreen> createState() =>
      _CustomersSelectedScreenState();
}

class _CustomersSelectedScreenState extends State<CustomersSelectedScreen> {
  int? selectedIndex;
  CustomersModel? selectedCustomerData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pelanggan"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (selectedCustomerData != null) {
                context.read<OrdersBloc>().add(SelectedCustomerEvent(
                    customersModel: selectedCustomerData!));
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.customersManage),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
          if (state is SuccessGetAllCustomers) {
            List<CustomersModel> listUsers = state.resultModel;

            if (listUsers.isEmpty) {
              return const Center(
                child: Text("Belum Ada Pelanggan yang Didaftarkan"),
              );
            }

            return ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                CustomersModel data = listUsers[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedCustomerData = data;
                    });
                  },
                  child: ListTile(
                    tileColor: (selectedIndex == index)
                        ? sageColor
                        : Colors.transparent,
                    title: Text(data.email ?? ""),
                    subtitle: Text("${data.fullname}"),
                    // trailing: Text(data.role.toString()),
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
