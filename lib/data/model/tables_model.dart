import 'package:cloud_firestore/cloud_firestore.dart';

enum TableShape {
  rectangle,
  circle,
  square,
  oval,
  lshape,
  barseat,
  others,
}

class TablesModel {
  String companyID;
  String tableID;
  String tableNo;
  int size;
  String shape;
  String tableName;

  static const defaultShape = "rectangle";

  TablesModel({
    required this.companyID,
    required this.tableID,
    this.tableNo = "",
    this.tableName = "",
    this.size = 0,
    this.shape = defaultShape,
  });

  factory TablesModel.fromJson(Map<String, dynamic> json) => TablesModel(
        companyID: json['companyID'] as String? ?? "",
        tableID: json['tableID'] as String? ?? "",
        tableNo: json['tableNo'] as String? ?? "",
        tableName: json['tableName'] as String? ?? "",
        size: json['size'],
        shape: json['shape'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'companyID': companyID,
        'tableNo': tableNo,
        'tableID': tableID,
        'size': size,
        'tableName': tableName,
        'shape': shape,
      };

  TablesModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : companyID = doc.data()!["companyID"],
        tableNo = doc.data()!["tableNo"],
        tableID = doc.data()!["tableID"],
        size = doc.data()!["size"],
        tableName = doc.data()!["tableName"],
        shape = doc.data()!["shape"];
}
