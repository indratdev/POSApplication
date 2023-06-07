import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/users_model.dart';
import '../../../shared/constants/constants.dart';
import '../../blocs/export_bloc.dart';

class BottomSheetUsersWidget extends StatefulWidget {
  const BottomSheetUsersWidget({super.key});

  @override
  State<BottomSheetUsersWidget> createState() => _BottomSheetUsersWidgetState();
}

class _BottomSheetUsersWidgetState extends State<BottomSheetUsersWidget> {
  int? selectedIndex;
  UsersModel? selectedUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is SuccessGetAllUserFromBox) {
          List<UsersModel> userList = state.resultModel;
          return SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Icon(Icons.minimize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pilih Staff Pembuat"),
                        IconButton(
                            onPressed: () {
                              print(
                                  ">>> tapp selected User : ${selectedUser?.firstname ?? ""}");
                              if (selectedUser != null) {
                                BlocProvider.of<UsersBloc>(context).add(
                                    selectedUserEvent(user: selectedUser!));
                              }
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.done)),
                      ],
                    ),
                    Divider(
                        color: Colors.green.shade200, thickness: 1, height: 1),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 2.0),
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          UsersModel data = userList[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selectedUser = data;
                              });
                            },
                            child: ListTile(
                              tileColor: (selectedIndex == index)
                                  ? sageColor
                                  : Colors.transparent,
                              title: Text(
                                "${data.firstname} ${data.lastname}",
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                data.role.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
        } else if (state is LoadingGetAllUserFromBox) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
