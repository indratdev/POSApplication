import 'package:flutter/material.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../module/transactions/export.dart';

class ProcessedButtonWidget extends StatelessWidget {
  String contentMessage;
  String textLabel;
  void Function()? voidCallback;

  ProcessedButtonWidget({
    super.key,
    required this.widget,
    required this.textLabel,
    required this.contentMessage,
    this.voidCallback,
  });

  final ButtonStatusWidget widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        CustomWidgets.showConfirmation(
          context,
          // "Apakah anda yakin menyelesaikan proses ini ?"
          contentMessage,
          voidCallback,
        );
        //     () {
        //   BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
        //     status: StatusOrder.ready,
        //     orderCustomer: widget.orderCustomer!,
        //   ));
        // });
      },
      child: Text(textLabel),
    );
  }
}
