import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/send_message_request.dart';

void main() {
  group('SendMessageRequest', () {
    test('should create from constructor', () {
      const request = SendMessageRequest(
        text: 'Hello World',
        username: 'John Doe',
        clientId: 'client123',
      );

      expect(request.text, 'Hello World');
      expect(request.username, 'John Doe');
      expect(request.clientId, 'client123');
    });

    test('should serialize to JSON', () {
      const request = SendMessageRequest(
        text: 'Hello World',
        username: 'John Doe',
        clientId: 'client123',
      );

      final json = request.toJson();

      expect(json['text'], 'Hello World');
      expect(json['username'], 'John Doe');
      expect(json['clientId'], 'client123');
    });

    test('should deserialize from JSON', () {
      final json = {
        'text': 'Hello World',
        'username': 'John Doe',
        'clientId': 'client123',
      };

      final request = SendMessageRequest.fromJson(json);

      expect(request.text, 'Hello World');
      expect(request.username, 'John Doe');
      expect(request.clientId, 'client123');
    });

    test('should support equality comparison', () {
      const request1 = SendMessageRequest(
        text: 'Hello World',
        username: 'John Doe',
        clientId: 'client123',
      );

      const request2 = SendMessageRequest(
        text: 'Hello World',
        username: 'John Doe',
        clientId: 'client123',
      );

      expect(request1, equals(request2));
    });

    test('should detect inequality', () {
      const request1 = SendMessageRequest(
        text: 'Hello World',
        username: 'John Doe',
        clientId: 'client123',
      );

      const request2 = SendMessageRequest(
        text: 'Different text',
        username: 'John Doe',
        clientId: 'client123',
      );

      expect(request1, isNot(equals(request2)));
    });

    test('should support copyWith', () {
      const request = SendMessageRequest(
        text: 'Hello World',
        username: 'John Doe',
        clientId: 'client123',
      );

      final updated = request.copyWith(text: 'Updated text');

      expect(updated.text, 'Updated text');
      expect(updated.username, 'John Doe');
      expect(updated.clientId, 'client123');
    });

    test('should handle empty text', () {
      const request = SendMessageRequest(
        text: '',
        username: 'John Doe',
        clientId: 'client123',
      );

      expect(request.text, '');
    });

    test('should handle long text', () {
      final longText = 'A' * 1000;
      final request = SendMessageRequest(
        text: longText,
        username: 'John Doe',
        clientId: 'client123',
      );

      expect(request.text.length, 1000);
    });

    test('should serialize and deserialize correctly', () {
      const original = SendMessageRequest(
        text: 'Test message',
        username: 'Test User',
        clientId: 'test-client-123',
      );

      final json = original.toJson();
      final restored = SendMessageRequest.fromJson(json);

      expect(restored, equals(original));
    });
  });
}
