import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/tables_model.dart';

import '../../../blocs/export_bloc.dart';

class TablesSelectedScreen extends StatefulWidget {
  const TablesSelectedScreen({super.key});

  @override
  State<TablesSelectedScreen> createState() => _TablesSelectedScreenState();
}

class _TablesSelectedScreenState extends State<TablesSelectedScreen> {
  int? selectedIndex;
  TablesModel? selectedTableModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meja"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (selectedTableModel != null) {
                context
                    .read<OrdersBloc>()
                    .add(SelectedTableEvent(tablesModel: selectedTableModel!));
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: BlocBuilder<TablesBloc, TablesState>(
        builder: (context, state) {
          if (state is SuccessGetAllTable) {
            List<TablesModel> listTables = state.resultModel;

            if (listTables.isEmpty) {
              return const Center(
                child: Text("Belum Ada Table yang Di Daftarkan"),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listTables.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                TablesModel data = listTables[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedTableModel = data;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: (selectedIndex == index)
                            ? Colors.amber
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("No. Meja"),
                        Text(
                          data.tableNo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(data.shape.toString()),
                      ],
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
