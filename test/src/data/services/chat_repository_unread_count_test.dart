import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';

class FakeUri extends Fake implements Uri {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  group('ChatRepository - Unread Count Polling', () {
    test('exposes onUnreadCountChanged stream', () async {
      final config = ShuttlersChatConfig(
        tripId: 'trip_123',
        username: 'testuser',
        authToken: 'test_token_12345',
      );

      final repository = ChatRepository(config: config);

      expect(repository.onUnreadCountChanged, isA<Stream<int>>());

      await repository.dispose();
    });

    test('getUnreadCount returns 0 on API error', () async {
      final config = ShuttlersChatConfig(
        tripId: 'trip_123',
        username: 'testuser',
        authToken: 'test_token_12345',
        baseUrl: 'https://invalid-url-that-will-fail.example.com',
      );

      final repository = ChatRepository(config: config);

      final count = await repository.getUnreadCount();

      expect(count, equals(0));

      await repository.dispose();
    });

    test('onUnreadCountChanged stream can be listened to', () async {
      final config = ShuttlersChatConfig(
        tripId: 'trip_123',
        username: 'testuser',
        authToken: 'test_token_12345',
      );

      final repository = ChatRepository(config: config);

      final counts = <int>[];
      final subscription = repository.onUnreadCountChanged.listen(counts.add);

      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(counts, isNotEmpty);

      await subscription.cancel();
      await repository.dispose();
    });

    test('stream emits done after dispose', () async {
      final config = ShuttlersChatConfig(
        tripId: 'trip_123',
        username: 'testuser',
        authToken: 'test_token_12345',
      );

      final repository = ChatRepository(config: config);

      await Future<void>.delayed(const Duration(milliseconds: 100));

      await repository.dispose();

      expect(
        repository.onUnreadCountChanged,
        emitsDone,
      );
    });

    test('multiple listeners can subscribe to unread count stream', () async {
      final config = ShuttlersChatConfig(
        tripId: 'trip_123',
        username: 'testuser',
        authToken: 'test_token_12345',
      );

      final repository = ChatRepository(config: config);

      final counts1 = <int>[];
      final counts2 = <int>[];

      final sub1 = repository.onUnreadCountChanged.listen(counts1.add);
      final sub2 = repository.onUnreadCountChanged.listen(counts2.add);

      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(counts1, isNotEmpty);
      expect(counts2, isNotEmpty);
      expect(counts1, equals(counts2));

      await sub1.cancel();
      await sub2.cancel();
      await repository.dispose();
    });
  });
}
