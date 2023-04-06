import 'package:posapplication/service/user_service/user_service.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

class LoginController {
  String accessMenuByRole(String role) {
    String route = "";
    if (role == RoleUsers.owner.name) {
      route = AppRoutes.ownerDashboard;
    }

    return route;
  }
}
