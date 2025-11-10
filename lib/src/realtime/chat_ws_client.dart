import 'dart:async';
import 'dart:convert';

import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/ws_envelope.dart';
import 'package:shuttlers_live_chat/src/realtime/message_handler.dart';
import 'package:shuttlers_live_chat/src/realtime/message_handlers.dart';
import 'package:web_socket_channel/io.dart';

class ChatWsClient {
  ChatWsClient(this.config) {
    _handlers = [
      MessageCreatedHandler(_messageCreatedCtrl),
      MessageAckHandler(_ackCtrl),
      TypingStartHandler(_typingStartCtrl),
      TypingStopHandler(_typingStopCtrl),
      PresenceUpdateHandler(_presenceCtrl),
      SystemErrorHandler(_errorCtrl),
      PongHandler(),
    ];
  }

  final ShuttlersChatConfig config;
  late final List<WsMessageHandler> _handlers;

  IOWebSocketChannel? _ch;
  StreamSubscription<dynamic>? _sub;
  Timer? _pingTimer;
  bool _disposed = false;

  int _retries = 0;
  static const _maxBackoffMs = 15000;

  final _messageCreatedCtrl = StreamController<ChatMessage>.broadcast();
  final _ackCtrl = StreamController<Map<String, dynamic>>.broadcast();
  final _typingStartCtrl = StreamController<Map<String, String>>.broadcast();
  final _typingStopCtrl = StreamController<Map<String, String>>.broadcast();
  final _presenceCtrl = StreamController<int>.broadcast();
  final _errorCtrl = StreamController<WsError>.broadcast();
  final _connectionCtrl = StreamController<bool>.broadcast();

  Stream<ChatMessage> get onMessageCreated => _messageCreatedCtrl.stream;
  Stream<Map<String, dynamic>> get onAck => _ackCtrl.stream;
  Stream<Map<String, String>> get onTypingStart => _typingStartCtrl.stream;
  Stream<Map<String, String>> get onTypingStop => _typingStopCtrl.stream;
  Stream<int> get onPresenceCount => _presenceCtrl.stream;
  Stream<WsError> get onError => _errorCtrl.stream;
  Stream<bool> get onConnection => _connectionCtrl.stream;

  Future<void> connect() async {
    if (_disposed) return;
    await _openChannel();
  }

  Future<void> _openChannel() async {
    final qs =
        Uri(
          queryParameters: {
            'tripId': config.tripId,
            'username': config.username,
            '__token': config.authToken,
          },
        ).query;

    final uri = Uri.parse('${config.wsUrl}?$qs');

    _ch = IOWebSocketChannel.connect(
      uri,
      headers: {'Authorization': 'Bearer ${config.authToken}'},
    );

    _connectionCtrl.add(true);
    _retries = 0;

    _sub = _ch!.stream.listen(
      _onMessage,
      onDone: _onDone,
      onError: (Object e, StackTrace st) {
        _scheduleReconnect();
      },
      cancelOnError: true,
    );

    _startPing();
  }

  void _onMessage(dynamic data) {
    try {
      final map = json.decode(data as String) as Map<String, dynamic>;
      final env = WsEnvelope.fromJson(map);

      for (final handler in _handlers) {
        if (handler.canHandle(env.type)) {
          handler.handle(env);
          return;
        }
      }
    } on Exception catch (_) {}
  }

  void _onDone() {
    _connectionCtrl.add(false);
    _stopPing();
    _scheduleReconnect();
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (_) => sendPing());
  }

  void _stopPing() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void _scheduleReconnect() {
    if (_disposed) return;
    _connectionCtrl.add(false);
    _stopPing();

    _retries += 1;
    final delayMs = (_retries * 1000).clamp(1000, _maxBackoffMs);
    Future.delayed(Duration(milliseconds: delayMs), () async {
      if (_disposed) return;
      await _openChannel();
    });
  }

  void sendPing() {
    _sendEnvelope(type: 'ping');
  }

  void sendMessage({
    required String clientId,
    required String text,
    String? requestId,
  }) {
    final payload = MessageSendPayload(
      tripId: config.tripId,
      clientId: clientId,
      text: text,
    );
    _sendEnvelope(
      type: 'message.send',
      requestId: requestId,
      payload: payload.toJson(),
    );
  }

  void typingStart() {
    final payload = TypingEventPayload(tripId: config.tripId);
    _sendEnvelope(
      type: 'typing.start',
      payload: payload.toJson(),
    );
  }

  void typingStop() {
    final payload = TypingEventPayload(tripId: config.tripId);
    _sendEnvelope(
      type: 'typing.stop',
      payload: payload.toJson(),
    );
  }

  void _sendEnvelope({
    required String type,
    Map<String, dynamic> payload = const {},
    String? requestId,
  }) {
    final env = WsEnvelope(
      type: type,
      version: '1',
      requestId: requestId,
      payload: payload,
    );
    final data = json.encode(env.toJson());
    _ch?.sink.add(data);
  }

  Future<void> dispose() async {
    _disposed = true;
    _stopPing();
    await _sub?.cancel();
    await _ch?.sink.close();
    await Future.wait(
      [
        _messageCreatedCtrl.close(),
        _ackCtrl.close(),
        _typingStartCtrl.close(),
        _typingStopCtrl.close(),
        _presenceCtrl.close(),
        _errorCtrl.close(),
        _connectionCtrl.close(),
      ].map((f) async {
        try {
          return await f;
        } on Exception catch (_) {}
      }),
    );
  }
}
