import 'package:flutter/material.dart';
import 'package:posapplication/data/model/category_model.dart';

import '../../../blocs/export_bloc.dart';

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
        title: const Text("Pilih Kategori"),
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
            icon: const Icon(Icons.check),
          ),
        ],
      ),
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
                // print(">>>> data : $data");
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedCategoryData = data;
                    });
                  },
                  child: ListTile(
                    tileColor: (selectedIndex == index)
                        ? Colors.amber
                        : Colors.transparent,
                    title: Text(data.categoryName.toString()),
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
