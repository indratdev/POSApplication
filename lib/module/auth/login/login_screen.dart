import 'package:flutter/material.dart';

import 'package:posapplication/shared/constants/constatns.dart';

import '../../../shared/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text("Hello Again!"),
                      SizedBox(height: 10),
                      Text(
                        "Welcome back you've \n been missed!",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Ketik Email Anda",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
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
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.forgotPassword),
                    child: const Text("Lupa Kata Sandi ?"),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 7,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text("LOGIN"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Colors.red))))),
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
                    Text("Belum menjadi anggota?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                        child: Text("Daftar sekarang")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
