import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/items_model.dart';
import '../../../shared/utils/general_function.dart';
import '../../../shared/utils/validator/validator.dart';

class ItemsManagementScreen extends StatefulWidget {
  bool isUpdate;
  ItemsModel? itemsModel;

  ItemsManagementScreen({
    super.key,
    this.isUpdate = false,
    this.itemsModel,
  });

  @override
  State<ItemsManagementScreen> createState() => _ItemsManagementScreenState();
}

class _ItemsManagementScreenState extends State<ItemsManagementScreen> {
  final _formKeyItemsManage = GlobalKey<FormState>();
  TextEditingController itemsNameController = TextEditingController();
  TextEditingController nameCategoryController = TextEditingController();
  TextEditingController sellByController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoryModel selectedCategory = CategoryModel(
      companyID: "", categoryID: "", categoryName: "Pilih Kategori");
  String selectedSellBy = "price";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengelolaan Item / Barang"),
        centerTitle: true,
        actions: [
          (widget.isUpdate)
              ? IconButton(
                  onPressed: () {
                    // CustomWidgets.showConfirmationDelete(
                    //     context, "Apakah Anda Yakin Hapus User Ini ?", () {
                    //   deleteCategory(widget.itemsModel!.categoryID.toString());
                    //   Navigator.pop(context);
                    // });
                  },
                  icon: Icon(Icons.delete_forever))
              : SizedBox()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is SuccessSelectedCategory) {
              selectedCategory = state.result;
            }
          },
          child: Form(
            key: _formKeyItemsManage,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: itemsNameController,
                      decoration: const InputDecoration(
                        label: Text("Nama Item / Barang"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.categorySelected);
                      },
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(selectedCategory.categoryName),
                        trailing: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text("by Harga"),
                              value: "price",
                              groupValue: selectedSellBy,
                              onChanged: (value) {
                                setState(() {
                                  selectedSellBy = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text("by KG"),
                              value: "kg",
                              groupValue: selectedSellBy,
                              onChanged: (value) {
                                setState(() {
                                  selectedSellBy = value!;
                                });
                              },
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: priceController,
                      decoration: const InputDecoration(
                        label: Text("Harga"),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 16,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("BATAL")),
                          ),
                        ),
                        const SizedBox(width: 10),
                        (widget.isUpdate)
                            // UPDATE DATA
                            ? Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: const Text("UPDATE"),
                                    onPressed: () {
                                      print("update");
                                      // addOrUpdateCategory(isUpdate: true);
                                    },
                                  ),
                                ),
                              )
                            // ADD NEW DATA
                            : Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: Text("SIMPAN"),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
