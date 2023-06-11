import 'package:flutter/material.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../module/transactions/export.dart';
import '../constants/constants.dart';

class CancelButtonWidget extends StatelessWidget {
  String contentMessage;
  void Function()? voidCallback;

  CancelButtonWidget({
    super.key,
    required this.widget,
    required this.contentMessage,
    this.voidCallback,
  });

  final ButtonStatusWidget widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.9),
      ),
      onPressed: () {
        CustomWidgets.showConfirmation(
          context,
          contentMessage,
          voidCallback,
        );
      },
      child: const Text("Batal Proses",
          style: TextStyle(color: errorMessageColor)),
    );
  }
}
