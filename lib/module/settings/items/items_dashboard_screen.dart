import 'package:flutter/material.dart';
import 'package:posapplication/data/model/items_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../shared/constants/constants.dart';
import '../../blocs/export_bloc.dart';

class ItemsDashboardScreen extends StatefulWidget {
  const ItemsDashboardScreen({super.key});

  @override
  State<ItemsDashboardScreen> createState() => _ItemsDashboardScreenState();
}

class _ItemsDashboardScreenState extends State<ItemsDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item / Barang"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.itemsManagement);
            context.read<SettingsBloc>().add(GetAllCategoryEvent());
          },
          child: const Icon(Icons.add)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SuccessGetAllItems) {
            List<ItemsModel> listItems = state.resultModel;
            // print(listItems.length);

            if (listItems.isEmpty) {
              return const Center(
                child: Text("Belum Ada Items / Barang yang Di Daftarkan"),
              );
            }

            return ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                ItemsModel data = listItems[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ItemsManagementScreen(
                          isUpdate: true,
                          itemsModel: data,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: mainWhite,
                    child: ListTile(
                      title: Text(data.itemName.toString()),
                    ),
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
