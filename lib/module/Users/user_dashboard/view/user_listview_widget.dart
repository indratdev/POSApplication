import 'package:flutter/material.dart';
import 'package:posapplication/shared/constants/constants.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

import '../../../../data/model/users_model.dart';
import '../../../../shared/utils/color_utils/color_utils.dart';
import '../../../export.dart';

class UserListviewWidget extends StatefulWidget {
  final List<UsersModel>? listUsers;

  const UserListviewWidget({
    super.key,
    this.listUsers,
  });

  @override
  State<UserListviewWidget> createState() => _UserListviewWidgetState();
}

class _UserListviewWidgetState extends State<UserListviewWidget> {
  ColorUtils colorUtils = ColorUtils();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listUsers?.length ?? 0,
      itemBuilder: (context, index) {
        UsersModel data = widget.listUsers![index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    UserManageScreen(isUpdate: true, userModel: data),
              ),
            );
          },
          child: Container(
            color: mainWhite,
            child: ListTile(
              leading: CircleAvatar(
                  child: Text(TextUtil.getInitialName(
                      "${data.firstname} ${data.lastname}"))),
              title: Text("${data.firstname} ${data.lastname}"),
              subtitle: Text(data.email ?? ""),
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: colorUtils.colorRoleUser(data.role!),
                  child: Text(
                    data.role.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
