import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posapplication/data/model/export_model.dart';

enum StatusOrder {
  open,
  waiting,
  progress,
  done,
  cancel,
}

class OrdersModel extends ItemsModel {
  double totalOrdersPrice;
  String orderID;
  String tableNo;
  int itemCountOrder;
  String status;
  DateTime? dateTimeOrder;
  DateTime? dateTimeWaiting;
  DateTime? dateTimeCooking;
  DateTime? dateTimeFinish;
  String? staffHandleBy;
  String? staffUserID;

  OrdersModel({
    this.totalOrdersPrice = 0,
    required this.orderID,
    required this.tableNo,
    this.itemCountOrder = 0,
    this.status = "open",
    this.dateTimeOrder,
    this.dateTimeWaiting,
    this.dateTimeCooking,
    this.dateTimeFinish,
    this.staffHandleBy,
    this.staffUserID,
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

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      OrdersModel(
        totalOrdersPrice: json['totalOrdersPrice'] as double? ?? 0,
        orderID: json['orderID'] as String? ?? "",
        tableNo: json['tableNo'] as String? ?? "",
        itemCountOrder: json['itemCountOrder'] as int? ?? 0,
        status: json['status'] as String? ?? "",
        dateTimeOrder: json['dateTimeOrder'] as DateTime? ?? DateTime.now(),
        dateTimeWaiting: json['dateTimeWaiting'] as DateTime? ?? DateTime.now(),
        dateTimeCooking: json['dateTimeCooking'] as DateTime? ?? DateTime.now(),
        dateTimeFinish: json['dateTimeFinish'] as DateTime? ?? DateTime.now(),
        staffHandleBy: json['staffHandleBy'] as String? ?? "",
        staffUserID: json['staffUserID'] as String? ?? "",
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
        'orderID': orderID,
        'tableNo': tableNo,
        'itemCountOrder': itemCountOrder,
        'status': status,
        'dateTimeOrder': dateTimeOrder,
        'dateTimeWaiting': dateTimeWaiting,
        'dateTimeCooking': dateTimeCooking,
        'dateTimeFinish': dateTimeFinish,
        'staffHandleBy': staffHandleBy,
        'staffUserID': staffUserID,
        'companyID': companyID,
        'categoryID': categoryID,
        'categoryName': categoryName,
        'itemID': itemID,
        'itemName': itemName,
        'itemPhoto': itemPhoto,
        'sellBy': sellBy,
        'sellPrice': sellPrice,
      };

  OrdersModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : totalOrdersPrice = doc.data()!["totalOrdersPrice"],
        orderID = doc.data()!["orderID"],
        tableNo = doc.data()!["tableNo"],
        itemCountOrder = doc.data()!["itemCountOrder"],
        status = doc.data()!["status"],
        dateTimeOrder = doc.data()!["dateTimeOrder"],
        dateTimeWaiting = doc.data()!["dateTimeWaiting"],
        dateTimeCooking = doc.data()!["dateTimeCooking"],
        dateTimeFinish = doc.data()!["dateTimeFinish"],
        staffHandleBy = doc.data()!["staffHandleBy"],
        staffUserID = doc.data()!["staffUserID"],
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
