import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/blocs/payment_bloc/payment_bloc.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../data/model/orders_model.dart';
import '../../shared/routes/app_routes.dart';

class PaymentCompletedScreen extends StatelessWidget {
  const PaymentCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is LoadingPay) {
            CustomWidgets.showLoadingWidgetContainer(context);
          }

          if (state is SuccessPay) {
            double changeMoney = state.changeMoney;
            OrdersModel data = state.orders;

            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("PEMBAYARAN SELESAI"),
                  Text(
                    "No. Order : ${TextUtil.substringAndEclipsText(data.orderID)}",
                  ),
                  Divider(),
                  Text("UANG KEMBALIAN"),
                  Text("RP. $changeMoney"),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("PRINT NOTA"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.ownerBottomNav, (route) => false);
                        },
                        child: const Text("SELESAI"),
                      )
                    ],
                  )
                ]);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
