import 'package:flutter/material.dart';
import 'package:posapplication/module/transactions/widgets/waiting_choose_table_widget.dart';
import 'package:posapplication/module/transactions/widgets/waiting_status_widget.dart';

import '../../../data/model/orders_model.dart';
import '../export.dart';

class StatusTransactionWidgets extends StatelessWidget {
  final OrdersModel? orderCustomer;
  final Map<String, dynamic> statusMap;
  final double _width;
  // final List<UsersModel>? usersList;

  const StatusTransactionWidgets({
    super.key,
    required this.statusMap,
    required double width,
    required this.orderCustomer,
  }) : _width = width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int widthIcon = width ~/ 5;

    return Column(
      children: [
        // Waiting, Haven't chosen a table number yet  & Haven't chosen a user maker yet
        if (orderCustomer?.status == StatusOrder.waiting.name &&
            orderCustomer?.dataTable?.tableID == "" &&
            orderCustomer?.userHandleBy == "") ...[
          WaitingChooseTableWidget(
            widthIcon: widthIcon,
            orderCustomer: orderCustomer,
          )
        ],
        // Waiting & user maker has chosen,  Haven't chosen a table number yet
        if (orderCustomer?.status == StatusOrder.waiting.name &&
            orderCustomer?.dataTable?.tableID == "" &&
            orderCustomer?.userHandleBy != "") ...[
          WaitingChooseTableWidget(
            widthIcon: widthIcon,
            orderCustomer: orderCustomer,
          )
        ],

        // waiting & table has chosen, Haven't user maker yet
        if (orderCustomer?.status == StatusOrder.waiting.name &&
            orderCustomer?.dataTable?.tableID != "" &&
            orderCustomer?.userHandleBy == "") ...[
          WaitingStatusWidget(
            widthIcon: widthIcon,
            orderCustomer: orderCustomer,
          )
        ],

        // progress
        if (orderCustomer?.status == StatusOrder.progress.name) ...[
          ProgressStatusWidget(
              widthIcon: widthIcon, orderCustomer: orderCustomer),
        ],

        // ready
        if (orderCustomer?.status == StatusOrder.ready.name) ...[
          DoneStatusWidget(
              width: width,
              widthIcon: widthIcon,
              orderCustomer: orderCustomer),
        ]
      ],
    );
  }
}
