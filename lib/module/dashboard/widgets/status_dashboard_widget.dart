import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/export.dart';

import '../../../shared/utils/TextUtil/text_util.dart';

class StatusDashboardWidget extends StatelessWidget {
  final String status;
  final Color? colorStatus;
  final int amountOfData;
  final List<OrdersModel>? dataList;
  // StatusOrder statusOrder;

  const StatusDashboardWidget({
    required this.status,
    this.colorStatus,
    this.amountOfData = 0,
    this.dataList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<OrdersModel>? listData =
            dataList?.where((element) => element.status == status).toList();

        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ListTransactionScreen(
            status: status,
            dataList: listData,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorStatus ?? Colors.grey.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width / 12,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      amountOfData.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: MediaQuery.of(context).size.width / 18,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  TextUtil.subStringbyUpperCase(status),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            // const SizedBox(height: 5),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 3),
            //   child: Text(
            //     TextUtil.subStringbyUpperCase(status),
            //     // status,
            //     overflow: TextOverflow.clip,
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
