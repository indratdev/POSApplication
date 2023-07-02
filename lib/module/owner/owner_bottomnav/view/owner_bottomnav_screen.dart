import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/module/orders/orders_screen.dart';
import 'package:posapplication/module/dashboard/dashboard_screen.dart';
import 'package:posapplication/module/settings/settings_list/view/settings_list_screen.dart';
import 'package:posapplication/shared/constants/constants.dart';

class OwnerBottomNavigationScreen extends StatefulWidget {
  const OwnerBottomNavigationScreen({super.key});

  @override
  State<OwnerBottomNavigationScreen> createState() =>
      _OwnerBottomNavigationScreenState();
}

class _OwnerBottomNavigationScreenState
    extends State<OwnerBottomNavigationScreen> {
  PersistentTabController _tabController = PersistentTabController();
  // final OwnerBottomNavController controller = OwnerBottomNavController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _tabController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: mainWhite,
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // colorBehindNavBar: Colors.white,
        colorBehindNavBar: mainGreen,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const DashboardScreen(),
    const OrdersScreen(),
    const SettingsListScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: ("Dashboard"),
      activeColorPrimary: mainGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.add),
      title: ("Transaction"),
      activeColorPrimary: mainGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.settings),
      title: ("Settings"),
      activeColorPrimary: mainGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
