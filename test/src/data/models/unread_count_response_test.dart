import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/unread_count_response.dart';

void main() {
  group('UnreadCountResponse', () {
    test('creates instance with count', () {
      const response = UnreadCountResponse(count: 5);

      expect(response.count, equals(5));
    });

    test('creates instance with zero count', () {
      const response = UnreadCountResponse(count: 0);

      expect(response.count, equals(0));
    });

    test('creates instance with large count', () {
      const response = UnreadCountResponse(count: 999);

      expect(response.count, equals(999));
    });

    test('fromJson creates instance correctly', () {
      final json = {'count': 10};

      final response = UnreadCountResponse.fromJson(json);

      expect(response.count, equals(10));
    });

    test('toJson serializes correctly', () {
      const response = UnreadCountResponse(count: 7);

      final json = response.toJson();

      expect(json, equals({'count': 7}));
    });

    test('fromJson handles zero count', () {
      final json = {'count': 0};

      final response = UnreadCountResponse.fromJson(json);

      expect(response.count, equals(0));
    });

    test('equality works correctly for same count', () {
      const response1 = UnreadCountResponse(count: 5);
      const response2 = UnreadCountResponse(count: 5);

      expect(response1, equals(response2));
    });

    test('equality works correctly for different count', () {
      const response1 = UnreadCountResponse(count: 5);
      const response2 = UnreadCountResponse(count: 10);

      expect(response1, isNot(equals(response2)));
    });

    test('copyWith updates count', () {
      const response = UnreadCountResponse(count: 5);

      final updated = response.copyWith(count: 10);

      expect(updated.count, equals(10));
      expect(response.count, equals(5));
    });

    test('copyWith with no parameters returns same values', () {
      const response = UnreadCountResponse(count: 5);

      final copied = response.copyWith();

      expect(copied.count, equals(5));
    });
  });
}
