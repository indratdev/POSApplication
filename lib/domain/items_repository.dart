import 'package:dartz/dartz.dart';
import 'package:posapplication/data/service/user_service/user_service.dart';

import '../data/model/category_model.dart';
import '../data/model/items_model.dart';
import '../data/service/hive_service/hive_service.dart';
import '../data/service/item_service/item_service.dart';

class ItemsRepository {
  final UserService userService = UserService();
  final ItemsService itemsService = ItemsService();
  final HiveService hiveService = HiveService();

  // READ
  // read list items from firebase
  Future<List<ItemsModel>> readAllItems(String companyID) async {
    List<ItemsModel> result = await userService.readAllItems(companyID);
    return result;
  }

  Future<List<ItemsModel>> readItemsByCategoryID(
      String companyID, String categoryID) async {
    List<ItemsModel> result =
        await userService.readItemsByCategoryID(companyID, categoryID);
    return result;
  }

  // read all category
  Future<List<CategoryModel>> readAllCategory(String companyID) async {
    List<CategoryModel> result = await userService.readAllCategory(companyID);
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
  // item
  Future<Either<String, String>> createNewItem(ItemsModel itemModel) async {
    return await itemsService.saveNewItem(itemModel);
  }

//   // customer
//   Future<Either<String, String>> createNewCustomer(
//       CustomersModel customerModel, String companyID, String uniqueID) async {
//     return await userService.saveNewCustomer(
//         customerModel, companyID, uniqueID);
//   }

//   // END CREATE

  // -------------- UPDATE
  Future<Either<String, String>> updateItems(ItemsModel itemsModel) async {
    return await itemsService.updateItems(itemsModel);
  }

//   // update customer
//   Future<Either<String, String>> updateCustomer(
//       CustomersModel customerModel) async {
//     return await userService.updateCustomer(customerModel);
//   }
//   // --------------  END UPDATE

  // DELETE
  Future<Either<String, String>> deleteItems(String itemID) async {
    return await itemsService.deleteItems(itemID);
  }

//   Future<Either<String, String>> deleteCustomer(String customerID) async {
//     return await userService.deleteCustomer(customerID);
//   }
//   // END DELETE
}
