import 'package:intl/intl.dart';

class DateUtil {
  static String getDateddMMyyyy() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
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
