import 'package:flutter/material.dart';

import '../../../../data/model/users_model.dart';
import '../../../export.dart';

class UserListviewWidget extends StatefulWidget {
  List<UsersModel>? listUsers;

  UserListviewWidget({
    super.key,
    this.listUsers,
  });

  @override
  State<UserListviewWidget> createState() => _UserListviewWidgetState();
}

class _UserListviewWidgetState extends State<UserListviewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listUsers?.length ?? 0,
      itemBuilder: (context, index) {
        UsersModel data = widget.listUsers?[index] ?? UsersModel();
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  UserManageScreen(isUpdate: true, userModel: data),
            ));
          },
          child: ListTile(
            title: Text(data.email ?? ""),
            subtitle: Text("${data.firstname} ${data.lastname}"),
            trailing: Text(data.role.toString()),
          ),
        );
      },
    );
  }
}
