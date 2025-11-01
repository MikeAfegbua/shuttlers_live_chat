import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';

part 'paged_messages_response.freezed.dart';
part 'paged_messages_response.g.dart';

@freezed
sealed class PagedMessagesResponse with _$PagedMessagesResponse {
  const factory PagedMessagesResponse({
    required List<ChatMessage> messages,
    String? nextCursor,
  }) = _PagedMessagesResponse;

  factory PagedMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$PagedMessagesResponseFromJson(json);
}
