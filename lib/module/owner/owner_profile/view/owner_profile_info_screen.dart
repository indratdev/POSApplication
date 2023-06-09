import 'package:flutter/material.dart';

import 'package:posapplication/module/owner/owner_profile/view/widgets/profile_widget.dart';

import '../../../../data/model/profile_model.dart';
import '../../../../shared/widgets/custom_widgets.dart';
import '../../../blocs/export_bloc.dart';

class OwnerProfileInfoScreen extends StatefulWidget {
  const OwnerProfileInfoScreen({super.key});

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
          return const SizedBox();
        },
      ),
    );
  }
}
