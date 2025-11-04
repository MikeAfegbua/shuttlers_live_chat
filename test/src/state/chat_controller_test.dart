import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';
import 'package:shuttlers_live_chat/src/state/providers.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockRepo;
  late ProviderContainer container;
  late StreamController<ChatMessage> messageController;
  late StreamController<bool> connectionController;
  late StreamController<Map<String, String>> typingStartController;
  late StreamController<Map<String, String>> typingStopController;
  late StreamController<int> presenceController;
  late StreamController<Map<String, dynamic>> ackController;

  setUpAll(() {
    registerFallbackValue(
      ShuttlersChatConfig(
        authToken: 'test-token-123456789', // Needs to be > 10 chars
        tripId: 'test-trip',
        username: 'Test User',
      ),
    );
  });

  setUp(() {
    mockRepo = MockChatRepository();
    messageController = StreamController<ChatMessage>.broadcast();
    connectionController = StreamController<bool>.broadcast();
    typingStartController = StreamController<Map<String, String>>.broadcast();
    typingStopController = StreamController<Map<String, String>>.broadcast();
    presenceController = StreamController<int>.broadcast();
    ackController = StreamController<Map<String, dynamic>>.broadcast();

    // Setup mock streams
    when(
      () => mockRepo.onMessageCreated,
    ).thenAnswer((_) => messageController.stream);
    when(
      () => mockRepo.onConnection,
    ).thenAnswer((_) => connectionController.stream);
    when(
      () => mockRepo.onTypingStart,
    ).thenAnswer((_) => typingStartController.stream);
    when(
      () => mockRepo.onTypingStop,
    ).thenAnswer((_) => typingStopController.stream);
    when(
      () => mockRepo.onPresenceCount,
    ).thenAnswer((_) => presenceController.stream);
    when(() => mockRepo.onAck).thenAnswer((_) => ackController.stream);

    // Setup mock config
    when(() => mockRepo.config).thenReturn(
      ShuttlersChatConfig(
        authToken: 'test-token-123456789', // Needs to be > 10 chars
        tripId: 'test-trip',
        username: 'Test User',
      ),
    );

    // Setup mock methods
    when(() => mockRepo.connect()).thenAnswer((_) async {});
    when(() => mockRepo.loadInitial()).thenAnswer((_) async => []);
    when(() => mockRepo.dispose()).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        chatRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await messageController.close();
    await connectionController.close();
    await typingStartController.close();
    await typingStopController.close();
    await presenceController.close();
    await ackController.close();
  });

  group('ChatController', () {
    test('should initialize with loading state', () async {
      // Wait for initial build to complete
      await container.read(chatControllerProvider.future);

      verify(() => mockRepo.connect()).called(1);
      verify(() => mockRepo.loadInitial()).called(1);
    });

    test('should load initial messages and sort them by date', () async {
      final message1 = ChatMessage(
        id: '1',
        clientId: 'client-1',
        tripId: 'test-trip',
        userId: 'user-1',
        username: 'User 1',
        text: 'First message',
        createdAt: DateTime.parse('2024-01-01T10:00:00Z'),
      );

      final message2 = ChatMessage(
        id: '2',
        clientId: 'client-2',
        tripId: 'test-trip',
        userId: 'user-2',
        username: 'User 2',
        text: 'Second message',
        createdAt: DateTime.parse('2024-01-01T09:00:00Z'),
      );

      when(
        () => mockRepo.loadInitial(),
      ).thenAnswer((_) async => [message1, message2]);

      final state = await container.read(chatControllerProvider.future);

      expect(state.messages.length, 2);
      expect(state.messages[0].id, '2'); // Earlier message first
      expect(state.messages[1].id, '1'); // Later message second
      expect(state.seenClientIds, {'client-1', 'client-2'});
    });

    test('should handle connection status changes', () async {
      await container.read(chatControllerProvider.future);

      connectionController.add(true);
      // Wait for the stream to be processed
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final state = container.read(chatControllerProvider).value!;
      expect(state.connected, true);

      connectionController.add(false);
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final state2 = container.read(chatControllerProvider).value!;
      expect(state2.connected, false);
    });

    test('should handle presence count updates', () async {
      await container.read(chatControllerProvider.future);

      presenceController.add(5);
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.presenceCount, 5);
    });

    test('should handle typing start events', () async {
      await container.read(chatControllerProvider.future);

      typingStartController.add({'username': 'Other User'});
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.typingUsers, {'Other User'});
    });

    test('should ignore typing start events from current user', () async {
      await container.read(chatControllerProvider.future);

      typingStartController.add({'username': 'Test User'});
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.typingUsers, isEmpty);
    });

    test('should handle typing stop events', () async {
      await container.read(chatControllerProvider.future);

      // Start typing
      typingStartController.add({'username': 'Other User'});
      await Future<void>.delayed(Duration.zero);

      // Stop typing
      typingStopController.add({'username': 'Other User'});
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.typingUsers, isEmpty);
    });

    test('should handle message acknowledgements', () async {
      await container.read(chatControllerProvider.future);

      ackController.add({'clientId': 'test-client', 'status': 'delivered'});
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.deliveryByClientId['test-client'], 'delivered');
    });

    test('should handle new incoming messages', () async {
      await container.read(chatControllerProvider.future);

      final newMessage = ChatMessage(
        id: 'new-1',
        clientId: 'new-client',
        tripId: 'test-trip',
        userId: 'other-user',
        username: 'Other User',
        text: 'New message',
        createdAt: DateTime.now().toUtc(),
      );

      messageController.add(newMessage);
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.messages, contains(newMessage));
      expect(state.seenClientIds, contains('new-client'));
      expect(state.deliveryByClientId['new-client'], 'delivered');
    });

    test(
      'should update existing message when receiving duplicate clientId',
      () async {
        // Set up initial message
        final initialMessage = ChatMessage(
          id: 'temp-1',
          clientId: 'client-1',
          tripId: 'test-trip',
          userId: 'test-user',
          username: 'Test User',
          text: 'Initial text',
          createdAt: DateTime.now().toUtc(),
        );

        when(
          () => mockRepo.loadInitial(),
        ).thenAnswer((_) async => [initialMessage]);
        await container.read(chatControllerProvider.future);

        // Send updated message with same clientId
        final updatedMessage = ChatMessage(
          id: 'real-1',
          clientId: 'client-1',
          tripId: 'test-trip',
          userId: 'test-user',
          username: 'Test User',
          text: 'Updated text',
          createdAt: DateTime.now().toUtc(),
        );

        messageController.add(updatedMessage);
        await Future<void>.delayed(Duration.zero);

        final state = container.read(chatControllerProvider).value!;
        expect(state.messages.length, 1);
        expect(state.messages[0].text, 'Updated text');
        expect(state.messages[0].id, 'real-1');
      },
    );

    test('should remove typing indicator when user sends message', () async {
      await container.read(chatControllerProvider.future);

      // Start typing
      typingStartController.add({'username': 'Other User'});
      await Future<void>.delayed(Duration.zero);

      // Send message from typing user
      final message = ChatMessage(
        id: '1',
        clientId: 'client-1',
        tripId: 'test-trip',
        userId: 'other-user',
        username: 'Other User',
        text: 'Hello',
        createdAt: DateTime.now().toUtc(),
      );

      messageController.add(message);
      await Future<void>.delayed(Duration.zero);

      final state = container.read(chatControllerProvider).value!;
      expect(state.typingUsers, isEmpty);
    });

    group('send message', () {
      test(
        'should create optimistic message and update delivery status',
        () async {
          when(
            () => mockRepo.sendText(
              clientId: any(named: 'clientId'),
              text: any(named: 'text'),
            ),
          ).thenAnswer((_) async => null);

          await container.read(chatControllerProvider.future);
          final notifier = container.read(chatControllerProvider.notifier);

          await notifier.send('test-client', 'Hello world');

          final state = container.read(chatControllerProvider).value!;
          expect(state.messages.any((m) => m.clientId == 'test-client'), true);
          expect(state.deliveryByClientId['test-client'], 'sent');
          expect(state.seenClientIds, contains('test-client'));

          verify(
            () =>
                mockRepo.sendText(clientId: 'test-client', text: 'Hello world'),
          ).called(1);
        },
      );

      test('should handle send failure and update delivery status', () async {
        when(
          () => mockRepo.sendText(
            clientId: any(named: 'clientId'),
            text: any(named: 'text'),
          ),
        ).thenThrow(Exception('Network error'));

        await container.read(chatControllerProvider.future);
        final notifier = container.read(chatControllerProvider.notifier);

        await notifier.send('test-client', 'Hello world');

        final state = container.read(chatControllerProvider).value!;
        expect(state.deliveryByClientId['test-client'], 'failed');
        expect(state.error, 'Exception: Network error');
      });

      test(
        'should preserve delivery status during optimistic updates',
        () async {
          // First set up an existing delivery status
          await container.read(chatControllerProvider.future);
          ackController.add({'clientId': 'existing-client', 'status': 'sent'});
          await Future<void>.delayed(Duration.zero);

          when(
            () => mockRepo.sendText(
              clientId: any(named: 'clientId'),
              text: any(named: 'text'),
            ),
          ).thenAnswer((_) async => null);

          final notifier = container.read(chatControllerProvider.notifier);
          await notifier.send('new-client', 'Hello');

          final state = container.read(chatControllerProvider).value!;
          expect(state.deliveryByClientId['existing-client'], 'sent');
          expect(state.deliveryByClientId['new-client'], 'sent');
        },
      );
    });

    test(
      'should calculate presence count from active users when no presence events received',
      () async {
        when(() => mockRepo.loadInitial()).thenAnswer((_) async => []);

        await container.read(chatControllerProvider.future);

        // Add messages from different users (should track active users)
        final message1 = ChatMessage(
          id: '1',
          clientId: 'client-1',
          tripId: 'test-trip',
          userId: 'user-1',
          username: 'User 1',
          text: 'Hello',
          createdAt: DateTime.now().toUtc(),
        );

        final message2 = ChatMessage(
          id: '2',
          clientId: 'client-2',
          tripId: 'test-trip',
          userId: 'user-2',
          username: 'User 2',
          text: 'Hi',
          createdAt: DateTime.now().toUtc(),
        );

        messageController.add(message1);
        await Future<void>.delayed(Duration.zero);
        messageController.add(message2);
        await Future<void>.delayed(Duration.zero);

        final state = container.read(chatControllerProvider).value!;
        expect(state.presenceCount, 3); // 2 other users + current user
      },
    );

    test(
      'should use presence events over calculated count when available',
      () async {
        await container.read(chatControllerProvider.future);

        // Send presence event
        presenceController.add(10);
        await Future<void>.delayed(Duration.zero);

        // Add message from new user (should not affect count)
        final message = ChatMessage(
          id: '1',
          clientId: 'client-1',
          tripId: 'test-trip',
          userId: 'user-1',
          username: 'User 1',
          text: 'Hello',
          createdAt: DateTime.now().toUtc(),
        );

        messageController.add(message);
        await Future<void>.delayed(Duration.zero);

        final state = container.read(chatControllerProvider).value!;
        expect(
          state.presenceCount,
          10,
        ); // Should use presence event, not calculated
      },
    );

    test('should dispose properly', () async {
      await container.read(chatControllerProvider.future);
      final notifier = container.read(chatControllerProvider.notifier);

      await notifier.dispose();

      verify(() => mockRepo.dispose()).called(1);
    });
  });
}
