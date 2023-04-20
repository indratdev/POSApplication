import 'package:flutter/widgets.dart';
import 'package:posapplication/module/Users/user_dashboard/view/user_dashboard_screen.dart';
import 'package:posapplication/module/Users/user_manage/view/user_manage_screen.dart';
import 'package:posapplication/module/auth/cover/coverauth_screen.dart';
import 'package:posapplication/module/auth/forgot_password/forgot_password_screen.dart';
import 'package:posapplication/module/auth/login/view/login_screen.dart';
import 'package:posapplication/module/auth/register/register_Screen.dart';
import 'package:posapplication/module/customers/view/customers_dashboard/customers_dashboard_screen.dart';
import 'package:posapplication/module/customers/view/customers_manage/customers_manage_screen.dart';
import 'package:posapplication/module/owner/owner_bottomnav/view/owner_bottomnav_screen.dart';
import 'package:posapplication/module/owner/owner_dashboard/view/owner_dashboard_screen.dart';
import 'package:posapplication/module/owner/owner_profile/view/owner_profile_info_screen.dart';
import 'package:posapplication/module/owner/owner_profile/view/owner_profile_screen.dart';

import '../../module/settings/settings_list/view/settings_list_screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotpassword';

  // owner
  static const String ownerBottomNav = '/owner/bottomnavigation';
  static const String ownerDashboard = '/owner/dashboard';

  static const String ownerProfileInfo = '/owner/settings/profileInfo';
  static const String ownerProfile = '/owner/settings/profile';

  // user management
  static const String userDashboard = "/userDashboard";
  static const String userManage = "/userManage";

  // settings
  static const String settingList = '/settingsList';

  // customer
  static const String customersDashboard = "/customersDashboard";
  static const String customersManage = "/customersManage";

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => CoverAuthScreen(),
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    forgotPassword: (_) => ForgotPasswordScreen(),
    ownerBottomNav: (_) => OwnerBottomNavigationScreen(),
    ownerDashboard: (_) => OwnerDashboardScreen(),
    ownerProfileInfo: (_) => OwnerProfileInfoScreen(),
    ownerProfile: (_) => OwnerProfileScreen(isUpdate: false),
    userDashboard: (_) => UserDashboardScreen(),
    userManage: (_) => UserManageScreen(),
    settingList: (_) => SettingsListScreen(),
    customersDashboard: (_) => CustomersDashboardScreen(),
    customersManage: (_) => CustomersManageScreen(),
  };
}
