import 'package:flutter/widgets.dart';
import 'package:posapplication/module/auth/cover/coverauth_screen.dart';
import 'package:posapplication/module/auth/forgot_password/forgot_password_screen.dart';
import 'package:posapplication/module/auth/login/view/login_screen.dart';
import 'package:posapplication/module/auth/register/register_Screen.dart';
import 'package:posapplication/module/owner/owner_bottomnav/owner_bottomnav_screen.dart';
import 'package:posapplication/module/owner/owner_dashboard/owner_dashboard_screen.dart';
import 'package:posapplication/module/owner/owner_profile/view/owner_profile_info_screen.dart';
import 'package:posapplication/module/owner/owner_profile/view/owner_profile_screen.dart';

import '../../module/owner/owner_settings/view/owner_settings_screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotpassword';

  // owner
  static const String ownerBottomNav = '/owner/bottomnavigation';
  static const String ownerDashboard = '/owner/dashboard';
  static const String ownerSettings = '/owner/settings';
  static const String ownerProfileInfo = '/owner/settings/profileInfo';
  static const String ownerProfile = '/owner/settings/profile';

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => CoverAuthScreen(),
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    forgotPassword: (_) => ForgotPasswordScreen(),
    ownerBottomNav: (_) => OwnerBottomNavigationScreen(),
    ownerDashboard: (_) => OwnerDashboardScreen(),
    ownerSettings: (_) => OwnerSettingsScreen(),
    ownerProfileInfo: (_) => OwnerProfileInfoScreen(),
    ownerProfile: (_) => OwnerProfileScreen(),
  };
}
