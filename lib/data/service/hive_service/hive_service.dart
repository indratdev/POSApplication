import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/data/service/hive_service/boxes.dart';

import '../../model/profile_model.dart';

class HiveService {
  static const String companyProfileBox = "company_profile";
  static const String companyProfileKey = "profile_key";
  static Box profileBox = Boxes.getTask();

  // check
  Future<Box<dynamic>> isBoxProfileAlreadyOpen() async {
    late Box box;
    bool status = Hive.isBoxOpen(companyProfileBox);
    if (status == false) {
      box = await Hive.openBox(companyProfileBox);
    }
    box = Hive.box(companyProfileBox);
    return box;
  }

  Future<bool> isExistkBoxCompanyProfile() async {
    return await Hive.boxExists(companyProfileBox);
  }

  Future<bool> isExistCompanyProfileFromBox() async {
    late Box box;
    box = await isBoxProfileAlreadyOpen();
    var data = await box.get(companyProfileKey);
    return (data != null) ? true : false;
  }

  // end check

  // add profile
  addProfileToHive(ProfileModel profile) async {
    Box box = await isBoxProfileAlreadyOpen();
    await box.put(companyProfileKey, profile);
  }

  // READ

  // readProfileCompanyIDFromBox
  Future<String> readProfileCompanyIDFromBox() async {
    late Box box;
    box = await isBoxProfileAlreadyOpen();

    ProfileModel model = await box.get(companyProfileKey) as ProfileModel;
    return model.companyID.toString();
  }

  // END READ

  // update
  updateProfileCompanyToBox(ProfileModel profileModel) async {
    // await profileBox.put(companyProfileKey, profile);
    try {
      // final box = await isBoxProfileAlreadyOpen();
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
      final box = await isBoxProfileAlreadyOpen();
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
