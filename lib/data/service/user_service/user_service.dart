import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/shared/utils/shared_preferences/myshared_preferences.dart';

import '../../model/users_model.dart';

enum RoleUsers {
  owner,
  admin,
  cashier,
  maker,
  staff,
}

class UserService {
  final MySharedPreferences mySharedP = MySharedPreferences();
  static const String userCollection = "users";
  static const String customersCollection = "customers";
  static const String listUserCollection = "list_user";

  getCompanyID(RoleUsers roleUsers) async {
    String companyID = "";
    if (roleUsers.name == RoleUsers.owner.name) {
      companyID = await mySharedP.getCompanyID();
    } else {
      companyID = FirebaseAuth.instance.currentUser!.uid.toString();
    }
    return companyID;
  }

  // Future<Either<String, DocumentSnapshot<Map<String, dynamic>>>>
  //     saveAndReadUserData(
  //         // Future<DocumentSnapshot<Map<String, dynamic>>> saveAndReadUserData(
  //         RoleUsers roleUsers) async {
  //   late Either<String, DocumentSnapshot<Map<String, dynamic>>> myEither;
  //   String message = "";

  //   var result = await saveUserData(roleUsers);
  //   result.fold(
  //     (l) => message = l,
  //     (data) => message = data,
  //   );

  //   var detailData = await FirebaseFirestore.instance
  //       .collection(userCollection)
  //       .doc(getCompanyID(roleUsers))
  //       .collection(listUserCollection)
  //       .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //       .get()
  //       .then((value) => myEither = Right(value))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // read detail user
  Future<Map<String, dynamic>> readDataUser() async {
    DocumentSnapshot<Map<String, dynamic>> detailUser = await FirebaseFirestore
        .instance
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    print(">>> detail: ${detailUser.data()!["role"]}");

    return detailUser.data() ?? {};
  }

  // read all user
  Future<List<UsersModel>> readAllUser(String companyID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(userCollection)
        .where('companyID', isEqualTo: companyID)
        .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
        .get();

    var data = querySnapshot.docs
        .map((e) => UsersModel.fromDocumentSnapshot(e))
        .toList();
    return data;
  }

  // read all customers
  Future<List<CustomersModel>> readAllCustomers(String companyID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection(customersCollection)
            .where('companyID', isEqualTo: companyID)
            // .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
            .get();

    var data = querySnapshot.docs
        .map((e) => CustomersModel.fromDocumentSnapshot(e))
        .toList();
    return data;
  }

  // readAllUser() async {
  //   // String companyID = await mySharedP.getCompanyID();

  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection(userCollection)
  //       .where('companyID',
  //           isEqualTo: "3BnGWuFviVPRRNfYqsS5aVa0xIm1") // masih salah
  //       .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
  //       .get();
  //   List<DocumentSnapshot> documents = querySnapshot.docs;
  //   // print(documents);
  //   for (var element in documents) {
  //     print(element.data());
  //   }

  //   // return detailUser.data() ?? {};
  // }

  Future<Either<String, String>> saveUserData(
    RoleUsers roleUsers,
    // bool isOwner,
  ) async {
    late Either<String, String> myEither;
    // String companyID = (roleUsers.name == RoleUsers.owner.name)
    //     ? await mySharedP.getCompanyID()
    // : FirebaseAuth.instance.currentUser!.uid.toString();
    String companyID = await mySharedP.getCompanyID();

    await FirebaseFirestore.instance
        .collection(userCollection)
        // .doc(companyID)
        // .collection(listUserCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .set({
          "companyID": companyID,
          "userID": FirebaseAuth.instance.currentUser!.uid.toString(),
          "email": FirebaseAuth.instance.currentUser!.email.toString(),
          "firstname": "",
          "lastname": "",
          "role": roleUsers.name.toString(),
          "photo": "",
        })
        .then((value) => myEither = const Right("Save User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    // if (roleUsers.name == RoleUsers.owner.name) {
    //   mySharedP
    //       .saveCompanyID(FirebaseAuth.instance.currentUser!.uid.toString());
    // }

    return myEither;
  }

  Future<Either<String, String>> saveNewUser(
    User newUser,
    UsersModel userModel,
    String companyID,
  ) async {
    late Either<String, String> myEither;

    // String companyID = await mySharedP.getCompanyID();

    await FirebaseFirestore.instance
        .collection(userCollection)
        // .doc(companyID)
        // .collection(listUserCollection)
        .doc(newUser.uid.toString())
        .set({
          "companyID": companyID,
          "userID": newUser.uid.toString(),
          "email": newUser.email.toString(),
          "firstname": userModel.firstname.toString(),
          "lastname": userModel.lastname.toString(),
          "role": userModel.role.toString(),
          "photo": userModel.photo.toString(),
        })
        .then((value) => myEither = const Right("Save User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // String? documentID;
  // String? companyID;

  // add new customer
  Future<Either<String, String>> saveNewCustomer(
    // User newUser,
    CustomersModel customerModel,
    String companyID,
    String uniqueID,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(customersCollection)
        .doc(uniqueID)
        .set({
          "companyID": companyID,
          "customerID": uniqueID,
          "email": customerModel.email.toString(),
          "fullname": customerModel.fullname.toString(),
          "address": customerModel.address.toString(),
          "gender": customerModel.gender.toString(),
          "phoneNumber": customerModel.phoneNumber.toString(),
          "point": 0,
        })
        .then((value) => myEither = const Right("Save Customers Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // update user
  Future<Either<String, String>> updateUser(
    // User newUser,
    UsersModel userModel,
    // String companyID,
  ) async {
    late Either<String, String> myEither;

    // String companyID = await mySharedP.getCompanyID();

    await FirebaseFirestore.instance
        .collection(userCollection)
        // .doc(companyID)
        // .collection(listUserCollection)
        .doc(userModel.documentID.toString())
        .set({
          "companyID": userModel.companyID.toString(),
          "userID": userModel.userID.toString(),
          "email": userModel.email.toString(),
          "firstname": userModel.firstname.toString(),
          "lastname": userModel.lastname.toString(),
          "role": userModel.role.toString(),
          "photo": userModel.photo.toString(),
        })
        .then((value) => myEither = const Right("Update User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // update customer
  Future<Either<String, String>> updateCustomer(
    CustomersModel customerModel,
    // String companyID,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(customersCollection)
        .doc(customerModel.customerID.toString())
        .update({
          // "companyID": companyID,
          // "customerID": uniqueID,
          "email": customerModel.email.toString(),
          "fullname": customerModel.fullname.toString(),
          "address": customerModel.address.toString(),
          "gender": customerModel.gender.toString(),
          "phoneNumber": customerModel.phoneNumber.toString(),
          // "point": 0,
        })
        .then(
            (value) => myEither = const Right("Update Customer Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // delete user
  Future<Either<String, String>> deleteUser(
    String documentID,
  ) async {
    late Either<String, String> myEither;
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(documentID)
        .delete()
        .then((value) => myEither = const Right("Delete User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // delete customer
  Future<Either<String, String>> deleteCustomer(
    String documentID,
  ) async {
    late Either<String, String> myEither;
    await FirebaseFirestore.instance
        .collection(customersCollection)
        .doc(documentID)
        .delete()
        .then((value) => myEither = const Right("Delete User Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }
}
