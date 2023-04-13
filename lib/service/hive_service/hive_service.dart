import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/service/hive_service/boxes.dart';

class HiveService {
  static const String companyProfileBox = "company_profile";
  static const String companyProfileKey = "profile_key";
  static Box profileBox = Boxes.getTask();

  Future<Box<dynamic>> isBoxProfileAlreadyOpen() async {
    late Box box;
    bool status = Hive.isBoxOpen(companyProfileBox);
    // var boxx = Hive.box('company_profile');
    print(">>>>> status : $status");

    (status)
        // ? box = Hive.box<ProfileModel>(HiveService.companyProfileBox)
        ? box = Hive.box<ProfileModel>(companyProfileBox)
        : box = await Hive.openBox(HiveService.companyProfileBox);

    return box;
  }

  Future<bool> isExistkBoxCompanyProfile() async {
    return await Hive.boxExists(companyProfileBox);
  }

  // To add User To hive
  addProfileToHive(ProfileModel profile) async {
    // await profileBox.add(profile);
    await profileBox.put(companyProfileKey, profile);
  }

  // read Proffile
  readProfileCompanyFromBox() async {
    var aaa = await profileBox.get(companyProfileBox);
    print(aaa);
  }

  // update
  updateProfileCompanyToBox(ProfileModel profileModel) async {
    // await profileBox.put(companyProfileKey, profile);
    try {
      final box = await isBoxProfileAlreadyOpen();
      final ProfileModel? profile = box.get(companyProfileKey);
      profile?.bussinessAddress = profileModel.bussinessAddress ?? "";
      profile?.bussinessCountry = profileModel.bussinessAddress ?? "";
      profile?.bussinessCurrency = profileModel.bussinessCurrency ?? "";
      profile?.bussinessName = profileModel.bussinessName ?? "";
      profile?.bussinessPhone = profileModel.bussinessPhone ?? "";
      profile?.bussinessType = profileModel.bussinessType ?? "";
      profile?.companyID = profileModel.companyID ?? "";
      await profileBox.put(companyProfileKey, profile);
      box.close();
    } catch (e) {
      print(e.toString());
    }
  }

  //delete profile
  deleteProfileBox() async {
    if (await Hive.boxExists(companyProfileBox)) {
      profileBox.delete(companyProfileKey);
    }
  }

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
