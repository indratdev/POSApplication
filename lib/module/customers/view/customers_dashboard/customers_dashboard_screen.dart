import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/customers_model.dart';

import 'package:posapplication/module/customers/bloc/customers_bloc.dart';
import 'package:posapplication/module/customers/view/customers_manage/customers_manage_screen.dart';

import 'package:posapplication/shared/routes/app_routes.dart';

class CustomersDashboardScreen extends StatefulWidget {
  const CustomersDashboardScreen({super.key});

  @override
  State<CustomersDashboardScreen> createState() =>
      _CustomersDashboardScreenState();
}

class _CustomersDashboardScreenState extends State<CustomersDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers Management"),
        centerTitle: true,
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomersManageScreen(
                          isUpdate: true, customersModel: data),
                    ));
                  },
                  child: ListTile(
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