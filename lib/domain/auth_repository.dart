import 'package:posapplication/data/service/user_service/user_service.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

class AuthRepository {
  String accessMenuByRole(String role) {
    String route = "";
    if (role == RoleUsers.owner.name) {
      route = AppRoutes.ownerDashboard;
    }

    return route;
  }
}
