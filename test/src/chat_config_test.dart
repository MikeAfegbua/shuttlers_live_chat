import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';

void main() {
  group('ShuttlersChatConfig', () {
    test('should create with required parameters', () {
      final config = ShuttlersChatConfig(
        authToken: 'valid_token_12345',
        tripId: 'trip123',
        username: 'John Doe',
      );

      expect(config.authToken, 'valid_token_12345');
      expect(config.tripId, 'trip123');
      expect(config.username, 'John Doe');
      expect(config.avatarUrl, isNull);
      expect(config.baseUrl, 'https://realtime.chat.qa.onshuttlers.com');
      expect(config.wsUrl, 'wss://realtime.chat.qa.onshuttlers.com/ws');
    });

    test('should create with custom URLs', () {
      final config = ShuttlersChatConfig(
        authToken: 'valid_token_12345',
        tripId: 'trip123',
        username: 'John Doe',
        baseUrl: 'https://custom.api.com',
        wsUrl: 'wss://custom.ws.com',
      );

      expect(config.baseUrl, 'https://custom.api.com');
      expect(config.wsUrl, 'wss://custom.ws.com');
    });

    test('should create with avatar URL', () {
      final config = ShuttlersChatConfig(
        authToken: 'valid_token_12345',
        tripId: 'trip123',
        username: 'John Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      expect(config.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should throw assertion error for short authToken', () {
      expect(
        () => ShuttlersChatConfig(
          authToken: 'short',
          tripId: 'trip123',
          username: 'John Doe',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should throw assertion error for empty tripId', () {
      expect(
        () => ShuttlersChatConfig(
          authToken: 'valid_token_12345',
          tripId: '',
          username: 'John Doe',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should throw assertion error for empty username', () {
      expect(
        () => ShuttlersChatConfig(
          authToken: 'valid_token_12345',
          tripId: 'trip123',
          username: '',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should support copyWith', () {
      final config = ShuttlersChatConfig(
        authToken: 'valid_token_12345',
        tripId: 'trip123',
        username: 'John Doe',
      );

      final updated = config.copyWith(username: 'Jane Doe');

      expect(updated.authToken, 'valid_token_12345');
      expect(updated.tripId, 'trip123');
      expect(updated.username, 'Jane Doe');
    });

    test('should support copyWith for all fields', () {
      final config = ShuttlersChatConfig(
        authToken: 'valid_token_12345',
        tripId: 'trip123',
        username: 'John Doe',
      );

      final updated = config.copyWith(
        authToken: 'new_token_67890',
        tripId: 'trip456',
        username: 'Jane Doe',
        avatarUrl: 'https://example.com/new.jpg',
        baseUrl: 'https://new.api.com',
        wsUrl: 'wss://new.ws.com',
      );

      expect(updated.authToken, 'new_token_67890');
      expect(updated.tripId, 'trip456');
      expect(updated.username, 'Jane Doe');
      expect(updated.avatarUrl, 'https://example.com/new.jpg');
      expect(updated.baseUrl, 'https://new.api.com');
      expect(updated.wsUrl, 'wss://new.ws.com');
    });

    test('should preserve original values when copyWith with null', () {
      final config = ShuttlersChatConfig(
        authToken: 'valid_token_12345',
        tripId: 'trip123',
        username: 'John Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      final updated = config.copyWith();

      expect(updated.authToken, config.authToken);
      expect(updated.tripId, config.tripId);
      expect(updated.username, config.username);
      expect(updated.avatarUrl, config.avatarUrl);
      expect(updated.baseUrl, config.baseUrl);
      expect(updated.wsUrl, config.wsUrl);
    });
  });
}
