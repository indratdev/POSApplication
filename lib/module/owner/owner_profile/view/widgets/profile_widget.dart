import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/module/owner/owner_profile/view/owner_profile_screen.dart';

import '../../../../../data/model/profile_model.dart';
import '../../../../../shared/constants/constatns.dart';

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
          title: const Text("PROFILE"),
          centerTitle: true,
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
          child: Container(
            padding: const EdgeInsets.all(13),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: (widget.isUpdate)
                      ? AssetImage(warningImage)
                      : AssetImage(noDataImage),
                  // backgroundColor: Colors.blue,
                  radius: MediaQuery.of(context).size.width / 5,
                  backgroundColor: Colors.blue,
                ),
                Text(
                  (widget.isUpdate)
                      ? widget.profileModel?.bussinessName.toString() ?? ""
                      : "-",
                ),
                Text(
                  (widget.isUpdate)
                      ? widget.profileModel?.bussinessPhone.toString() ?? ""
                      : "-",
                ),
                SizedBox(height: 50),
                ListTile(
                  title: Text("Tipe Perusahaan"),
                  subtitle: Text(
                    (widget.isUpdate)
                        ? widget.profileModel?.bussinessType.toString() ?? ""
                        : "-",
                  ),
                ),
                ListTile(
                  title: Text("Negara"),
                  subtitle: Text(
                    (widget.isUpdate)
                        ? widget.profileModel?.bussinessCountry.toString() ?? ""
                        : "-",
                  ),
                ),
                ListTile(
                  title: Text("Mata Uang"),
                  subtitle: Text(
                    (widget.isUpdate)
                        ? widget.profileModel?.bussinessCurrency.toString() ??
                            ""
                        : "-",
                  ),
                ),
                ListTile(
                  title: Text("Alamat"),
                  subtitle: Text(
                    (widget.isUpdate)
                        ? widget.profileModel?.bussinessAddress.toString() ?? ""
                        : "-",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
