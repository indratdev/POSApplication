class TextUtil {
  static int maxInitialName = 3;

  static String getInitialName(String fullname) {
    String result = '';
    List<String> words = fullname.split(' ');
    for (String word in words) {
      result += word.substring(0, 1).toUpperCase();
    }

    (result.length >=
            maxInitialName) // if clause more than 3, result only get max 3 clause
        ? result = result.substring(0, maxInitialName)
        : result = result;

    return result;
  }

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
