import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../model/category_model.dart';
import '../../model/ops_daily_model.dart';
import '../../model/profile_model.dart';
import '../../model/tables_model.dart';
import '../../model/users_model.dart';

class HiveData {
  static init() async {
    final appDocDor = await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDor.path);
    Hive.registerAdapter(ProfileModelAdapter());
    Hive.registerAdapter(UsersModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(TablesModelAdapter());
    Hive.registerAdapter(OpsDailyModelAdapter());
    // await Hive.openBox<ProfileModel>("company_profile");
  }
}
