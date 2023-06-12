import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/shared/utils/shared_preferences/myshared_preferences.dart';

import '../../model/items_model.dart';

class OrderService {
  final MySharedPreferences mySharedP = MySharedPreferences();
  static const String userCollection = "users";
  static const String listUserCollection = "list_user";
  static const String customersCollection = "customers";
  static const String tablesCollection = "tables";
  static const String categoryCollection = "categories";
  static const String itemsCollection = "items";
  static const String ordersCollection = "orders";

  // getCompanyID(RoleUsers roleUsers) async {
  //   String companyID = "";
  //   if (roleUsers.name == RoleUsers.owner.name) {
  //     companyID = await mySharedP.getCompanyID();
  //   } else {
  //     companyID = FirebaseAuth.instance.currentUser!.uid.toString();
  //   }
  //   return companyID;
  // }

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

  // // read detail user
  // Future<Map<String, dynamic>> readDataUser() async {
  //   DocumentSnapshot<Map<String, dynamic>> detailUser = await FirebaseFirestore
  //       .instance
  //       .collection(userCollection)
  //       .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //       .get();

  //   print(">>> detail: ${detailUser.data()!["role"]}");

  //   return detailUser.data() ?? {};
  // }

  // // read all user
  // Future<List<UsersModel>> readAllUser(String companyID) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection(userCollection)
  //       .where('companyID', isEqualTo: companyID)
  //       .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
  //       .get();

  //   var data = querySnapshot.docs
  //       .map((e) => UsersModel.fromDocumentSnapshot(e))
  //       .toList();
  //   return data;
  // }

  // // read all customers
  // Future<List<CustomersModel>> readAllCustomers(String companyID) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await FirebaseFirestore.instance
  //           .collection(customersCollection)
  //           .where('companyID', isEqualTo: companyID)
  //           // .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
  //           .get();

  //   var data = querySnapshot.docs
  //       .map((e) => CustomersModel.fromDocumentSnapshot(e))
  //       .toList();
  //   return data;
  // }

  // // read all table
  // Future<List<TablesModel>> readAllTables(String companyID) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await FirebaseFirestore.instance
  //           .collection(tablesCollection)
  //           .where('companyID', isEqualTo: companyID)
  //           // .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
  //           .get();

  //   var data = querySnapshot.docs
  //       .map((e) => TablesModel.fromDocumentSnapshot(e))
  //       .toList();
  //   return data;
  // }

  // // read all category
  // Future<List<CategoryModel>> readAllCategory(String companyID) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection(categoryCollection)
  //       .where('companyID', isEqualTo: companyID)
  //       .get();

  //   var data = querySnapshot.docs
  //       .map((e) => CategoryModel.fromDocumentSnapshot(e))
  //       .toList();
  //   return data;
  // }

  // // read all items
  // Future<List<ItemsModel>> readAllItems(String companyID) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection(itemsCollection)
  //       .where('companyID', isEqualTo: companyID)
  //       .get();

  //   var data = querySnapshot.docs
  //       .map((e) => ItemsModel.fromDocumentSnapshot(e))
  //       .toList();
  //   return data;
  // }

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

  // Future<Either<String, String>> saveUserData(
  //   RoleUsers roleUsers,
  //   // bool isOwner,
  // ) async {
  //   late Either<String, String> myEither;
  //   // String companyID = (roleUsers.name == RoleUsers.owner.name)
  //   //     ? await mySharedP.getCompanyID()
  //   // : FirebaseAuth.instance.currentUser!.uid.toString();
  //   String companyID = await mySharedP.getCompanyID();

  //   await FirebaseFirestore.instance
  //       .collection(userCollection)
  //       // .doc(companyID)
  //       // .collection(listUserCollection)
  //       .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //       .set({
  //         "companyID": companyID,
  //         "userID": FirebaseAuth.instance.currentUser!.uid.toString(),
  //         "email": FirebaseAuth.instance.currentUser!.email.toString(),
  //         "firstname": "",
  //         "lastname": "",
  //         "role": roleUsers.name.toString(),
  //         "photo": "",
  //       })
  //       .then((value) => myEither = const Right("Save User Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   // if (roleUsers.name == RoleUsers.owner.name) {
  //   //   mySharedP
  //   //       .saveCompanyID(FirebaseAuth.instance.currentUser!.uid.toString());
  //   // }

  //   return myEither;
  // }

  // Future<Either<String, String>> saveNewUser(
  //   User newUser,
  //   UsersModel userModel,
  //   String companyID,
  // ) async {
  //   late Either<String, String> myEither;

  //   // String companyID = await mySharedP.getCompanyID();

