import 'package:flutter/material.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/routes/app_routes.dart';
import '../../transactions/export.dart';

class CoverAuthScreen extends StatelessWidget {
  const CoverAuthScreen({super.key});

  Future<Image> loadLogoApp() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return Image.asset(logoAppImage, fit: BoxFit.fill);
      },
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    final sizeLayer = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadLogoApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
              // if (snapshot.connectionState == ConnectionState.done) {}
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: sizeLayer.height / 2,
                      width: sizeLayer.width,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: snapshot.data),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      height: sizeLayer.height / 3.5,
                      width: sizeLayer.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 8,
                              child: const FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "Welcome",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ))),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 18,
                              child: const FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text("to POS Application"))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: MainButtonWidget(
                        buttonName: ButtonName.mainButton,
                        textLabel: "MASUK",
                        onPress: () =>
                            Navigator.pushNamed(context, AppRoutes.login),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: MainButtonWidget(
                        buttonName: ButtonName.secondButton,
                        textLabel: "DAFTAR",
                        onPress: () =>
                            Navigator.pushNamed(context, AppRoutes.register),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
