import 'package:posapplication/service/user_service/user_service.dart';

class UserDashboardController {
  final UserService userService = UserService();

  getAllUser() async {
    await userService.readAllUser();
  }
}
