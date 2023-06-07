import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../shared/constants/constants.dart';

class SettingsWidget extends StatelessWidget {
  String menu;
  Widget screenToOpen;
  Bloc? bloc;
  Object? eventToCall;
  IconData iconName;

  SettingsWidget({
    super.key,
    required this.menu,
    required this.screenToOpen,
    required this.iconName,
    this.bloc,
    this.eventToCall,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [boxShadowMenu],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Tab(icon: Icon(iconName)),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                menu,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
