import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/ui/utils/date_formatters.dart';

void main() {
  group('DateTimeFormatters', () {
    test('formatTime should return 12-hour format with AM/PM', () {
      final morning = DateTime(2024, 1, 15, 9, 30);
      expect(morning.formatTime(), '9:30 AM');

      final afternoon = DateTime(2024, 1, 15, 14, 45);
      expect(afternoon.formatTime(), '2:45 PM');

      final midnight = DateTime(2024, 1, 15, 0);
      expect(midnight.formatTime(), '12:00 AM');

      final noon = DateTime(2024, 1, 15, 12);
      expect(noon.formatTime(), '12:00 PM');
    });

    test('formatDateHeader should return "Today" for today\'s date', () {
      final now = DateTime.now();
      expect(now.formatDateHeader(), 'Today');
    });

    test(
      'formatDateHeader should return "Yesterday" for yesterday\'s date',
      () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(yesterday.formatDateHeader(), 'Yesterday');
      },
    );

    test('formatDateHeader should return formatted date for older dates', () {
      final oldDate = DateTime(2024, 1, 15);
      final formatted = oldDate.formatDateHeader();
      expect(
        formatted,
        matches(RegExp(r'^[A-Z][a-z]{2} \d{1,2}$')),
      ); // e.g., "Jan 15"
    });

    test('isSameDayAs should return true for same day', () {
      final date1 = DateTime(2024, 1, 15, 9, 30);
      final date2 = DateTime(2024, 1, 15, 18, 45);

      expect(date1.isSameDayAs(date2), isTrue);
    });

    test('isSameDayAs should return false for different days', () {
      final date1 = DateTime(2024, 1, 15, 23, 59);
      final date2 = DateTime(2024, 1, 16, 0, 1);

      expect(date1.isSameDayAs(date2), isFalse);
    });

    test('isSameDayAs should return false for different months', () {
      final date1 = DateTime(2024, 1, 31);
      final date2 = DateTime(2024, 2);

      expect(date1.isSameDayAs(date2), isFalse);
    });

    test('isSameDayAs should return false for different years', () {
      final date1 = DateTime(2023, 12, 31);
      final date2 = DateTime(2024, 1);

      expect(date1.isSameDayAs(date2), isFalse);
    });
  });

  group('shouldShowDateHeader', () {
    test('should return true for first message', () {
      final messages = [
        _MockMessage(DateTime(2024, 1, 15, 10)),
      ];

      expect(shouldShowDateHeader(0, messages), isTrue);
    });

    test('should return true when date changes', () {
      final messages = [
        _MockMessage(DateTime(2024, 1, 14, 23, 59)),
        _MockMessage(DateTime(2024, 1, 15, 0, 1)),
      ];

      expect(shouldShowDateHeader(1, messages), isTrue);
    });

    test('should return false when date is same as previous', () {
      final messages = [
        _MockMessage(DateTime(2024, 1, 15, 10)),
        _MockMessage(DateTime(2024, 1, 15, 14, 30)),
      ];

      expect(shouldShowDateHeader(1, messages), isFalse);
    });

    test('should handle multiple messages across different days', () {
      final messages = [
        _MockMessage(DateTime(2024, 1, 13, 10)),
        _MockMessage(DateTime(2024, 1, 13, 14, 30)),
        _MockMessage(DateTime(2024, 1, 14, 9)),
        _MockMessage(DateTime(2024, 1, 14, 15)),
        _MockMessage(DateTime(2024, 1, 15, 11)),
      ];

      expect(shouldShowDateHeader(0, messages), isTrue);
      expect(shouldShowDateHeader(1, messages), isFalse);
      expect(shouldShowDateHeader(2, messages), isTrue);
      expect(
        shouldShowDateHeader(3, messages),
        isFalse,
      );
      expect(shouldShowDateHeader(4, messages), isTrue);
    });
  });
}

class _MockMessage {
  _MockMessage(this.createdAt);
  final DateTime createdAt;
}
