class ProfileModel {
  String companyID;
  String bussinessName;
  String bussinessType;
  String bussinessCountry;
  String bussinessCurrency;
  String bussinessAddress;
  String bussinessPhone;
  String bussinessPhoto;

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
