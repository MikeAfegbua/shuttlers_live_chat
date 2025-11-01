import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_envelope.freezed.dart';
part 'ws_envelope.g.dart';

sealed class WsPayload {
  const WsPayload();
  Map<String, dynamic> toJson();
}

class EmptyPayload extends WsPayload {
  const EmptyPayload();

  @override
  Map<String, dynamic> toJson() => {};
}

@freezed
sealed class WsEnvelope with _$WsEnvelope {
  const factory WsEnvelope({
    required String type,
    String? version,
    @Default({}) Map<String, dynamic> payload,
    String? ts,
    String? requestId,
    WsError? error,
  }) = _WsEnvelope;

  factory WsEnvelope.fromJson(Map<String, dynamic> json) =>
      _$WsEnvelopeFromJson(json);
}

@freezed
sealed class WsError with _$WsError {
  const factory WsError({
    required String code,
    required String message,
    Map<String, dynamic>? details,
  }) = _WsError;

  factory WsError.fromJson(Map<String, dynamic> json) =>
      _$WsErrorFromJson(json);
}

@freezed
sealed class MessageCreatedPayload
    with _$MessageCreatedPayload
    implements WsPayload {
  const factory MessageCreatedPayload({
    required String id,
    required String clientId,
    required String tripId,
    required String userId,
    required String username,
    required String text,
    required String createdAt,
    String? avatarUrl,
  }) = _MessageCreatedPayload;

  factory MessageCreatedPayload.fromJson(Map<String, dynamic> json) =>
      _$MessageCreatedPayloadFromJson(json);
}

@freezed
sealed class MessageAckPayload with _$MessageAckPayload implements WsPayload {
  const factory MessageAckPayload({
    required String clientId,
    required String serverId,
    required String status,
  }) = _MessageAckPayload;

  factory MessageAckPayload.fromJson(Map<String, dynamic> json) =>
      _$MessageAckPayloadFromJson(json);
}

@freezed
sealed class TypingPayload with _$TypingPayload implements WsPayload {
  const factory TypingPayload({
    required String userId,
    required String username,
  }) = _TypingPayload;

  factory TypingPayload.fromJson(Map<String, dynamic> json) =>
      _$TypingPayloadFromJson(json);
}

@freezed
sealed class PresencePayload with _$PresencePayload implements WsPayload {
  const factory PresencePayload({
    required int count,
  }) = _PresencePayload;

  factory PresencePayload.fromJson(Map<String, dynamic> json) =>
      _$PresencePayloadFromJson(json);
}

@freezed
sealed class MessageSendPayload with _$MessageSendPayload implements WsPayload {
  const factory MessageSendPayload({
    required String tripId,
    required String clientId,
    required String text,
  }) = _MessageSendPayload;

  factory MessageSendPayload.fromJson(Map<String, dynamic> json) =>
      _$MessageSendPayloadFromJson(json);
}

@freezed
sealed class TypingEventPayload with _$TypingEventPayload implements WsPayload {
  const factory TypingEventPayload({
    required String tripId,
  }) = _TypingEventPayload;

  factory TypingEventPayload.fromJson(Map<String, dynamic> json) =>
      _$TypingEventPayloadFromJson(json);
}
