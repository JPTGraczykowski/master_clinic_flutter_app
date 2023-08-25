import 'package:intl/intl.dart';

class DatetimeHelper {
  static formatDatetime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    return DateFormat('MMMM dd HH:mm').format(dateTime);
  }
}
