import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/module/blocs/users_bloc/users_bloc.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/custom_widgets.dart';
import '../export.dart';

class WaitingStatusWidget extends StatefulWidget {
  final OrdersModel? orderCustomer;
  final int _widthIcon;

  const WaitingStatusWidget({
    super.key,
    required int widthIcon,
    required this.orderCustomer,
  }) : _widthIcon = widthIcon;

  @override
  State<WaitingStatusWidget> createState() => _WaitingStatusWidgetState();
}

class _WaitingStatusWidgetState extends State<WaitingStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              workProcess,
              cacheWidth: widget._widthIcon,
              color: activeIconColor,
            ),
            ElevatedButton(
              onPressed: () {
                // // change status from waiting --> progress
                BlocProvider.of<UsersBloc>(context)
                    .add(GetAllUsersFromBoxEvent());

                Navigator.pushNamed(context, AppRoutes.userSelected);

                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(defaultBorderRadius),
                //   ),
                //   context: context,
                //   builder: (context) => const BottomSheetUsersWidget(),
                // ).then((value) {
                //   print(">>>> hasil schowmodal :: ${value}");
                // });
              },
              child: const Text("Pilih Staff"),
            ),
          ],
        ),
      ],
    );
  }
}
