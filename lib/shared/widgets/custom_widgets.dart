import 'package:flutter/material.dart';
import 'package:posapplication/data/model/orders_model.dart';

import '../../module/export.dart';
import '../constants/constants.dart';

class CustomWidgets {
  static showLoadingWidget() {
    return const Center(child: Text('Loading..'));
  }

  static showInfoMessageWidget(String message) {
    return Center(child: Text(message));
  }

  static showLoadingWidgetContainer(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    Text('Loading...'),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showConfirmation(
      BuildContext context, String content, void Function()? voidCallback) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      foregroundColor: Colors.transparent,
                      child: Image.asset(warningImage),
                    ),
                    sbHeight20,
                    Text(content, textAlign: TextAlign.center),
                    sbHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text("BATAL",
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // backgroundColor: lightBlue
                              ),
                          onPressed: voidCallback,
                          child: const Text("OK"),
                        ),
                      ],
                    )
                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width / 2,
                    //     child: ElevatedButton(
                    //         onPressed: () => Navigator.pop(context),
                    //         child: const Text("OK")))
                  ],
                ),
              ),
            ),
          );
        });
  }

  // static showConfirmationDelete2(
  //     BuildContext context, String content, void Function()? voidCallback) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('confirmation'.tr()),
  //         content: Text(content),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () => Navigator.pop(context),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.white,
  //             ),
  //             child: Text('cancel'.tr(),
  //                 style: const TextStyle(color: Colors.black)),
  //           ),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(backgroundColor: lightBlue),
  //             onPressed: voidCallback,
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // static showMessageAlertBasic2(BuildContext context, String content) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('status'.tr()),
  //         content: Text(content, textAlign: TextAlign.center),
  //         actions: [
  //           ElevatedButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text("OK"))
  //         ],
  //       );
  //     },
  //   );
  // }

  static showMessageAlertBasic(
    BuildContext context,
    String content,
    bool isSuccess,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      foregroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          (isSuccess) ? successImage : failedImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    sbHeight20,
                    Text(content, textAlign: TextAlign.center),
                    sbHeight20,
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK")))
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showMessageAlertWithF(
    BuildContext context,
    String content,
    bool isSuccess,
    Function()? voidCallBack,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      foregroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          (isSuccess) ? successImage : failedImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    sbHeight20,
                    Text(content, textAlign: TextAlign.center),
                    sbHeight20,
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: voidCallBack,
                        child: const Text("OK"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showModalPaymentWidget(BuildContext context, OrdersModel? orders,
      double totalTranscationAmount) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
                leading: const Icon(Icons.wallet_outlined),
                title: const Text('Tunai / Cash'),
                subtitle: const Text("Menggunakan uang tunai"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CashPaymentTransactionScreen(
                            orderCustomer: orders,
                            totalTranscationAmount: totalTranscationAmount),
                      ));
                }),
            const ListTile(
              leading: Icon(Icons.wallet_outlined),
              title: Text('Kartu Debit'),
              subtitle: Text("Menggunakan kartu debit"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            // ListTile(
            //   leading: Icon(Icons.copy),
            //   title: Text('Copy Link'),
            // ),
            // ListTile(
            //   leading: Icon(Icons.edit),
            //   title: Text('Edit'),
            // ),
          ],
        );
      },
    );
  }

  static showSnackBarCustom(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // static showConfirmationWithF(
  //   BuildContext context,
  //   String content,
  //   Function()? voidCallBack,
  // ) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0)), //this right here
  //           child: SizedBox(
  //             height: MediaQuery.of(context).size.height / 3,
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   CircleAvatar(
  //                     radius: MediaQuery.of(context).size.width / 8,
  //                     foregroundColor: Colors.transparent,
  //                     child: ClipOval(
  //                       child: Image.asset(
  //                         warningImage,
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                   ),
  //                   SB_Height20,
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       content,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   SB_Height20,
  //                   SizedBox(
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 4,
  //                             child: ElevatedButton(
  //                                 onPressed: (() => Navigator.pop(context)),
  //                                 child: Text('cancel'.tr())),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width / 4,
  //                             child: ElevatedButton(
  //                                 onPressed: voidCallBack,
  //                                 child: const Text("OK")),
  //                           ),
  //                         ],
  //                       ))
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
