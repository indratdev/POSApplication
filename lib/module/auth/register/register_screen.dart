import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/auth/bloc/auth_bloc.dart';
import 'package:posapplication/service/auth_service/auth_service.dart';
import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/utils/validator/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool isPasswordEquals(String password, String rePassword) {
    //   return (password == rePassword) ? true : false;
    // }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is FailureRegisterResto) {
                print("------------------");
                print(state.messageError);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 10),
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: Column(
                        children: const <Widget>[
                          Text("Daftar"),
                          SizedBox(height: 10),
                          Text(
                            "Buat akun gratis!",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) =>
                                  Validator.emailValidator(value),
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Ketik Email Anda",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: Colors.white70,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Ketik Kata Sandi / Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white70,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: rePasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Ketik Ulang Kata Sandi / Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 7,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("DAFTAR"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                              RegisterRestoEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  rePassword: rePasswordController.text));
                          // bool resultPass = isPasswordEquals(
                          //     passwordController.text, rePasswordController.text);
                          // print("${resultPass}");
                          // if (resultPass) {
                          //   AuthService.registerUser(emailController.text,
                          //       passwordController.text, "Owner");
                          // }
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Sudah memiliki akun?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            child: Text("Masuk")),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
