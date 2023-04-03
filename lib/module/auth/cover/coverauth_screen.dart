import 'package:flutter/cupertino.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text("data")),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoSlidingSegmentedControl<bool>(
                    groupValue: isRegister,
                    children: {
                      true: SliderMenuLogin(label: "REGISTER"),
                      false: SliderMenuLogin(label: "LOGIN"),
                    },
                    onValueChanged: (value) {
                      isRegister = value!;

                      Future.delayed(
                        Duration(
                          milliseconds: 400,
                        ),
                        () {
                          // (isRegister)
                          //     ? Navigator.pushNamed(context, AppRoutes.register)
                          //     : Navigator.pushNamed(context, AppRoutes.login);
                          if (isRegister) {
                            print("jalan");
                            Navigator.pushNamed(context, AppRoutes.register);
                          } else {
                            print("jalan2");
                            Navigator.pushNamed(context, AppRoutes.login);
                          }
                        },
                      );

                      setState(() {});
                    },
                  ),
                ),
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
