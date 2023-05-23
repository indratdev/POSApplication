import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/orders_model.dart';
import '../../../shared/widgets/custom_widgets.dart';
import '../../orders/bloc/orders_bloc.dart';
import 'export.dart';

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
        // open
        if (orderCustomer?.status == StatusOrder.open.name) ...[
          OpenStatusWidget(widthIcon: _widthIcon, orderCustomer: orderCustomer)
        ],

        // progress
        if (orderCustomer?.status == StatusOrder.progress.name) ...[
          ProgressStatusWidget(
              widthIcon: _widthIcon, orderCustomer: orderCustomer),
        ],

        // done
        if (orderCustomer?.status == StatusOrder.done.name) ...[
          DoneStatusWidget(
              width: _width,
              widthIcon: _widthIcon,
              orderCustomer: orderCustomer),
        ]
      ],
    );
  }
}
