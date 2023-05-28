import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'tables_model.g.dart';

enum TableShape {
  rectangle,
  circle,
  square,
  oval,
  lshape,
  barseat,
  others,
}

@HiveType(typeId: 5)
class TablesModel extends HiveObject {
  @HiveField(0)
  String companyID;
  @HiveField(1)
  String tableID;
  @HiveField(2)
  String tableNo;
  @HiveField(3)
  int size;
  @HiveField(4)
  String shape;
  @HiveField(5)
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
