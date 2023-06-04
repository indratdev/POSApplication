import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/data/model/ops_daily_model.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/data/service/hive_service/boxes.dart';

import '../../model/profile_model.dart';

class HiveService {
  static const String companyProfileBox = "company_profile";
  static const String companyProfileKey = "profile_key";
  static const String currentUserLoginBox = "currentUserLogin_box";
  static const String currentUserLoginKey = "currentUserLogin_key";
  static const String usersBox = "users_box";
  static const String usersKey = "users_key";
  static const String opsDailyBox = "opsDaily_box";
  static const String opsDailyKey = "opsDaily_key";
  static Box profileBox = Boxes.getTask();

  // check
  Future<Box<dynamic>> isBoxAlreadyOpen(String boxName) async {
    late Box box;
    bool status = Hive.isBoxOpen(boxName);
    print(">>> status new : $status");
    if (status == false) {
      if (boxName == companyProfileBox) {
        box = await Hive.openBox(companyProfileBox);
      }
      if (boxName == currentUserLoginBox) {
        box = await Hive.openBox(currentUserLoginBox);
      }
      if (boxName == opsDailyBox) {
        box = await Hive.openBox(opsDailyBox);
      }
      if (boxName == usersBox) {
        box = await Hive.openBox(usersBox);
      }
    }

    // box = Hive.box(boxName);
    box = await Hive.openBox(boxName);

    print(">> status box nya  ::: ${box.values}");

    return box;
  }

  Future<bool> isExistkBoxCompanyProfile() async {
    return await Hive.boxExists(companyProfileBox);
  }

  Future<bool> isExistkBoxUsers() async {
    return await Hive.boxExists(usersBox);
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

  // add ops daily
  addOpsDailyToHive(OpsDailyModel opsDailyModel) async {
    Box box = await isBoxAlreadyOpen(opsDailyBox);

    await box.put(opsDailyKey, opsDailyModel);
  }

  rewriteOpsDailyToHive(OpsDailyModel opsDailyModel) async {
    Box box = await isBoxAlreadyOpen(opsDailyBox);
    await box.clear();
    await box.put(opsDailyKey, opsDailyModel);
  }

  // addUserLoginToHive
  addUserLoginToHive(UsersModel usersModel) async {
    Box box = await isBoxAlreadyOpen(currentUserLoginBox);
    // first delete data and insert again
    await box.deleteAll(box.keys);

    await box.put(currentUserLoginKey, usersModel);
  }

  // addUserLoginToHive
  addUserFirebaseToHive(UsersModel usersModel) async {
    await isExistkBoxUsers();

    Box box = await isBoxAlreadyOpen(usersBox);

    await box.add(usersModel);
  }

  // ------------------------------ READ
  // readProfileCompanyIDFromBox
  Future<String> readProfileCompanyIDFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(companyProfileBox);

    ProfileModel model = await box.get(companyProfileKey) as ProfileModel;
    return model.companyID.toString();
  }

  // testing
  Future<List<UsersModel>> readAllUserFromBox() async {
    late Box box;
    box = await isBoxAlreadyOpen(usersBox);
    var result = box.values;

    print(">>> readAllUserFromBox :: ${result.length}");

    return List<UsersModel>.from(result);

    // var aaa = box.get(usersKey) as List<UsersModel>;

    // for (var element in bbb) {
    //   UsersModel aaa = element;
    //   print(">>> element : ${aaa.firstname}");
    // }

    // UsersModel model = await box.get(usersKey) as UsersModel;

    // print(">>> user length : ${model.firstname}");

    // var aaa = box.getAt(0);
    // var bbb = box.getAt(1);

    // print(aaa);
    // print(bbb);

    // Map<dynamic, dynamic> tess = box.toMap();
    // List list = tess.values.toList();

    // print(">>> list length : ${list.length}");

    // for (var element in list) {
    //   print(element);
    // }

    // var model = await box.get(usersKey);
    // print(model[0]);
    // print(model[1]);
    // var aaa = HiveList(box);
    // print(model);
    // print(">>> aaa: ${tess}");
    // for (var element in tess) {
    //   print(">>> element : ${element}");
    // }
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

    UsersModel model = await box.get(currentUserLoginKey) as UsersModel;

    return model;
  }

  // readProfileCompanyIDFromBox
  // Future<List<UsersModel>> readUsersFromBox() async {
  //   late Box box;
  //   box = await isBoxAlreadyOpen(usersBox);

  //   var modelBox = await box.get(usersKey);

  //   for (var element in modelBox) {

  //   }

  //   return model;
  // }

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

  deleteOpsDailyBox() async {
    if (await Hive.boxExists(opsDailyBox)) {
      Hive.box(opsDailyBox).clear();
    }
  }

  deleteUsersBox() async {
    if (await Hive.boxExists(usersBox)) {
      // Hive.box(usersBox).clear();
      Hive.box(usersBox).deleteFromDisk();
      // Hive.deleteBoxFromDisk(usersBox);
      // Hive.box(usersBox).delete(usersKey);
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
