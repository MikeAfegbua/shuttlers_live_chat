import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';
import 'package:shuttlers_live_chat/src/state/chat_state.dart';
import 'package:shuttlers_live_chat/src/state/providers.dart';

class ChatController extends AutoDisposeAsyncNotifier<ChatState> {
  late final ChatRepository _repo;
  final Set<String> _activeUsers = {};
  bool _hasReceivedPresenceEvent = false;
  StreamSubscription<ChatMessage>? _msgSub;
  StreamSubscription<bool>? _connSub;

  StreamSubscription<Map<String, String>>? _typingStartSub;
  StreamSubscription<Map<String, String>>? _typingStopSub;
  StreamSubscription<int>? _presenceSub;
  StreamSubscription<Map<String, dynamic>>? _ackSub;
  @override
  Future<ChatState> build() async {
    _repo = ref.read(chatRepositoryProvider);
    state = const AsyncValue.data(ChatState(loading: true));

    _connSub = _repo.onConnection.listen((connected) {
      final cur = state.value ?? const ChatState();
      state = AsyncValue.data(cur.copyWith(connected: connected));
    });

    _presenceSub = _repo.onPresenceCount.listen((count) {
      _hasReceivedPresenceEvent = true;
      final cur = state.value ?? const ChatState();
      state = AsyncValue.data(cur.copyWith(presenceCount: count));
    });

    _typingStartSub = _repo.onTypingStart.listen((data) {
      final username = data['username'];
      if (username == null || username == _repo.config.username) return;

      if (!_hasReceivedPresenceEvent) {
        _activeUsers.add(username);
        _updatePresenceCount();
      }

      final cur = state.value ?? const ChatState();
      final nextTyping = <String>{...cur.typingUsers}..add(username);
      state = AsyncValue.data(cur.copyWith(typingUsers: nextTyping));
    });

    _typingStopSub = _repo.onTypingStop.listen((data) {
      final username = data['username'];
      if (username == null) return;
      final cur = state.value ?? const ChatState();
      final nextTyping = <String>{...cur.typingUsers}..remove(username);
      state = AsyncValue.data(cur.copyWith(typingUsers: nextTyping));
    });

    _ackSub = _repo.onAck.listen((ack) {
      final clientId = ack['clientId'] as String?;
      final status = (ack['status'] as String?) ?? 'delivered';
      if (clientId == null) return;
      final cur = state.value ?? const ChatState();
      final nextMap = Map<String, String>.from(cur.deliveryByClientId);
      nextMap[clientId] = status;
      state = AsyncValue.data(cur.copyWith(deliveryByClientId: nextMap));
    });

    unawaited(_repo.connect());

    final history = await _repo.loadInitial();
    final sortedHistory = List<ChatMessage>.from(history)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    _msgSub = _repo.onMessageCreated.listen((m) {
      final cur = state.value ?? const ChatState();

      if (!_hasReceivedPresenceEvent && m.username != _repo.config.username) {
        _activeUsers.add(m.username);
        _updatePresenceCount();
      }

      final idx = cur.messages.indexWhere((x) => x.clientId == m.clientId);
      final next = List<ChatMessage>.of(cur.messages);
      final seen = <String>{...cur.seenClientIds}..add(m.clientId);

      if (idx >= 0) {
        next[idx] = m;
      } else {
        next
          ..add(m)
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }

      final dm = Map<String, String>.from(cur.deliveryByClientId);
      dm[m.clientId] =
          dm[m.clientId] == 'sending' || dm[m.clientId] == 'sent'
              ? 'delivered'
              : (dm[m.clientId] ?? 'delivered');

      state = AsyncValue.data(
        cur.copyWith(
          messages: next,
          typingUsers: {...cur.typingUsers}..remove(m.username),
          seenClientIds: seen,
          deliveryByClientId: dm,
        ),
      );
    });

    final cur = state.value ?? const ChatState();
    return ChatState(
      connected: cur.connected,
      messages: sortedHistory,
      seenClientIds: {
        for (final h in sortedHistory) h.clientId,
      },
      presenceCount:
          _hasReceivedPresenceEvent
              ? cur.presenceCount
              : (_activeUsers.length + 1),
    );
  }

  void _updatePresenceCount() {
    final cur = state.value ?? const ChatState();
    state = AsyncValue.data(
      cur.copyWith(presenceCount: _activeUsers.length + 1),
    );
  }

  Future<void> send(String clientId, String text) async {
    final cur = state.value ?? const ChatState();

    final optimistic = ChatMessage(
      id: 'tmp-$clientId',
      clientId: clientId,
      tripId: _repo.config.tripId,
      userId: 'me',
      username: _repo.config.username,
      avatarUrl: _repo.config.avatarUrl,
      text: text,
      createdAt: DateTime.now().toUtc(),
    );
    final dm = Map<String, String>.from(cur.deliveryByClientId);
    dm[clientId] = 'sending';

    final updatedMessages = [...cur.messages, optimistic]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    state = AsyncValue.data(
      cur.copyWith(
        messages: updatedMessages,
        deliveryByClientId: dm,
        seenClientIds: {...cur.seenClientIds}..add(clientId),
      ),
    );

    try {
      await _repo.sendText(clientId: clientId, text: text);
      final cur2 = state.value ?? cur;
      final dm2 = Map<String, String>.from(cur2.deliveryByClientId);
      if (dm2[clientId] == 'sending') dm2[clientId] = 'sent';
      state = AsyncValue.data(cur2.copyWith(deliveryByClientId: dm2));
    } on Exception catch (e) {
      final cur2 = state.value ?? cur;
      final dm2 = Map<String, String>.from(cur2.deliveryByClientId);
      dm2[clientId] = 'failed';
      state = AsyncValue.data(
        cur2.copyWith(deliveryByClientId: dm2, error: '$e'),
      );
    }
  }

  Future<void> dispose() async {
    await _msgSub?.cancel();
    await _connSub?.cancel();
    await _typingStartSub?.cancel();
    await _typingStopSub?.cancel();
    await _presenceSub?.cancel();
    await _repo.dispose();
    await _ackSub?.cancel();
  }
}
