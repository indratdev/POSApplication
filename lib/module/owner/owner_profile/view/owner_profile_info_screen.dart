import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
// import 'package:posapplication/module/owner/owner_profile/controller/profile_controller.dart';
import 'package:posapplication/module/owner/owner_profile/view/widgets/profile_widget.dart';

import '../../../../data/model/profile_model.dart';
import '../../../../shared/widgets/custom_widgets.dart';

class OwnerProfileInfoScreen extends StatefulWidget {
  OwnerProfileInfoScreen({super.key});

  @override
  State<OwnerProfileInfoScreen> createState() => _OwnerProfileInfoScreenState();
}

class _OwnerProfileInfoScreenState extends State<OwnerProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OwnerBloc, OwnerState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadingOpenBoxProfileCompany) {
            return CustomWidgets.showLoadingWidget();
          }
          if (state is FailureOpenBoxProfileCompany) {
            return Center(
              child: Text(state.messageError.toString()),
            );
          }
          if (state is SuccessOpenBoxProfileCompany) {
            var datas = state.dataBox;

            if (datas.isEmpty) {
              return ProfileWidget(
                isUpdate: false,
              );
            }
            if (datas.isNotEmpty) {
              ProfileModel profile = datas.values.first;
              return ProfileWidget(
                isUpdate: true,
                profileModel: profile,
              );
            }
          }
          return SizedBox();
        },
      ),
    );
  }
}
