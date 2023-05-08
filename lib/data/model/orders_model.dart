import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posapplication/data/model/export_model.dart';

class OrdersModel extends ItemsModel {
  double totalOrdersPrice;

  OrdersModel({
    this.totalOrdersPrice = 0,
    companyID,
    categoryID,
    itemID,
    itemName,
    categoryName,
    itemPhoto,
    sellBy,
    sellPrice,
  }) : super(
          categoryID: categoryID,
          companyID: companyID,
          itemID: itemID,
          itemName: itemName,
          itemPhoto: itemPhoto,
          sellBy: sellBy,
          sellPrice: sellPrice,
          categoryName: categoryName,
        );

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        totalOrdersPrice: json['totalOrdersPrice'] as double? ?? 0,
        companyID: json['companyID'] as String? ?? "",
        categoryID: json['categoryID'] as String? ?? "",
        categoryName: json['categoryName'] as String? ?? "",
        itemID: json['itemID'] as String? ?? "",
        itemName: json['itemName'] as String? ?? "",
        itemPhoto: json['itemPhoto'] as String? ?? "",
        sellBy: json['sellBy'] as String? ?? "unit",
        sellPrice: json['sellPrice'] as double? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'totalOrdersPrice': totalOrdersPrice,
        'companyID': companyID,
        'categoryID': categoryID,
        'categoryName': categoryName,
        'itemID': itemID,
        'itemName': itemName,
        'itemPhoto': itemPhoto,
        'sellBy': sellBy,
        'sellPrice': sellPrice,
      };

  OrdersModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : totalOrdersPrice = doc.data()!["totalOrdersPrice"],
        super(
          categoryID: doc.data()!["categoryID"],
          companyID: doc.data()!["companyID"],
          categoryName: doc.data()!["categoryName"],
          itemID: doc.data()!["itemID"],
          itemName: doc.data()!["itemName"],
          itemPhoto: doc.data()!["itemPhoto"],
          sellBy: doc.data()!["sellBy"],
          sellPrice: doc.data()!["sellPrice"],
        );
}
