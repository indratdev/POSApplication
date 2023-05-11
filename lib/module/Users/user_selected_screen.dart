import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/module/Users/bloc/users_bloc.dart';
import 'package:posapplication/module/Users/user_manage/view/user_manage_screen.dart';
import 'package:posapplication/module/export.dart';

import 'package:posapplication/shared/routes/app_routes.dart';

import '../../../../data/model/users_model.dart';

class UserSelectedScreen extends StatefulWidget {
  const UserSelectedScreen({super.key});

  @override
  State<UserSelectedScreen> createState() => _UserSelectedScreenState();
}

class _UserSelectedScreenState extends State<UserSelectedScreen> {
  int? selectedIndex;
  UsersModel? selectedUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Staff"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (selectedUserData != null) {
                context.read<OrdersBloc>().add(
                    SelectedStaffHandledEvent(usersModel: selectedUserData!));
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is SuccessGetAllUser) {
            List<UsersModel> listUsers = state.resultModel;

            if (listUsers.isEmpty) {
              return const Center(
                child: Text("Belum Ada Pengguna yang Didaftarkan"),
              );
            }

            return ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) {
                UsersModel data = listUsers[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedUserData = data;
                    });
                  },
                  child: ListTile(
                    tileColor: (selectedIndex == index)
                        ? Colors.amber
                        : Colors.transparent,
                    title: Text("${data.firstname} ${data.lastname}"),
                    trailing: Text(data.role.toString()),
                  ),
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