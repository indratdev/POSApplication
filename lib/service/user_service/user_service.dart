import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posapplication/shared/utils/shared_preferences/myshared_preferences.dart';

enum RoleUsers {
  owner,
  admin,
  cashier,
  maker,
  staff,
}

class UserService {
  final MySharedPreferences mySharedP = MySharedPreferences();

  Future<Either<String, String>> saveUserData(
    RoleUsers roleUsers,
  ) async {
    late Either<String, String> myEither;
    String companyID = await mySharedP.getCompanyID();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(companyID)
        .set({
          "companyID": FirebaseAuth.instance.currentUser!.uid.toString(),
          "userID": FirebaseAuth.instance.currentUser!.uid.toString(),
          "email": FirebaseAuth.instance.currentUser!.email.toString(),
          "firstname": "",
          "lastname": "",
          "role": roleUsers.name.toString(),
          "photo": "",
        })
        .then((value) => myEither = const Right("Save User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    if (roleUsers.name == RoleUsers.owner.name) {
      mySharedP
          .saveCompanyID(FirebaseAuth.instance.currentUser!.uid.toString());
    }

    return myEither;
  }
}
