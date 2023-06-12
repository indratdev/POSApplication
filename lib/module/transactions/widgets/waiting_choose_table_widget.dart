import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/blocs/users_bloc/users_bloc.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../shared/constants/constants.dart';
import '../../blocs/export_bloc.dart';

class WaitingChooseTableWidget extends StatefulWidget {
  final OrdersModel? orderCustomer;
  final int _widthIcon;

  const WaitingChooseTableWidget({
    super.key,
    required int widthIcon,
    required this.orderCustomer,
  }) : _widthIcon = widthIcon;

  @override
  State<WaitingChooseTableWidget> createState() =>
      _WaitingChooseTableWidgetState();
}

class _WaitingChooseTableWidgetState extends State<WaitingChooseTableWidget> {
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
                // BlocProvider.of<UsersBloc>(context)
                //     .add(GetAllUsersFromBoxEvent());

                // Navigator.pushNamed(context, AppRoutes.userSelected);
                BlocProvider.of<TablesBloc>(context).add(GetAllTablesEvent());

                Navigator.pushNamed(context, AppRoutes.tablesSelected);

                // PersistentNavBarNavigator.pushNewScreen(
                //   context,
                //   screen: TablesSelectedScreen(),
                //   withNavBar: false,
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
              },
              child: const Text("Pilih Meja"),
            ),
          ],
        ),
      ],
    );
  }
}
