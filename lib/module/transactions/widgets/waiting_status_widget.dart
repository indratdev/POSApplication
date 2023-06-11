import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/blocs/users_bloc/users_bloc.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../shared/constants/constants.dart';

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
              },
              child: const Text("Pilih Staff"),
            ),
          ],
        ),
      ],
    );
  }
}
