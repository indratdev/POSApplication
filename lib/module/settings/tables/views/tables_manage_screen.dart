import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/validator/validator.dart';
import '../../../../data/model/tables_model.dart';
import '../../../../shared/utils/general_function.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../bloc/tables_bloc.dart';

class TablesManageScreen extends StatefulWidget {
  bool isUpdate;
  TablesModel? tableModel;
  TablesManageScreen({
    super.key,
    this.isUpdate = false,
    this.tableModel,
  });

  @override
  State<TablesManageScreen> createState() => _TablesManageScreenState();
}

class _TablesManageScreenState extends State<TablesManageScreen> {
  final _formKeyTableManage = GlobalKey<FormState>();
  TextEditingController noTableController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController nameTableController = TextEditingController();
  // String selectedShape = RoleUsers.admin.name.toString();
  String selectedShape = TableShape.rectangle.name.toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDatatableModel();
  }

  fillDatatableModel() {
    // kalau dia update data, akan isi data yang lama ke textfield
    if (widget.isUpdate == true) {
      noTableController.text = widget.tableModel?.tableNo.toString() ?? "";
      nameTableController.text = widget.tableModel?.tableName.toString() ?? "";
      sizeController.text = widget.tableModel?.size.toString() ?? "";
      selectedShape = widget.tableModel?.shape.toString() ?? "";
    } else {
      return;
    }
  }

  addOrUpdateUser({required bool isUpdate}) {
    if (_formKeyTableManage.currentState!.validate()) {
      TablesModel tableModel = TablesModel(
        tableNo: noTableController.text,
        size: int.parse(sizeController.text),
        tableName: nameTableController.text,
        shape: selectedShape,
        tableID: widget.tableModel?.tableID.toString() ?? "",
        companyID: widget.tableModel?.companyID.toString() ?? "",
      );

      (isUpdate)
          // ? ""
          ? BlocProvider.of<TablesBloc>(context)
              .add(UpdateTablesEvent(tableModel: tableModel))
          : BlocProvider.of<TablesBloc>(context)
              .add(AddNewTablesEvent(tableModel: tableModel));
    }
  }

  deleteTable(String documentID) {
    BlocProvider.of<TablesBloc>(context)
        .add(deleteTablesEvent(documentID: documentID));
  }

  @override
  Widget build(BuildContext context) {
    print("isupdate : ${widget.isUpdate}");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Meja"),
          centerTitle: true,
          actions: [
            (widget.isUpdate)
                ? IconButton(
                    onPressed: () {
                      CustomWidgets.showConfirmation(
                          context, "Apakah Anda Yakin Hapus User Ini ?", () {
                        deleteTable(widget.tableModel!.tableID.toString());
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(Icons.delete_forever))
                : SizedBox()
          ],
        ),
        body: BlocListener<TablesBloc, TablesState>(
          listener: (context, state) {
            // // add new table
            if (state is LoadingAddNewTable) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureAddNewTable) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessAddNewTable) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                BlocProvider.of<TablesBloc>(context).add(GetAllTablesEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }

            // update user
            if (state is LoadingUpdateTable) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureUpdateTable) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessUpdateTable) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                BlocProvider.of<TablesBloc>(context).add(GetAllTablesEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }

            // delete user
            if (state is LoadingDeleteTable) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureDeleteTable) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessDeleteTable) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                BlocProvider.of<TablesBloc>(context).add(GetAllTablesEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKeyTableManage,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      // enabled: (widget.isUpdate) ? false : true,
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: noTableController,
                      decoration: InputDecoration(
                        label: Text("No. Meja"),
                        // fillColor: Colors.grey.shade300,
                        // filled: (widget.isUpdate) ? true : false,
                        // focusColor: (widget.isUpdate) ? Colors.grey : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: nameTableController,
                      decoration: const InputDecoration(
                        label: Text("Nama Meja"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: sizeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Ukuran Meja"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedShape,
                      items: dropdownShapes,
                      onChanged: (value) {
                        selectedShape = value!;
                        setState(() {});
                      },
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
                                    print("update");
                                    addOrUpdateUser(isUpdate: true);
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
                                      addOrUpdateUser(isUpdate: false),
                                  // onPressed: _addData,
                                  // onPressed: () {
                                  //   if (_formKeyTableManage.currentState!
                                  //       .validate()) {
                                  //     TablesModel users = TablesModel(
                                  //       email: noTableController.text,
                                  //       firstname: sizeController.text,
                                  //       lastname: nameTableController.text,
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
        ));
  }
}

List<DropdownMenuItem<String>> get dropdownShapes {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text("Persegi Panjang"),
        value: TableShape.rectangle.name.toString()),
    DropdownMenuItem(
        child: Text("Lingkaran"), value: TableShape.circle.name.toString()),
    DropdownMenuItem(
        child: Text("Bentuk L"), value: TableShape.lshape.name.toString()),
    DropdownMenuItem(
        child: Text("Bar"), value: TableShape.barseat.name.toString()),
    DropdownMenuItem(
        child: Text("Oval"), value: TableShape.oval.name.toString()),
    DropdownMenuItem(
        child: Text("Persegi"), value: TableShape.square.name.toString()),
    DropdownMenuItem(
        child: Text("Lainnya"), value: TableShape.others.name.toString()),
  ];
  return menuItems;
}
