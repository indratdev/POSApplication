import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/data/model/category_model.dart';
import 'package:posapplication/data/model/tables_model.dart';
import 'package:posapplication/data/model/users_model.dart';

part 'ops_daily_model.g.dart';

@HiveType(typeId: 3)
class OpsDailyModel extends HiveObject {
  @HiveField(0)
  String? initDate;

  @HiveField(1)
  List<UsersModel>? userList;

  @HiveField(2)
  List<CategoryModel>? categoryList;

  @HiveField(3)
  List<TablesModel>? tableList;

  OpsDailyModel({
    this.initDate,
    this.userList,
    this.categoryList,
    this.tableList,
  });

  factory OpsDailyModel.fromJson(Map<String, dynamic> json) => OpsDailyModel(
        initDate: json['initDate'] as String? ?? "",
        userList: (json['userList'] as List<dynamic>?)
            ?.map((e) => UsersModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        categoryList: (json['categoryList'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        tableList: (json['tableList'] as List<dynamic>?)
            ?.map((e) => TablesModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'initDate': initDate,
        'userList': userList,
        'categoryList': categoryList,
        'tableList': tableList,
      };

  OpsDailyModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : initDate = doc.data()!["initDate"],
        userList = (doc.data()!['userList'] as List<dynamic>?)
            ?.map((e) => UsersModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        categoryList = (doc.data()!['categoryList'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        tableList = (doc.data()!['tableList'] as List<dynamic>?)
            ?.map((e) => TablesModel.fromJson(e as Map<String, dynamic>))
            .toList();
}
