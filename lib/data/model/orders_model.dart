import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posapplication/data/model/customers_model.dart';
import 'package:posapplication/data/model/export_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_model.g.dart';

enum StatusOrder {
  open,
  waiting,
  progress,
  done,
  cancel,
}

@JsonSerializable()
class OrdersModel {
  String orderID;
  double totalOrdersPrice;
  int itemCountOrder;
  String status;
  DateTime? dateTimeOrder;
  DateTime? dateTimeWaiting;
  DateTime? dateTimeProccess;
  DateTime? dateTimeFinish;
  String? staffHandleBy;
  String? staffUserID;
  List<ItemsModel>? dataItem;
  TablesModel? dataTable;
  CustomersModel? dataCustomer;

  OrdersModel({
    this.orderID = "",
    this.totalOrdersPrice = 0,
    this.itemCountOrder = 0,
    this.status = "open",
    this.dataItem,
    this.dataTable,
    this.dataCustomer,
    this.dateTimeProccess,
    this.dateTimeFinish,
    this.dateTimeOrder,
    this.dateTimeWaiting,
    this.staffHandleBy,
    this.staffUserID,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  // static DateTime _timestampFromJson(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);

  OrdersModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : totalOrdersPrice = doc.data()!["totalOrdersPrice"],
        orderID = doc.data()!["orderID"],
        // dataItem = doc.data()!["dataItem"],
        // dataTable = doc.data()!["dataTable"],
        // dataCustomer = doc.data()!["dataCustomer"],
        dataItem = (doc.data()!['dataItem'] as List<dynamic>?)
            ?.map((e) => ItemsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        dataTable = TablesModel.fromJson(
            doc.data()!['dataTable'] as Map<String, dynamic>),
        dataCustomer = CustomersModel.fromJson(
            doc.data()!['dataCustomer'] as Map<String, dynamic>),
        itemCountOrder = doc.data()!["itemCountOrder"],
        status = doc.data()!["status"],
        dateTimeOrder = (doc.data()?["dateTimeOrder"] == null)
            ? DateTime.parse("1900-01-01 00:00:00")
            : (doc.data()?["dateTimeOrder"]).toDate(),
        dateTimeWaiting = (doc.data()?["dateTimeWaiting"] == null)
            ? DateTime.parse("1900-01-01 00:00:00")
            : (doc.data()?["dateTimeWaiting"]).toDate(),
        dateTimeProccess = (doc.data()?["dateTimeProccess"] == null)
            ? DateTime.parse("1900-01-01 00:00:00")
            : (doc.data()?["dateTimeProccess"]).toDate(),
        dateTimeFinish = (doc.data()?["dateTimeFinish"] == null)
            ? DateTime.parse("1900-01-01 00:00:00")
            : (doc.data()?["dateTimeFinish"]).toDate(),
        staffHandleBy = doc.data()!["staffHandleBy"],
        staffUserID = doc.data()!["staffUserID"];
}

// class OrdersModel extends ItemsModel {
//   double totalOrdersPrice;
//   String orderID;
//   String tableNo;
//   int itemCountOrder;
//   String status;
//   DateTime? dateTimeOrder;
//   DateTime? dateTimeWaiting;
//   DateTime? dateTimeCooking;
//   DateTime? dateTimeFinish;
//   String? staffHandleBy;
//   String? staffUserID;

//   OrdersModel({
//     this.totalOrdersPrice = 0,
//     required this.orderID,
//     required this.tableNo,
//     this.itemCountOrder = 0,
//     this.status = "open",
//     this.dateTimeOrder,
//     this.dateTimeWaiting,
//     this.dateTimeCooking,
//     this.dateTimeFinish,
//     this.staffHandleBy,
//     this.staffUserID,
//     companyID,
//     categoryID,
//     itemID,
//     itemName,
//     categoryName,
//     itemPhoto,
//     sellBy,
//     sellPrice,
//   }) : super(
//           categoryID: categoryID,
//           companyID: companyID,
//           itemID: itemID,
//           itemName: itemName,
//           itemPhoto: itemPhoto,
//           sellBy: sellBy,
//           sellPrice: sellPrice,
//           categoryName: categoryName,
//         );

//   factory OrdersModel.fromJson(Map<String, dynamic> json) =>
//       OrdersModel(
//         totalOrdersPrice: json['totalOrdersPrice'] as double? ?? 0,
//         orderID: json['orderID'] as String? ?? "",
//         tableNo: json['tableNo'] as String? ?? "",
//         itemCountOrder: json['itemCountOrder'] as int? ?? 0,
//         status: json['status'] as String? ?? "",
//         dateTimeOrder: json['dateTimeOrder'] as DateTime? ?? DateTime.now(),
//         dateTimeWaiting: json['dateTimeWaiting'] as DateTime? ?? DateTime.now(),
//         dateTimeCooking: json['dateTimeCooking'] as DateTime? ?? DateTime.now(),
//         dateTimeFinish: json['dateTimeFinish'] as DateTime? ?? DateTime.now(),
//         staffHandleBy: json['staffHandleBy'] as String? ?? "",
//         staffUserID: json['staffUserID'] as String? ?? "",
//         companyID: json['companyID'] as String? ?? "",
//         categoryID: json['categoryID'] as String? ?? "",
//         categoryName: json['categoryName'] as String? ?? "",
//         itemID: json['itemID'] as String? ?? "",
//         itemName: json['itemName'] as String? ?? "",
//         itemPhoto: json['itemPhoto'] as String? ?? "",
//         sellBy: json['sellBy'] as String? ?? "unit",
//         sellPrice: json['sellPrice'] as double? ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         'totalOrdersPrice': totalOrdersPrice,
//         'orderID': orderID,
//         'tableNo': tableNo,
//         'itemCountOrder': itemCountOrder,
//         'status': status,
//         'dateTimeOrder': dateTimeOrder,
//         'dateTimeWaiting': dateTimeWaiting,
//         'dateTimeCooking': dateTimeCooking,
//         'dateTimeFinish': dateTimeFinish,
//         'staffHandleBy': staffHandleBy,
//         'staffUserID': staffUserID,
//         'companyID': companyID,
//         'categoryID': categoryID,
//         'categoryName': categoryName,
//         'itemID': itemID,
//         'itemName': itemName,
//         'itemPhoto': itemPhoto,
//         'sellBy': sellBy,
//         'sellPrice': sellPrice,
//       };


