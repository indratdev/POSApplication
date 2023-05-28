import 'package:intl/intl.dart';

class DateUtil {
  static String getDateddMMyyyy() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  static String getDateyyyyMMdd() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  static String convertyyyyMMdd(DateTime datetime) {
    return DateFormat('yyyy-MM-dd').format(datetime);
  }

  static String convertToOnlyTime(DateTime time) {
    // DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm:ss').format(time);
  }

  // ex : Sunday, 17 May 2023
  static String convertToDayAndDateTime(DateTime time) {
    return DateFormat('EEEE, dd MMMM yyyy').format(time);
  }

  static bool compareDate(String date1, String date2) {
    return (date1 == date2) ? true : false;
  }

  static DateTime getDateyyyyMMddWithMilisecond() {
    DateTime originalDateTime = DateTime.now();

    // Create a new DateTime object with the same date but set the time to 00:00:00.000
    DateTime convertedDateTime = DateTime(
      originalDateTime.year,
      originalDateTime.month,
      originalDateTime.day,
      0, // Hours
      0, // Minutes
      0, // Seconds
      0, // Milliseconds
    );

    // Format the converted DateTime to the desired string format
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    String convertedDateTimeString = dateFormat.format(convertedDateTime);

    return DateTime.parse(convertedDateTimeString);
  }
}
