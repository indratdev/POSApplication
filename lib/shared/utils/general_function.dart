import 'package:flutter/material.dart';
import 'package:posapplication/domain/user_repository.dart';
import 'package:uuid/uuid.dart';


class GeneralFunction {
  UserRepository userRepository = UserRepository();

  static navigationBackOneStep(BuildContext context) {
    Navigator.of(context).pop();
  }

  static navigationBackTwoStep(BuildContext context) {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  static navigationBack(BuildContext context, int step) {
    if (step == 1) {
      Navigator.of(context).pop();
    } else if (step == 2) {
      Navigator.of(context)
        ..pop()
        ..pop();
    } else if (step == 3) {
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  String generateUniqueID() {
    var uuid = const Uuid().v1();
    var id = uuid.replaceAll("-", "");
    return id;
  }

  String hideSeveralUserID(String userID) {
    var subUserID = userID.substring(0, 10);
    return "$subUserID-xxxx.xxx.xxx";
  }

  // generate table id
  String generateUniqueTableID() {
    var uuid = const Uuid().v1();
    var id = uuid.replaceAll("-", "");

    return "tbl$id";
  }

  // generate item id
  String generateUniqueItemID() {
    var uuid = const Uuid().v1();
    var id = uuid.replaceAll("-", "");

    return "item$id";
  }

  // generate general id
  String generateUniqueGeneralID(String uniqueName) {
    var uuid = const Uuid().v1();
    var id = uuid.replaceAll("-", "");
    String name = uniqueName + id;

    return name;
  }

  String hideSeveralTableID(String tableID) {
    var subTableID = tableID.substring(0, 12);
    return "$subTableID-xxxx.xxx.xxx";
  }

  // generate general id
  Future<String> generateOrderID() async {
    var uuid = const Uuid().v1();
    var id = uuid.replaceAll("-", "");
    String companyID = await userRepository.readCompanyID();
    String name = "orderS$companyID$id";
    return name;
  }
}
