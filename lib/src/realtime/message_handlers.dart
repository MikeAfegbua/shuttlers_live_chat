import 'dart:async';

import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/ws_envelope.dart';
import 'package:shuttlers_live_chat/src/realtime/message_handler.dart';

class MessageCreatedHandler implements WsMessageHandler {
  MessageCreatedHandler(this.controller);

  final StreamController<ChatMessage> controller;

  @override
  bool canHandle(String messageType) => messageType == 'message.created';

  @override
  void handle(WsEnvelope env) {
    final payload = MessageCreatedPayload.fromJson(env.payload);
    controller.add(
      ChatMessage(
        id: payload.id,
        clientId: payload.clientId,
        tripId: payload.tripId,
        userId: payload.userId,
        username: payload.username,
        avatarUrl: payload.avatarUrl,
        text: payload.text,
        createdAt: DateTime.parse(payload.createdAt),
      ),
    );
  }
}

class MessageAckHandler implements WsMessageHandler {
  MessageAckHandler(this.controller);

  final StreamController<Map<String, dynamic>> controller;

  @override
  bool canHandle(String messageType) => messageType == 'message.ack';

  @override
  void handle(WsEnvelope env) {
    final payload = MessageAckPayload.fromJson(env.payload);
    controller.add({
      'clientId': payload.clientId,
      'serverId': payload.serverId,
      'status': payload.status,
      'requestId': env.requestId,
    });
  }
}

class TypingStartHandler implements WsMessageHandler {
  TypingStartHandler(this.controller);

  final StreamController<Map<String, String>> controller;

  @override
  bool canHandle(String messageType) => messageType == 'typing.start';

  @override
  void handle(WsEnvelope env) {
    final payload = TypingPayload.fromJson(env.payload);
    controller.add({
      'userId': payload.userId,
      'username': payload.username,
    });
  }
}

class TypingStopHandler implements WsMessageHandler {
  TypingStopHandler(this.controller);

  final StreamController<Map<String, String>> controller;

  @override
  bool canHandle(String messageType) => messageType == 'typing.stop';

  @override
  void handle(WsEnvelope env) {
    final payload = TypingPayload.fromJson(env.payload);
    controller.add({
      'userId': payload.userId,
      'username': payload.username,
    });
  }
}

class PresenceUpdateHandler implements WsMessageHandler {
  PresenceUpdateHandler(this.controller);

  final StreamController<int> controller;

  @override
  bool canHandle(String messageType) => messageType == 'presence.update';

  @override
  void handle(WsEnvelope env) {
    final payload = PresencePayload.fromJson(env.payload);
    controller.add(payload.count);
  }
}

class SystemErrorHandler implements WsMessageHandler {
  SystemErrorHandler(this.controller);

  final StreamController<WsError> controller;

  @override
  bool canHandle(String messageType) => messageType == 'system.error';

  @override
  void handle(WsEnvelope env) {
    if (env.error != null) {
      controller.add(env.error!);
    }
  }
}

class PongHandler implements WsMessageHandler {
  @override
  bool canHandle(String messageType) => messageType == 'pong';

  @override
  void handle(WsEnvelope env) {
    // No-op: pong is just for keep-alive
  }
}
