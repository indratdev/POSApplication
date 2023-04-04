
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapplication/module/auth/bloc/auth_bloc.dart';

import '../../../shared/routes/app_routes.dart';
import '../../../shared/utils/validator/validator.dart';
import '../../../shared/widgets/custom_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccessForgotPassword) {
              Navigator.pop(context);
              CustomWidgets.showMessageAlertWithF(
                  context,
                  state.result,
                  true,
                  () => Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.first, (route) => false));
            }

            if (state is FailureForgotPassword) {
              Navigator.pop(context);
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError, false);
            }

            if (state is LoadingForgotPassword) {
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
                            Text("Lupa Kata Sandi ?"),
                            SizedBox(height: 10),
                            Text(
                              "Masukkan alamat email Anda yang terkait dengan akun Anda",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          validator: (value) => Validator.emailValidator(value),
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Ketik Email Anda",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 7,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  ForgotPasswordEvent(
                                      email: emailController.text));
                            }
                          },
                          child: const Text("RESET PASSWORD"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
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
