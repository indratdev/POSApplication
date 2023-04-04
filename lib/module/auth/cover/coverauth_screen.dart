import 'package:flutter/material.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

class CoverAuthScreen extends StatefulWidget {
  const CoverAuthScreen({super.key});

  @override
  State<CoverAuthScreen> createState() => _CoverAuthScreenState();
}

class _CoverAuthScreenState extends State<CoverAuthScreen> {
  bool isRegister = true;

  @override
  Widget build(BuildContext context) {
    final sizeLayer = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: <Widget>[
                Container(
                  height: sizeLayer.height / 2,
                  width: sizeLayer.width,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                ),
                Container(
                  height: sizeLayer.height / 3.5,
                  width: sizeLayer.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text("data")),
                ),
                SizedBox(
                  height: sizeLayer.height / 16,
                  width: sizeLayer.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.login),
                            child: Text("LOGIN"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.register),
                            child: Text("DAFTAR"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: sizeLayer.height / 14,
                //   width: sizeLayer.width,
                //   child: CupertinoSlidingSegmentedControl<bool>(
                //     groupValue: isRegister,
                //     children: {
                //       true: SliderMenuLogin(label: "REGISTER"),
                //       false: SliderMenuLogin(label: "LOGIN"),
                //     },
                //     onValueChanged: (value) {
                //       isRegister = value!;

                //       Future.delayed(
                //         Duration(
                //           milliseconds: 400,
                //         ),
                //         () {
                //           // (isRegister)
                //           //     ? Navigator.pushNamed(context, AppRoutes.register)
                //           //     : Navigator.pushNamed(context, AppRoutes.login);
                //           if (isRegister) {
                //             print("jalan");
                //             Navigator.pushNamed(context, AppRoutes.register);
                //           } else {
                //             print("jalan2");
                //             Navigator.pushNamed(context, AppRoutes.login);
                //           }
                //         },
                //       );

                //       setState(() {});
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliderMenuLogin extends StatelessWidget {
  String label;
  SliderMenuLogin({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 16,
      child: Text(label),
    );
  }
}
