// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsEnvelope _$WsEnvelopeFromJson(Map<String, dynamic> json) => _WsEnvelope(
  type: json['type'] as String,
  version: json['version'] as String?,
  payload: json['payload'] as Map<String, dynamic>? ?? const {},
  ts: json['ts'] as String?,
  requestId: json['requestId'] as String?,
  error:
      json['error'] == null
          ? null
          : WsError.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WsEnvelopeToJson(_WsEnvelope instance) =>
    <String, dynamic>{
      'type': instance.type,
      'version': instance.version,
      'payload': instance.payload,
      'ts': instance.ts,
      'requestId': instance.requestId,
      'error': instance.error,
    };

_WsError _$WsErrorFromJson(Map<String, dynamic> json) => _WsError(
  code: json['code'] as String,
  message: json['message'] as String,
  details: json['details'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$WsErrorToJson(_WsError instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'details': instance.details,
};

_MessageCreatedPayload _$MessageCreatedPayloadFromJson(
  Map<String, dynamic> json,
) => _MessageCreatedPayload(
  id: json['id'] as String,
  clientId: json['clientId'] as String,
  tripId: json['tripId'] as String,
  userId: json['userId'] as String,
  username: json['username'] as String,
  text: json['text'] as String,
  createdAt: json['createdAt'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$MessageCreatedPayloadToJson(
  _MessageCreatedPayload instance,
) => <String, dynamic>{
  'id': instance.id,
  'clientId': instance.clientId,
  'tripId': instance.tripId,
  'userId': instance.userId,
  'username': instance.username,
  'text': instance.text,
  'createdAt': instance.createdAt,
  'avatarUrl': instance.avatarUrl,
};

_MessageAckPayload _$MessageAckPayloadFromJson(Map<String, dynamic> json) =>
    _MessageAckPayload(
      clientId: json['clientId'] as String,
      serverId: json['serverId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$MessageAckPayloadToJson(_MessageAckPayload instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'serverId': instance.serverId,
      'status': instance.status,
    };

_TypingPayload _$TypingPayloadFromJson(Map<String, dynamic> json) =>
    _TypingPayload(
      userId: json['userId'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$TypingPayloadToJson(_TypingPayload instance) =>
    <String, dynamic>{'userId': instance.userId, 'username': instance.username};

_PresencePayload _$PresencePayloadFromJson(Map<String, dynamic> json) =>
    _PresencePayload(count: (json['count'] as num).toInt());

Map<String, dynamic> _$PresencePayloadToJson(_PresencePayload instance) =>
    <String, dynamic>{'count': instance.count};

_MessageSendPayload _$MessageSendPayloadFromJson(Map<String, dynamic> json) =>
    _MessageSendPayload(
      tripId: json['tripId'] as String,
      clientId: json['clientId'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$MessageSendPayloadToJson(_MessageSendPayload instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'clientId': instance.clientId,
      'text': instance.text,
    };

_TypingEventPayload _$TypingEventPayloadFromJson(Map<String, dynamic> json) =>
    _TypingEventPayload(tripId: json['tripId'] as String);

Map<String, dynamic> _$TypingEventPayloadToJson(_TypingEventPayload instance) =>
    <String, dynamic>{'tripId': instance.tripId};
