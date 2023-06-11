import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/module/export.dart';

class StatusDashboardWidget extends StatelessWidget {
  String status;
  Color? colorStatus;
  int amountOfData;
  List<OrdersModel>? dataList;
  // StatusOrder statusOrder;

  StatusDashboardWidget({
    required this.status,
    this.colorStatus,
    this.amountOfData = 0,
    this.dataList,
    // required this.statusOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<OrdersModel>? listData =
            dataList?.where((element) => element.status == status).toList();

        print(">>> status ${status}");
        print(">>> datalist ${dataList!.first.orderID}");
        print(">>> listData ${listData!.first.orderID}");

        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ListTransactionScreen(
            status: status,
            dataList: listData,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ListTransactionScreen(
        //     status: status,
        //     dataList: listData,
        //   ),
        // ));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorStatus ?? Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
          // boxShadow: ["boxShadowMenu"],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tab(icon: Icon(Icons.abc)),
            Text(
              amountOfData.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                status.toUpperCase(),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
