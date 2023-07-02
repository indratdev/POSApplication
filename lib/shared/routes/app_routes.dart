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
    first: (_) => const CoverAuthScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    ownerBottomNav: (_) => const OwnerBottomNavigationScreen(),
    ownerDashboard: (_) => const DashboardScreen(),
    ownerProfileInfo: (_) => const OwnerProfileInfoScreen(),
    ownerProfile: (_) => OwnerProfileScreen(isUpdate: false),
    userDashboard: (_) => const UserDashboardScreen(),
    userManage: (_) => UserManageScreen(),
    userSelected: (_) => const UserSelectedScreen(),
    settingList: (_) => const SettingsListScreen(),
    customersDashboard: (_) => const CustomersDashboardScreen(),
    customersManage: (_) => CustomersManageScreen(),
    customerSelectedName: (_) => const CustomersSelectedScreen(),
    tablesDashboard: (_) => const TablesDashboardScreen(),
    tablesManagement: (_) => TablesManageScreen(),
    tablesSelected: (_) => const TablesSelectedScreen(),
    categoryDashboard: (_) => const CategoryDashboardScreen(),
    categoryManagement: (_) => CategoryManagementScreen(),
    categorySelected: (_) => const CategorySelectedScreen(),
    itemsDashboard: (_) => const ItemsDashboardScreen(),
    itemsManagement: (_) => ItemsManagementScreen(),
    orders: (_) => const OrdersScreen(),
    ordersList: (_) => const OrdersListScreen(),
    ordersConfirmation: (_) => const OrdersConfirmationScreen(),
    listTransaction: (_) => ListTransactionScreen(status: ""),
    detailTransaction: (_) => DetailTransactionScreen(),
    confirmationPayment: (_) => ConfirmationPaymentScreen(),
    cashPayment: (_) =>
        CashPaymentTransactionScreen(totalTranscationAmount: 0.0),
    paymentCompleted: (_) => const PaymentCompletedScreen(),
  };
}
