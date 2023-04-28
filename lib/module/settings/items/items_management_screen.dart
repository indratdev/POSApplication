import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/category_model.dart';
import 'package:posapplication/module/export.dart';

import '../../../../shared/utils/general_function.dart';
import '../../../../shared/utils/validator/validator.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../../../data/model/items_model.dart';
import '../../../data/service/user_service/user_service.dart';
import '../../../domain/category_repository.dart';
import '../../../domain/user_repository.dart';

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
  String itemPhoto = "";

  // CategoryModel selectedCategory = CategoryModel(companyID: "", categoryID: "");
  List<CategoryModel> listCategory = [];
  String? _selectedValue;

  // String _selectedValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDatatableModel();
    // getAllCategory();
  }

  fillDatatableModel() {
    // kalau dia update data, akan isi data yang lama ke textfield
    if (widget.isUpdate == true) {
      nameCategoryController.text =
          widget.itemsModel?.categoryName.toString() ?? "";
    } else {
      return;
    }
  }

  Future<List<CategoryModel>> getAllCategory() async {
    String companyID = await UserRepository().readCompanyID();

    List<CategoryModel> result =
        await CategoryRepository().readAllCategory(companyID);

    listCategory = result;
    // _selectedValue = listCategory.first.categoryName.toString();
    // _selectedValue = result.first.categoryName.toString();

    return result;
  }

  Future<List<CategoryModel>> getAllCategory2() async {
    String companyID = await UserRepository().readCompanyID();

    List<CategoryModel> result =
        await CategoryRepository().readAllCategory(companyID);

    // listCategory = result;
    // _selectedValue = listCategory.first.categoryName.toString();
    // _selectedValue = result.first.categoryName.toString();

    return result;
  }

  addOrUpdateCategory({required bool isUpdate}) {
    if (_formKeyItemsManage.currentState!.validate()) {
      ItemsModel itemsModel = ItemsModel(
        companyID: widget.itemsModel?.companyID.toString() ?? "",
        categoryID: widget.itemsModel?.categoryID.toString() ?? "",
        categoryName: nameCategoryController.text,
        itemID: nameCategoryController.text,
        itemName: nameCategoryController.text,
        itemPhoto: nameCategoryController.text,
        sellBy: nameCategoryController.text,
        sellPrice: double.parse(nameCategoryController.text),
      );

      (isUpdate)
          // ? ""
          ? BlocProvider.of<SettingsBloc>(context)
              .add(UpdateItemsEvent(itemsModel: itemsModel))
          : BlocProvider.of<SettingsBloc>(context)
              .add(AddNewItemsEvent(itemsModel: itemsModel));
    }
  }

  deleteCategory(String documentID) {
    BlocProvider.of<SettingsBloc>(context)
        .add(deleteCategoryEvent(documentID: documentID));
  }

  @override
  Widget build(BuildContext context) {
    print("isupdate : ${widget.isUpdate}");

    print(">>>@ _slected :: ${_selectedValue}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengelolaan Item / Barang"),
        centerTitle: true,
        actions: [
          (widget.isUpdate)
              ? IconButton(
                  onPressed: () {
                    CustomWidgets.showConfirmationDelete(
                        context, "Apakah Anda Yakin Hapus User Ini ?", () {
                      deleteCategory(widget.itemsModel!.categoryID.toString());
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(Icons.delete_forever))
              : SizedBox()
        ],
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          // // add new table
          if (state is LoadingAddNewCategory) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is FailureAddNewCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessAddNewCategory) {
            CustomWidgets.showMessageAlertWithF(context, state.result, true,
                () {
              BlocProvider.of<SettingsBloc>(context).add(GetAllCategoryEvent());
              GeneralFunction.navigationBackTwoStep(context);
            });
          }

          // update category
          if (state is LoadingUpdateCategory) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is FailureUpdateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessUpdateCategory) {
            CustomWidgets.showMessageAlertWithF(context, state.result, true,
                () {
              BlocProvider.of<SettingsBloc>(context).add(GetAllCategoryEvent());
              GeneralFunction.navigationBackTwoStep(context);
            });
          }

          // delete category
          if (state is LoadingDeleteCategory) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is FailureDeleteCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessDeleteCategory) {
            CustomWidgets.showMessageAlertWithF(context, state.result, true,
                () {
              BlocProvider.of<SettingsBloc>(context).add(GetAllCategoryEvent());
              GeneralFunction.navigationBackTwoStep(context);
            });
          }
        },

        // builder: (context, state) {
        //   print(">>> state : ${state}");
        //   if (state is FailureGetAllCategory) {
        //     return Center(
        //         child: Text("Silahkan Daftarkan Kategori Terlebih dahulu"));
        //   }
        //   if (state is LoadingGetAllCategory) {
        //     return Center(child: CircularProgressIndicator.adaptive());
        //   }

        //   if (state is SuccessGetAllCategory) {
        //     listCategory = state.resultModel;
        //     _selectedValue = listCategory.first.categoryName;
        //     print(listCategory);

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKeyItemsManage,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: TextFormField(
                  //     // enabled: (widget.isUpdate) ? false : true,
                  //     validator: (value) =>
                  //         Validator.rule(value, required: true),
                  //     controller: noTableController,
                  //     decoration: InputDecoration(
                  //       label: Text("No. Meja"),
                  //       // fillColor: Colors.grey.shade300,
                  //       // filled: (widget.isUpdate) ? true : false,
                  //       // focusColor: (widget.isUpdate) ? Colors.grey : null,
                  //     ),
                  //   ),
                  // ),
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FutureBuilder<List<CategoryModel>>(
                      future: getAllCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            List<CategoryModel>? allData = snapshot.data;

                            if (allData!.isEmpty) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Belum ada List Kategori, Silahkan daftarkan dahulu !",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              );
                              // CustomWidgets.showMessageAlertWithF(
                              //     context,
                              //     "Belum ada List Kategori, Silahkan daftarkan dahulu !",
                              //     false, () {
                              //   GeneralFunction.navigationBackOneStep(context);
                              // });
                            } else {
                              return DropdownButton(
                                hint: const Text("Pilih Kategori"),
                                value: _selectedValue,
                                isExpanded: true,
                                items: allData.map((item) {
                                  return DropdownMenuItem(
                                      value: item.categoryName,
                                      child: Text(
                                        item.categoryName.toString(),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  // _selectedValue = value!;
                                  // setState(() {});
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  });
                                },
                              );
                            }
                          }

                          if (snapshot.hasError) {
                            return Text("hasError : ${snapshot.error}");
                          }
                        }
                        return const Text("loading....");
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: DropdownButton(
                  //     value: _selectedValue,
                  //     isExpanded: true,
                  //     items: listCategory.map((item) {
                  //       return DropdownMenuItem(
                  //           value: item.categoryName,
                  //           child: Text(
                  //             item.categoryName.toString(),
                  //           ));
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _selectedValue = value!;
                  //         print(">>> _selectedValue : ${_selectedValue}");
                  //       });
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: sellByController,
                      decoration: const InputDecoration(
                        label: Text("Dijual Berdasarkan"),
                      ),
                      onTap: () {},
                    ),
                  ),
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: CircleAvatar(),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: TextFormField(
                  //     validator: (value) =>
                  //         Validator.rule(value, required: true),
                  //     controller: sizeController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: const InputDecoration(
                  //       label: Text("Ukuran Meja"),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  //   child: DropdownButton(
                  //     isExpanded: true,
                  //     value: selectedShape,
                  //     items: dropdownShapes,
                  //     onChanged: (value) {
                  //       selectedShape = value!;
                  //       setState(() {});
                  //     },
                  //   ),
                  // ),
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
                        )),
                        const SizedBox(width: 10),
                        (widget.isUpdate)
                            // UPDATE DATA
                            ? Expanded(
                                child: SizedBox(
                                height: MediaQuery.of(context).size.height / 16,
                                child: ElevatedButton(
                                  child: const Text("UPDATE"),
                                  onPressed: () {
                                    print("update");
                                    addOrUpdateCategory(isUpdate: true);
                                  },
                                ),
                              ))
                            // ADD NEW DATA
                            : Expanded(
                                child: SizedBox(
                                height: MediaQuery.of(context).size.height / 16,
                                child: ElevatedButton(
                                  child: Text("SIMPAN"),
                                  onPressed: () =>
                                      addOrUpdateCategory(isUpdate: false),
                                  // onPressed:
                                  //     addOrUpdateCategory(isUpdate: false),
                                  // onPressed: _addData,
                                  // onPressed: () {}
                                  //   if (_formKeyItemsManage.currentState!
                                  //       .validate()) {
                                  //     TablesModel users = TablesModel(
                                  //       email: noTableController.text,
                                  //       firstname: sizeController.text,
                                  //       lastname: nameCategoryController.text,
                                  //       role: selectedRole,
                                  //       photo: "",
                                  //     );
                                  //     BlocProvider.of<TablesBloc>(context)
                                  //         .add(AddNewUsers(tableModel: users));
                                  //   }
                                  // },
                                ),
                              )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

        // }
        // return SizedBox();
        ,
      ),
    );
  }
}

