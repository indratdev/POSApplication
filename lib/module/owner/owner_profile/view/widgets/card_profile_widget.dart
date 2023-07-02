import 'package:flutter/material.dart';
import 'package:posapplication/module/owner/owner_profile/view/widgets/profile_widget.dart';

import '../../../../../data/model/profile_model.dart';
import '../../../../../shared/constants/constants.dart';

class CardProfileWidget extends StatelessWidget {
  final bool isUpdate;
  ProfileModel? profileModel = ProfileModel(bussinessName: "unknown");
  final String titleText;
  final ProfileType profileType;

  CardProfileWidget({
    super.key,
    required this.isUpdate,
    required this.titleText,
    required this.profileType,
    required this.profileModel,
  });

  String valueProfileType(ProfileType profileType) {
    String value = "";
    if (profileType.name == ProfileType.companyTypeProfile.name) {
      value = profileModel?.bussinessType.toString() ?? "";
    }

    if (profileType.name == ProfileType.countryProfile.name) {
      value = profileModel?.bussinessCountry.toString() ?? "";
    }

    if (profileType.name == ProfileType.currencyProfile.name) {
      value = profileModel?.bussinessCurrency.toString() ?? "";
    }

    if (profileType.name == ProfileType.addressProfile.name) {
      value = profileModel?.bussinessAddress.toString() ?? "";
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mainWhite,
      elevation: 3,
      shadowColor: mainGreen,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 0.8,
          color: secondGreen,
        ),
        borderRadius: BorderRadius.circular(18), //<-- SEE HERE
      ),
      child: ListTile(
        title: Text(titleText),
        subtitle: Text(
          (isUpdate) ? valueProfileType(profileType) : "-",
        ),
        // trailing: const Icon(FontAwesomeIcons.chevronRight),
      ),
    );
  }
}
