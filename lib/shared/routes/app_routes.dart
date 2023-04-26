import 'package:flutter/widgets.dart';
import 'package:posapplication/module/settings/category/view/category_dashboard_screen.dart';
import 'package:posapplication/module/settings/category/view/category_management_screen.dart';

import '../../module/export.dart';
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

  // tables
  static const String tablesDashboard = "/tablesDashboard";
  static const String tablesManagement = "/tablesManage";

  // category
  static const String categoryDashboard = "/categoryDashboard";
  static const String categoryManagement = "/categoryManage";

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
    tablesDashboard: (_) => TablesDashboardScreen(),
    tablesManagement: (_) => TablesManageScreen(),
    categoryDashboard: (_) => CategoryDashboardScreen(),
    categoryManagement: (_) => CategoryManagementScreen(),
  };
}
