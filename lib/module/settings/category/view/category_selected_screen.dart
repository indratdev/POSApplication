import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/category_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/module/settings/category/view/category_management_screen.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

class CategorySelectedScreen extends StatefulWidget {
  const CategorySelectedScreen({super.key});

  @override
  State<CategorySelectedScreen> createState() => _CategorySelectedScreenState();
}

class _CategorySelectedScreenState extends State<CategorySelectedScreen> {
  int? selectedIndex;
  CategoryModel? selectedCategoryData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Kategori"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (selectedCategoryData != null) {
                context.read<SettingsBloc>().add(SelectedCategoryEvent(
                    categoryModel: selectedCategoryData!));
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       // Navigator.pushNamed(context, AppRoutes.categoryManagement);
      //       print("object");
      //       Navigator.pushNamed(context, AppRoutes.categoryManagement);
      //     },
      //     child: Icon(Icons.add)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SuccessGetAllCategory) {
            List<CategoryModel> listCategorys = state.resultModel;

            if (listCategorys.isEmpty) {
              return const Center(
                child: Text("Belum Ada Kategori yang Di Daftarkan"),
              );
            }

            return ListView.builder(
              itemCount: listCategorys.length,
              itemBuilder: (context, index) {
                CategoryModel data = listCategorys[index];
                print(">>>> data : $data");
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedCategoryData = data;
                    });
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => CategoryManagementScreen(
                    //       isUpdate: true,
                    //       categoryModel: data,
                    //     ),
                    //   ),
                    // );
                  },
                  child: ListTile(
                    tileColor: (selectedIndex == index)
                        ? Colors.amber
                        : Colors.transparent,
                    title: Text(data.categoryName.toString()),
                    // subtitle: Text(data.categoryName.toString()),
                    // trailing: Text(data.tableName.toString()),
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
