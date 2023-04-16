import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/Users/bloc/users_bloc.dart';
import 'package:posapplication/module/Users/user_dashboard/controller/user_dashboard_controller.dart';
import 'package:posapplication/service/user_service/user_service.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  final UserDashboardController controller = UserDashboardController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              UserService().readAllUser();
            },
            icon: Icon(Icons.abc),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.userManage),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(UserService.userCollection)
            .where('companyID', isEqualTo: controller.readCompanyID())
            .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
            .snapshots(),
        builder: (context, snapshot) {
          var datas = snapshot.data?.docs;
          return ListView.builder(
            itemCount: datas?.length ?? 0,
            itemBuilder: (context, index) {
              var data = datas?[index].data();
              // return Text(datas?[index].data()["email"] ?? "");
              return ListTile(
                title: Text(data?["email"] ?? ""),
                // subtitle: Text(data?["firstname"] ?? "" + data?["lastname"] ?? ""),
                subtitle: Text(
                    "${data?["firstname"] ?? ""} ${data?["lastname"] ?? ""} "),
                trailing: Text(data?["role"] ?? ""),
              );
            },
          );
        },
      ),
    );
  }
}
