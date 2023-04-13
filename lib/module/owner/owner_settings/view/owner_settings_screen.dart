import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/module/Users/user_dashboard/view/user_dashboard_screen.dart';

import '../../owner_profile/view/owner_profile_info_screen.dart';

class OwnerSettingsScreen extends StatefulWidget {
  const OwnerSettingsScreen({super.key});

  @override
  State<OwnerSettingsScreen> createState() => _OwnerSettingsScreenState();
}

class _OwnerSettingsScreenState extends State<OwnerSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(height: 20, thickness: 0.8, color: Colors.black),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              MenuSettingListTile(
                menu: "Profile",
                screenToOpen: OwnerProfileInfoScreen(),
              ),
              MenuSettingListTile(
                menu: "User Management",
                screenToOpen: UserDashboardScreen(),
              )
            ],
          );
        },
      ),
    );
  }
}

class MenuSettingListTile extends StatelessWidget {
  String menu;
  Widget screenToOpen;

  MenuSettingListTile({
    super.key,
    required this.menu,
    required this.screenToOpen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menu),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: screenToOpen, //OwnerProfileInfoScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }
}
