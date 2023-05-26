import 'package:flutter/material.dart';

import '../constants/constatns.dart';

class CustomWidgets {
  static showLoadingWidget() {
    return const Center(child: Text('Loading..'));
  }

  static showLoadingWidgetContainer(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                    Text('Loading..'),
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
                    Text(content),
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
                          child: Text("BATAL",
                              style: const TextStyle(color: Colors.black)),
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
