import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/orders_model.dart';
import '../../../shared/constants/constatns.dart';
import '../../../shared/utils/TextUtil/text_util.dart';
import '../../../shared/widgets/custom_widgets.dart';
import '../../blocs/export_bloc.dart';

class DoneStatusWidget extends StatelessWidget {
  final OrdersModel? orderCustomer;
  final double _width;
  final int _widthIcon;

  const DoneStatusWidget({
    super.key,
    required double width,
    required int widthIcon,
    required this.orderCustomer,
  })  : _width = width,
        _widthIcon = widthIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Image.asset(
                excellence,
                cacheWidth: _width ~/ 3,
                color: activeIconColor,
              ),
              const Text("Status Transaksi ini Sudah Selesai"),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
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
                    // change status from done --> open
                    CustomWidgets.showConfirmation(
                        context, TextUtil.confrimProcessText, () {
                      OrdersModel? result = orderCustomer;
                      result?.dateTimeReady = null;
                      result?.dateTimeProccess = null;

                      if (orderCustomer != null) {
                        BlocProvider.of<OrdersBloc>(context)
                            .add(UpdateStatusOrders(
                          status: StatusOrder.waiting,
                          orderCustomer: result!,
                        ));
                      }
                    });
                  },
                  child: const Text("BATAL PESANAN"),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  check,
                  cacheWidth: _widthIcon,
                  color: cancelIconColor,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // change status from done --> progress
                    CustomWidgets.showConfirmation(
                        context, TextUtil.confrimProcessText, () {
                      OrdersModel? result = orderCustomer;
                      result?.dateTimeReady = null;

                      if (orderCustomer != null) {
                        BlocProvider.of<OrdersBloc>(context)
                            .add(UpdateStatusOrders(
                          status: StatusOrder.progress,
                          orderCustomer: result!,
                        ));
                      }
                    });
                  },
                  child: const Text("BATAL PROSES"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
