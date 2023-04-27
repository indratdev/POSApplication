import 'package:dartz/dartz.dart';

import '../data/model/items_model.dart';
import '../data/service/hive_service/hive_service.dart';
import '../data/service/user_service/user_service.dart';

class ItemsRepository {
  final UserService userService = UserService();
  final HiveService hiveService = HiveService();

  // READ
  // read list category from firebase
  Future<List<ItemsModel>> readAllItems(String companyID) async {
    List<ItemsModel> result = await userService.readAllItems(companyID);
    return result;
  }

//   // read list customers from firebase
//   Future<List<CustomersModel>> readAllCustomers() async {
//     String companyID = await readCompanyID();
//     List<CustomersModel> result = await userService.readAllCustomers(companyID);
//     return result;
//   }
//   // END READ

  // --------- CREATE
  // category
  // Future<Either<String, String>> createNewCategory(
  //     CategoryModel categoryModel, String companyID, String categoryID) async {
  //   return await userService.saveNewCategory(
  //       categoryModel, companyID, categoryID);
  // }

//   // customer
//   Future<Either<String, String>> createNewCustomer(
//       CustomersModel customerModel, String companyID, String uniqueID) async {
//     return await userService.saveNewCustomer(
//         customerModel, companyID, uniqueID);
//   }

//   // END CREATE

  // -------------- UPDATE
  // Future<Either<String, String>> updateCategory(
  //     CategoryModel categoryModel) async {
  //   return await userService.updateCategory(categoryModel);
  // }

//   // update customer
//   Future<Either<String, String>> updateCustomer(
//       CustomersModel customerModel) async {
//     return await userService.updateCustomer(customerModel);
//   }
//   // --------------  END UPDATE

  // DELETE
  // Future<Either<String, String>> deleteCategory(String documentID) async {
  //   return await userService.deleteCategory(documentID);
  // }

//   Future<Either<String, String>> deleteCustomer(String customerID) async {
//     return await userService.deleteCustomer(customerID);
//   }
//   // END DELETE
}
