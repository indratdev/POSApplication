import 'package:flutter/material.dart';
import 'package:posapplication/data/model/tables_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../blocs/export_bloc.dart';

class TablesDashboardScreen extends StatefulWidget {
  const TablesDashboardScreen({super.key});

  @override
  State<TablesDashboardScreen> createState() => _TablesDashboardScreenState();
}

class _TablesDashboardScreenState extends State<TablesDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tables Management"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.tablesManagement);
          },
          child: const Icon(Icons.add)),
      body: BlocBuilder<TablesBloc, TablesState>(
        builder: (context, state) {
          if (state is SuccessGetAllTable) {
            List<TablesModel> listTables = state.resultModel;

            if (listTables.isEmpty) {
              return const Center(
                child: Text("Belum Ada Table yang Di Daftarkan"),
              );
            }

            return ListView.builder(
              itemCount: listTables.length,
              itemBuilder: (context, index) {
                TablesModel data = listTables[index];
                print(">>>> data : $data");
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TablesManageScreen(isUpdate: true, tableModel: data),
                    ));
                  },
                  child: ListTile(
                    title: Text("No. Meja : ${data.tableNo}"),
                    subtitle: Text("Ukuran : ${data.size.toString()} "),
                    trailing: Text(data.tableName.toString()),
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
