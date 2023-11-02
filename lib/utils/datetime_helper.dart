import 'package:intl/intl.dart';

class DatetimeHelper {
  static String formatDatetimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    return DateFormat('MMMM dd HH:mm').format(dateTime);
  }

  static String formatDatetime(DateTime dateTime) {
    return DateFormat('MMMM dd HH:mm').format(dateTime);
  }

  static String prepareDatetimeToSend(DateTime dateTime) {
    return DateFormat('y-M-d H:m:s.S').format(dateTime);
  }
}
