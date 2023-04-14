import 'package:posapplication/service/hive_service/hive_service.dart';
import 'package:posapplication/service/profile_service/profle_service.dart';

import '../../../../model/profile_model.dart';

class OwnerBottomNavController {
  final HiveService hiveService = HiveService();
  final ProfileService profileServices = ProfileService();

  checkProfileBoxAndFirebase() async {
    // check local box
    bool statusLocal = await hiveService.isExistCompanyProfileFromBox();
    // kalo false(tidak ada) -> check ke firebase
    if (!statusLocal) {
      Map<String, dynamic> dataProfile =
          await profileServices.readProfileCompany();

      if (dataProfile.isNotEmpty) {
        hiveService.addProfileToHive(ProfileModel.fromJson(dataProfile));
      }
    }
  }

  Future<Map<String, dynamic>> readProfileCompany() async {
    return await profileServices.readProfileCompany();
  }
}
