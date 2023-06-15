import 'package:flutter/material.dart';
import 'package:posapplication/module/transactions/widgets/status_transaction_widgets.dart';

import '../../../data/model/orders_model.dart';
import '../../../shared/widgets/export_widget.dart';
import '../../blocs/export_bloc.dart';

class ButtonStatusWidget extends StatefulWidget {
  OrdersModel? orderCustomer;
  double width;
  Map<String, dynamic>? statusMap;

  ButtonStatusWidget({
    super.key,
    this.orderCustomer,
    required this.width,
    this.statusMap,
  });

  @override
  State<ButtonStatusWidget> createState() => _ButtonStatusWidgetState();
}

class _ButtonStatusWidgetState extends State<ButtonStatusWidget> {
  @override
  Widget build(BuildContext context) {
    // if status == waiting && Haven't chosen a table number yet
    if (widget.orderCustomer!.status == StatusOrder.waiting.name &&
        widget.orderCustomer!.dataTable?.tableID == "") {
      return StatusTransactionWidgets(
        statusMap: widget.statusMap ?? {},
        width: widget.width,
        orderCustomer: widget.orderCustomer,
      );
    } else if (widget.orderCustomer!.status == StatusOrder.waiting.name &&
        widget.orderCustomer?.userHandleBy == "") {
      return StatusTransactionWidgets(
        orderCustomer: widget.orderCustomer,
        statusMap: widget.statusMap ?? {},
        width: widget.width,
      );
      // if status = waiting and user handle/maker has fill
    } else if (widget.orderCustomer!.status == StatusOrder.waiting.name) {
      return ElevatedButton(
        onPressed: () {
          CustomWidgets.showConfirmation(
              context, "Apakah anda yakin melanjutkan proses ini ?", () {
            // update time waiting
            widget.orderCustomer!.dateTimeWaiting = DateTime.now();

            // print(widget.orderCustomer?.dataTable?.tableID);

            BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
              status: StatusOrder.progress,
              orderCustomer: widget.orderCustomer!,
            ));
          });
        },
        child: const Text("Lanjut Proses"),
      );

      // if status = progress
    } else if (widget.orderCustomer!.status == StatusOrder.progress.name) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //batal proses
          CancelButtonWidget(
            widget: widget,
            contentMessage:
                "Apakah anda yakin mengubah status menjadi menunggu kembali ?",
            voidCallback: () =>
                BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
              status: StatusOrder.waiting,
              orderCustomer: widget.orderCustomer!,
            )),
          ),

          ProcessedButtonWidget(
              widget: widget,
              textLabel: "Pesanan Selesai",
              contentMessage: "Apakah anda yakin menyelesaikan proses ini ?",
              voidCallback: () {
                // update dateTimeReady
                widget.orderCustomer?.dateTimeReady = DateTime.now();

                BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
                  status: StatusOrder.ready,
                  orderCustomer: widget.orderCustomer!,
                ));
              }),
        ],
      );

      // if status ready
    } else if (widget.orderCustomer!.status == StatusOrder.ready.name) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //batal proses
          CancelButtonWidget(
            widget: widget,
            contentMessage:
                "Apakah anda yakin mengubah status menjadi proses kembali ?",
            voidCallback: () =>
                BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
              status: StatusOrder.progress,
              orderCustomer: widget.orderCustomer!,
            )),
          ),

          ProcessedButtonWidget(
              widget: widget,
              textLabel: "Antar Pesanan",
              contentMessage: "Apakah anda yakin menyelesaikan proses ini ?",
              voidCallback: () {
                // update dateTimeOrderComplete
                widget.orderCustomer?.dateTimeOrderComplete = DateTime.now();

                BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
                  status: StatusOrder.orderCompleted,
                  orderCustomer: widget.orderCustomer!,
                ));
              }),
        ],
      );
      // if status order completed
    } else if (widget.orderCustomer!.status ==
        StatusOrder.orderCompleted.name) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //batal proses
          CancelButtonWidget(
            widget: widget,
            contentMessage: "Apakah anda yakin mengubah status menjadi ready ?",
            voidCallback: () =>
                BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
              status: StatusOrder.ready,
              orderCustomer: widget.orderCustomer!,
            )),
          ),

          ProcessedButtonWidget(
              widget: widget,
              textLabel: "Pesanan Sudah Diantar",
              contentMessage: "Apakah anda yakin menyelesaikan proses ini ?",
              voidCallback: () {
                // update dateTimeOrderComplete
                widget.orderCustomer?.dateTimeOrderComplete = DateTime.now();

                BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
                  status: StatusOrder.billIsReady,
                  orderCustomer: widget.orderCustomer!,
                ));
              }),
        ],
      );
    }
    // else if (widget.orderCustomer!.status == StatusOrder.billIsReady.name) {

    // }
    else {
      return const SizedBox();
    }

    // return const Placeholder();
  }
}
