import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/profile_model.dart';

class ProfileService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String profilesCollection = "profiles";

  // read profile
  Future<Map<String, dynamic>> readProfileCompany() async {
    DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection(profilesCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    return result.data() ?? {};
  }

  // save profile
  Future<Either<String, ProfileModel>> saveProfile(
    ProfileModel profile,
  ) async {
    late Either<String, ProfileModel> myEither;
    profile.companyID = FirebaseAuth.instance.currentUser!.uid.toString();

    // save
    await FirebaseFirestore.instance
        .collection(profilesCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .set(profile.toJson())
        // .then((value) => myEither = const Right("Save User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    // read
    Map<String, dynamic> profileData = await readProfileCompany();

    myEither = Right(ProfileModel.fromJson(profileData));

    return myEither;
  }
}
