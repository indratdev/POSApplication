import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/Users/bloc/users_bloc.dart';

import 'package:posapplication/module/auth/bloc/auth_bloc.dart';
import 'package:posapplication/module/customers/bloc/customers_bloc.dart';
import 'package:posapplication/module/owner/bloc/owner_bloc.dart';
import 'package:posapplication/data/service/hive_service/hive_init.dart';
import 'package:posapplication/shared/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase init
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAI0UrENx1W1jyFlLRDl_YSZSr4mBrabEQ",
    appId: "1:738882296645:android:f1ce775358b8b97ac73c2c",
    messagingSenderId: "738882296645",
    projectId: "posapplication-f36fa",
  ));

  // init hive
  await HiveData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => OwnerBloc(),
        ),
        BlocProvider(
          create: (context) => UsersBloc(),
        ),
        BlocProvider(
          create: (context) => CustomersBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes().getRoutes,
        // home: LoginScreen(),
      ),
    );
  }
}
