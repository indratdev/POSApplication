import 'package:flutter/widgets.dart';
import 'package:posapplication/module/auth/cover/login_screen.dart';
import 'package:posapplication/module/auth/login/login_screen.dart';
import 'package:posapplication/module/auth/register/register_Screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String login = '/login';
  static const String register = '/register';

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => CoverAuthScreen(),
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
  };
}
