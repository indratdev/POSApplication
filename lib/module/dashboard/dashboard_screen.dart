import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
// import 'package:posapplication/module/owner/owner_dashboard/controller/owner_dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final OwnerDashboardController controller = OwnerDashboardController();

  logout() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    // controller.logout();
    BlocProvider.of<OwnerBloc>(context).add(LogoutEvent());
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
      body: GridView.count(
        primary: false,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          StatusDashboardWidget(
            status: "OPEN",
            colorStatus: Colors.blueAccent.shade200,
          ),
          StatusDashboardWidget(status: "WAITING"),
          StatusDashboardWidget(
            status: "PROGRESS",
            colorStatus: Colors.amber.shade300,
          ),
          StatusDashboardWidget(
            status: "DONE",
            colorStatus: Colors.green.shade300,
          ),
          StatusDashboardWidget(
            status: "CANCELED",
            colorStatus: Colors.redAccent.shade200,
          ),
        ],
      ),
    );
  }
}

class StatusDashboardWidget extends StatelessWidget {
  String status;
  Color? colorStatus;
  int amountOfData;

  StatusDashboardWidget({
    required this.status,
    this.colorStatus,
    this.amountOfData = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              status,
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
    );
  }
}
