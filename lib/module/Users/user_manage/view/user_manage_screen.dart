import 'package:flutter/material.dart';

import '../../../../shared/utils/validator/validator.dart';

class UserManageScreen extends StatefulWidget {
  bool isUpdate;
  UserManageScreen({
    super.key,
    this.isUpdate = false,
  });

  @override
  State<UserManageScreen> createState() => _UserManageScreenState();
}

class _UserManageScreenState extends State<UserManageScreen> {
  final _formKeyUserManage = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  String selectedRole = "Admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Manage"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKeyUserManage,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) => Validator.rule(value, required: true),
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email :",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) => Validator.rule(value, required: true),
                    controller: firstnameController,
                    decoration: InputDecoration(
                      hintText: "Nama Depan : ",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) => Validator.rule(value, required: true),
                    controller: lastnameController,
                    decoration: InputDecoration(
                      hintText: "Nama Belakang :",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectedRole,
                    items: dropdownItems,
                    onChanged: (value) {
                      selectedRole = value!;
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
                          // UPDATE
                          ? Expanded(
                              child: SizedBox(
                              height: MediaQuery.of(context).size.height / 16,
                              child: ElevatedButton(
                                child: const Text("UPDATE"),
                                onPressed: () {
                                  print("update");
                                },
                              ),
                            ))
                          // ADD NEW
                          : Expanded(
                              child: SizedBox(
                              height: MediaQuery.of(context).size.height / 16,
                              child: ElevatedButton(
                                child: Text("SIMPAN"),
                                // onPressed: _addData,
                                onPressed: () {},
                              ),
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Admin"), value: "Admin"),
    DropdownMenuItem(child: Text("Cashier"), value: "Cashier"),
    DropdownMenuItem(child: Text("Staff"), value: "Staff"),
    DropdownMenuItem(child: Text("Maker"), value: "Maker"),
  ];
  return menuItems;
}
