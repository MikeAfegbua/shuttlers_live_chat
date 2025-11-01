import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';
import 'package:shuttlers_live_chat/src/state/chat_controller.dart';
import 'package:shuttlers_live_chat/src/state/chat_state.dart';

final chatConfigProvider = Provider<ShuttlersChatConfig>((ref) {
  throw UnimplementedError('Override chatConfigProvider at the page boundary.');
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final config = ref.watch(chatConfigProvider);
  final repo = ChatRepository(config: config);
  ref.onDispose(repo.dispose);
  return repo;
});

final chatControllerProvider =
    AutoDisposeAsyncNotifierProvider<ChatController, ChatState>(
      ChatController.new,
    );
