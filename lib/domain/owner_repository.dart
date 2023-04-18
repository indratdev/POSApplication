import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/data/service/auth_service/auth_service.dart';
import 'package:posapplication/data/service/hive_service/hive_service.dart';
import 'package:posapplication/data/service/profile_service/profle_service.dart';

import '../../../../data/model/profile_model.dart';

class OwnerRepository {
  final HiveService hiveService = HiveService();
  final ProfileService profileServices = ProfileService();
  final AuthService authService = AuthService();

  checkProfileBoxAndFirebase() async {
    bool statusLocal =
        await hiveService.isExistCompanyProfileFromBox(); // check local box
    // kalo false(tidak ada) -> check ke firebase
    if (!statusLocal) {
      Map<String, dynamic> dataProfile =
          await profileServices.readProfileCompany();

      if (dataProfile.isNotEmpty) {
        hiveService.addProfileToHive(ProfileModel.fromJson(dataProfile));
      }
    }
  }

  Future<Map<String, dynamic>> readProfileCompany() async {
    return await profileServices.readProfileCompany();
  }

  void logout() {
    authService.signOut();
  }

  //

  // check profile box already open ?
  Future<Box> isBoxProfileAlreadyOpen() async {
    return await hiveService.isBoxProfileAlreadyOpen();
  }

  // add profile company
  Future<Either<String, ProfileModel>> addProfileCompany(
      ProfileModel profile) async {
    return await profileServices.saveProfile(profile);
  }

  // Future<Map<String, dynamic>> readProfileCompany() async {
  //   return await profileServices.readProfileCompany();
  // }

  Future<bool> isExistkBoxCompanyProfile() async {
    return await hiveService.isExistkBoxCompanyProfile();
  }

  // set data to box
  setProfileCompanytoBox(ProfileModel data) {
    hiveService.addProfileToHive(data);
  }

  // update profile company
  updateProfileCompanyToBox(ProfileModel data) async {
    await hiveService.updateProfileCompanyToBox(data);
  }

  readProfileCompanyFromBox() async {
    await hiveService.readProfileCompanyIDFromBox();
  }
}
