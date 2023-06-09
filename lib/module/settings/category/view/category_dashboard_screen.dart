import 'package:flutter/material.dart';
import 'package:posapplication/data/model/category_model.dart';

import 'package:posapplication/module/export.dart';
import 'package:posapplication/module/settings/category/view/category_management_screen.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../../shared/constants/constants.dart';
import '../../../blocs/export_bloc.dart';

class CategoryDashboardScreen extends StatefulWidget {
  const CategoryDashboardScreen({super.key});

  @override
  State<CategoryDashboardScreen> createState() =>
      _CategoryDashboardScreenState();
}

class _CategoryDashboardScreenState extends State<CategoryDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manajemen Kategori"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.categoryManagement);
          },
          child: const Icon(Icons.add)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SuccessGetAllCategory) {
            List<CategoryModel> listCategorys = state.resultModel;

            if (listCategorys.isEmpty) {
              return const Center(
                child: Text("Belum Ada Kategori yang Di Daftarkan"),
              );
            }

            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: MediaQuery.of(context).size.width / 10,
                    padding: const EdgeInsets.all(8),
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Nama Kategori : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listCategorys.length,
                  itemBuilder: (context, index) {
                    CategoryModel data = listCategorys[index];
                    print(">>>> data : $data");
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryManagementScreen(
                              isUpdate: true,
                              categoryModel: data,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: mainWhite,
                        child: ListTile(
                          // title: const Text("Nama Kategori"),
                          title: Text(data.categoryName.toString()),
                          // trailing: Text(data.tableName.toString()),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
