import 'package:dartz/dartz.dart';
import 'package:posapplication/model/profile_model.dart';
import 'package:posapplication/service/profile_service/profle_service.dart';

class ProfileController {
  final ProfileService profileServices = ProfileService();

  Future<Either<String, String>> addProfileCompany(ProfileModel profile) async {
    return await profileServices.saveProfile(profile);
  }
}
