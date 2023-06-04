import 'package:flutter/material.dart';
import 'package:posapplication/data/model/users_model.dart';

import '../../../export.dart';

class ListViewUserWidget extends StatefulWidget {
  int length;
  List<UsersModel>? listUsers;

  ListViewUserWidget({
    super.key,
    required this.length,
    this.listUsers,
  });

  @override
  State<ListViewUserWidget> createState() => _ListViewUserWidgetState();
}

class _ListViewUserWidgetState extends State<ListViewUserWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.length,
      itemBuilder: (context, index) {
        UsersModel data = widget.listUsers![index];
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
