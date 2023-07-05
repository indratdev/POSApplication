import 'package:flutter/material.dart';
import 'package:posapplication/data/service/export_services.dart';

import '../../constants/constants.dart';

class ColorUtils {
  Color? colorRoleUser(String role) {
    Color? roleColor = mainGreen;
    if (role == RoleUsers.admin.name) {
      roleColor = mainGreen;
    }
    if (role == RoleUsers.cashier.name) {
      roleColor = waitingColor;
    }
    if (role == RoleUsers.maker.name) {
      roleColor = orderCompletedColor;
    }

    if (role == RoleUsers.owner.name) {
      roleColor = cancelColor;
    }
    if (role == RoleUsers.staff.name) {
      roleColor = readyColor;
    }

    return roleColor.withOpacity(0.8);
  }
}
