import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

import '../../../../shared/constants/constants.dart';

class SettingsWidget extends StatelessWidget {
  final String menu;
  final Widget screenToOpen;
  final Bloc? bloc;
  final Object? eventToCall;
  final IconData iconName;

  const SettingsWidget({
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
          color: mainWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [boxShadowMenu],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Tab(icon: Icon(iconName)),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  TextUtil.clipStringTwoClause(menu),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
