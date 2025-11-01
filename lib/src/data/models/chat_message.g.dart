// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  clientId: json['clientId'] as String,
  tripId: json['tripId'] as String,
  userId: json['userId'] as String,
  username: json['username'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'tripId': instance.tripId,
      'userId': instance.userId,
      'username': instance.username,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'avatarUrl': instance.avatarUrl,
    };
