import 'package:flutter/material.dart';

import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';
import 'package:posapplication/shared/widgets/twooption_button_widget.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/items_model.dart';
import '../../../shared/utils/general_function.dart';
import '../../../shared/utils/sell_category_enum.dart';
import '../../../shared/utils/validator/validator.dart';
import '../../blocs/export_bloc.dart';

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
  SellCategoryBy selectedSellBy = SellCategoryBy.unit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDataItemModel();
  }

  fillDataItemModel() {
    // kalau dia update data, akan isi data yang lama ke textfield
    if (widget.isUpdate == true) {
      itemsNameController.text = widget.itemsModel?.itemName.toString() ?? "";
      selectedCategory.categoryName =
          widget.itemsModel?.categoryName.toString() ?? "";
      selectedSellBy =
          convertToEnum(widget.itemsModel?.sellBy.toString() ?? "");

      priceController.text = widget.itemsModel?.sellPrice.toString() ?? "0";
    } else {
      return;
    }
  }

  addOrUpdateItems(String itemID, {required bool isUpdate}) {
    if (_formKeyItemsManage.currentState!.validate()) {
      ItemsModel data = ItemsModel(
        companyID: (widget.isUpdate)
            ? widget.itemsModel!.companyID
            : selectedCategory.companyID,
        categoryID: (widget.isUpdate)
            ? widget.itemsModel!.categoryID
            : selectedCategory.categoryID,
        itemID: (widget.isUpdate) ? widget.itemsModel!.itemID : itemID,
        itemName: itemsNameController.text,
        categoryName: selectedCategory.categoryName,
        sellBy: selectedSellBy.name.toString(),
        sellPrice: double.tryParse(priceController.text) ?? 0,
        itemPhoto: "",
      );

      (isUpdate)
          ? context.read<SettingsBloc>().add(UpdateItemsEvent(itemsModel: data))
          : context
              .read<SettingsBloc>()
              .add(AddNewItemsEvent(itemsModel: data));
    }
  }

  deleteItems(String itemID) {
    BlocProvider.of<SettingsBloc>(context)
        .add(deleteItemsEvent(itemID: itemID));
  }

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
                    CustomWidgets.showConfirmation(
                        context, "Apakah Anda Yakin Hapus User Ini ?", () {
                      deleteItems(widget.itemsModel!.itemID.toString());
                      Navigator.pop(context);
                    });
                  },
                  icon: const Icon(Icons.delete_forever))
              : const SizedBox()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            // add new item
            if (state is LoadingAddNewItems) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureAddNewItems) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessAddNewItems) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                context.read<SettingsBloc>().add(GetAllItemsEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }
            // end add new

            // update item
            if (state is LoadingUpdateItems) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureUpdateItems) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessUpdateItems) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                context.read<SettingsBloc>().add(GetAllItemsEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }
            // end update item

            // delete item
            if (state is LoadingDeleteItems) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureDeleteItems) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessDeleteItems) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                context.read<SettingsBloc>().add(GetAllItemsEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }
            // end delete item

            if (state is SuccessSelectedCategory) {
              selectedCategory = state.result;
            }
          },
          builder: (context, state) {
            if (state is SuccessSelectedCategory) {
              selectedCategory = state.result;
            }

            return Form(
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<SettingsBloc>()
                              .add(GetAllCategoryEvent());
                          Navigator.pushNamed(
                              context, AppRoutes.categorySelected);
                        },
                        child: ListTile(
                          minLeadingWidth: 0,
                          title: Text(selectedCategory.categoryName),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: const Text("Satuan"),
                                value: SellCategoryBy.unit,
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
                                title: const Text("Pecahan (Kg)"),
                                value: SellCategoryBy.fractionkg,
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
                    TwoOptionButtonWidget(
                      mainTitleButton: (widget.isUpdate) ? "UPDATE" : "SIMPAN",
                      mainButtonvoidCallback: (widget.isUpdate)
                          ? () => addOrUpdateItems("", isUpdate: true)
                          : () {
                              String itemID =
                                  GeneralFunction().generateUniqueItemID();

                              addOrUpdateItems(itemID, isUpdate: false);
                            },
                    )
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: SizedBox(
                    //           height: MediaQuery.of(context).size.height / 16,
                    //           child: ElevatedButton(
                    //               style: ElevatedButton.styleFrom(
                    //                 backgroundColor: Colors.white,
                    //                 foregroundColor: Colors.red,
                    //               ),
                    //               onPressed: () {
                    //                 Navigator.pop(context);
                    //               },
                    //               child: const Text("BATAL")),
                    //         ),
                    //       ),
                    //       const SizedBox(width: 10),
                    //       (widget.isUpdate)
                    //           // UPDATE DATA
                    //           ? Expanded(
                    //               child: SizedBox(
                    //                 height:
                    //                     MediaQuery.of(context).size.height / 16,
                    //                 child: ElevatedButton(
                    //                   child: const Text("UPDATE"),
                    //                   onPressed: () {
                    //                     addOrUpdateItems("", isUpdate: true);
                    //                   },
                    //                 ),
                    //               ),
                    //             )
                    //           // ADD NEW DATA
                    //           : Expanded(
                    //               child: SizedBox(
                    //                 height:
                    //                     MediaQuery.of(context).size.height / 16,
                    //                 child: ElevatedButton(
                    //                   child: const Text("SIMPAN"),
                    //                   onPressed: () {
                    //                     String itemID = GeneralFunction()
                    //                         .generateUniqueItemID();

                    //                     addOrUpdateItems(itemID,
                    //                         isUpdate: false);
                    //                   },
                    //                 ),
                    //               ),
                    //             ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
