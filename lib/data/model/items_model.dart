import 'package:posapplication/data/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel extends CategoryModel {
  String itemID;
  String itemName;
  String itemPhoto;
  String sellBy;
  double sellPrice;
  // int countOrder;

  ItemsModel({
    required companyID,
    required categoryID,
    categoryName,
    required this.itemID,
    required this.itemName,
    this.sellBy = "unit",
    this.sellPrice = 0,
    this.itemPhoto = "",
    // this.countOrder = 0,
  }) : super(
          categoryID: categoryID,
          companyID: companyID,
          categoryName: categoryName,
        );

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        companyID: json['companyID'] as String? ?? "",
        categoryID: json['categoryID'] as String? ?? "",
        categoryName: json['categoryName'] as String? ?? "",
        itemID: json['itemID'] as String? ?? "",
        itemName: json['itemName'] as String? ?? "",
        itemPhoto: json['itemPhoto'] as String? ?? "",
        sellBy: json['sellBy'] as String? ?? "unit",
        sellPrice: json['sellPrice'] as double? ?? 0,
        // countOrder: json['countOrder'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'companyID': companyID,
        'categoryID': categoryID,
        'categoryName': categoryName,
        'itemID': itemID,
        'itemName': itemName,
        'itemPhoto': itemPhoto,
        'sellBy': sellBy,
        'sellPrice': sellPrice,
        // 'countOrder': countOrder,
      };

  ItemsModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : itemID = doc.data()!["itemID"],
        itemName = doc.data()!["itemName"],
        itemPhoto = doc.data()!["itemPhoto"],
        sellBy = doc.data()!["sellBy"],
        sellPrice = doc.data()!["sellPrice"],
        // countOrder = doc.data()!["countOrder"],
        super(
          categoryID: doc.data()!["categoryID"],
          companyID: doc.data()!["companyID"],
          categoryName: doc.data()!["categoryName"],
        );
}
