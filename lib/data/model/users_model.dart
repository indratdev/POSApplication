import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:hive/hive.dart';
part 'users_model.g.dart';

UsersModel userModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String userModelToJson(UsersModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class UsersModel extends HiveObject {
  @HiveField(0)
  String? documentID;
  @HiveField(1)
  String? companyID;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? firstname;
  @HiveField(4)
  String? lastname;
  @HiveField(5)
  String? photo;
  @HiveField(6)
  String? role;
  @HiveField(7)
  String? userID;

  UsersModel({
    this.documentID,
    this.companyID,
    this.email,
    this.firstname,
    this.lastname,
    this.photo,
    this.role,
    this.userID,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        documentID: json['documentID'] as String? ?? "",
        companyID: json['companyID'] as String? ?? "",
        email: json['email'] as String? ?? "",
        userID: json['userID'] as String? ?? "",
        firstname: json['firstname'] as String? ?? "",
        lastname: json['lastname'] as String? ?? "",
        photo: json['photo'] as String? ?? "",
        role: json['role'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'documentID': documentID,
        'companyID': companyID,
        'email': email,
        'userID': userID,
        'firstname': firstname,
        'lastname': lastname,
        'photo': photo,
        'role': role,
      };

  UsersModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : documentID = doc.id,
        companyID = doc.data()!["companyID"],
        email = doc.data()!["email"],
        userID = doc.data()!["userID"],
        firstname = doc.data()!["firstname"],
        lastname = doc.data()!["lastname"],
        photo = doc.data()!["photo"],
        role = doc.data()!["role"];
}
