import 'package:flutter/material.dart';

import '../../../../shared/routes/app_routes.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text("Sudah memiliki akun?"),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
            child: const Text("Masuk")),
      ],
    );
  }
}
