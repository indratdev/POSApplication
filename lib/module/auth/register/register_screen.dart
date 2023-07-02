import 'package:flutter/material.dart';
import 'package:posapplication/module/auth/register/widgets/export.dart';
import 'package:posapplication/module/transactions/widgets/custom_textformfield_widget.dart';
import 'package:posapplication/shared/routes/app_routes.dart';
import 'package:posapplication/shared/utils/validator/validator.dart';
import 'package:posapplication/shared/widgets/custom_widgets.dart';

import '../../blocs/export_bloc.dart';
import '../../transactions/export.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _keyRegister = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  bool checkIsValidPassword(String password, String rePassword) {
    bool result = Validator.isPasswordEquals(password, rePassword);
    if (!result) {
      CustomWidgets.showMessageAlertBasic(
          context, "Kata Sandi Tidak Sesuai", false);
    }
    return result;
  }

  registerUser(String email, String password, String rePassword) {
    bool isValidPassword = checkIsValidPassword(password, rePassword);
    if (isValidPassword) {
      BlocProvider.of<AuthBloc>(context).add(RegisterRestoEvent(
        email: email,
        password: password,
        rePassword: rePassword,
      ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SuccessRegisterResto) {
                Navigator.pop(context);
                CustomWidgets.showMessageAlertWithF(
                    context,
                    state.message,
                    true,
                    () => Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.first, (route) => false));
              }

              if (state is FailureRegisterResto) {
                Navigator.pop(context);
                CustomWidgets.showMessageAlertBasic(
                    context, state.messageError, false);
              }

              if (state is LoadingRegisterResto) {
                CustomWidgets.showLoadingWidgetContainer(context);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 10),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 8,
                              child: const FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "Hello Again!",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ))),
                          const SizedBox(height: 8),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 18,
                              child: const FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text("Create a free account!"))),
                        ],
                      ),
                    ),
                    Form(
                      key: _keyRegister,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
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
                            CustomTextFormFieldWidget(
                              textFieldController: rePasswordController,
                              typeTextField: TypeTextField.password,
                              hintText: "Ketik Ulang Kata Sandi / Password",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      // padding: const EdgeInsets.only(top: 50, bottom: 50),
                      height: MediaQuery.of(context).size.width / 7,
                      width: double.infinity,
                      child: MainButtonWidget(
                        buttonName: ButtonName.mainButton,
                        textLabel: "Daftar",
                        onPress: () {
                          if (_keyRegister.currentState!.validate()) {
                            registerUser(
                                emailController.text,
                                passwordController.text,
                                rePasswordController.text);
                          }
                        },
                      ),
                    ),
                    const HaveAccountWidget()
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
