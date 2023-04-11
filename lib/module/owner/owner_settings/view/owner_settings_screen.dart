import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
              ListTile(
                title: Text("Profile"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: OwnerProfileInfoScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              ListTile(
                title: Text("tes"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          );
        },
      ),
    );
  }
}
