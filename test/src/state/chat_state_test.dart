import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/state/chat_state.dart';

void main() {
  group('ChatState', () {
    test('should create with default values', () {
      const state = ChatState();

      expect(state.connected, false);
      expect(state.messages, isEmpty);
      expect(state.loading, false);
      expect(state.error, isNull);
      expect(state.presenceCount, 0);
      expect(state.typingUsers, isEmpty);
      expect(state.deliveryByClientId, isEmpty);
      expect(state.seenClientIds, isEmpty);
    });

    test('should create with custom values', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final state = ChatState(
        connected: true,
        messages: [message],
        loading: true,
        error: 'Connection failed',
        presenceCount: 5,
        typingUsers: {'user1', 'user2'},
        deliveryByClientId: {'client1': 'delivered'},
        seenClientIds: {'client1'},
      );

      expect(state.connected, true);
      expect(state.messages.length, 1);
      expect(state.loading, true);
      expect(state.error, 'Connection failed');
      expect(state.presenceCount, 5);
      expect(state.typingUsers, {'user1', 'user2'});
      expect(state.deliveryByClientId, {'client1': 'delivered'});
      expect(state.seenClientIds, {'client1'});
    });

    test('should support copyWith', () {
      const state = ChatState();
      final updated = state.copyWith(connected: true, presenceCount: 3);

      expect(updated.connected, true);
      expect(updated.presenceCount, 3);
      expect(updated.messages, isEmpty);
      expect(updated.loading, false);
    });

    test('should support copyWith for messages', () {
      const state = ChatState();
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final updated = state.copyWith(messages: [message]);

      expect(updated.messages.length, 1);
      expect(updated.messages.first.id, 'msg1');
    });

    test('should support copyWith for error', () {
      const state = ChatState();
      final updated = state.copyWith(error: 'Network error');

      expect(updated.error, 'Network error');
    });

    test('should support copyWith for typing users', () {
      const state = ChatState();
      final updated = state.copyWith(typingUsers: {'user1', 'user2'});

      expect(updated.typingUsers, {'user1', 'user2'});
    });

    test('should support copyWith for delivery status', () {
      const state = ChatState();
      final updated = state.copyWith(
        deliveryByClientId: {'client1': 'sent', 'client2': 'delivered'},
      );

      expect(updated.deliveryByClientId['client1'], 'sent');
      expect(updated.deliveryByClientId['client2'], 'delivered');
    });

    test('should support equality comparison', () {
      const state1 = ChatState(connected: true, presenceCount: 5);
      const state2 = ChatState(connected: true, presenceCount: 5);

      expect(state1, equals(state2));
    });

    test('should detect inequality', () {
      const state1 = ChatState(connected: true, presenceCount: 5);
      const state2 = ChatState(presenceCount: 5);

      expect(state1, isNot(equals(state2)));
    });

    test('should be immutable', () {
      final message = ChatMessage(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: DateTime.now(),
      );

      final state = ChatState(messages: [message]);
      final originalLength = state.messages.length;

      final updated = state.copyWith(
        messages: [...state.messages, message.copyWith(id: 'msg2')],
      );

      expect(state.messages.length, originalLength);
      expect(updated.messages.length, 2);
    });

    test('should handle multiple typing users', () {
      const state = ChatState();
      final updated = state.copyWith(
        typingUsers: {'user1', 'user2', 'user3'},
      );

      expect(updated.typingUsers.length, 3);
      expect(updated.typingUsers.contains('user1'), true);
      expect(updated.typingUsers.contains('user2'), true);
      expect(updated.typingUsers.contains('user3'), true);
    });

    test('should handle seen client IDs', () {
      const state = ChatState();
      final updated = state.copyWith(
        seenClientIds: {'client1', 'client2'},
      );

      expect(updated.seenClientIds.length, 2);
      expect(updated.seenClientIds.contains('client1'), true);
      expect(updated.seenClientIds.contains('client2'), true);
    });
  });
}
