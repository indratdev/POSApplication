import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/service/hive_service/boxes.dart';

class HiveService {
  static const String companyProfileBox = "company_profile";
  static const String companyProfileKey = "profile_key";
  static Box profileBox = Boxes.getTask();

  Future<bool> isExistkBoxCompanyProfile() async {
    return await Hive.boxExists(companyProfileBox);
  }

  // To add User To hive
  addProfileToHive(ProfileModel profile) async {
    await profileBox.add(profile);
  }

  // read Proffile
  readProfileCompanyFromBox() async {
    var aaa = await profileBox.get(0);
    print(aaa);
  }

  //delete profile
  deleteProfileBox() async {
    if (await Hive.boxExists(companyProfileBox)) {
      profileBox.delete(companyProfileKey);
    }
  }
}
