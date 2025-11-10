import 'package:shuttlers_live_chat/src/data/models/ws_envelope.dart';

abstract class WsMessageHandler {
  bool canHandle(String messageType);
  void handle(WsEnvelope env);
}
