import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/paged_messages_response.dart';

void main() {
  group('PagedMessagesResponse', () {
    test('should create from constructor', () {
      final message1 = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final message2 = ChatMessage(
        id: 'msg2',
        clientId: 'client2',
        tripId: 'trip1',
        userId: 'user2',
        username: 'Jane',
        text: 'Hi',
        createdAt: DateTime.now(),
      );

      final response = PagedMessagesResponse(
        messages: [message1, message2],
        nextCursor: 'cursor123',
      );

      expect(response.messages.length, 2);
      expect(response.nextCursor, 'cursor123');
    });

    test('should create without nextCursor', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final response = PagedMessagesResponse(messages: [message]);

      expect(response.messages.length, 1);
      expect(response.nextCursor, isNull);
    });

    test('should create with empty messages list', () {
      const response = PagedMessagesResponse(messages: []);

      expect(response.messages, isEmpty);
      expect(response.nextCursor, isNull);
    });

    test('should serialize to JSON', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final response = PagedMessagesResponse(
        messages: [message],
        nextCursor: 'cursor123',
      );

      final json = response.toJson();

      expect(json['messages'], isA<List<dynamic>>());
      expect((json['messages'] as List).length, 1);
      expect(json['nextCursor'], 'cursor123');
    });

    test('should deserialize from JSON', () {
      final json = {
        'messages': [
          {
            'id': 'msg1',
            'clientId': 'client1',
            'tripId': 'trip1',
            'userId': 'user1',
            'username': 'John',
            'text': 'Hello',
            'createdAt': '2024-01-15T10:30:00.000',
          },
        ],
        'nextCursor': 'cursor123',
      };

      final response = PagedMessagesResponse.fromJson(json);

      expect(response.messages.length, 1);
      expect(response.messages.first.id, 'msg1');
      expect(response.nextCursor, 'cursor123');
    });

    test('should support equality comparison', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final response1 = PagedMessagesResponse(
        messages: [message],
        nextCursor: 'cursor123',
      );

      final response2 = PagedMessagesResponse(
        messages: [message],
        nextCursor: 'cursor123',
      );

      expect(response1, equals(response2));
    });

    test('should detect inequality', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final response1 = PagedMessagesResponse(
        messages: [message],
        nextCursor: 'cursor123',
      );

      final response2 = PagedMessagesResponse(
        messages: [message],
        nextCursor: 'cursor456',
      );

      expect(response1, isNot(equals(response2)));
    });

    test('should support copyWith', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final response = PagedMessagesResponse(
        messages: [message],
        nextCursor: 'cursor123',
      );

      final updated = response.copyWith(nextCursor: 'cursor456');

      expect(updated.messages.length, 1);
      expect(updated.nextCursor, 'cursor456');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'messages': [
          {
            'id': 'msg1',
            'clientId': 'client1',
            'tripId': 'trip1',
            'userId': 'user1',
            'username': 'John',
            'text': 'Hello',
            'createdAt': '2024-01-15T10:30:00.000',
          },
        ],
        'nextCursor': 'cursor123',
      };

      final response = PagedMessagesResponse.fromJson(json);

      expect(response.messages.length, 1);
      expect(response.messages.first.id, 'msg1');
      expect(response.messages.first.text, 'Hello');
      expect(response.nextCursor, 'cursor123');
    });

    test('should handle multiple messages', () {
      final messages = List.generate(
        10,
        (i) => ChatMessage(
          id: 'msg$i',
          clientId: 'client$i',
          tripId: 'trip1',
          userId: 'user$i',
          username: 'User $i',
          text: 'Message $i',
          createdAt: DateTime.now(),
        ),
      );

      final response = PagedMessagesResponse(
        messages: messages,
        nextCursor: 'cursor123',
      );

      expect(response.messages.length, 10);
    });
  });
}
