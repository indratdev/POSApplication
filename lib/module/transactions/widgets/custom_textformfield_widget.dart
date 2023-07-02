import 'package:flutter/material.dart';

import '../../../shared/utils/validator/validator.dart';

enum TypeTextField {
  general,
  email,
  password,
}

class CustomTextFormFieldWidget extends StatefulWidget {
  final TextEditingController textFieldController;
  final TypeTextField typeTextField;
  final String hintText;

  const CustomTextFormFieldWidget({
    super.key,
    required this.textFieldController,
    required this.typeTextField,
    required this.hintText,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  String? typeValidator(TypeTextField typeTextField, String? value) {
    String? result;

    if (typeTextField.name == TypeTextField.email.name) {
      result = Validator.emailValidator(value);
    }

    if (typeTextField.name == TypeTextField.password.name) {
      result = Validator.rule(value);
    }

    return result;
  }

  // @override
  // void dispose() {
  //   widget.textFieldController.dispose;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        enableInteractiveSelection: true,
        validator: (value) => typeValidator(widget.typeTextField, value),
        controller: widget.textFieldController,
        obscureText: (widget.typeTextField.name == TypeTextField.password.name)
            ? true
            : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.white70,
        ),
      ),
    );
  }
}
