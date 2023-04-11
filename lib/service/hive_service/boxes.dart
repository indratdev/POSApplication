import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/service/hive_service/hive_init.dart';

class Boxes {
  HiveData hiveData = HiveData();

  static Box<ProfileModel> getTask() =>
      Hive.box<ProfileModel>("company_profile");

  // Futher,  you can add any other boxes here ...
}
