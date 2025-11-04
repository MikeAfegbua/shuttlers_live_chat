import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/paged_messages_response.dart';
import 'package:shuttlers_live_chat/src/data/models/send_message_request.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ChatApiClient apiClient;
  late MockHttpClient mockHttpClient;
  late ShuttlersChatConfig config;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    config = ShuttlersChatConfig(
      authToken: 'test-auth-token-12345',
      tripId: 'test-trip-123',
      username: 'Test User',
      baseUrl: 'https://api.test.com',
    );
    apiClient = ChatApiClient(config: config, httpClient: mockHttpClient);
  });

  group('ChatApiClient', () {
    group('headers', () {
      test('should include authorization header', () {
        // We can't directly test private _headers, but we can verify it's used in requests
        expect(config.authToken, 'test-auth-token-12345');
      });
    });

    group('listMessages', () {
      test('should fetch messages successfully', () async {
        final mockResponse = {
          'messages': [
            {
              'id': '1',
              'clientId': 'client-1',
              'tripId': 'test-trip-123',
              'userId': 'user-1',
              'username': 'User 1',
              'text': 'Hello',
              'createdAt': '2024-01-01T10:00:00.000Z',
            },
            {
              'id': '2',
              'clientId': 'client-2',
              'tripId': 'test-trip-123',
              'userId': 'user-2',
              'username': 'User 2',
              'text': 'Hi there',
              'createdAt': '2024-01-01T10:01:00.000Z',
            },
          ],
        };

        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode(mockResponse),
            200,
            headers: {'content-type': 'application/json'},
          ),
        );

        final result = await apiClient.listMessages();

        expect(result, isA<PagedMessagesResponse>());
        expect(result.messages.length, 2);
        expect(result.messages[0].id, '1');
        expect(result.messages[0].text, 'Hello');
        expect(result.messages[1].id, '2');
        expect(result.messages[1].text, 'Hi there');

        verify(
          () => mockHttpClient.get(
            Uri.parse('https://api.test.com/trips/test-trip-123/chat?limit=20'),
            headers: {
              'Authorization': 'Bearer test-auth-token-12345',
              'Content-Type': 'application/json',
            },
          ),
        ).called(1);
      });

      test('should fetch messages with custom limit', () async {
        final mockResponse = {'messages': <Map<String, dynamic>>[]};

        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode(mockResponse),
            200,
            headers: {'content-type': 'application/json'},
          ),
        );

        await apiClient.listMessages(limit: 50);

        verify(
          () => mockHttpClient.get(
            Uri.parse('https://api.test.com/trips/test-trip-123/chat?limit=50'),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });

      test('should fetch messages with before cursor', () async {
        final mockResponse = {'messages': <Map<String, dynamic>>[]};

        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode(mockResponse),
            200,
            headers: {'content-type': 'application/json'},
          ),
        );

        await apiClient.listMessages(limit: 10, before: 'cursor-123');

        verify(
          () => mockHttpClient.get(
            Uri.parse(
              'https://api.test.com/trips/test-trip-123/chat?limit=10&before=cursor-123',
            ),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });

      test('should throw exception on non-200 response', () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        expect(
          () => apiClient.listMessages(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to fetch messages: 404'),
            ),
          ),
        );
      });

      test('should throw exception on invalid JSON response', () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('invalid json', 200));

        expect(
          () => apiClient.listMessages(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('sendMessage', () {
      test('should send message successfully', () async {
        const request = SendMessageRequest(
          text: 'Hello, world!',
          username: 'Test User',
          clientId: 'client-123',
        );

        final mockResponse = {
          'id': 'msg-123',
          'clientId': 'client-123',
          'tripId': 'test-trip-123',
          'userId': 'user-123',
          'username': 'Test User',
          'text': 'Hello, world!',
          'createdAt': '2024-01-01T10:00:00.000Z',
        };

        when(
          () => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode(mockResponse),
            201,
            headers: {'content-type': 'application/json'},
          ),
        );

        final result = await apiClient.sendMessage(request);

        expect(result, isA<ChatMessage>());
        expect(result.id, 'msg-123');
        expect(result.clientId, 'client-123');
        expect(result.text, 'Hello, world!');
        expect(result.username, 'Test User');

        verify(
          () => mockHttpClient.post(
            Uri.parse('https://api.test.com/trips/test-trip-123/chat/messages'),
            headers: {
              'Authorization': 'Bearer test-auth-token-12345',
              'Content-Type': 'application/json',
            },
            body: json.encode(request.toJson()),
          ),
        ).called(1);
      });

      test('should send message with special characters', () async {
        const request = SendMessageRequest(
          text: r'Hello! 🚗 Special chars: @#$%',
          username: 'Test User',
          clientId: 'client-456',
        );

        final mockResponse = {
          'id': 'msg-456',
          'clientId': 'client-456',
          'tripId': 'test-trip-123',
          'userId': 'user-123',
          'username': 'Test User',
          'text': r'Hello! 🚗 Special chars: @#$%',
          'createdAt': '2024-01-01T10:00:00.000Z',
        };

        when(
          () => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode(mockResponse),
            201,
            headers: {'content-type': 'application/json'},
          ),
        );

        final result = await apiClient.sendMessage(request);

        expect(result.text, r'Hello! 🚗 Special chars: @#$%');
      });

      test('should throw exception on non-201 response', () async {
        const request = SendMessageRequest(
          text: 'Hello',
          username: 'Test User',
          clientId: 'client-123',
        );

        when(
          () => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Bad request', 400));

        expect(
          () => apiClient.sendMessage(request),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to send message: 400'),
            ),
          ),
        );
      });

      test('should throw exception on invalid JSON response', () async {
        const request = SendMessageRequest(
          text: 'Hello',
          username: 'Test User',
          clientId: 'client-123',
        );

        when(
          () => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('invalid json', 201));

        expect(
          () => apiClient.sendMessage(request),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle network errors', () async {
        const request = SendMessageRequest(
          text: 'Hello',
          username: 'Test User',
          clientId: 'client-123',
        );

        when(
          () => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenThrow(http.ClientException('Network error'));

        expect(
          () => apiClient.sendMessage(request),
          throwsA(isA<http.ClientException>()),
        );
      });
    });

    group('close', () {
      test('should close HTTP client', () {
        apiClient.close();
        verify(() => mockHttpClient.close()).called(1);
      });
    });

    group('configuration', () {
      test('should use correct base URL', () {
        expect(config.baseUrl, 'https://api.test.com');
        expect(config.tripId, 'test-trip-123');
        expect(config.authToken, 'test-auth-token-12345');
      });

      test('should work with different configurations', () {
        final differentConfig = ShuttlersChatConfig(
          authToken: 'different-token-67890',
          tripId: 'different-trip-456',
          username: 'Different User',
          baseUrl: 'https://different.api.com',
        );

        final differentClient = ChatApiClient(
          config: differentConfig,
          httpClient: mockHttpClient,
        );

        expect(differentClient.config.baseUrl, 'https://different.api.com');
        expect(differentClient.config.tripId, 'different-trip-456');
        expect(differentClient.config.authToken, 'different-token-67890');
      });
    });

    group('error handling', () {
      test('should handle timeout errors', () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenThrow(http.ClientException('Connection timeout'));

        expect(
          () => apiClient.listMessages(),
          throwsA(isA<http.ClientException>()),
        );
      });

      test('should handle server errors', () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response(
            json.encode({'error': 'Internal server error'}),
            500,
          ),
        );

        expect(
          () => apiClient.listMessages(),
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
  });
}