  //   await FirebaseFirestore.instance
  //       .collection(userCollection)
  //       // .doc(companyID)
  //       // .collection(listUserCollection)
  //       .doc(newUser.uid.toString())
  //       .set({
  //         "companyID": companyID,
  //         "userID": newUser.uid.toString(),
  //         "email": newUser.email.toString(),
  //         "firstname": userModel.firstname.toString(),
  //         "lastname": userModel.lastname.toString(),
  //         "role": userModel.role.toString(),
  //         "photo": userModel.photo.toString(),
  //       })
  //       .then((value) => myEither = const Right("Save User Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // save new table
  // Future<Either<String, String>> saveNewTable(
  //   TablesModel tableModel,
  //   String companyID,
  //   String tableID,
  // ) async {
  //   late Either<String, String> myEither;

  //   await FirebaseFirestore.instance
  //       .collection(tablesCollection)
  //       .doc(tableID)
  //       .set({
  //         "companyID": companyID,
  //         "tableID": tableID,
  //         "tableNo": tableModel.tableNo.toString(),
  //         "size": tableModel.size,
  //         "shape": tableModel.shape.toString(),
  //         "tableName": tableModel.tableName.toString(),
  //       })
  //       .then((value) => myEither = const Right("Save Table Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // save new item
  Future<Either<String, String>> createNewOrder(
    List<OrdersModel> orderData,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(ordersCollection)
        .doc(orderData.first.orderID)
        .set({
          "companyID": orderData.first.dataItem!.first.companyID,
          "orderID": orderData.first.orderID,
          "dataCustomer": orderData.first.dataCustomer!.toJson(),
          "listDataItem": orderData.map((e) => e.dataItem!.first.toJson()),
          "dataTable": orderData.first.dataTable!.toJson(),
          "dateTimeReady": orderData.first.dateTimeReady,
          "dateTimeProccess": orderData.first.dateTimeProccess,
          "dateTimeOrder": orderData.first.dateTimeOrder,
          "dateTimeWaiting": orderData.first.dateTimeWaiting,
          "itemCountOrder": orderData.first.itemCountOrder,
          "userHandleBy": orderData.first.userHandleBy,
          "userHandleID": orderData.first.userHandleID,
          "addBy": orderData.first.addBy,
          "addByID": orderData.first.addByID,
          "status": orderData.first.status,
          "totalOrdersPrice": orderData.first.totalOrdersPrice,
        })
        .then(
            (value) => myEither = const Right("Create New Order Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // update items
  Future<Either<String, String>> updateItems(
    ItemsModel itemModel,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(itemsCollection)
        .doc(itemModel.itemID)
        .update({
          "companyID": itemModel.companyID,
          "categoryID": itemModel.categoryID,
          "categoryName": itemModel.categoryName.toString(),
          "itemID": itemModel.itemID,
          "itemName": itemModel.itemName,
          "itemPhoto": itemModel.itemPhoto,
          "sellBy": itemModel.sellBy,
          "sellPrice": itemModel.sellPrice,
        })
        .then((value) => myEither = const Right("Update Items Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // update status orders
  Future<Either<String, String>> updateStatusOrder(
    String status,
    OrdersModel orderModel,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(ordersCollection)
        .doc(orderModel.orderID)
        .update({
          "status": status,
          "dataTable": orderModel.dataTable,
          "dateTimeOrder": orderModel.dateTimeOrder,
          "dateTimeWaiting": orderModel.dateTimeWaiting,
          "dateTimeProccess": orderModel.dateTimeProccess,
          "dateTimeReady": orderModel.dateTimeReady,
          "dateTimeOrderComplete": orderModel.dateTimeOrderComplete,
          "dateTimeBillIsReady": orderModel.dateTimeBillIsReady,
          "dateTimePaymentComplete": orderModel.dateTimePaymentComplete,
          "dateTimeCancel": orderModel.dateTimeCancel,
          "userHandleBy": orderModel.userHandleBy,
          "userHandleID": orderModel.userHandleID,
          "userSenderBy": orderModel.userSenderBy,
          "userSenderID": orderModel.userSenderID,
          "userPaymentBy": orderModel.userPaymentBy,
          "userPaymentID": orderModel.userPaymentID,

          // "dateTimeWaiting": orderModel.dateTimeWaiting,
        })
        .then((value) =>
            myEither = const Right("Update Status Order Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // delete items
  Future<Either<String, String>> deleteItems(
    String itemID,
  ) async {
    late Either<String, String> myEither;
    await FirebaseFirestore.instance
        .collection(itemsCollection)
        .doc(itemID)
        .delete()
        .then((value) => myEither = const Right("Delete Items Successfully!"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // String? documentID;
  // String? companyID;

  // // add new customer
  // Future<Either<String, String>> saveNewCustomer(
  //   // User newUser,
  //   CustomersModel customerModel,
  //   String companyID,
  //   String uniqueID,
  // ) async {
  //   late Either<String, String> myEither;

  //   await FirebaseFirestore.instance
  //       .collection(customersCollection)
  //       .doc(uniqueID)
  //       .set({
  //         "companyID": companyID,
  //         "customerID": uniqueID,
  //         "email": customerModel.email.toString(),
  //         "fullname": customerModel.fullname.toString(),
  //         "address": customerModel.address.toString(),
  //         "gender": customerModel.gender.toString(),
  //         "phoneNumber": customerModel.phoneNumber.toString(),
  //         "point": 0,
  //       })
  //       .then((value) => myEither = const Right("Save Customers Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // update user
  // Future<Either<String, String>> updateUser(
  //   // User newUser,
  //   UsersModel userModel,
  //   // String companyID,
  // ) async {
  //   late Either<String, String> myEither;

  //   // String companyID = await mySharedP.getCompanyID();

  //   await FirebaseFirestore.instance
  //       .collection(userCollection)
  //       // .doc(companyID)
  //       // .collection(listUserCollection)
  //       .doc(userModel.documentID.toString())
  //       .update({
  //         "companyID": userModel.companyID.toString(),
  //         "userID": userModel.userID.toString(),
  //         "email": userModel.email.toString(),
  //         "firstname": userModel.firstname.toString(),
  //         "lastname": userModel.lastname.toString(),
  //         "role": userModel.role.toString(),
  //         "photo": userModel.photo.toString(),
  //       })
  //       .then((value) => myEither = const Right("Update User Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // update customer
  // Future<Either<String, String>> updateCustomer(
  //   CustomersModel customerModel,
  //   // String companyID,
  // ) async {
  //   late Either<String, String> myEither;

  //   await FirebaseFirestore.instance
  //       .collection(customersCollection)
  //       .doc(customerModel.customerID.toString())
  //       .update({
  //         // "companyID": companyID,
  //         // "customerID": uniqueID,
  //         "email": customerModel.email.toString(),
  //         "fullname": customerModel.fullname.toString(),
  //         "address": customerModel.address.toString(),
  //         "gender": customerModel.gender.toString(),
  //         "phoneNumber": customerModel.phoneNumber.toString(),
  //         // "point": 0,
  //       })
  //       .then(
  //           (value) => myEither = const Right("Update Customer Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // update table
  // Future<Either<String, String>> updateTable(
  //   // User newUser,
  //   TablesModel tableModel,
  //   // String companyID,
  // ) async {
  //   late Either<String, String> myEither;

  //   // String companyID = await mySharedP.getCompanyID();

  //   await FirebaseFirestore.instance
  //       .collection(tablesCollection)
  //       // .doc(companyID)
  //       // .collection(listUserCollection)
  //       .doc(tableModel.tableID)
  //       .update({
  //         // "companyID": userModel.companyID.toString(),
  //         // "userID": userModel.userID.toString(),
  //         // "email": userModel.email.toString(),
  //         // "firstname": userModel.firstname.toString(),
  //         // "lastname": userModel.lastname.toString(),
  //         // "role": userModel.role.toString(),
  //         // "photo": userModel.photo.toString(),
  //         "companyID": tableModel.companyID.toString(),
  //         "tableID": tableModel.tableID.toString(),
  //         "tableNo": tableModel.tableNo.toString(),
  //         "size": tableModel.size,
  //         "shape": tableModel.shape.toString(),
  //         "tableName": tableModel.tableName.toString(),
  //       })
  //       .then((value) => myEither = const Right("Update Table Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // delete user
  // Future<Either<String, String>> deleteUser(
  //   String documentID,
  // ) async {
  //   late Either<String, String> myEither;
  //   await FirebaseFirestore.instance
  //       .collection(userCollection)
  //       .doc(documentID)
  //       .delete()
  //       .then((value) => myEither = const Right("Delete User Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // delete customer
  // Future<Either<String, String>> deleteCustomer(
  //   String documentID,
  // ) async {
  //   late Either<String, String> myEither;
  //   await FirebaseFirestore.instance
  //       .collection(customersCollection)
  //       .doc(documentID)
  //       .delete()
  //       .then((value) => myEither = const Right("Delete User Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }

  // // delete user
  // Future<Either<String, String>> deleteTable(
  //   String documentID,
  // ) async {
  //   late Either<String, String> myEither;
  //   await FirebaseFirestore.instance
  //       .collection(tablesCollection)
  //       .doc(documentID)
  //       .delete()
  //       .then((value) => myEither = const Right("Delete Table Successfully!"))
  //       .catchError((e) => myEither = Left(e.toString()));

  //   return myEither;
  // }
}
