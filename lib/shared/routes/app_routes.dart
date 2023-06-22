import 'package:flutter/widgets.dart';

import '../../module/export.dart';

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
  static const String userSelected = "/userSelected";

  // settings
  static const String settingList = '/settingsList';

  // customer
  static const String customersDashboard = "/customersDashboard";
  static const String customersManage = "/customersManage";
  static const String customerSelectedName = "/customersSelectedName";

  // tables
  static const String tablesDashboard = "/tablesDashboard";
  static const String tablesManagement = "/tablesManage";
  static const String tablesSelected = "/tablesSelected";

  // category
  static const String categoryDashboard = "/categoryDashboard";
  static const String categoryManagement = "/categoryManage";
  static const String categorySelected = "/categorySelected";

  // items
  static const String itemsDashboard = "/itemsDashboard";
  static const String itemsManagement = "/itemsManage";

  // orders
  static const String orders = "/orders";
  static const String ordersList = "/orders/lists";
  static const String ordersConfirmation = "/orders/lists/confirmation";

  // transactions
  static const String listTransaction = "/listTransaction";
  static const String detailTransaction = "/detailTransaction";

  // payments
  static const String confirmationPayment = '/confirmationPayment';
  static const String cashPayment = "/cashPaymentTransaction";
  static const String paymentCompleted = "/paymentCompleted";

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => CoverAuthScreen(),
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    forgotPassword: (_) => ForgotPasswordScreen(),
    ownerBottomNav: (_) => OwnerBottomNavigationScreen(),
    ownerDashboard: (_) => DashboardScreen(),
    ownerProfileInfo: (_) => OwnerProfileInfoScreen(),
    ownerProfile: (_) => OwnerProfileScreen(isUpdate: false),
    userDashboard: (_) => UserDashboardScreen(),
    userManage: (_) => UserManageScreen(),
    userSelected: (_) => UserSelectedScreen(),
    settingList: (_) => SettingsListScreen(),
    customersDashboard: (_) => CustomersDashboardScreen(),
    customersManage: (_) => CustomersManageScreen(),
    customerSelectedName: (_) => CustomersSelectedScreen(),
    tablesDashboard: (_) => TablesDashboardScreen(),
    tablesManagement: (_) => TablesManageScreen(),
    tablesSelected: (_) => TablesSelectedScreen(),
    categoryDashboard: (_) => CategoryDashboardScreen(),
    categoryManagement: (_) => CategoryManagementScreen(),
    categorySelected: (_) => CategorySelectedScreen(),
    itemsDashboard: (_) => ItemsDashboardScreen(),
    itemsManagement: (_) => ItemsManagementScreen(),
    orders: (_) => const OrdersScreen(),
    ordersList: (_) => const OrdersListScreen(),
    ordersConfirmation: (_) => OrdersConfirmationScreen(),
    listTransaction: (_) => ListTransactionScreen(status: ""),
    detailTransaction: (_) => DetailTransactionScreen(),
    confirmationPayment: (_) => ConfirmationPaymentScreen(),
    cashPayment: (_) =>
        CashPaymentTransactionScreen(totalTranscationAmount: 0.0),
    paymentCompleted: (_) => PaymentCompletedScreen(),
  };
}
