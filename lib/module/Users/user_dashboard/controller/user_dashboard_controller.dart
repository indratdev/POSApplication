import 'package:posapplication/data/service/hive_service/hive_service.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';

import '../../../../data/model/users_model.dart';

class UserDashboardController {
  final UserService userService = UserService();
  final HiveService hiveService = HiveService();

  // READ
  // read company ID from Box/Hive
  Future<String> readCompanyID() async {
    return await hiveService.readProfileCompanyIDFromBox();
  }

  // read list users from firebase
  Future<List<UsersModel>> readAllUser() async {
    String companyID = await readCompanyID();
    List<UsersModel> result = await userService.readAllUser(companyID);
    return result;
  }

  // END READ
}
