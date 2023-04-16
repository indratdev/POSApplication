import 'package:posapplication/service/hive_service/hive_service.dart';
import 'package:posapplication/service/user_service/user_service.dart';

class UserDashboardController {
  final UserService userService = UserService();
  final HiveService hiveService = HiveService();

  getAllUser() async {
    await userService.readAllUser();
  }

  Future<String> readCompanyID() async {
    return await hiveService.readProfileCompanyIDFromBox();
  }
}
