// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PagedMessagesResponse _$PagedMessagesResponseFromJson(
  Map<String, dynamic> json,
) => _PagedMessagesResponse(
  messages:
      (json['messages'] as List<dynamic>)
          .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
  nextCursor: json['nextCursor'] as String?,
);

Map<String, dynamic> _$PagedMessagesResponseToJson(
  _PagedMessagesResponse instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'nextCursor': instance.nextCursor,
};
