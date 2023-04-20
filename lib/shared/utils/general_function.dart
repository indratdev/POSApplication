import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GeneralFunction {
  static navigationBackOneStep(BuildContext context) {
    Navigator.of(context).pop();
  }

  static navigationBackTwoStep(BuildContext context) {
    Navigator.of(context)
      ..pop()
      ..pop();
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
}
