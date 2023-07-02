import 'package:flutter/material.dart';
import 'package:posapplication/module/transactions/widgets/custom_textformfield_widget.dart';
import 'package:posapplication/module/transactions/widgets/main_button_widget.dart';

import '../../../shared/routes/app_routes.dart';
import '../../../shared/utils/validator/validator.dart';
import '../../../shared/widgets/custom_widgets.dart';
import '../../blocs/export_bloc.dart';
import '../register/widgets/export.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKeyForgotPassword = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  key: _formKeyForgotPassword,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            // Text("Lupa Kata Sandi ?"),
                            Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                height: MediaQuery.of(context).size.width / 12,
                                child: const FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      "Lupa Kata Sandi?",
                                      // "Hello Again!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))),

                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              height: MediaQuery.of(context).size.width / 22,
                              child: const FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  "Masukkan alamat email Anda",
                                  style: TextStyle(fontWeight: FontWeight.w500),
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
                      const SizedBox(height: 20),
                      MainButtonWidget(
                        buttonName: ButtonName.mainButton,
                        textLabel: "RESET PASSWORD",
                        onPress: () {
                          if (_formKeyForgotPassword.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                                ForgotPasswordEvent(
                                    email: emailController.text));
                          }
                        },
                      ),
                      const HaveAccountWidget()
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
