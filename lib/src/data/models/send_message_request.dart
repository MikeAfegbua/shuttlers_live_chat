import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_request.freezed.dart';
part 'send_message_request.g.dart';

@freezed
sealed class SendMessageRequest with _$SendMessageRequest {
  const factory SendMessageRequest({
    required String text,
    required String username,
    required String clientId,
  }) = _SendMessageRequest;

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
}
