import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/module/Users/bloc/users_bloc.dart';
import 'package:posapplication/module/Users/user_dashboard/controller/user_dashboard_controller.dart';

import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../../data/model/users_model.dart';

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
            onPressed: () {},
            icon: Icon(Icons.abc),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.userManage),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is SuccessGetAllUser) {
            List<UsersModel> listUsers = state.resultModel;
            return ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                UsersModel data = listUsers[index];
                return ListTile(
                  title: Text(data.email),
                  subtitle: Text("${data.firstname} ${data.lastname}"),
                  trailing: Text(data.role.toString()),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection(UserService.userCollection)
      //       .where('companyID', isEqualTo: controller.readCompanyID())
      //       .where('role', isNotEqualTo: RoleUsers.owner.name.toString())
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     var datas = snapshot.data?.docs;
      //     return ListView.builder(
      //       itemCount: datas?.length ?? 0,
      //       itemBuilder: (context, index) {
      //         var data = datas?[index].data();
      //         // return Text(datas?[index].data()["email"] ?? "");
      //         return ListTile(
      //           title: Text(data?["email"] ?? ""),
      //           // subtitle: Text(data?["firstname"] ?? "" + data?["lastname"] ?? ""),
      //           subtitle: Text(
      //               "${data?["firstname"] ?? ""} ${data?["lastname"] ?? ""} "),
      //           trailing: Text(data?["role"] ?? ""),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
