/// Date helpers that ignore the time of day.
extension DateTimeX on DateTime {
  /// A copy with hours, minutes, seconds and milliseconds set to zero.
  DateTime get startOfDay => DateTime(year, month, day);

  /// Whether both values fall on the same calendar day.
  bool isSameDayAs(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

/// Returns midnight of the day containing [value].
DateTime startOfDay(DateTime value) => value.startOfDay;

/// Days between two dates, ignoring the time of day.
int daysBetween(DateTime from, DateTime to) =>
    to.startOfDay.difference(from.startOfDay).inDays;
