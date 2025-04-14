import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  DateTime get toFormattedDateTime {
    return DateTime.parse(toFormattedDateTimeString);
  }

  String get toFormattedDateTimeString {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
