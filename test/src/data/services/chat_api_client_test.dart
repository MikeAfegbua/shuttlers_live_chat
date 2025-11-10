import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/paged_messages_response.dart';
import 'package:shuttlers_live_chat/src/data/models/send_message_request.dart';
import 'package:shuttlers_live_chat/src/data/models/unread_count_response.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockHttp;
  late ChatApiClient client;
  late ShuttlersChatConfig config;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttp = MockHttpClient();
    config = ShuttlersChatConfig(
      tripId: 'trip_123',
      username: 'testuser',
      authToken: 'test_token_12345',
      baseUrl: 'https://api.example.com',
      wsUrl: 'wss://api.example.com',
    );
    client = ChatApiClient(config: config, httpClient: mockHttp);
  });

  group('ChatApiClient', () {
    group('listMessages', () {
      test('makes GET request with correct URL and headers', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode({
              'messages': <dynamic>[],
              'nextCursor': null,
            }),
            200,
          ),
        );

        await client.listMessages();

        final captured =
            verify(
              () => mockHttp.get(
                captureAny(),
                headers: captureAny(named: 'headers'),
              ),
            ).captured;

        final uri = captured[0] as Uri;
        final headers = captured[1] as Map<String, String>;

        expect(
          uri.toString(),
          equals('https://api.example.com/trips/trip_123/chat?limit=20'),
        );
        expect(headers['Authorization'], equals('Bearer test_token_12345'));
        expect(headers['Content-Type'], equals('application/json'));
      });

      test('includes before parameter when provided', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode({
              'messages': <dynamic>[],
              'nextCursor': null,
            }),
            200,
          ),
        );

        await client.listMessages(before: 'msg_123');

        final uri =
            verify(
                  () => mockHttp.get(
                    captureAny(),
                    headers: any(named: 'headers'),
                  ),
                ).captured.first
                as Uri;

        expect(
          uri.toString(),
          equals(
            'https://api.example.com/trips/trip_123/chat?limit=20&before=msg_123',
          ),
        );
      });

      test('returns PagedMessagesResponse on success', () async {
        final responseBody = {
          'messages': [
            {
              'id': 'msg_1',
              'clientId': 'client_1',
              'tripId': 'trip_123',
              'userId': 'user_456',
              'username': 'testuser',
              'text': 'Hello',
              'createdAt': '2024-01-01T12:00:00Z',
            },
          ],
          'nextCursor': 'msg_2',
        };

        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(json.encode(responseBody), 200),
        );

        final result = await client.listMessages();

        expect(result, isA<PagedMessagesResponse>());
        expect(result.messages.length, equals(1));
        expect(result.messages.first.text, equals('Hello'));
        expect(result.nextCursor, equals('msg_2'));
      });

      test('throws exception on non-200 status code', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Error', 500));

        expect(
          () => client.listMessages(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to fetch messages: 500'),
            ),
          ),
        );
      });
    });

    group('sendMessage', () {
      test('makes POST request with correct URL and headers', () async {
        when(
          () => mockHttp.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode({
              'id': 'msg_1',
              'clientId': 'client_1',
              'tripId': 'trip_123',
              'userId': 'user_456',
              'username': 'testuser',
              'text': 'Hello',
              'createdAt': '2024-01-01T12:00:00Z',
            }),
            201,
          ),
        );

        const request = SendMessageRequest(
          text: 'Hello',
          username: 'testuser',
          clientId: 'client_1',
        );

        await client.sendMessage(request);

        final captured =
            verify(
              () => mockHttp.post(
                captureAny(),
                headers: captureAny(named: 'headers'),
                body: captureAny(named: 'body'),
              ),
            ).captured;

        final uri = captured[0] as Uri;
        final headers = captured[1] as Map<String, String>;
        final body = captured[2] as String;

        expect(
          uri.toString(),
          equals('https://api.example.com/trips/trip_123/chat/messages'),
        );
        expect(headers['Authorization'], equals('Bearer test_token_12345'));
        expect(headers['Content-Type'], equals('application/json'));
        expect(json.decode(body), equals(request.toJson()));
      });

      test('returns ChatMessage on success', () async {
        final responseBody = {
          'id': 'msg_1',
          'clientId': 'client_1',
          'tripId': 'trip_123',
          'userId': 'user_456',
          'username': 'testuser',
          'text': 'Hello',
          'createdAt': '2024-01-01T12:00:00Z',
        };

        when(
          () => mockHttp.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(json.encode(responseBody), 201),
        );

        const request = SendMessageRequest(
          text: 'Hello',
          username: 'testuser',
          clientId: 'client_1',
        );

        final result = await client.sendMessage(request);

        expect(result, isA<ChatMessage>());
        expect(result.text, equals('Hello'));
        expect(result.id, equals('msg_1'));
      });

      test('throws exception on non-201 status code', () async {
        when(
          () => mockHttp.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Error', 500));

        const request = SendMessageRequest(
          text: 'Hello',
          username: 'testuser',
          clientId: 'client_1',
        );

        expect(
          () => client.sendMessage(request),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to send message: 500'),
            ),
          ),
        );
      });
    });

    group('getUnreadCount', () {
      test('makes GET request with correct URL and headers', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode({'count': 5}),
            200,
          ),
        );

        await client.getUnreadCount();

        final captured =
            verify(
              () => mockHttp.get(
                captureAny(),
                headers: captureAny(named: 'headers'),
              ),
            ).captured;

        final uri = captured[0] as Uri;
        final headers = captured[1] as Map<String, String>;

        expect(
          uri.toString(),
          equals('https://api.example.com/trips/trip_123/chat/unread'),
        );
        expect(headers['Authorization'], equals('Bearer test_token_12345'));
        expect(headers['Content-Type'], equals('application/json'));
      });

      test('returns UnreadCountResponse on success', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(json.encode({'count': 10}), 200),
        );

        final result = await client.getUnreadCount();

        expect(result, isA<UnreadCountResponse>());
        expect(result.count, equals(10));
      });

      test('returns zero count when API returns zero', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(json.encode({'count': 0}), 200),
        );

        final result = await client.getUnreadCount();

        expect(result.count, equals(0));
      });

      test('returns large count correctly', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(json.encode({'count': 999}), 200),
        );

        final result = await client.getUnreadCount();

        expect(result.count, equals(999));
      });

      test('throws exception on 401 unauthorized', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Unauthorized', 401));

        expect(
          () => client.getUnreadCount(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to fetch unread count: 401'),
            ),
          ),
        );
      });

      test('throws exception on 500 server error', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Server Error', 500));

        expect(
          () => client.getUnreadCount(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to fetch unread count: 500'),
            ),
          ),
        );
      });

      test('throws exception on non-200 status code', () async {
        when(
          () => mockHttp.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(
          () => client.getUnreadCount(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to fetch unread count: 404'),
            ),
          ),
        );
      });
    });

    test('close calls http client close', () {
      when(() => mockHttp.close()).thenAnswer((_) async {});

      client.close();

      verify(() => mockHttp.close()).called(1);
    });
  });
}
