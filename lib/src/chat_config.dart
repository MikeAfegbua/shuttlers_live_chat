import 'package:flutter/widgets.dart';

@immutable
class ShuttlersChatConfig {
  ShuttlersChatConfig({
    required this.authToken,
    required this.tripId,
    required this.username,
    this.avatarUrl,
    this.baseUrl = 'https://realtime.chat.qa.onshuttlers.com',
    this.wsUrl = 'wss://realtime.chat.qa.onshuttlers.com/ws',
  }) : assert(authToken.length > 10, 'Invalid authToken'),
       assert(tripId.isNotEmpty, 'tripId is required'),
       assert(username.isNotEmpty, 'username is required');

  final String wsUrl;
  final String authToken;
  final String tripId;
  final String username;
  final String? avatarUrl;
  final String baseUrl;

  ShuttlersChatConfig copyWith({
    String? authToken,
    String? tripId,
    String? username,
    String? avatarUrl,
    String? baseUrl,
    String? wsUrl,
  }) {
    return ShuttlersChatConfig(
      authToken: authToken ?? this.authToken,
      tripId: tripId ?? this.tripId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      baseUrl: baseUrl ?? this.baseUrl,
      wsUrl: wsUrl ?? this.wsUrl,
    );
  }
}
