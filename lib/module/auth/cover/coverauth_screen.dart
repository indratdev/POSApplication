import 'package:flutter/material.dart';

import 'package:posapplication/shared/routes/app_routes.dart';

import '../../transactions/export.dart';

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
                  child: Center(child: Text("Welcome to POS Application")),
                ),
                MainButtonWidget(buttonName: ButtonName.login),
                const SizedBox(height: 15),
                MainButtonWidget(buttonName: ButtonName.register),

                // SizedBox(
                //   height: sizeLayer.height / 16,
                //   width: sizeLayer.width,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       LoginButtonWidget(),
                //       // const SizedBox(height: 4),
                //       // Expanded(
                //       //   child: SizedBox(
                //       //     height: double.infinity,
                //       //     child: ElevatedButton(
                //       //       style: ElevatedButton.styleFrom(
                //       //         backgroundColor: Colors.grey.shade200,
                //       //         foregroundColor: Colors.black,
                //       //       ),
                //       //       onPressed: () => Navigator.pushNamed(
                //       //           context, AppRoutes.register),
                //       //       child: Text("DAFTAR"),
                //       //     ),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
                // ElevatedButton(
                //     onPressed: () async {
                //       // var aaa = await MySharedPreferences().getCompanyID();
                //       // print(aaa);
                //       // _networkConnectivity.initialise();
                //       // _networkConnectivity.myStream.listen((source) {
                //       //   _source = source;
                //       //   print('source $_source');
                //       //   // 1.
                //       //   switch (_source.keys.toList()[0]) {
                //       //     case ConnectivityResult.mobile:
                //       //       string = _source.values.toList()[0]
                //       //           ? 'Mobile: Online'
                //       //           : 'Mobile: Offline';
                //       //       break;
                //       //     case ConnectivityResult.wifi:
                //       //       string = _source.values.toList()[0]
                //       //           ? 'WiFi: Online'
                //       //           : 'WiFi: Offline';
                //       //       break;
                //       //     case ConnectivityResult.none:
                //       //     default:
                //       //       string = 'Offline';
                //       //   }
                //       //   // 2.
                //       //   setState(() {});
                //       //   // 3.
                //       //   ScaffoldMessenger.of(context).showSnackBar(
                //       //     SnackBar(
                //       //       content: Text(
                //       //         string,
                //       //         style: TextStyle(fontSize: 30),
                //       //       ),
                //       //     ),
                //       //   );
                //       // });

                //       // print(
                //       //     ">>>  ${await NetworkConnectivity.hasInternetConnection()}");
                //     },
                //     child: Text("test")),
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
