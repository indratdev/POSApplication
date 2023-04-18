import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/module/Users/bloc/users_bloc.dart';
import 'package:posapplication/module/Users/user_dashboard/view/user_dashboard_screen.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';

import '../../owner_profile/view/owner_profile_info_screen.dart';

class OwnerSettingsScreen extends StatefulWidget {
  const OwnerSettingsScreen({super.key});

  @override
  State<OwnerSettingsScreen> createState() => _OwnerSettingsScreenState();
}

class _OwnerSettingsScreenState extends State<OwnerSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // final usersBloc = BlocProvider.of<UsersBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(height: 20, thickness: 0.8, color: Colors.black),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              MenuSettingListTile(
                menu: "Profile",
                screenToOpen: OwnerProfileInfoScreen(),
                bloc: BlocProvider.of<OwnerBloc>(context),
                eventToCall: OpenBoxProfileEvent(),
              ),
              MenuSettingListTile(
                menu: "User Management",
                screenToOpen: UserDashboardScreen(),
                bloc: BlocProvider.of<UsersBloc>(context),
                eventToCall: GetAllUsersEvent(),
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
  Bloc? bloc;
  Object? eventToCall;

  MenuSettingListTile({
    super.key,
    required this.menu,
    required this.screenToOpen,
    this.bloc,
    this.eventToCall,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menu),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (bloc != null) {
          bloc!.add(eventToCall);
        }
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: screenToOpen,
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }
}
