import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posapplication/data/model/orders_model.dart';

import 'package:posapplication/domain/hive_repository.dart';

import 'package:posapplication/module/dashboard/widgets/status_dashboard_widget.dart';
import 'package:posapplication/shared/constants/constants.dart';

import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../shared/utils/firebase_utils/firebase_utils.dart';
import '../blocs/export_bloc.dart';
// import 'package:posapplication/module/owner/owner_dashboard/controller/owner_dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final OwnerDashboardController controller = OwnerDashboardController();
  List<OrdersModel> resultData = [];
  Map<String, dynamic> statusItem = {};

  logout() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    // controller.logout();
    BlocProvider.of<OwnerBloc>(context).add(LogoutEvent());
  }

  colletionDataFB(QuerySnapshot<Map<String, dynamic>>? dataList) {
    resultData = [];

    if (dataList != null) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          dataList.docs;

      for (var document in documents) {
        OrdersModel data = OrdersModel.fromDocumentSnapshot(document);
        resultData.add(data);
      }
    }
    countStatus(resultData);
  }

  void countStatus(List<OrdersModel> statusList) {
    statusItem = {};
    for (var element in statusList) {
      if (statusItem.containsKey(element.status)) {
        statusItem[element.status] = (statusItem[element.status] ?? 0) + 1;
      } else {
        statusItem[element.status] = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: HiveRepository().readProfileCompanyIDFromBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomWidgets.showLoadingWidget();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            String companyID = snapshot.data ?? "";

            return StreamBuilder(
              stream: FirebaseUtil().queryOrdersFirebase(companyID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                // var dataList = snapshot.data;
                colletionDataFB(snapshot.data);

                return GridView.count(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    StatusDashboardWidget(
                      status: StatusOrder.waiting.name,
                      dataList: resultData,
                      amountOfData:
                          statusItem[StatusOrder.waiting.name.toString()] ?? 0,
                      colorStatus: waitingColor,
                    ),
                    StatusDashboardWidget(
                      status: StatusOrder.progress.name,
                      dataList: resultData,
                      amountOfData:
                          statusItem[StatusOrder.progress.name.toString()] ?? 0,
                      colorStatus: progressColor,
                    ),
                    StatusDashboardWidget(
                      status: StatusOrder.ready.name,
                      dataList: resultData,
                      amountOfData:
                          statusItem[StatusOrder.ready.name.toString()] ?? 0,
                      colorStatus: readyColor,
                    ),
                    StatusDashboardWidget(
                      status: StatusOrder.orderCompleted.name,
                      dataList: resultData,
                      amountOfData: statusItem[
                              StatusOrder.orderCompleted.name.toString()] ??
                          0,
                      colorStatus: orderCompletedColor,
                    ),
                    StatusDashboardWidget(
                      status: StatusOrder.billIsReady.name,
                      dataList: resultData,
                      amountOfData:
                          statusItem[StatusOrder.billIsReady.name.toString()] ??
                              0,
                      colorStatus: billIsReadyColor,
                    ),
                    StatusDashboardWidget(
                      status: StatusOrder.paymentCompleted.name,
                      dataList: resultData,
                      amountOfData: statusItem[
                              StatusOrder.paymentCompleted.name.toString()] ??
                          0,
                      colorStatus: paymentCompleteColor,
                    ),
                    StatusDashboardWidget(
                      status: StatusOrder.cancel.name,
                      dataList: resultData,
                      amountOfData:
                          statusItem[StatusOrder.cancel.name.toString()] ?? 0,
                      colorStatus: cancelColor,
                    ),
                  ],
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
