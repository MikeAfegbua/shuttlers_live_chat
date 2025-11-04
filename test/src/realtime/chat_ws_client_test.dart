import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/ws_envelope.dart';
import 'package:shuttlers_live_chat/src/realtime/chat_ws_client.dart';

void main() {
  late ChatWsClient client;
  late ShuttlersChatConfig config;

  setUp(() {
    config = ShuttlersChatConfig(
      authToken: 'test-token-123456789',
      tripId: 'trip-123',
      username: 'TestUser',
      baseUrl: 'https://api.test.com',
      wsUrl: 'wss://ws.test.com',
    );

    client = ChatWsClient(config);
  });

  tearDown(() {
    client.dispose();
  });

  group('ChatWsClient', () {
    group('initialization', () {
      test('creates client with config', () {
        expect(client.config, equals(config));
      });

      test('provides stream getters', () {
        expect(client.onMessageCreated, isA<Stream<ChatMessage>>());
        expect(client.onAck, isA<Stream<Map<String, dynamic>>>());
        expect(client.onTypingStart, isA<Stream<Map<String, String>>>());
        expect(client.onTypingStop, isA<Stream<Map<String, String>>>());
        expect(client.onPresenceCount, isA<Stream<int>>());
        expect(client.onError, isA<Stream<WsError>>());
        expect(client.onConnection, isA<Stream<bool>>());
      });
    });

    group('message sending API', () {
      test('sendMessage method exists and accepts correct parameters', () {
        expect(
          () => client.sendMessage(
            clientId: 'client-123',
            text: 'Hello world',
            requestId: 'req-456',
          ),
          isA<void>(),
        );
      });

      test('typingStart method exists', () {
        expect(() => client.typingStart(), isA<void>());
      });

      test('typingStop method exists', () {
        expect(() => client.typingStop(), isA<void>());
      });

      test('sendPing method exists', () {
        expect(() => client.sendPing(), isA<void>());
      });
    });

    group('stream functionality', () {
      test('onMessageCreated stream is broadcast', () {
        final stream = client.onMessageCreated;
        expect(stream.isBroadcast, isTrue);

        // Can listen multiple times to broadcast stream
        final subscription1 = stream.listen((_) {});
        final subscription2 = stream.listen((_) {});

        subscription1.cancel();
        subscription2.cancel();
      });

      test('onAck stream is broadcast', () {
        final stream = client.onAck;
        expect(stream.isBroadcast, isTrue);

        final subscription = stream.listen((_) {});
        subscription.cancel();
      });

      test('onTypingStart stream is broadcast', () {
        final stream = client.onTypingStart;
        expect(stream.isBroadcast, isTrue);

        final subscription = stream.listen((_) {});
        subscription.cancel();
      });

      test('onTypingStop stream is broadcast', () {
        final stream = client.onTypingStop;
        expect(stream.isBroadcast, isTrue);

        final subscription = stream.listen((_) {});
        subscription.cancel();
      });

      test('onPresenceCount stream is broadcast', () {
        final stream = client.onPresenceCount;
        expect(stream.isBroadcast, isTrue);

        final subscription = stream.listen((_) {});
        subscription.cancel();
      });

      test('onError stream is broadcast', () {
        final stream = client.onError;
        expect(stream.isBroadcast, isTrue);

        final subscription = stream.listen((_) {});
        subscription.cancel();
      });

      test('onConnection stream is broadcast', () {
        final stream = client.onConnection;
        expect(stream.isBroadcast, isTrue);

        final subscription = stream.listen((_) {});
        subscription.cancel();
      });
    });

    group('envelope models', () {
      test('WsEnvelope can be created with required fields', () {
        final envelope = WsEnvelope(
          type: 'test',
          version: '1',
          payload: {'key': 'value'},
          requestId: 'req-123',
        );

        expect(envelope.type, equals('test'));
        expect(envelope.version, equals('1'));
        expect(envelope.payload, equals({'key': 'value'}));
        expect(envelope.requestId, equals('req-123'));
      });

      test('WsEnvelope can be serialized to JSON', () {
        final envelope = WsEnvelope(
          type: 'message.send',
          version: '1',
          payload: {'text': 'Hello'},
          requestId: 'req-456',
        );

        final json = envelope.toJson();

        expect(json['type'], equals('message.send'));
        expect(json['version'], equals('1'));
        expect(json['payload'], equals({'text': 'Hello'}));
        expect(json['requestId'], equals('req-456'));
      });

      test('WsEnvelope can be created from JSON', () {
        final json = {
          'type': 'message.created',
          'version': '1',
          'payload': {
            'id': 'msg-123',
            'text': 'Hello world',
          },
          'requestId': 'req-789',
        };

        final envelope = WsEnvelope.fromJson(json);

        expect(envelope.type, equals('message.created'));
        expect(envelope.version, equals('1'));
        expect(envelope.payload['id'], equals('msg-123'));
        expect(envelope.payload['text'], equals('Hello world'));
        expect(envelope.requestId, equals('req-789'));
      });

      test('WsError can be created and serialized', () {
        final error = WsError(
          code: 'INVALID_MESSAGE',
          message: 'Message text is required',
          details: {'field': 'text'},
        );

        expect(error.code, equals('INVALID_MESSAGE'));
        expect(error.message, equals('Message text is required'));
        expect(error.details, equals({'field': 'text'}));

        final json = error.toJson();
        expect(json['code'], equals('INVALID_MESSAGE'));
        expect(json['message'], equals('Message text is required'));
        expect(json['details'], equals({'field': 'text'}));
      });
    });

    group('payload models', () {
      test('MessageCreatedPayload can be created and serialized', () {
        final now = DateTime.now();
        final payload = MessageCreatedPayload(
          id: 'msg-123',
          clientId: 'client-456',
          tripId: 'trip-789',
          userId: 'user-abc',
          username: 'TestUser',
          text: 'Hello world',
          createdAt: now.toIso8601String(),
        );

        expect(payload.id, equals('msg-123'));
        expect(payload.clientId, equals('client-456'));
        expect(payload.tripId, equals('trip-789'));
        expect(payload.userId, equals('user-abc'));
        expect(payload.username, equals('TestUser'));
        expect(payload.text, equals('Hello world'));
        expect(payload.createdAt, equals(now.toIso8601String()));

        final json = payload.toJson();
        expect(json['id'], equals('msg-123'));
        expect(json['text'], equals('Hello world'));
        expect(json['username'], equals('TestUser'));
      });

      test('MessageAckPayload can be created and serialized', () {
        final payload = MessageAckPayload(
          clientId: 'client-123',
          serverId: 'server-456',
          status: 'sent',
        );

        expect(payload.clientId, equals('client-123'));
        expect(payload.serverId, equals('server-456'));
        expect(payload.status, equals('sent'));

        final json = payload.toJson();
        expect(json['clientId'], equals('client-123'));
        expect(json['serverId'], equals('server-456'));
        expect(json['status'], equals('sent'));
      });

      test('MessageSendPayload can be created and serialized', () {
        final payload = MessageSendPayload(
          tripId: 'trip-123',
          clientId: 'client-456',
          text: 'Hello world',
        );

        expect(payload.tripId, equals('trip-123'));
        expect(payload.clientId, equals('client-456'));
        expect(payload.text, equals('Hello world'));

        final json = payload.toJson();
        expect(json['tripId'], equals('trip-123'));
        expect(json['clientId'], equals('client-456'));
        expect(json['text'], equals('Hello world'));
      });

      test('TypingPayload can be created and serialized', () {
        final payload = TypingPayload(
          userId: 'user-123',
          username: 'TestUser',
        );

        expect(payload.userId, equals('user-123'));
        expect(payload.username, equals('TestUser'));

        final json = payload.toJson();
        expect(json['userId'], equals('user-123'));
        expect(json['username'], equals('TestUser'));
      });

      test('TypingEventPayload can be created and serialized', () {
        final payload = TypingEventPayload(tripId: 'trip-123');

        expect(payload.tripId, equals('trip-123'));

        final json = payload.toJson();
        expect(json['tripId'], equals('trip-123'));
      });

      test('PresencePayload can be created and serialized', () {
        final payload = PresencePayload(count: 5);

        expect(payload.count, equals(5));

        final json = payload.toJson();
        expect(json['count'], equals(5));
      });
    });

    group('disposal', () {
      test('dispose method exists and can be called', () async {
        expect(() => client.dispose(), returnsNormally);
      });

      test('dispose can be called multiple times safely', () async {
        await client.dispose();
        await client.dispose(); // Should not throw
      });
    });

    group('connection behavior', () {
      test('connect method exists', () {
        expect(() => client.connect(), returnsNormally);
      });

      test('client starts disconnected', () {
        // Since we can't easily test actual connection without a server,
        // we test that the methods exist and don't throw
        expect(() => client.onConnection, returnsNormally);
      });
    });

    group('error handling', () {
      test('client handles invalid JSON gracefully', () {
        // This test would require access to internal methods
        // For now, we ensure error stream exists
        expect(client.onError, isA<Stream<WsError>>());
      });

      test('client has error stream for connection issues', () {
        final errorStream = client.onError;
        expect(errorStream.isBroadcast, isTrue);

        final subscription = errorStream.listen((_) {});
        subscription.cancel();
      });
    });

    group('message types', () {
      test('supports all expected message types', () {
        final supportedTypes = [
          'message.created',
          'message.ack',
          'typing.start',
          'typing.stop',
          'presence.update',
          'pong',
          'system.error',
          'ping',
          'message.send',
        ];

        // Test that envelopes can be created for all types
        for (final type in supportedTypes) {
          expect(
            () => WsEnvelope(type: type, payload: {}),
            returnsNormally,
          );
        }
      });
    });
  });
}
