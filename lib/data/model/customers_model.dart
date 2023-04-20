import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersModel {
  String? customerID;
  String? companyID;

  String? email;
  String? fullname;
  String? address;
  String? gender;
  String? phoneNumber;
  int point;

  CustomersModel({
    this.address,
    this.companyID,
    this.customerID,
    this.email,
    this.fullname,
    this.gender,
    this.phoneNumber,
    this.point = 0,
  });

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
        customerID: json['customerID'] as String? ?? "",
        companyID: json['companyID'] as String? ?? "",
        email: json['email'] as String? ?? "",
        address: json['address'] as String? ?? "",
        fullname: json['fullname'] as String? ?? "",
        gender: json['gender'] as String? ?? "",
        phoneNumber: json['phoneNumber'] as String? ?? "",
        point: json['point'] as int,
      );

  Map<String, dynamic> toJson() => {
        'customerID': customerID,
        'companyID': companyID,
        'email': email,
        'address': address,
        'fullname': fullname,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'point': point,
      };

  CustomersModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : customerID = doc.id,
        companyID = doc.data()!["companyID"],
        email = doc.data()!["email"],
        address = doc.data()!["address"],
        fullname = doc.data()!["fullname"],
        gender = doc.data()!["gender"],
        phoneNumber = doc.data()!["phoneNumber"],
        point = doc.data()!["point"];
}
