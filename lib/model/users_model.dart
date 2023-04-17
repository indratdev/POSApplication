import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String documentID;
  String companyID;
  String email;
  String? firstname;
  String? lastname;
  String? photo;
  String? role;
  String userID;

  UsersModel({
    required this.documentID,
    required this.companyID,
    required this.email,
    this.firstname,
    this.lastname,
    this.photo,
    this.role,
    required this.userID,
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
