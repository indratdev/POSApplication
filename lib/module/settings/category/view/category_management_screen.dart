import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/category_model.dart';

import '../../../../shared/utils/general_function.dart';
import '../../../../shared/utils/validator/validator.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../../../blocs/export_bloc.dart';

class CategoryManagementScreen extends StatefulWidget {
  bool isUpdate;
  CategoryModel? categoryModel;

  CategoryManagementScreen({
    super.key,
    this.isUpdate = false,
    this.categoryModel,
  });

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final _formKeyCategoryManage = GlobalKey<FormState>();
  TextEditingController nameCategoryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDatatableModel();
  }

  fillDatatableModel() {
    // kalau dia update data, akan isi data yang lama ke textfield
    if (widget.isUpdate == true) {
      nameCategoryController.text =
          widget.categoryModel?.categoryName.toString() ?? "";
    } else {
      return;
    }
  }

  addOrUpdateCategory({required bool isUpdate}) {
    if (_formKeyCategoryManage.currentState!.validate()) {
      CategoryModel categoryModel = CategoryModel(
        companyID: widget.categoryModel?.companyID.toString() ?? "",
        categoryID: widget.categoryModel?.categoryID.toString() ?? "",
        categoryName: nameCategoryController.text,
      );

      (isUpdate)
          // ? ""
          ? BlocProvider.of<SettingsBloc>(context)
              .add(UpdateCategoryEvent(categoryModel: categoryModel))
          : BlocProvider.of<SettingsBloc>(context)
              .add(AddNewCategoryEvent(categoryModel: categoryModel));
    }
  }

  deleteCategory(String documentID) {
    BlocProvider.of<SettingsBloc>(context)
        .add(deleteCategoryEvent(documentID: documentID));
  }

  @override
  Widget build(BuildContext context) {
    print("isupdate : ${widget.isUpdate}");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pengelolaan Kategori"),
          centerTitle: true,
          actions: [
            (widget.isUpdate)
                ? IconButton(
                    onPressed: () {
                      CustomWidgets.showConfirmation(
                          context, "Apakah Anda Yakin Hapus User Ini ?", () {
                        deleteCategory(
                            widget.categoryModel!.categoryID.toString());
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
                BlocProvider.of<SettingsBloc>(context)
                    .add(GetAllCategoryEvent());
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
                BlocProvider.of<SettingsBloc>(context)
                    .add(GetAllCategoryEvent());
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
                BlocProvider.of<SettingsBloc>(context)
                    .add(GetAllCategoryEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKeyCategoryManage,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: nameCategoryController,
                      decoration: const InputDecoration(
                        label: Text("Nama Kategori"),
                      ),
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
                                    addOrUpdateCategory(isUpdate: true);
                                  },
                                ),
                              ))
                            // ADD NEW DATA
                            : Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: Text("SIMPAN"),
                                    onPressed: () =>
                                        addOrUpdateCategory(isUpdate: false),
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
        ));
  }
}
