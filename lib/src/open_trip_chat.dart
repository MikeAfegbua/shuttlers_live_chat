import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/ui/trip_chat_page.dart';

Future<T?> openTripChat<T>(BuildContext context, ShuttlersChatConfig config) {
  return Navigator.of(context).push<T>(
    MaterialPageRoute(
      builder: (_) => TripChatPage(config: config),
      fullscreenDialog: true,
    ),
  );
}
