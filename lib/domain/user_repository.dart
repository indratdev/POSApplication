import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posapplication/data/model/customers_model.dart';

import '../data/model/users_model.dart';
import '../data/service/hive_service/hive_service.dart';
import '../data/service/user_service/user_service.dart';

class UserRepository {
  final UserService userService = UserService();
  final HiveService hiveService = HiveService();

  // READ
  // read company ID from Box/Hive
  Future<String> readCompanyID() async {
    return await hiveService.readProfileCompanyIDFromBox();
  }

  // read list users from firebase
  Future<List<UsersModel>> readAllUser() async {
    String companyID = await readCompanyID();
    List<UsersModel> result = await userService.readAllUser(companyID);
    return result;
  }

  // read list customers from firebase
  Future<List<CustomersModel>> readAllCustomers() async {
    String companyID = await readCompanyID();
    List<CustomersModel> result = await userService.readAllCustomers(companyID);
    return result;
  }
  // END READ

  // --------- CREATE
  // user
  Future<Either<String, String>> createNewUser(
      User newUser, UsersModel userModel, String companyID) async {
    return await userService.saveNewUser(newUser, userModel, companyID);
  }

  // customer
  Future<Either<String, String>> createNewCustomer(
      CustomersModel customerModel, String companyID, String uniqueID) async {
    return await userService.saveNewCustomer(
        customerModel, companyID, uniqueID);
  }
  // END CREATE

  // -------------- UPDATE
  Future<Either<String, String>> updateUser(UsersModel userModel) async {
    return await userService.updateUser(userModel);
  }

  // update customer
  Future<Either<String, String>> updateCustomer(
      CustomersModel customerModel) async {
    return await userService.updateCustomer(customerModel);
  }
  // --------------  END UPDATE

  // DELETE
  Future<Either<String, String>> deleteUser(String documentID) async {
    return await userService.deleteUser(documentID);
  }

  Future<Either<String, String>> deleteCustomer(String customerID) async {
    return await userService.deleteCustomer(customerID);
  }
  // END DELETE
}