// List<DropdownMenuItem<String>> get dropdownShapes {
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(
//         child: Text("Persegi Panjang"),
//         value: TableShape.rectangle.name.toString()),
//     DropdownMenuItem(
//         child: Text("Lingkaran"), value: TableShape.circle.name.toString()),
//     DropdownMenuItem(
//         child: Text("Bentuk L"), value: TableShape.lshape.name.toString()),
//     DropdownMenuItem(
//         child: Text("Bar"), value: TableShape.barseat.name.toString()),
//     DropdownMenuItem(
//         child: Text("Oval"), value: TableShape.oval.name.toString()),
//     DropdownMenuItem(
//         child: Text("Persegi"), value: TableShape.square.name.toString()),
//     DropdownMenuItem(
//         child: Text("Lainnya"), value: TableShape.others.name.toString()),
//   ];
//   return menuItems;
// }

// List<DropdownMenuItem<String>> get dropdownCategoryItems {
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(
//         child: Text("Admin"), value: RoleUsers.admin.name.toString()),
//     DropdownMenuItem(
//         child: Text("Cashier"), value: RoleUsers.cashier.name.toString()),
//     DropdownMenuItem(
//         child: Text("Staff"), value: RoleUsers.staff.name.toString()),
//     DropdownMenuItem(
//         child: Text("Maker"), value: RoleUsers.maker.name.toString()),
//   ];
//   return menuItems;
// }

List<DropdownMenuItem<String>> get dropdownCategoryItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text("Admin"), value: RoleUsers.admin.name.toString()),
    DropdownMenuItem(
        child: Text("Cashier"), value: RoleUsers.cashier.name.toString()),
    DropdownMenuItem(
        child: Text("Staff"), value: RoleUsers.staff.name.toString()),
    DropdownMenuItem(
        child: Text("Maker"), value: RoleUsers.maker.name.toString()),
  ];
  return menuItems;
}
