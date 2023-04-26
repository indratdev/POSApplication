import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String companyID;
  String categoryID;
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
