import 'package:flutter/material.dart';
import 'package:posapplication/module/transactions/widgets/waiting_status_widget.dart';

import '../../../data/model/orders_model.dart';
import '../export.dart';

class StatusTransactionWidgets extends StatelessWidget {
  final OrdersModel? orderCustomer;
  final Map<String, dynamic> statusMap;
  final double _width;

  StatusTransactionWidgets({
    super.key,
    required this.statusMap,
    required double width,
    required this.orderCustomer,
  }) : _width = width;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    int _widthIcon = _width ~/ 5;

    return Column(
      children: [
        // waiting
        if (orderCustomer?.status == StatusOrder.waiting.name) ...[
          WaitingStatusWidget(
              widthIcon: _widthIcon, orderCustomer: orderCustomer)
        ],

        // // waiting old
        // if (orderCustomer?.status == StatusOrder.waiting.name) ...[
        //   OpenStatusWidget(widthIcon: _widthIcon, orderCustomer: orderCustomer)
        // ],

        // progress
        if (orderCustomer?.status == StatusOrder.progress.name) ...[
          ProgressStatusWidget(
              widthIcon: _widthIcon, orderCustomer: orderCustomer),
        ],

        // ready
        if (orderCustomer?.status == StatusOrder.ready.name) ...[
          DoneStatusWidget(
              width: _width,
              widthIcon: _widthIcon,
              orderCustomer: orderCustomer),
        ]
      ],
    );
  }
}
