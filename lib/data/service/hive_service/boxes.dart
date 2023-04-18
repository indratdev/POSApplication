import 'package:hive_flutter/hive_flutter.dart';

import 'package:posapplication/data/service/hive_service/hive_init.dart';

import '../../model/profile_model.dart';

class Boxes {
  HiveData hiveData = HiveData();

  static Box<ProfileModel> getTask() =>
      Hive.box<ProfileModel>("company_profile");

  // Futher,  you can add any other boxes here ...
}
