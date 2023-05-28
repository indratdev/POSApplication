import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 4)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String companyID;
  @HiveField(1)
  String categoryID;
  @HiveField(2)
  String categoryName;

  CategoryModel({
    required this.companyID,
    required this.categoryID,
    this.categoryName = "",
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        companyID: json['companyID'] as String? ?? "",
        categoryID: json['categoryID'] as String? ?? "",
        categoryName: json['categoryName'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'companyID': companyID,
        'categoryID': categoryID,
        'categoryName': categoryName,
      };

  CategoryModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : companyID = doc.data()!["companyID"],
        categoryID = doc.data()!["categoryID"],
        categoryName = doc.data()!["categoryName"];
}
