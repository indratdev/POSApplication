import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/Users/user_dashboard/view/user_listview_widget.dart';

import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../../../data/model/users_model.dart';
import '../../../blocs/export_bloc.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print("==================");
              context.read<UsersBloc>().add(GetAllUsersFromBoxEvent());
              print("==================");
            },
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
          List<UsersModel> listUsers = [];

          // loading
          if (state is LoadingGetAllUser || state is LoadingGetAllUserFromBox) {
            return CustomWidgets.showLoadingWidget();
          }

          // failure
          if (state is FailureGetAllUser) {
            CustomWidgets.showInfoMessageWidget(state.messageError);
          }
          if (state is FailureGetAllUserFromBox) {
            CustomWidgets.showInfoMessageWidget(state.messageError);
          }

          //success
          if (state is SuccessGetAllUser) {
            listUsers = state.resultModel;
            return UserListviewWidget(listUsers: listUsers);
          }

          if (state is SuccessGetAllUserFromBox) {
            listUsers = state.resultModel;
            return UserListviewWidget(listUsers: listUsers);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
