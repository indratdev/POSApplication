import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/data/service/hive_service/hive_service.dart';

class HiveRepository {
  final HiveService hiveService = HiveService();

  // -------------- CREATE
  // create user login to hive
  createUserLoginToHive(UsersModel usersModel) async {
    return await hiveService.addUserLoginToHive(usersModel);
  }

  // --------------- READ
  Future<UsersModel> readUserLoginFromHive() async {
    return await hiveService.readUserLoginFromBox();
  }
}
