class TextUtil {
  static String clipStringTwoClause(String text) {
    String separatedText = text.replaceAllMapped(RegExp(r'^(.*?)\s'), (match) {
      return '${match.group(1)}\n';
    });
    return separatedText;
  }

  static String substringAndEclipsText(String text) {
    return "${text.substring(0, 20)}...";
  }

  static String subStringbyUpperCase(String text) {
    String separatedText = text.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    return separatedText.toUpperCase();
  }

  static String confrimProcessText =
      "Apakah anda ingin melanjutkan proses ini ?";
}
