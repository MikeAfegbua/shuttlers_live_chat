// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    _SendMessageRequest(
      text: json['text'] as String,
      username: json['username'] as String,
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$SendMessageRequestToJson(_SendMessageRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'username': instance.username,
      'clientId': instance.clientId,
    };
