import 'package:intl/intl.dart';

extension DateTimeFormatters on DateTime {
  String formatTime() {
    return DateFormat('h:mm a').format(this);
  }

  String formatDateHeader() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(year, month, day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d').format(this);
    }
  }

  bool isSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

bool shouldShowDateHeader(int index, List<dynamic> messages) {
  if (index == 0) return true;

  final current = (messages[index] as dynamic).createdAt as DateTime;
  final previous = (messages[index - 1] as dynamic).createdAt as DateTime;

  return !current.isSameDayAs(previous);
}
