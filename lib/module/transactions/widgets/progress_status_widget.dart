import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/orders_model.dart';
import '../../../shared/constants/constatns.dart';
import '../../../shared/utils/TextUtil/text_util.dart';
import '../../../shared/widgets/custom_widgets.dart';
import '../../orders/bloc/orders_bloc.dart';

class ProgressStatusWidget extends StatelessWidget {
  final OrdersModel? orderCustomer;
  final int _widthIcon;

  ProgressStatusWidget({
    super.key,
    required int widthIcon,
    required this.orderCustomer,
  }) : _widthIcon = widthIcon;

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
              cacheWidth: _widthIcon,
              color: cancelIconColor,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                // change status from progress --> open
                CustomWidgets.showConfirmation(
                    context, TextUtil.confrimProcessText, () {
                  OrdersModel? result = orderCustomer;
                  result?.dateTimeProccess = null;
                  result?.dateTimeFinish = null;

                  if (orderCustomer != null) {
                    BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
                      status: StatusOrder.open,
                      orderCustomer: result!,
                    ));
                  }
                });
              },
              child: const Text("BATAL PESANAN"),
            ),
          ],
        ),
        SizedBox(
          child: Column(
            children: [
              Image.asset(
                check,
                cacheWidth: _widthIcon,
                color: activeIconColor,
              ),
              ElevatedButton(
                onPressed: () {
                  // change status from progress --> done
                  CustomWidgets.showConfirmation(
                      context, TextUtil.confrimProcessText, () {
                    OrdersModel? result = orderCustomer;
                    result?.dateTimeFinish = DateTime.now();

                    if (orderCustomer != null) {
                      BlocProvider.of<OrdersBloc>(context)
                          .add(UpdateStatusOrders(
                        status: StatusOrder.done,
                        orderCustomer: result!,
                      ));
                    }
                  });
                },
                child: const Text("SELESAI PROSES"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
