import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/models/send_message_request.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_api_client.dart';
import 'package:shuttlers_live_chat/src/data/services/outbox.dart';
import 'package:shuttlers_live_chat/src/realtime/chat_ws_client.dart';

class ChatRepository {
  ChatRepository({required this.config})
    : _api = ChatApiClient(config: config),
      _ws = ChatWsClient(config),
      _outbox = Outbox() {
    unawaited(_init());
  }

  final ShuttlersChatConfig config;
  final ChatApiClient _api;
  final ChatWsClient _ws;
  final Outbox _outbox;

  Stream<ChatMessage> get onMessageCreated => _ws.onMessageCreated;
  Stream<bool> get onConnection => _ws.onConnection;
  Stream<Map<String, String>> get onTypingStart => _ws.onTypingStart;
  Stream<Map<String, String>> get onTypingStop => _ws.onTypingStop;
  Stream<int> get onPresenceCount => _ws.onPresenceCount;
  Stream<Map<String, dynamic>> get onAck => _ws.onAck;
  Stream<int> get onUnreadCountChanged => _unreadCountController.stream;

  StreamSubscription<dynamic>? _connSub;
  StreamSubscription<dynamic>? _netSub;
  Timer? _unreadCountTimer;
  final _unreadCountController = StreamController<int>.broadcast();
  bool _isOnline = true;

  Future<void> _init() async {
    await _outbox.init();

    _netSub = Connectivity().onConnectivityChanged.listen((result) async {
      _isOnline =
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi);
      if (_isOnline) {
        await _flushOutbox();
      }
    });

    _connSub = _ws.onConnection.listen((connected) async {
      if (connected) await _flushOutbox();
    });

    _startUnreadCountPolling();
  }

  void _startUnreadCountPolling() {
    unawaited(_fetchAndEmitUnreadCount());

    _unreadCountTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _fetchAndEmitUnreadCount(),
    );
  }

  Future<void> _fetchAndEmitUnreadCount() async {
    if (_unreadCountController.isClosed) return;

    final count = await getUnreadCount();

    if (!_unreadCountController.isClosed) {
      _unreadCountController.add(count);
    }
  }

  Future<void> connect() => _ws.connect();

  Future<List<ChatMessage>> loadInitial({int limit = 10}) async {
    final page = await _api.listMessages(limit: limit);
    return page.messages;
  }

  Future<ChatMessage?> sendText({
    required String clientId,
    required String text,
  }) async {
    await _outbox.add(OutboxItem(clientId: clientId, text: text));
    return _tryDrainSingle(clientId);
  }

  Future<void> _flushOutbox() async {
    final items = _outbox.peekAll();
    for (final it in List<OutboxItem>.from(items)) {
      await _tryDrainSingle(it.clientId);
    }
  }

  Future<ChatMessage?> _tryDrainSingle(String clientId) async {
    final item = _outbox.peekAll().firstWhere(
      (e) => e.clientId == clientId,
      orElse: () => OutboxItem(clientId: clientId, text: ''),
    );
    if (item.text.isEmpty) return null;

    if (!_isOnline) return null;

    try {
      final res = await _api.sendMessage(
        SendMessageRequest(
          text: item.text,
          username: config.username,
          clientId: item.clientId,
        ),
      );
      await _outbox.removeById(item.clientId);
      return res;
    } on Exception catch (_) {
      return null;
    }
  }

  void typingStart() => _ws.typingStart();
  void typingStop() => _ws.typingStop();

  Future<int> getUnreadCount() async {
    try {
      final response = await _api.getUnreadCount();
      return response.count;
    } on Exception catch (_) {
      return 0;
    }
  }

  Future<void> dispose() async {
    _unreadCountTimer?.cancel();
    _api.close();
    await _unreadCountController.close();
    await _ws.dispose();
    await _connSub?.cancel();
    await _netSub?.cancel();
  }
}
