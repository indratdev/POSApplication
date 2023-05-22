import 'package:flutter/material.dart';

import '../../../shared/constants/constatns.dart';

class OpenStatusWidget extends StatelessWidget {
  const OpenStatusWidget({
    super.key,
    required int widthIcon,
  }) : _widthIcon = widthIcon;

  final int _widthIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              workProcess,
              cacheWidth: _widthIcon,
              color: activeIconColor,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("PROSES PESANAN"),
            ),
          ],
        ),
        Container(
          foregroundDecoration: BoxDecoration(
            color: inActiveIconColor,
            backgroundBlendMode: BlendMode.saturation,
          ),
          child: Column(
            children: [
              Image.asset(
                check,
                cacheWidth: _widthIcon,
                color: activeIconColor,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text("SELESAI PROSES"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
