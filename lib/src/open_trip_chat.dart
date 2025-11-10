import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';
import 'package:shuttlers_live_chat/src/ui/trip_chat_page.dart';

class TripChatManager {
  TripChatManager._();

  static final instance = TripChatManager._();

  ChatRepository? _repository;
  Future<void>? _initFuture;

  Future<void> initialize(ShuttlersChatConfig config) async {
    if (_initFuture != null) {
      await _initFuture;
    }

    if (_repository != null && _repository!.config.tripId != config.tripId) {
      await _repository!.dispose();
      _repository = null;
    }

    if (_repository != null) return;

    _initFuture = _initializeRepository(config);
    try {
      await _initFuture;
    } finally {
      _initFuture = null;
    }
  }

  Future<void> _initializeRepository(ShuttlersChatConfig config) async {
    _repository = ChatRepository(config: config);
    await _repository!.connect();
  }

  Stream<int> get unreadCountStream =>
      _repository?.onUnreadCountChanged ?? const Stream<int>.empty();

  Future<T?> open<T>(
    BuildContext context,
    ShuttlersChatConfig config,
  ) async {
    try {
      await initialize(config);

      if (!context.mounted) return null;

      return Navigator.of(context).push<T>(
        MaterialPageRoute(
          builder: (_) => TripChatPage(config: config),
          fullscreenDialog: true,
        ),
      );
    } catch (e) {
      debugPrint('Error opening trip chat: $e');
      rethrow;
    }
  }

  Future<void> dispose() async {
    await _repository?.dispose();
    _repository = null;
  }
}
