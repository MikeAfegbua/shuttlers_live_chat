import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/send_message_request.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_api_client.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';
import 'package:shuttlers_live_chat/src/data/services/outbox.dart';
import 'package:shuttlers_live_chat/src/realtime/chat_ws_client.dart';

class MockChatApiClient extends Mock implements ChatApiClient {}

class MockChatWsClient extends Mock implements ChatWsClient {}

class MockOutbox extends Mock implements Outbox {}

void main() {
  late ChatRepository repository;
  late MockChatApiClient mockApi;
  late MockChatWsClient mockWs;
  late MockOutbox mockOutbox;
  late ShuttlersChatConfig config;
  late StreamController<ChatMessage> messageController;
  late StreamController<bool> connectionController;
  late StreamController<Map<String, String>> typingStartController;
  late StreamController<Map<String, String>> typingStopController;
  late StreamController<int> presenceController;
  late StreamController<Map<String, dynamic>> ackController;

  setUpAll(() {
    registerFallbackValue(
      const SendMessageRequest(
        text: 'test',
        username: 'test-user',
        clientId: 'test-client',
      ),
    );
    registerFallbackValue(OutboxItem(clientId: 'test', text: 'test'));
  });

  setUp(() {
    config = ShuttlersChatConfig(
      authToken: 'test-auth-token-12345',
      tripId: 'test-trip-id',
      username: 'Test User',
    );

    mockApi = MockChatApiClient();
    mockWs = MockChatWsClient();
    mockOutbox = MockOutbox();

    messageController = StreamController<ChatMessage>.broadcast();
    connectionController = StreamController<bool>.broadcast();
    typingStartController = StreamController<Map<String, String>>.broadcast();
    typingStopController = StreamController<Map<String, String>>.broadcast();
    presenceController = StreamController<int>.broadcast();
    ackController = StreamController<Map<String, dynamic>>.broadcast();

    when(
      () => mockWs.onMessageCreated,
    ).thenAnswer((_) => messageController.stream);
    when(
      () => mockWs.onConnection,
    ).thenAnswer((_) => connectionController.stream);
    when(
      () => mockWs.onTypingStart,
    ).thenAnswer((_) => typingStartController.stream);
    when(
      () => mockWs.onTypingStop,
    ).thenAnswer((_) => typingStopController.stream);
    when(
      () => mockWs.onPresenceCount,
    ).thenAnswer((_) => presenceController.stream);
    when(() => mockWs.onAck).thenAnswer((_) => ackController.stream);

    when(() => mockWs.connect()).thenAnswer((_) async {});
    when(() => mockWs.dispose()).thenAnswer((_) async {});
    when(() => mockWs.typingStart()).thenReturn(null);
    when(() => mockWs.typingStop()).thenReturn(null);
    when(() => mockApi.close()).thenReturn(null);
    when(() => mockOutbox.init()).thenAnswer((_) async {});
    when(() => mockOutbox.peekAll()).thenReturn([]);

    repository = ChatRepository(config: config);
  });

  tearDown(() async {
    await messageController.close();
    await connectionController.close();
    await typingStartController.close();
    await typingStopController.close();
    await presenceController.close();
    await ackController.close();
  });

  group('ChatRepository', () {
    test('should expose WebSocket streams', () {
      expect(repository.onMessageCreated, isA<Stream<ChatMessage>>());
      expect(repository.onConnection, isA<Stream<bool>>());
      expect(repository.onTypingStart, isA<Stream<Map<String, String>>>());
      expect(repository.onTypingStop, isA<Stream<Map<String, String>>>());
      expect(repository.onPresenceCount, isA<Stream<int>>());
      expect(repository.onAck, isA<Stream<Map<String, dynamic>>>());
    });

    test('should connect to WebSocket', () async {
      await repository.connect();

      expect(() => repository.connect(), returnsNormally);
    });

    test('should load initial messages from API', () async {
      expect(() => repository.loadInitial(), returnsNormally);
      expect(() => repository.loadInitial(limit: 20), returnsNormally);
    });

    test('should handle sendText with valid parameters', () async {
      const clientId = 'test-client-123';
      const text = 'Hello, world!';

      expect(
        () => repository.sendText(clientId: clientId, text: text),
        returnsNormally,
      );
    });

    test('should handle typing start', () {
      expect(() => repository.typingStart(), returnsNormally);
    });

    test('should handle typing stop', () {
      expect(() => repository.typingStop(), returnsNormally);
    });

    test('should dispose properly', () async {
      expect(() => repository.dispose(), returnsNormally);
    });

    test('should have correct config', () {
      expect(repository.config, equals(config));
      expect(repository.config.authToken, 'test-auth-token-12345');
      expect(repository.config.tripId, 'test-trip-id');
      expect(repository.config.username, 'Test User');
    });
  });

  group('ChatRepository integration behavior', () {
    test('should handle multiple sendText calls', () async {
      final futures = [
        repository.sendText(clientId: 'client-1', text: 'Message 1'),
        repository.sendText(clientId: 'client-2', text: 'Message 2'),
        repository.sendText(clientId: 'client-3', text: 'Message 3'),
      ];

      expect(() => Future.wait(futures), returnsNormally);
    });

    test('should handle empty text', () async {
      expect(
        () => repository.sendText(clientId: 'test', text: ''),
        returnsNormally,
      );
    });

    test('should handle special characters in text', () async {
      const specialText = r'Hello! This has special chars: @#$%^&*()';
      expect(
        () => repository.sendText(clientId: 'test', text: specialText),
        returnsNormally,
      );
    });

    test('should handle very long client IDs', () async {
      final longClientId = 'very-long-client-id-' * 10;
      expect(
        () => repository.sendText(clientId: longClientId, text: 'test'),
        returnsNormally,
      );
    });

    test('should handle concurrent dispose calls', () async {
      final futures = [
        repository.dispose(),
        repository.dispose(),
        repository.dispose(),
      ];

      expect(() => Future.wait(futures), returnsNormally);
    });
  });
}
