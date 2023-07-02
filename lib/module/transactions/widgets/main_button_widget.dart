import 'package:flutter/material.dart';
import 'package:posapplication/shared/constants/constants.dart';

enum ButtonName {
  mainButton,
  secondButton,
}

class MainButtonWidget extends StatelessWidget {
  ButtonName buttonName;
  // Color? customColor;
  String textLabel;
  Function()? onPress;

  MainButtonWidget({
    super.key,
    required this.buttonName,
    required this.textLabel,
    this.onPress,
    // this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 8,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          shadowColor: blackTextColor,
          backgroundColor: (buttonName.name == ButtonName.mainButton.name)
              ? mainGreen
              : mainWhite,
          // (customColor != null)
          //     ? customColor
          //     : ((buttonName.name == ButtonName.login.name))
          //         ? mainGreen
          //         : mainWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPress,
        // () {
        //   (buttonName.name == ButtonName.mainButton.name)
        //       ? Navigator.pushNamed(context, AppRoutes.login)
        //       : Navigator.pushNamed(context, AppRoutes.register);
        // },
        child: Text(
          // (buttonName.name == ButtonName.login.name) ? "LOGIN" : "DAFTAR",
          textLabel,
          style: TextStyle(
            color: (buttonName.name == ButtonName.mainButton.name)
                ? mainWhite
                : mainGreen,
          ),
        ),
      ),
    );
  }
}
