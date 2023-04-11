import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../../../shared/constants/constatns.dart';

class ProfileWidget extends StatefulWidget {
  bool isUpdate = true;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROFILE"),
        centerTitle: true,
        actions: [
          TextButton(
            // icon: (isUpdate == true)
            //     ? const Icon(Icons.edit, color: Colors.white)
            //     : const Icon(Icons.add, color: Colors.white),
            child: Text(
              (widget.isUpdate == true) ? "UBAH" : "TAMBAH",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              (widget.isUpdate)
                  ? Navigator.pushNamed(context, AppRoutes.ownerProfile)
                  : Navigator.pushNamed(
                      context,
                      AppRoutes
                          .ownerProfile); // yg bawah buat update tapi bleum
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
                      ? widget.profileModel?.bussinessCurrency.toString() ?? ""
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
    );
  }
}
