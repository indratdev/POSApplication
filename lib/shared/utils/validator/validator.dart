class Validator {
  // basic
  static String? rule(
    String? value, {
    bool required = false,
  }) {
    if (required && value!.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  // check password & repassword is equals
  static bool isPasswordEquals(String password, String rePassword) {
    return (password == rePassword) ? true : false;
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) return "This field is required";

    final bool isValidEmail = RegExp(
            "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
        .hasMatch(value);

    if (!isValidEmail) {
      return "This field is not in a valid email format";
    }
    return null;
  }
}
