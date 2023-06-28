import 'package:flutter/material.dart';
import 'package:posapplication/shared/constants/constants.dart';

import '../../../shared/routes/app_routes.dart';

enum ButtonName {
  login,
  register,
}

class MainButtonWidget extends StatelessWidget {
  ButtonName buttonName;

  MainButtonWidget({
    super.key,
    required this.buttonName,
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
          backgroundColor: (buttonName.name == ButtonName.login.name)
              ? mainGreen
              : mainWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          (buttonName.name == ButtonName.login.name)
              ? Navigator.pushNamed(context, AppRoutes.login)
              : Navigator.pushNamed(context, AppRoutes.register);
        },
        child: Text(
          (buttonName.name == ButtonName.login.name) ? "LOGIN" : "DAFTAR",
          style: TextStyle(
            color: (buttonName.name == ButtonName.login.name)
                ? mainWhite
                : mainGreen,
          ),
        ),
      ),
    );
  }
}
