import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/module/owner/owner_dashboard/view/owner_dashboard_screen.dart';
import 'package:posapplication/module/owner/owner_settings/view/owner_settings_screen.dart';

import '../controller/owner_bottomnav_controller.dart';

class OwnerBottomNavigationScreen extends StatefulWidget {
  const OwnerBottomNavigationScreen({super.key});

  @override
  State<OwnerBottomNavigationScreen> createState() =>
      _OwnerBottomNavigationScreenState();
}

class _OwnerBottomNavigationScreenState
    extends State<OwnerBottomNavigationScreen> {
  PersistentTabController _tabController = PersistentTabController();
  final OwnerBottomNavController controller = OwnerBottomNavController();

  @override
  void initState() {
    super.initState();
    controller
        .checkProfileBoxAndFirebase(); // check is profile box or firebase already exist
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
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
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
    OwnerDashboardScreen(),
    OwnerSettingsScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Dashboard"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.settings),
      title: ("Settings"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
