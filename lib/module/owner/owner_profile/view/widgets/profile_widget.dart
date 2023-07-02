import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/module/owner/owner_profile/view/owner_profile_screen.dart';
import 'package:posapplication/module/owner/owner_profile/view/widgets/card_profile_widget.dart';

import '../../../../../data/model/profile_model.dart';
import '../../../../../shared/constants/constants.dart';

enum ProfileType {
  companyTypeProfile,
  countryProfile,
  currencyProfile,
  addressProfile,
}

class ProfileWidget extends StatefulWidget {
  bool isUpdate = false;
  ProfileModel? profileModel = ProfileModel(bussinessName: "unknown");

  ProfileWidget({
    super.key,
    required this.isUpdate,
    this.profileModel,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Hive.close();
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          centerTitle: true,
          elevation: 0,
          actions: [
            TextButton(
              child: Text(
                (widget.isUpdate) ? "UBAH" : "TAMBAH",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (widget.isUpdate) {
                  // ProfileController controller = ProfileController();
                  // var data = ProfileModel(
                  //   bussinessName: "Bakso yuk 2",
                  //   bussinessAddress: "dasdas",
                  //   bussinessCountry: "Switzerland Franc",
                  //   bussinessCurrency: "CHF",
                  //   bussinessPhone: "02100998877",
                  //   bussinessPhoto: "",
                  //   bussinessType: "Restoran",
                  //   companyID: "3BnGWuFviVPRRNfYqsS5aVa0xIm1",
                  // );
                  // // controller.updateProfileCompanyToBox(data);

                  // controller.testUpdate(data);
                  // Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnerProfileScreen(
                            isUpdate: true, profileModel: widget.profileModel),
                      )); // update
                } else {
                  // tambah
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OwnerProfileScreen(isUpdate: false),
                      )); // add
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: mainGreen,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3.5,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: (widget.isUpdate)
                            ? const AssetImage(warningImage)
                            : const AssetImage(noDataImage),
                        radius: MediaQuery.of(context).size.width / 5,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width / 18,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                (widget.isUpdate)
                                    ? widget.profileModel?.bussinessName
                                            .toString() ??
                                        ""
                                    : "-",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ))),
                      SizedBox(
                          height: MediaQuery.of(context).size.width / 18,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                (widget.isUpdate)
                                    ? widget.profileModel?.bussinessPhone
                                            .toString() ??
                                        ""
                                    : "-",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ))),
                    ],
                  ),
                ),
                CardProfileWidget(
                  isUpdate: widget.isUpdate,
                  titleText: "Tipe Perusahaan",
                  profileType: ProfileType.companyTypeProfile,
                  profileModel: widget.profileModel,
                ),
                CardProfileWidget(
                  isUpdate: widget.isUpdate,
                  titleText: "Negara",
                  profileType: ProfileType.countryProfile,
                  profileModel: widget.profileModel,
                ),
                CardProfileWidget(
                  isUpdate: widget.isUpdate,
                  titleText: "Mata Uang",
                  profileType: ProfileType.currencyProfile,
                  profileModel: widget.profileModel,
                ),
                CardProfileWidget(
                  isUpdate: widget.isUpdate,
                  titleText: "Alamat",
                  profileType: ProfileType.addressProfile,
                  profileModel: widget.profileModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
