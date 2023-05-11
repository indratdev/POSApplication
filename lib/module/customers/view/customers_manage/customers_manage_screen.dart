import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/customers_model.dart';

import 'package:posapplication/module/customers/bloc/customers_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../shared/utils/general_function.dart';
import '../../../../shared/utils/validator/validator.dart';
import '../../../../shared/widgets/custom_widgets.dart';

enum GenderEnum {
  male,
  female,
}

class CustomersManageScreen extends StatefulWidget {
  bool isUpdate;
  CustomersModel? customersModel;
  CustomersManageScreen({
    super.key,
    this.isUpdate = false,
    this.customersModel,
  });

  @override
  State<CustomersManageScreen> createState() => _CustomersManageScreenState();
}

class _CustomersManageScreenState extends State<CustomersManageScreen> {
  final _formKeyUserManage = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String selectedGender = GenderEnum.male.name.toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDataUserModel();
  }

  fillDataUserModel() {
    //// kalau dia update data, akan isi data yang lama ke textfield
    if (widget.isUpdate == true) {
      emailController.text = widget.customersModel?.email.toString() ?? "";
      fullnameController.text =
          widget.customersModel?.fullname.toString() ?? "";
      phoneController.text =
          widget.customersModel?.phoneNumber.toString() ?? "";
      selectedGender = widget.customersModel?.gender.toString() ?? "";
    } else {
      return;
    }
  }

  addOrUpdateCustomer({required bool isUpdate}) {
    if (_formKeyUserManage.currentState!.validate()) {
      CustomersModel customers = CustomersModel(
        fullname: fullnameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        gender: selectedGender,
        address: addressController.text,
        companyID: widget.customersModel?.companyID.toString() ?? "",
        customerID: widget.customersModel?.customerID.toString() ?? "",
      );

      (isUpdate)
          ? BlocProvider.of<CustomersBloc>(context).add(UpdateCustomersEvent(
              customerModel: customers)) // update customer data
          : BlocProvider.of<CustomersBloc>(context).add(AddNewCustomerEvent(
              customersModel: customers)); // add new customer data
    }
  }

  deleteCustomer(String documentID) {
    BlocProvider.of<CustomersBloc>(context)
        .add(deleteCustomerEvent(documentID: documentID));
  }

  @override
  Widget build(BuildContext context) {
    print("isupdate pelanngan : ${widget.isUpdate}");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Pelanggan"),
          centerTitle: true,
          actions: [
            (widget.isUpdate)
                ? IconButton(
                    onPressed: () {
                      CustomWidgets.showConfirmation(
                          context, "Apakah Anda Yakin Hapus Pelanggan Ini ?",
                          () {
                        deleteCustomer(
                            widget.customersModel!.customerID.toString());
                        Navigator.pop(context);
                      });
                    },
                    icon: const Icon(Icons.delete_forever))
                : const SizedBox()
          ],
        ),
        body: BlocListener<CustomersBloc, CustomersState>(
          listener: (context, state) {
            // add new user
            if (state is LoadingAddNewCustomer) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureAddNewCustomer) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessAddNewCustomer) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                BlocProvider.of<CustomersBloc>(context)
                    .add(GetAllCustomersEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }

            // update user
            if (state is LoadingUpdateCustomer) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureUpdateCustomer) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessUpdateCustomer) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                BlocProvider.of<CustomersBloc>(context)
                    .add(GetAllCustomersEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }

            // delete user
            if (state is LoadingDeleteCustomers) {
              CustomWidgets.showLoadingWidget();
            }
            if (state is FailureDeleteCustomers) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessDeleteCustomers) {
              CustomWidgets.showMessageAlertWithF(context, state.result, true,
                  () {
                BlocProvider.of<CustomersBloc>(context)
                    .add(GetAllCustomersEvent());
                GeneralFunction.navigationBackTwoStep(context);
              });
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKeyUserManage,
                child: Column(
                  children: <Widget>[
                    (widget.isUpdate)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: QrImage(
                              data:
                                  widget.customersModel!.customerID.toString(),
                              version: QrVersions.auto,
                              size: MediaQuery.of(context).size.width / 2.5,
                              gapless: false,
                            ))
                        : const SizedBox(),
                    (widget.isUpdate)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              initialValue: GeneralFunction().hideSeveralUserID(
                                  widget.customersModel!.customerID.toString()),
                              enabled: false,
                              decoration: InputDecoration(
                                label: const Text("User ID"),
                                fillColor: Colors.grey.shade300,
                                filled: (widget.isUpdate) ? true : false,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        controller: fullnameController,
                        decoration: const InputDecoration(
                          label: Text("Nama Lengkap"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          label: Text("Email"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            label: Text("No.Telpon"),
                            hintText: "contoh : 0857xxxxx"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Jenis Kelamin"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: GenderEnum.male.name.toString(),
                                  groupValue: selectedGender,
                                  onChanged: (val) {
                                    selectedGender = val!;
                                    setState(() {});
                                  },
                                ),
                                const Text('Laki - laki'),
                                Radio(
                                  value: GenderEnum.female.name.toString(),
                                  groupValue: selectedGender,
                                  onChanged: (val) {
                                    selectedGender = val!;
                                    setState(() {});
                                  },
                                ),
                                const Text('Perempaun'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: TextFormField(
                        // validator: (value) => Validator.rule(value, required: true),
                        controller: addressController,
                        keyboardType: TextInputType.multiline,

                        maxLines: 5,
                        decoration: const InputDecoration(
                          label: Text("Alamat"),
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
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: const Text("UPDATE"),
                                    onPressed: () {
                                      print("update");
                                      addOrUpdateCustomer(isUpdate: true);
                                    },
                                  ),
                                ))
                              // ADD NEW DATA
                              : Expanded(
                                  child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: const Text("SIMPAN"),
                                    onPressed: () =>
                                        addOrUpdateCustomer(isUpdate: false),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
