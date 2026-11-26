import 'package:intl/intl.dart';

import '../utils/date_time_x.dart';

/// User-facing date and interval formatting.
abstract final class Formatters {
  static final DateFormat _date = DateFormat.yMMMd();
  static final DateFormat _dateTime = DateFormat.yMMMd().add_jm();

  static String date(DateTime value) => _date.format(value);

  static String dateTime(DateTime value) => _dateTime.format(value);

  static String weekdayShort(DateTime value) => DateFormat.E().format(value);

  /// A short, human readable description of when a card is due.
  static String dueLabel(DateTime dueDate, {DateTime? now}) {
    final reference = (now ?? DateTime.now()).startOfDay;
    final due = dueDate.startOfDay;
    final difference = due.difference(reference).inDays;

    if (difference < 0) {
      return difference == -1 ? 'Due yesterday' : 'Due ${-difference} days ago';
    }
    if (difference == 0) {
      return 'Due today';
    }
    if (difference == 1) {
      return 'Due tomorrow';
    }
    return 'Due in $difference days';
  }

  static String days(int value) => value == 1 ? '1 day' : '$value days';

  static String cards(int value) => value == 1 ? '1 card' : '$value cards';
}
