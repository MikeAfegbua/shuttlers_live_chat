import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/paged_messages_response.dart';
import 'package:shuttlers_live_chat/src/data/models/send_message_request.dart';
import 'package:shuttlers_live_chat/src/data/models/unread_count_response.dart';

class ChatApiClient {
  ChatApiClient({required this.config, http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  final ShuttlersChatConfig config;
  final http.Client _http;

  Map<String, String> get _headers => {
    'Authorization': 'Bearer ${config.authToken}',
    'Content-Type': 'application/json',
  };

  Future<PagedMessagesResponse> listMessages({
    int limit = 20,
    String? before,
  }) async {
    final uri = Uri.parse(
      '${config.baseUrl}/trips/${config.tripId}/chat'
      '${before != null ? '?limit=$limit&before=$before' : '?limit=$limit'}',
    );
    final res = await _http.get(uri, headers: _headers);
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch messages: ${res.statusCode}');
    }
    return PagedMessagesResponse.fromJson(
      json.decode(res.body) as Map<String, dynamic>,
    );
  }

  Future<ChatMessage> sendMessage(SendMessageRequest body) async {
    final uri = Uri.parse(
      '${config.baseUrl}/trips/${config.tripId}/chat/messages',
    );
    final res = await _http.post(
      uri,
      headers: _headers,
      body: json.encode(body.toJson()),
    );
    if (res.statusCode != 201) {
      throw Exception('Failed to send message: ${res.statusCode}');
    }
    return ChatMessage.fromJson(json.decode(res.body) as Map<String, dynamic>);
  }

  Future<UnreadCountResponse> getUnreadCount() async {
    final uri = Uri.parse(
      '${config.baseUrl}/trips/${config.tripId}/chat/unread',
    );
    final res = await _http.get(uri, headers: _headers);
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch unread count: ${res.statusCode}');
    }
    return UnreadCountResponse.fromJson(
      json.decode(res.body) as Map<String, dynamic>,
    );
  }

  void close() => _http.close();
}
