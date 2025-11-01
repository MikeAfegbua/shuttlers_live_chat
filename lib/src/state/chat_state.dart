import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';

part 'chat_state.freezed.dart';

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    @Default(false) bool connected,
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(false) bool loading,
    String? error,
    @Default(0) int presenceCount,
    @Default(<String>{}) Set<String> typingUsers,
    @Default(<String, String>{}) Map<String, String> deliveryByClientId,
    @Default(<String>{}) Set<String> seenClientIds,
  }) = _ChatState;
}
