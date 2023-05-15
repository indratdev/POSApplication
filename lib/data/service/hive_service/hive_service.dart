import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/data/service/hive_service/boxes.dart';

import '../../model/profile_model.dart';

class HiveService {
  static const String companyProfileBox = "company_profile";
  static const String companyProfileKey = "profile_key";
  static const String currentUserLoginBox = "currentUserLogin_box";
  static const String currentUserLoginKey = "currentUserLogin_key";
  static Box profileBox = Boxes.getTask();

  // check
  Future<Box<dynamic>> isBoxAlreadyOpen(String boxName) async {
    late Box box;
    bool status = Hive.isBoxOpen(boxName);
    print(">>> status : $status");
    if (status == false) {
      if (boxName == companyProfileBox) {
        box = await Hive.openBox(companyProfileBox);
      }
      if (boxName == currentUserLoginBox) {
        box = await Hive.openBox(currentUserLoginBox);
      }
    }

    box = Hive.box(boxName);

    return box;
  }

  Future<bool> isExistkBoxCompanyProfile() async {
    return await Hive.boxExists(companyProfileBox);
  }

  Future<bool> isExistCompanyProfileFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(companyProfileBox);
    var data = await box.get(companyProfileKey);
    return (data != null) ? true : false;
  }

  // end check

  // add profile
  addProfileToHive(ProfileModel profile) async {
    Box box = await isBoxAlreadyOpen(companyProfileBox);
    await box.put(companyProfileKey, profile);
  }

  // addUserLoginToHive
  addUserLoginToHive(UsersModel usersModel) async {
    print(">>> run addUserLoginToHive");
    Box box = await isBoxAlreadyOpen(currentUserLoginBox);
    await box.put(currentUserLoginKey, usersModel);
  }

  // READ

  // readProfileCompanyIDFromBox
  Future<String> readProfileCompanyIDFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(companyProfileBox);

    ProfileModel model = await box.get(companyProfileKey) as ProfileModel;
    return model.companyID.toString();
  }

  // readProfileCompanyNameFromBox
  Future<String> readProfileCompanyNameFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(companyProfileBox);

    ProfileModel model = await box.get(companyProfileKey) as ProfileModel;
    // String name = model.companyID.toString();
    String name = model.bussinessName.toString();
    // name = name.replaceAll(" ", "");
    return name;
  }

  // readProfileFromBox
  Future<ProfileModel> readProfileFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(companyProfileBox);

    ProfileModel model = await box.get(companyProfileKey) as ProfileModel;

    return model;
  }

  // readProfileCompanyIDFromBox
  Future<UsersModel> readUserLoginFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(currentUserLoginBox);

    print(">>> box readUserLoginFromBox : ${box} ");

    UsersModel model = await box.get(currentUserLoginKey) as UsersModel;
    print(">>> model readUserLoginFromBox : ${model.companyID} ");
    return model;
  }

  // END READ

  // update
  updateProfileCompanyToBox(ProfileModel profileModel) async {
    // await profileBox.put(companyProfileKey, profile);
    try {
      // final box = await isBoxAlreadyOpen();
      // final ProfileModel? profile = box.get(companyProfileKey);
      // profile?.bussinessAddress = profileModel.bussinessAddress ?? "";
      // profile?.bussinessCountry = profileModel.bussinessAddress ?? "";
      // profile?.bussinessCurrency = profileModel.bussinessCurrency ?? "";
      // profile?.bussinessName = profileModel.bussinessName ?? "";
      // profile?.bussinessPhone = profileModel.bussinessPhone ?? "";
      // profile?.bussinessType = profileModel.bussinessType ?? "";
      // profile?.companyID = profileModel.companyID ?? "";
      // await profileBox.put(companyProfileKey, profile);
      // box.close();

      // new
      final box = await isBoxAlreadyOpen(companyProfileBox);
      await box.put(companyProfileKey, profileModel);
    } catch (e) {
      log(e.toString());
    }
  }

  //delete profile
  deleteProfileBox() async {
    if (await Hive.boxExists(companyProfileBox)) {
      profileBox.delete(companyProfileKey);
    }
  }

  // save companyID
  saveCompanyID() {}

  //test
//   testUpdate(ProfileModel profileModel) async {
// //     final box = await Hive.openBox<Person>('myBox');
// // final person = box.get('myPersonKey');
// // person.name = 'New Name';
// // person.age = 30;
// // await box.put('myPersonKey', person);

//     print(profileModel.bussinessName);
//     try {
//       final box = await isBoxAlreadyOpen(companyProfileBox);
//       // final box = await Hive.openBox<ProfileModel>(companyProfileBox);
//       final ProfileModel? profile = box.get(companyProfileKey);
//       profile?.bussinessAddress = profileModel.bussinessAddress ?? "";
//       profile?.bussinessCountry = profileModel.bussinessAddress ?? "";
//       profile?.bussinessCurrency = profileModel.bussinessCurrency ?? "";
//       profile?.bussinessName = profileModel.bussinessName ?? "";
//       profile?.bussinessPhone = profileModel.bussinessPhone ?? "";
//       profile?.bussinessType = profileModel.bussinessType ?? "";
//       profile?.companyID = profileModel.companyID ?? "";
//       await profileBox.put(companyProfileKey, profile);

//       print(">>>> pro : $profile");
//     } catch (e) {
//       print("Error : $e");
//     }
//   }
}
