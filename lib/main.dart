import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

import 'module/auth/cover/coverauth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAI0UrENx1W1jyFlLRDl_YSZSr4mBrabEQ",
    appId: "1:738882296645:android:f1ce775358b8b97ac73c2c",
    messagingSenderId: "738882296645",
    projectId: "posapplication-f36fa",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes().getRoutes,
      // home: LoginScreen(),
    );
  }
}
