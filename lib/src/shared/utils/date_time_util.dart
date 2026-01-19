import 'package:intl/intl.dart';

class DateTimeUtil {
  DateTimeUtil._();
  static String formatToDayMonthYear(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatToHourMinute(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatToFullDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String formatCustom(DateTime date, String format) {
    return DateFormat(format).format(date);
  }
}
