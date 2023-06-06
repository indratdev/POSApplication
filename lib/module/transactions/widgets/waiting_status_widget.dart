import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/data/model/orders_model.dart';
import 'package:posapplication/data/model/users_model.dart';
import 'package:posapplication/module/blocs/users_bloc/users_bloc.dart';
import 'package:posapplication/module/export.dart';
import 'package:posapplication/shared/utils/TextUtil/text_util.dart';

import '../../../shared/constants/constatns.dart';
import '../../../shared/widgets/custom_widgets.dart';

class WaitingStatusWidget extends StatefulWidget {
  final OrdersModel? orderCustomer;
  final int _widthIcon;
  // final List<UsersModel> userList;

  const WaitingStatusWidget({
    super.key,
    required int widthIcon,
    required this.orderCustomer,
    // required this.userList,
  }) : _widthIcon = widthIcon;

  @override
  State<WaitingStatusWidget> createState() => _WaitingStatusWidgetState();
}

class _WaitingStatusWidgetState extends State<WaitingStatusWidget> {
  // _showModalBottomSheetUsers(BuildContext context, List<UsersModel> userList) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(defaultBorderRadius),
  //     ),
  //     context: context,
  //     builder: (context) {
  //       return SizedBox(
  //           height: MediaQuery.of(context).size.height - 50,
  //           child: Column(
  //             children: [
  //               const Icon(Icons.minimize),
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: IconButton(onPressed: () {}, icon: Icon(Icons.done)),
  //               ),
  //               Divider(color: Colors.green.shade200, thickness: 1, height: 1),
  //               Expanded(
  //                 child: ListView.separated(
  //                   separatorBuilder: (context, index) => Divider(),
  //                   scrollDirection: Axis.vertical,
  //                   shrinkWrap: true,
  //                   itemCount: userList.length,
  //                   itemBuilder: (context, index) {
  //                     // return Text(userList[index].firstname ?? "");
  //                     return Text("Data");
  //                   },
  //                 ),
  //               )
  //             ],
  //           ));
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // List<UsersModel> userList = [];
    // return BlocBuilder<UsersBloc, UsersState>(
    //   builder: (context, state) {
    //     if (state is SuccessGetAllUserFromBox) {
    //       userList = state.resultModel;
    //       // _showModalBottomSheetUsers(context, userList);
    //     }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              workProcess,
              cacheWidth: widget._widthIcon,
              color: activeIconColor,
            ),
            ElevatedButton(
              onPressed: () {
                // // change status from waiting --> progress
                BlocProvider.of<UsersBloc>(context)
                    .add(GetAllUsersFromBoxEvent());
                // _showModalBottomSheetUsers(context);
                // BlocProvider.value(
                //   value: BlocProvider.of<UsersBloc>(context)
                //       .add(GetAllUsersFromBoxEvent()),
                //   child: _buildBottomSheetContent(context),
                // );
                // _buildBottomSheetContent(context);
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  context: context,
                  builder: (context) => _buildBottomSheetContent(),
                );
              },
              child: const Text("Pilih Staff"),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     Image.asset(
        //       check,
        //       cacheWidth: _widthIcon,
        //       color: inActiveIconColor,
        //     ),
        //     const ElevatedButton(
        //       onPressed: null,
        //       child: Text("SELESAI PROSES"),
        //     ),
        //   ],
        // ),
      ],
    );
    // },
    // );
  }
}

Widget _buildBottomSheetContent() {
  return BlocBuilder<UsersBloc, UsersState>(
    builder: (context, state) {
      if (state is SuccessGetAllUserFromBox) {
        List<UsersModel> userList = state.resultModel;
        return SizedBox(
            height: MediaQuery.of(context).size.height - 50,
            child: Column(
              children: [
                const Icon(Icons.minimize),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.done)),
                ),
                Divider(color: Colors.green.shade200, thickness: 1, height: 1),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      // return Text(userList[index].firstname ?? "");
                      return Text(userList[index].firstname ?? "");
                    },
                  ),
                )
              ],
            )
            // child: ListView.separated(
            //   separatorBuilder: (context, index) => Divider(),
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   itemCount: userList.length,
            //   itemBuilder: (context, index) {
            //     // return Text(userList[index].firstname ?? "");
            //     return Text(userList[index].firstname ?? "");
            //   },
            // ),
            );
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


// Widget _buildBottomSheetContent(BuildContext context) {
//   print(">>> jalannnnnnn.....");
//   return BlocBuilder<UsersBloc, UsersState>(
//     builder: (context, state) {
//       print(">>> state : ${state}");
//       if (state is SuccessGetAllUserFromBox) {
//         // Gunakan data dari state untuk membangun UI Bottom Sheet

//         List<UsersModel> userList = state.resultModel;

//         showModalBottomSheet(
//           isScrollControlled: true,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(defaultBorderRadius),
//           ),
//           context: context,
//           builder: (context) {
//             return SizedBox(
//                 height: MediaQuery.of(context).size.height - 50,
//                 child: Column(
//                   children: [
//                     const Icon(Icons.minimize),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child:
//                           IconButton(onPressed: () {}, icon: Icon(Icons.done)),
//                     ),
//                     Divider(
//                         color: Colors.green.shade200, thickness: 1, height: 1),
//                     Expanded(
//                       child: ListView.separated(
//                         separatorBuilder: (context, index) => Divider(),
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemCount: userList.length,
//                         itemBuilder: (context, index) {
//                           // return Text(userList[index].firstname ?? "");
//                           return Text("Data");
//                         },
//                       ),
//                     )
//                   ],
//                 ));
//           },
//         );
//       } else {
//         return CircularProgressIndicator();
//       }

//       return SizedBox(
//         child: Text("kosong"),
//       );
//     },
//   );
// }
