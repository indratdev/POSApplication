import 'package:flutter/material.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/module/transactions/export.dart';
import 'package:posapplication/shared/utils/general_function.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';
import 'package:posapplication/shared/widgets/twooption_button_widget.dart';

import '../../../../data/service/user_service/user_service.dart';
import '../../../../shared/utils/validator/validator.dart';
import '../../../blocs/export_bloc.dart';

class UserManageScreen extends StatefulWidget {
  bool isUpdate;
  UsersModel? userModel;
  UserManageScreen({
    super.key,
    this.isUpdate = false,
    this.userModel,
  });

  @override
  State<UserManageScreen> createState() => _UserManageScreenState();
}

class _UserManageScreenState extends State<UserManageScreen> {
  final _formKeyUserManage = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  String selectedRole = RoleUsers.admin.name.toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDataUserModel();
  }

  fillDataUserModel() {
    // kalau dia update data, akan isi data yang lama ke textfield
    if (widget.isUpdate == true) {
      emailController.text = widget.userModel?.email.toString() ?? "";
      firstnameController.text = widget.userModel?.firstname.toString() ?? "";
      lastnameController.text = widget.userModel?.lastname.toString() ?? "";
      selectedRole = widget.userModel?.role.toString() ?? "";
    } else {
      return;
    }
  }

  addOrUpdateUser({required bool isUpdate}) {
    if (_formKeyUserManage.currentState!.validate()) {
      UsersModel users = UsersModel(
        email: emailController.text,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        role: selectedRole,
        photo: "",
        companyID: widget.userModel?.companyID.toString() ?? "",
        documentID: widget.userModel?.documentID.toString() ?? "",
        userID: widget.userModel?.userID.toString() ?? "",
      );

      (isUpdate)
          ? BlocProvider.of<UsersBloc>(context)
              .add(UpdateUsersEvent(userModel: users))
          : BlocProvider.of<UsersBloc>(context)
              .add(AddNewUsersEvent(userModel: users));
    }
  }

  deleteUser(String documentID) {
    BlocProvider.of<UsersBloc>(context)
        .add(deleteUsersEvent(documentID: documentID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pengguna"),
        centerTitle: true,
        actions: [
          (widget.isUpdate)
              ? IconButton(
                  onPressed: () {
                    CustomWidgets.showConfirmation(
                        context, "Apakah Anda Yakin Hapus User Ini ?", () {
                      deleteUser(widget.userModel!.documentID.toString());
                      Navigator.pop(context);
                    });
                  },
                  icon: const Icon(Icons.delete_forever))
              : const SizedBox()
        ],
      ),
      body: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          // add new user
          if (state is LoadingAddNewUser) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is FailureAddNewUser) {
            CustomWidgets.showMessageAlertBasic(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessAddNewUser) {
            CustomWidgets.showMessageAlertWithF(context, state.result, true,
                () {
              BlocProvider.of<UsersBloc>(context).add(GetAllUsersEvent());
              GeneralFunction.navigationBackTwoStep(context);
            });
          }

          // update user
          if (state is LoadingUpdateUser) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is FailureUpdateUser) {
            CustomWidgets.showMessageAlertBasic(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessUpdateUser) {
            CustomWidgets.showMessageAlertWithF(context, state.result, true,
                () {
              BlocProvider.of<UsersBloc>(context).add(GetAllUsersEvent());
              GeneralFunction.navigationBackTwoStep(context);
            });
          }

          // delete user
          if (state is LoadingDeleteUser) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is FailureDeleteUser) {
            CustomWidgets.showMessageAlertBasic(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessDeleteUser) {
            CustomWidgets.showMessageAlertWithF(context, state.result, true,
                () {
              BlocProvider.of<UsersBloc>(context).add(GetAllUsersEvent());
              GeneralFunction.navigationBackTwoStep(context);
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKeyUserManage,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    enabled: (widget.isUpdate) ? false : true,
                    validator: (value) => Validator.rule(value, required: true),
                    controller: emailController,
                    decoration: InputDecoration(
                      label: const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: (widget.isUpdate) ? true : false,
                      // focusColor: (widget.isUpdate) ? Colors.grey : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) => Validator.rule(value, required: true),
                    controller: firstnameController,
                    decoration: const InputDecoration(
                      label: Text("Nama Depan"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    // validator: (value) => Validator.rule(value, required: true),
                    controller: lastnameController,
                    decoration: const InputDecoration(
                      label: Text("Nama Belakang"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  // padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: DropdownButton(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    value: selectedRole,
                    items: dropdownItems,
                    onChanged: (value) {
                      selectedRole = value!;
                      setState(() {});
                    },
                  ),
                ),
                TwoOptionButtonWidget(
                  mainTitleButton: (widget.isUpdate) ? "UPDATE" : "SIMPAN",
                  mainButtonvoidCallback: (widget.isUpdate)
                      ? () {
                          addOrUpdateUser(isUpdate: true);
                        }
                      : () {
                          addOrUpdateUser(isUpdate: false);
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: RoleUsers.admin.name.toString(), child: const Text("Admin")),
    DropdownMenuItem(
        value: RoleUsers.cashier.name.toString(), child: const Text("Cashier")),
    DropdownMenuItem(
        value: RoleUsers.staff.name.toString(), child: const Text("Staff")),
    DropdownMenuItem(
        value: RoleUsers.maker.name.toString(), child: const Text("Maker")),
  ];
  return menuItems;
}
