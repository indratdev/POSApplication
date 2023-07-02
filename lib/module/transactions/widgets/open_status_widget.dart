import 'package:flutter/material.dart';
import 'package:posapplication/data/model/orders_model.dart';

import 'package:posapplication/shared/utils/TextUtil/text_util.dart';
import '../../blocs/export_bloc.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/custom_widgets.dart';

class OpenStatusWidget extends StatelessWidget {
  final OrdersModel? orderCustomer;
  final int _widthIcon;

  const OpenStatusWidget({
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
              color: activeIconColor,
            ),
            ElevatedButton(
              onPressed: () {
                // change status from open --> progress
                CustomWidgets.showConfirmation(
                    context, TextUtil.confrimProcessText, () {
                  if (orderCustomer != null) {
                    OrdersModel? result = orderCustomer;
                    result?.dateTimeProccess = DateTime.now();

                    BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
                      status: StatusOrder.progress,
                      orderCustomer: result!,
                    ));
                  }
                });
              },
              child: const Text("PROSES PESANAN"),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(
              check,
              cacheWidth: _widthIcon,
              color: inActiveIconColor,
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("SELESAI PROSES"),
            ),
          ],
        ),
      ],
    );
  }
}
