import 'package:posapplication/data/model/ops_daily_model.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/data/service/hive_service/hive_service.dart';

import '../data/model/profile_model.dart';

class HiveRepository {
  final HiveService hiveService = HiveService();

  // -------------- CREATE
  // create user login to hive
  createUserLoginToHive(UsersModel usersModel) async {
    return await hiveService.addUserLoginToHive(usersModel);
  }

  // set data to box
  createProfileCompanytoBox(ProfileModel data) {
    hiveService.addProfileToHive(data);
  }

  // create ops daily
  createOpsDailytoBox(OpsDailyModel opsDailyModel) {
    hiveService.addOpsDailyToHive(opsDailyModel);
  }

  rewriteOpsDailytoBox(OpsDailyModel opsDailyModel) {
    hiveService.rewriteOpsDailyToHive(opsDailyModel);
  }

  // --------------- READ
  Future<UsersModel> readUserLoginFromHive() async {
    return await hiveService.readUserLoginFromBox();
  }

  Future<String> readProfileCompanyIDFromBox() async {
    return await hiveService.readProfileCompanyIDFromBox();
  }

  Future<ProfileModel> readProfileCompanyFromBox() async {
    return await hiveService.readProfileFromBox();
  }

  // ---------------------- UPDATE
  updateProfileCompanyToBox(ProfileModel data) async {
    await hiveService.updateProfileCompanyToBox(data);
  }

  // ---------------------- DELETE
  deleteOpsDailyBox() async {
    await hiveService.deleteOpsDailyBox();
  }
}
