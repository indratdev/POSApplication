import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:posapplication/data/service/hive_service/hive_service.dart';
import 'package:posapplication/module/owner/owner_profile/controller/profile_controller.dart';
import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/utils/validator/validator.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';
import 'package:posapplication/shared/widgets/twooption_button_widget.dart';

import '../../../../data/model/profile_model.dart';
import '../../../blocs/export_bloc.dart';

class OwnerProfileScreen extends StatefulWidget {
  bool isUpdate;
  ProfileModel? profileModel = ProfileModel(bussinessName: "unknown");

  OwnerProfileScreen({
    super.key,
    required this.isUpdate,
    this.profileModel,
  });

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
  final HiveService hiveService = HiveService();
  final _formKeyProfile = GlobalKey<FormState>();

  String selectedValue = "";
  late final Box box;

  @override
  void initState() {
    super.initState();
    openBoxx();
    initTextfield();
  }

  initTextfield() {
    if (widget.profileModel?.companyID != "") {
      bussinessNameController = TextEditingController(
          text: widget.profileModel?.bussinessName.toString());
      bussinessTypeController = TextEditingController(
          text: widget.profileModel?.bussinessType.toString());
      bussinessAddressController = TextEditingController(
          text: widget.profileModel?.bussinessAddress.toString());
      bussinessPhoneController = TextEditingController(
          text: widget.profileModel?.bussinessPhone.toString());
      bussinessCountryController = TextEditingController(
          text: widget.profileModel?.bussinessCountry.toString());
      bussinessCurrencyController = TextEditingController(
          text: widget.profileModel?.bussinessCurrency.toString());
    }
  }

  Future<Box> openBoxx() async {
    var resultBox = await controller.isBoxProfileAlreadyOpen();
    box = resultBox;
    return resultBox;
    // trial
    // print(">>> start openBoxx");
    // print(">>> status openBoxx : ${resultBox.values}");
    // print(">>> end status Box : ${box.values}");
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
    ProfileModel data = ProfileModel(
      bussinessName: bussinessNameController.text,
      bussinessAddress: bussinessAddressController.text,
      bussinessCountry: bussinessCountryController.text,
      bussinessCurrency: bussinessCurrencyController.text,
      bussinessPhone: bussinessPhoneController.text,
      bussinessPhoto: "",
      bussinessType: bussinessTypeController.text,
      companyID: "companyID-123",
    );
    hiveService.addProfileToHive(data);
    // print('Info added to box!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROFIL USAHA"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<OwnerBloc, OwnerState>(
          listener: (context, state) {
            if (state is LoadingAddProfileCompany ||
                state is LoadingUpdateProfileCompany) {
              CustomWidgets.showLoadingWidgetContainer(context);
            }

            if (state is FailureAddProfileCompany) {
              Navigator.pop(context);

              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }
            if (state is FailureUpdateProfileCompany) {
              Navigator.pop(context);

              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
            }

            if (state is SuccessUpdateProfileCompany) {
              Navigator.of(context)
                ..pop()
                ..pop();
              var result = state.dataProfile;

              controller.updateProfileCompanyToBox(result);

              BlocProvider.of<OwnerBloc>(context).add(OpenBoxProfileEvent());
              Navigator.popAndPushNamed(context, AppRoutes.ownerProfileInfo);
              CustomWidgets.showMessageAlertBasic(
                  context, "Profile Usaha Berhasil di Perbaharui", true);
            }
            if (state is SuccessAddProfileCompany) {
              Navigator.of(context)
                ..pop()
                ..pop();
              var result = state.dataProfile;
              controller.setProfileCompanytoBox(result);
              BlocProvider.of<OwnerBloc>(context).add(OpenBoxProfileEvent());
              Navigator.popAndPushNamed(context, AppRoutes.ownerProfileInfo);
              CustomWidgets.showMessageAlertBasic(
                  context, "Profile Usaha Berhasil ditambahkan", true);
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
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
                          hintText: "Tipe Bisnis",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) =>
                            Validator.rule(value, required: true),
                        decoration:
                            const InputDecoration(hintText: "Pilih Negara"),
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
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
                          hintText: "No. Telepon",
                        ),
                      ),
                    ),
                    (widget.isUpdate)
                        ? TwoOptionButtonWidget(
                            mainTitleButton: "UPDATE",
                            mainButtonvoidCallback: () {
                              if (_formKeyProfile.currentState!.validate()) {
                                var datas = ProfileModel(
                                  bussinessName: bussinessNameController.text,
                                  bussinessAddress:
                                      bussinessAddressController.text,
                                  bussinessCountry:
                                      bussinessCountryController.text,
                                  bussinessCurrency:
                                      bussinessCurrencyController.text,
                                  bussinessPhone: bussinessPhoneController.text,
                                  bussinessType: bussinessTypeController.text,
                                );

                                BlocProvider.of<OwnerBloc>(context).add(
                                    UpdateProfileCompanyEvent(
                                        profileModel: datas));
                              }
                            },
                          )
                        : TwoOptionButtonWidget(
                            mainTitleButton: "SIMPAN",
                            mainButtonvoidCallback: () {
                              if (_formKeyProfile.currentState!.validate()) {
                                var datas = ProfileModel(
                                  bussinessName: bussinessNameController.text,
                                  bussinessAddress:
                                      bussinessAddressController.text,
                                  bussinessCountry:
                                      bussinessCountryController.text,
                                  bussinessCurrency:
                                      bussinessCurrencyController.text,
                                  bussinessPhone: bussinessPhoneController.text,
                                  bussinessType: bussinessTypeController.text,
                                );

                                BlocProvider.of<OwnerBloc>(context).add(
                                    AddProfileCompanyEvent(
                                        profileModel: datas));

                                // print(bussinessNameController.text);
                                // print("ok");
                              }
                            },
                          )
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
