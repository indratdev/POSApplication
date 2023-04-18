import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
// import 'package:posapplication/module/owner/owner_dashboard/controller/owner_dashboard_controller.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
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
        title: const Text("Owner Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}
