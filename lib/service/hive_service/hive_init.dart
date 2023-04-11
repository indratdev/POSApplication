import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:posapplication/model/profile_model.dart';

class HiveData {
  static init() async {
    final appDocDor = await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDor.path);
    Hive.registerAdapter(ProfileModelAdapter());
    // await Hive.openBox<ProfileModel>("company_profile");
  }
}
