import 'package:dartz/dartz.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/service/hive_service/hive_service.dart';
import 'package:posapplication/service/profile_service/profle_service.dart';

class ProfileController {
  final ProfileService profileServices = ProfileService();
  final HiveService hiveService = HiveService();

  // final String companyProfileBox = "companyProfile";

  Future<Either<String, ProfileModel>> addProfileCompany(
      ProfileModel profile) async {
    return await profileServices.saveProfile(profile);
  }

  Future<Map<String, dynamic>> readProfileCompany() async {
    return await profileServices.readProfileCompany();
  }

  Future<bool> isExistkBoxCompanyProfile() async {
    // return await Hive.boxExists(companyProfileBox);
    return await hiveService.isExistkBoxCompanyProfile();
  }

  // set data to box
  setProfileCompanytoBox(ProfileModel data) {
    hiveService.addProfileToHive(data);
  }

  readProfileCompanyFromBox() async {
    await hiveService.readProfileCompanyFromBox();
  }
}
