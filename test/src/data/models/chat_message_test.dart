import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('should create from constructor', () {
      final createdAt = DateTime(2024, 1, 15, 10, 30);
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: createdAt,
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      expect(message.id, 'msg1');
      expect(message.clientId, 'client1');
      expect(message.tripId, 'trip1');
      expect(message.userId, 'user1');
      expect(message.username, 'John Doe');
      expect(message.text, 'Hello World');
      expect(message.createdAt, createdAt);
      expect(message.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should create without avatarUrl', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: DateTime.now(),
      );

      expect(message.avatarUrl, isNull);
    });

    test('should serialize to JSON', () {
      final createdAt = DateTime(2024, 1, 15, 10, 30);
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: createdAt,
      );

      final json = message.toJson();

      expect(json['id'], 'msg1');
      expect(json['clientId'], 'client1');
      expect(json['tripId'], 'trip1');
      expect(json['userId'], 'user1');
      expect(json['username'], 'John Doe');
      expect(json['text'], 'Hello World');
      expect(json['createdAt'], isNotNull);
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'msg1',
        'clientId': 'client1',
        'tripId': 'trip1',
        'userId': 'user1',
        'username': 'John Doe',
        'text': 'Hello World',
        'createdAt': '2024-01-15T10:30:00.000',
        'avatarUrl': 'https://example.com/avatar.jpg',
      };

      final message = ChatMessage.fromJson(json);

      expect(message.id, 'msg1');
      expect(message.clientId, 'client1');
      expect(message.tripId, 'trip1');
      expect(message.userId, 'user1');
      expect(message.username, 'John Doe');
      expect(message.text, 'Hello World');
      expect(message.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should support equality comparison', () {
      final createdAt = DateTime(2024, 1, 15, 10, 30);
      final message1 = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: createdAt,
      );

      final message2 = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: createdAt,
      );

      expect(message1, equals(message2));
    });

    test('should detect inequality', () {
      final createdAt = DateTime(2024, 1, 15, 10, 30);
      final message1 = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: createdAt,
      );

      final message2 = ChatMessage(
        id: 'msg2',
        clientId: 'client2',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: createdAt,
      );

      expect(message1, isNot(equals(message2)));
    });

    test('should support copyWith', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John Doe',
        text: 'Hello World',
        createdAt: DateTime.now(),
      );

      final updated = message.copyWith(text: 'Updated text');

      expect(updated.id, message.id);
      expect(updated.text, 'Updated text');
    });
  });
}
