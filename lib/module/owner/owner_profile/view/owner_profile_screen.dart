import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
import 'package:posapplication/module/owner/owner_profile/controller/profile_controller.dart';
import 'package:posapplication/service/hive_service/hive_init.dart';
import 'package:posapplication/service/hive_service/hive_service.dart';
import 'package:posapplication/shared/utils/validator/validator.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
  TextEditingController bussinessNameController = TextEditingController();
  TextEditingController bussinessTypeController = TextEditingController();
  TextEditingController bussinessAddressController = TextEditingController();
  TextEditingController bussinessPhoneController = TextEditingController();
  TextEditingController bussinessCountryController = TextEditingController();
  TextEditingController bussinessCurrencyController = TextEditingController();
  final ProfileController controller = ProfileController();
  final _formKeyProfile = GlobalKey<FormState>();

  String selectedValue = "";
  bool isUpdate = false;
  late final Box box;

  @override
  void initState() {
    // isExistProfile();
    openBoxx();
    super.initState();
  }

  openBoxx() async {
    // box = await Hive.openBox("company_profile");
    bool status = Hive.isBoxOpen(HiveService.companyProfileBox);
    (status)
        ? box = Hive.box<ProfileModel>(HiveService.companyProfileBox)
        // Hive.lazyBox(HiveService.companyProfileBox) as Box
        // .box(HiveService.companyProfileBox)
        : box = await Hive.openBox(HiveService.companyProfileBox);
  }

  // setProfileBox(ProfileModel data) {
  //   controller.setProfileCompanytoBox(data);
  // }

  // isExistProfile() async {
  //   bool result = await controller.isExistkBoxCompanyProfile();
  //   print("result ::: $result");
  //   if (result) {
  //     await controller.readProfileCompanyFromBox();
  //     var lazyBox = await Hive.openLazyBox('hugePeopleBox');
  //     String name = await lazyBox.get('name');
  //   }
  //   isUpdate = result;
  // }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  _addData() {
    // Storing key-value pair
    box.put(
        'profile_key',
        ProfileModel(
          bussinessName: bussinessNameController.text,
          bussinessAddress: bussinessAddressController.text,
          bussinessCountry: bussinessCountryController.text,
          bussinessCurrency: bussinessCurrencyController.text,
          bussinessPhone: bussinessPhoneController.text,
          bussinessPhoto: "",
          bussinessType: bussinessTypeController.text,
          companyID: "companyID-123",
        ));
    print('Info added to box!');
  }

  @override
  Widget build(BuildContext context) {
    print(isUpdate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Company"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                // var abc = await controller.readProfileCompany();
                // print(abc);
                // bool ress = await Hive.boxExists('_companyProfile');
                // bool ress = await controller.isExistkBoxCompanyProfile();
                // print(ress);
                // print(bussinessAddressController.text);
                ProfileModel result = box.get('profile_key');
                // result.toJson().map((key, value) {
                //   print(value);
                // });
              },
              icon: Icon(Icons.abc))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<OwnerBloc, OwnerState>(
          listener: (context, state) {
            if (state is LoadingAddProfileCompany) {
              CustomWidgets.showLoadingWidgetContainer(context);
            }
            if (state is FailureAddProfileCompany) {
              Navigator.pop(context);
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is SuccessAddProfileCompany) {
              Navigator.pop(context);
              var result = state.dataProfile;
              controller.setProfileCompanytoBox(result);
              CustomWidgets.showMessageAlertBasic(
                  context, "Profile berhasil disimpan", true);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKeyProfile,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        controller: bussinessNameController,
                        decoration: InputDecoration(
                          hintText: "Nama Bisnis",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        controller: bussinessTypeController,
                        decoration: InputDecoration(
                          hintText: "Tipe Bisnis",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        decoration: InputDecoration(hintText: "Pilih Negara"),
                        controller: bussinessCountryController,
                        onTap: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showSearchField: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            onSelect: (Currency currency) {
                              bussinessCountryController.text =
                                  currency.name.toString();
                              bussinessCurrencyController.text = currency.code;
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        controller: bussinessCurrencyController,
                        decoration: InputDecoration(
                          hintText: "Mata Uang",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        controller: bussinessAddressController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: "Alamat",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        controller: bussinessPhoneController,
                        decoration: InputDecoration(
                          hintText: "No. Telepon",
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
                                child: Text("Batal")),
                          )),
                          SizedBox(width: 10),
                          (isUpdate)
                              ? Expanded(
                                  child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: Text("Update"),
                                    onPressed: () {
                                      if (_formKeyProfile.currentState!
                                          .validate()) {
                                        var datas = ProfileModel(
                                          bussinessName:
                                              bussinessNameController.text,
                                          bussinessAddress:
                                              bussinessAddressController.text,
                                          bussinessCountry:
                                              bussinessCountryController.text,
                                          bussinessCurrency:
                                              bussinessCurrencyController.text,
                                          bussinessPhone:
                                              bussinessPhoneController.text,
                                          bussinessType:
                                              bussinessTypeController.text,
                                        );

                                        // BlocProvider.of<OwnerBloc>(context).add(
                                        //     AddProfileCompanyEvent(
                                        //         profileModel: datas));

                                        print("update");
                                      }
                                    },
                                  ),
                                ))
                              : Expanded(
                                  child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  child: ElevatedButton(
                                    child: Text("Simpan"),
                                    onPressed: _addData,
                                    //   onPressed: () {
                                    //     if (_formKeyProfile.currentState!
                                    //         .validate()) {
                                    //       var datas = ProfileModel(
                                    //         bussinessName:
                                    //             bussinessNameController.text,
                                    //         bussinessAddress:
                                    //             bussinessAddressController.text,
                                    //         bussinessCountry:
                                    //             bussinessCountryController.text,
                                    //         bussinessCurrency:
                                    //             bussinessCurrencyController.text,
                                    //         bussinessPhone:
                                    //             bussinessPhoneController.text,
                                    //         bussinessType:
                                    //             bussinessTypeController.text,
                                    //       );

                                    //       BlocProvider.of<OwnerBloc>(context).add(
                                    //           AddProfileCompanyEvent(
                                    //               profileModel: datas));

                                    //       print(bussinessNameController.text);
                                    //       print("ok");
                                    //     }
                                    //   },
                                  ),
                                )),
                        ],
                      ),
                    ),
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
