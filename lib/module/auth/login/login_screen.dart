import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posapplication/shared/constants/constatns.dart';
import 'package:posapplication/shared/utils/validator/validator.dart';

import '../../../shared/routes/app_routes.dart';

import '../../../shared/widgets/custom_widgets.dart';
import '../../blocs/export_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  // String string = '';
  // Map _source = {ConnectivityResult.none: false};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccessLoginUser) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.ownerBottomNav, (route) => false);
            }

            if (state is FailureLoginUser) {
              Navigator.pop(context);
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError, false);
            }

            if (state is LoadingLoginUser) {
              CustomWidgets.showLoadingWidgetContainer(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Column(
                          children: const <Widget>[
                            Text("Hello Again!"),
                            SizedBox(height: 10),
                            Text(
                              "Welcome back you've \n been missed!",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) => Validator.emailValidator(value),
                        decoration: InputDecoration(
                          hintText: "Ketik Email Anda",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) => Validator.rule(value),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Ketik Kata Sandi / Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white70,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, AppRoutes.forgotPassword),
                          child: const Text("Lupa Kata Sandi ?"),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 7,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                          color: Colors.red)))),
                          child: const Text("LOGIN"),
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            // BlocProvider.of<AuthBloc>(context).add(
                            //     LoginUserEvent(
                            //         email: emailController.text,
                            //         password: passwordController.text));

                            // }

                            BlocProvider.of<AuthBloc>(context).add(
                                LoginUserEvent(
                                    email: "owner@mail.com",
                                    password: "123123"));
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text("Atau lanjutkan dengan"),
                      ),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.rectangle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(googleLogo),
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("Belum menjadi anggota?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.register);
                              },
                              child: const Text("Daftar sekarang")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
