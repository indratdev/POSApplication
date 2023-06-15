import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/utils/connectivity/network_connectivity.dart';

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
    // Map _source = {ConnectivityResult.none: false};
    // final NetworkConnectivity _networkConnectivity =
    //     NetworkConnectivity.instance;
    // String string = '';

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
                            onPressed: () {
                              print("login click...");
                              // Navigator.pushNamed(context, AppRoutes.login);
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRoutes.login);
                            },
                            child: const Text("LOGIN"),
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
                ElevatedButton(
                    onPressed: () async {
                      // var aaa = await MySharedPreferences().getCompanyID();
                      // print(aaa);
                      // _networkConnectivity.initialise();
                      // _networkConnectivity.myStream.listen((source) {
                      //   _source = source;
                      //   print('source $_source');
                      //   // 1.
                      //   switch (_source.keys.toList()[0]) {
                      //     case ConnectivityResult.mobile:
                      //       string = _source.values.toList()[0]
                      //           ? 'Mobile: Online'
                      //           : 'Mobile: Offline';
                      //       break;
                      //     case ConnectivityResult.wifi:
                      //       string = _source.values.toList()[0]
                      //           ? 'WiFi: Online'
                      //           : 'WiFi: Offline';
                      //       break;
                      //     case ConnectivityResult.none:
                      //     default:
                      //       string = 'Offline';
                      //   }
                      //   // 2.
                      //   setState(() {});
                      //   // 3.
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //         string,
                      //         style: TextStyle(fontSize: 30),
                      //       ),
                      //     ),
                      //   );
                      // });

                      // print(
                      //     ">>>  ${await NetworkConnectivity.hasInternetConnection()}");
                    },
                    child: Text("test")),
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
