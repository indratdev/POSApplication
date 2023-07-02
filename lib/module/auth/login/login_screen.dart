import 'package:flutter/material.dart';
import 'package:posapplication/module/transactions/export.dart';
import 'package:posapplication/module/transactions/widgets/custom_textformfield_widget.dart';

import '../../../shared/routes/app_routes.dart';

import '../../../shared/widgets/custom_widgets.dart';
import '../../blocs/export_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  key: _formKeyLogin,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                height: MediaQuery.of(context).size.width / 8,
                                child: const FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      "Hello Again!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: MediaQuery.of(context).size.width / 10,
                              child: const FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  "Welcome back you've \n been missed!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormFieldWidget(
                        textFieldController: emailController,
                        typeTextField: TypeTextField.email,
                        hintText: "Ketik Email Anda",
                      ),
                      CustomTextFormFieldWidget(
                        textFieldController: passwordController,
                        typeTextField: TypeTextField.password,
                        hintText: "Ketik Kata Sandi / Password",
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, AppRoutes.forgotPassword),
                          child: const Text("Lupa Kata Sandi?"),
                        ),
                      ),
                      const SizedBox(height: 40),
                      MainButtonWidget(
                        buttonName: ButtonName.mainButton,
                        textLabel: "LOGIN",
                        onPress: () {
                          // if (_formKey.currentState!.validate()) {
                          // BlocProvider.of<AuthBloc>(context).add(
                          //     LoginUserEvent(
                          //         email: emailController.text,
                          //         password: passwordController.text));

                          // }

                          // only-test
                          BlocProvider.of<AuthBloc>(context).add(LoginUserEvent(
                              email: "owner@mail.com", password: "123123"));
                        },
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 30),
                      //   child: Text("Atau lanjutkan dengan"),
                      // ),
                      // const SizedBox(height: 30),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.white, width: 2),
                      //     shape: BoxShape.rectangle,
                      //   ),
                      //   child: IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset(googleLogo),
                      //   ),
                      // ),
                      // const SizedBox(height: 50),
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
