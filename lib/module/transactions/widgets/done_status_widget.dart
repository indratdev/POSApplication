import 'package:flutter/material.dart';

import '../../../shared/constants/constatns.dart';

class DoneStatusWidget extends StatelessWidget {
  const DoneStatusWidget({
    super.key,
    required double width,
    required int widthIcon,
  })  : _width = width,
        _widthIcon = widthIcon;

  final double _width;
  final int _widthIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Image.asset(
                excellence,
                cacheWidth: _width ~/ 3,
                color: activeIconColor,
              ),
              const Text("Status Transaksi ini Sudah Selesai"),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
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
            Column(
              children: [
                Image.asset(
                  check,
                  cacheWidth: _widthIcon,
                  color: cancelIconColor,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: const Text("BATAL PROSES"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
