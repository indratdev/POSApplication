import 'package:flutter/material.dart';

import 'package:posapplication/shared/constants/constants.dart';

class TwoOptionButtonWidget extends StatelessWidget {
  final void Function() mainButtonvoidCallback;
  final String mainTitleButton;

  final void Function()? secondButtonvoidCallback;
  final String secondTitleButton;

  const TwoOptionButtonWidget({
    super.key,
    this.mainTitleButton = "PROSES",
    required this.mainButtonvoidCallback,
    this.secondTitleButton = "BATAL",
    this.secondButtonvoidCallback,
  });

  // final ButtonStatusWidget widget;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height / 17;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: _width / 3,
          height: _height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainWhite.withOpacity(0.9),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: (secondButtonvoidCallback == null)
                ? () => Navigator.pop(context)
                : secondButtonvoidCallback,
            child: Text(
              secondTitleButton,
              style: const TextStyle(
                color: redColors,
              ),
            ),
          ),
        ),
        SizedBox(
          width: _width / 2,
          height: _height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: mainGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: mainButtonvoidCallback,
            child: Text(mainTitleButton),
          ),
        ),
      ],
    );
  }
}
