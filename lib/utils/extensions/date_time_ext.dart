import 'package:intl/intl.dart';
import '../constants/datetime_constants.dart';

extension DateTimeExt on DateTime {
  String convertToString({String pattern = DateTimeFormat.date}) {
    try {
      return DateFormat(pattern).format(this);
    } catch (_) {
      return '';
    }
  }

  int daysBetween(DateTime to) {
    final dateFrom = DateTime(year, month, day);
    final dateTo = DateTime(to.year, to.month, to.day);
    return (dateTo.difference(dateFrom).inHours / 24).round();
  }

  String get dayMonth {
    try {
      return DateFormat(DateTimeFormat.ddMMM).format(this);
    } catch (_) {
      return '';
    }
  }
}
