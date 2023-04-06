import 'package:flutter/widgets.dart';
import 'package:posapplication/module/auth/cover/coverauth_screen.dart';
import 'package:posapplication/module/auth/forgot_password/forgot_password_screen.dart';
import 'package:posapplication/module/auth/login/view/login_screen.dart';
import 'package:posapplication/module/auth/register/register_Screen.dart';
import 'package:posapplication/module/owner/owner_dashboard/owner_dashboard_screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotpassword';

  // owner
  static const String ownerDashboard = '/owner/dashboard';

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => CoverAuthScreen(),
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    forgotPassword: (_) => ForgotPasswordScreen(),
    ownerDashboard: (_) => OwnerDashboardScreen(),
  };
}
