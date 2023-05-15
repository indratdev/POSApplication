import 'package:flutter/material.dart';

class StatusDashboardWidget extends StatelessWidget {
  String status;
  Color? colorStatus;
  int amountOfData;

  StatusDashboardWidget({
    required this.status,
    this.colorStatus,
    this.amountOfData = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorStatus ?? Colors.grey.shade400,
        borderRadius: BorderRadius.circular(15),
        // boxShadow: ["boxShadowMenu"],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tab(icon: Icon(Icons.abc)),
          Text(
            amountOfData.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              status,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
