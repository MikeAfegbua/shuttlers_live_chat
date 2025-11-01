import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/ws_envelope.dart';

void main() {
  group('WsEnvelope', () {
    test('should create from constructor', () {
      const envelope = WsEnvelope(
        type: 'message.created',
        version: '1.0',
        payload: {'text': 'Hello'},
        ts: '2024-01-15T10:30:00Z',
        requestId: 'req123',
      );

      expect(envelope.type, 'message.created');
      expect(envelope.version, '1.0');
      expect(envelope.payload['text'], 'Hello');
      expect(envelope.ts, '2024-01-15T10:30:00Z');
      expect(envelope.requestId, 'req123');
      expect(envelope.error, isNull);
    });

    test('should create with minimal fields', () {
      const envelope = WsEnvelope(type: 'ping');

      expect(envelope.type, 'ping');
      expect(envelope.version, isNull);
      expect(envelope.payload, isEmpty);
      expect(envelope.ts, isNull);
      expect(envelope.requestId, isNull);
      expect(envelope.error, isNull);
    });

    test('should create with error', () {
      const error = WsError(
        code: 'INVALID_MESSAGE',
        message: 'Message validation failed',
        details: {'field': 'text'},
      );

      const envelope = WsEnvelope(
        type: 'error',
        error: error,
      );

      expect(envelope.error, isNotNull);
      expect(envelope.error!.code, 'INVALID_MESSAGE');
      expect(envelope.error!.message, 'Message validation failed');
    });

    test('should serialize to JSON', () {
      const envelope = WsEnvelope(
        type: 'message.created',
        version: '1.0',
        payload: {'text': 'Hello'},
      );

      final json = envelope.toJson();

      expect(json['type'], 'message.created');
      expect(json['version'], '1.0');
      expect(json['payload'], {'text': 'Hello'});
    });

    test('should deserialize from JSON', () {
      final json = {
        'type': 'message.created',
        'version': '1.0',
        'payload': {'text': 'Hello'},
        'ts': '2024-01-15T10:30:00Z',
        'requestId': 'req123',
      };

      final envelope = WsEnvelope.fromJson(json);

      expect(envelope.type, 'message.created');
      expect(envelope.version, '1.0');
      expect(envelope.payload['text'], 'Hello');
      expect(envelope.ts, '2024-01-15T10:30:00Z');
      expect(envelope.requestId, 'req123');
    });

    test('should support equality comparison', () {
      const envelope1 = WsEnvelope(
        type: 'ping',
        version: '1.0',
      );

      const envelope2 = WsEnvelope(
        type: 'ping',
        version: '1.0',
      );

      expect(envelope1, equals(envelope2));
    });
  });

  group('WsError', () {
    test('should create from constructor', () {
      const error = WsError(
        code: 'ERROR_CODE',
        message: 'Error message',
        details: {'key': 'value'},
      );

      expect(error.code, 'ERROR_CODE');
      expect(error.message, 'Error message');
      expect(error.details, {'key': 'value'});
    });

    test('should create without details', () {
      const error = WsError(
        code: 'ERROR_CODE',
        message: 'Error message',
      );

      expect(error.code, 'ERROR_CODE');
      expect(error.message, 'Error message');
      expect(error.details, isNull);
    });

    test('should serialize to JSON', () {
      const error = WsError(
        code: 'ERROR_CODE',
        message: 'Error message',
        details: {'key': 'value'},
      );

      final json = error.toJson();

      expect(json['code'], 'ERROR_CODE');
      expect(json['message'], 'Error message');
      expect(json['details'], {'key': 'value'});
    });

    test('should deserialize from JSON', () {
      final json = {
        'code': 'ERROR_CODE',
        'message': 'Error message',
        'details': {'key': 'value'},
      };

      final error = WsError.fromJson(json);

      expect(error.code, 'ERROR_CODE');
      expect(error.message, 'Error message');
      expect(error.details, {'key': 'value'});
    });
  });

  group('MessageCreatedPayload', () {
    test('should create from constructor', () {
      const payload = MessageCreatedPayload(
        id: 'msg1',
        clientId: 'client1',
        tripId: 'trip1',
        userId: 'user1',
        username: 'John',
        text: 'Hello',
        createdAt: '2024-01-15T10:30:00Z',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      expect(payload.id, 'msg1');
      expect(payload.clientId, 'client1');
      expect(payload.tripId, 'trip1');
      expect(payload.userId, 'user1');
      expect(payload.username, 'John');
      expect(payload.text, 'Hello');
      expect(payload.createdAt, '2024-01-15T10:30:00Z');
      expect(payload.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'msg1',
        'clientId': 'client1',
        'tripId': 'trip1',
        'userId': 'user1',
        'username': 'John',
        'text': 'Hello',
        'createdAt': '2024-01-15T10:30:00Z',
      };

      final payload = MessageCreatedPayload.fromJson(json);

      expect(payload.id, 'msg1');
      expect(payload.text, 'Hello');
    });
  });

  group('MessageAckPayload', () {
    test('should create from constructor', () {
      const payload = MessageAckPayload(
        clientId: 'client1',
        serverId: 'server1',
        status: 'delivered',
      );

      expect(payload.clientId, 'client1');
      expect(payload.serverId, 'server1');
      expect(payload.status, 'delivered');
    });

    test('should deserialize from JSON', () {
      final json = {
        'clientId': 'client1',
        'serverId': 'server1',
        'status': 'delivered',
      };

      final payload = MessageAckPayload.fromJson(json);

      expect(payload.clientId, 'client1');
      expect(payload.serverId, 'server1');
      expect(payload.status, 'delivered');
    });
  });

  group('TypingPayload', () {
    test('should create from constructor', () {
      const payload = TypingPayload(
        userId: 'user1',
        username: 'John',
      );

      expect(payload.userId, 'user1');
      expect(payload.username, 'John');
    });

    test('should deserialize from JSON', () {
      final json = {
        'userId': 'user1',
        'username': 'John',
      };

      final payload = TypingPayload.fromJson(json);

      expect(payload.userId, 'user1');
      expect(payload.username, 'John');
    });
  });

  group('PresencePayload', () {
    test('should create from constructor', () {
      const payload = PresencePayload(count: 5);

      expect(payload.count, 5);
    });

    test('should deserialize from JSON', () {
      final json = {'count': 10};

      final payload = PresencePayload.fromJson(json);

      expect(payload.count, 10);
    });
  });

  group('EmptyPayload', () {
    test('should create and serialize to empty JSON', () {
      const payload = EmptyPayload();
      final json = payload.toJson();

      expect(json, isEmpty);
    });
  });
}
