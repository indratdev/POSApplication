import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/service/hive_service/hive_service.dart';
import 'package:posapplication/service/profile_service/profle_service.dart';

class ProfileController {
  final ProfileService profileServices = ProfileService();
  final HiveService hiveService = HiveService();

  // check profile box already open ?
  Future<Box> isBoxProfileAlreadyOpen() async {
    return await hiveService.isBoxProfileAlreadyOpen();
  }

  // add profile company
  Future<Either<String, ProfileModel>> addProfileCompany(
      ProfileModel profile) async {
    return await profileServices.saveProfile(profile);
  }

  Future<Map<String, dynamic>> readProfileCompany() async {
    return await profileServices.readProfileCompany();
  }

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

  // Future<Either<String, ProfileModel>> updateProfileCompany(
  //     ProfileModel profile) async {
  //   return await profileServices.saveProfile(profile);
  // }

  // testUpdate(ProfileModel profileModel) async {
  //   await hiveService.testUpdate(profileModel);
  // }

  readProfileCompanyFromBox() async {
    await hiveService.readProfileCompanyFromBox();
  }
}
