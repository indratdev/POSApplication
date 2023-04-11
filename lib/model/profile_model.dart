import 'dart:convert';

import 'package:hive/hive.dart';
part 'profile_model.g.dart';

ProfileModel userModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String userModelToJson(ProfileModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class ProfileModel extends HiveObject {
  @HiveField(0)
  String? companyID;
  @HiveField(1)
  String? bussinessName;
  @HiveField(2)
  String? bussinessType;
  @HiveField(3)
  String? bussinessCountry;
  @HiveField(4)
  String? bussinessCurrency;
  @HiveField(5)
  String? bussinessAddress;
  @HiveField(6)
  String? bussinessPhone;
  @HiveField(7)
  String? bussinessPhoto;

  ProfileModel({
    this.companyID = "",
    required this.bussinessName,
    this.bussinessType = "",
    this.bussinessCurrency = "",
    this.bussinessCountry = "",
    this.bussinessAddress = "",
    this.bussinessPhone = "",
    this.bussinessPhoto = "",
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        companyID: json['companyID'] as String? ?? "",
        bussinessName: json['bussinessName'] as String? ?? "",
        bussinessAddress: json['bussinessAddress'] as String? ?? "",
        bussinessCountry: json['bussinessCountry'] as String? ?? "",
        bussinessCurrency: json['bussinessCurrency'] as String? ?? "",
        bussinessPhone: json['bussinessPhone'] as String? ?? "",
        bussinessType: json['bussinessType'] as String? ?? "",
        bussinessPhoto: json['bussinessPhoto'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'companyID': companyID,
        'bussinessName': bussinessName,
        'bussinessAddress': bussinessAddress,
        'bussinessCountry': bussinessCountry,
        'bussinessCurrency': bussinessCurrency,
        'bussinessPhone': bussinessPhone,
        'bussinessType': bussinessType,
        'bussinessPhoto': bussinessPhoto,
      };
}
