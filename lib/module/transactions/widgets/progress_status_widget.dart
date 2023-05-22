import 'package:flutter/material.dart';

import '../../../shared/constants/constatns.dart';

class ProgressStatusWidget extends StatelessWidget {
  const ProgressStatusWidget({
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
              color: cancelIconColor,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
              ),
              onPressed: () {},
              child: const Text("BATAL PESANAN"),
            ),
          ],
        ),
        SizedBox(
          child: Column(
            children: [
              Image.asset(
                check,
                cacheWidth: _widthIcon,
                color: activeIconColor,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("SELESAI PROSES"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
