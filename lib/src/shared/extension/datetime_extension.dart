import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime? other) {
    if (other == null) {
      return false;
    }
    return year == other.year && month == other.month && day == other.day;
  }

  String get convertDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get convertDateTime {
    return DateFormat('hh:mm • dd/MM/yyyy').format(this);
  }

  String get convertDateTimeHour {
    return DateFormat('(hh:mm:ss)').format(this);
  }
}
