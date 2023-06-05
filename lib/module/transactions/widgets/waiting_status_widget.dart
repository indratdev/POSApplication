import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

import '../../../shared/constants/constatns.dart';
import '../../../shared/widgets/custom_widgets.dart';

class WaitingStatusWidget extends StatelessWidget {
  final OrdersModel? orderCustomer;
  final int _widthIcon;

  const WaitingStatusWidget({
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
                // // change status from waiting --> progress
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  context: context,
                  builder: (context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height - 50,
                        child: Column(
                          children: [
                            const Icon(Icons.minimize),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.done)),
                            ),
                            Divider(
                                color: Colors.green.shade200,
                                thickness: 1,
                                height: 1),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 100,
                                itemBuilder: (context, index) {
                                  return Text("data");
                                },
                              ),
                            )
                          ],
                        ));
                  },
                );
                // CustomWidgets.showConfirmation(
                // context, TextUtil.confrimProcessText, () {

                // if (orderCustomer != null) {
                //   OrdersModel? result = orderCustomer;
                //   result?.dateTimeProccess = DateTime.now();

                //   BlocProvider.of<OrdersBloc>(context).add(UpdateStatusOrders(
                //     status: StatusOrder.progress,
                //     orderCustomer: result!,
                //   ));
                // }
                // });
              },
              child: const Text("Pilih Staff"),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     Image.asset(
        //       check,
        //       cacheWidth: _widthIcon,
        //       color: inActiveIconColor,
        //     ),
        //     const ElevatedButton(
        //       onPressed: null,
        //       child: Text("SELESAI PROSES"),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
