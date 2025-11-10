import 'package:flutter/material.dart';

class ChatTheme {
  const ChatTheme({
    this.backgroundColor,
    this.appBarColor,
    this.messageBubbleColor,
    this.myMessageBubbleColor,
    this.messageTextColor,
    this.myMessageTextColor,
    this.timestampTextColor,
    this.inputBackgroundColor,
    this.sendButtonColor,
    this.dateHeaderColor,
    this.dateHeaderTextColor,
    this.typingIndicatorColor,
    this.connectionIndicatorColor,
  });

  final Color? backgroundColor;
  final Color? appBarColor;
  final Color? messageBubbleColor;
  final Color? myMessageBubbleColor;
  final Color? messageTextColor;
  final Color? myMessageTextColor;
  final Color? timestampTextColor;
  final Color? inputBackgroundColor;
  final Color? sendButtonColor;
  final Color? dateHeaderColor;
  final Color? dateHeaderTextColor;
  final Color? typingIndicatorColor;
  final Color? connectionIndicatorColor;

  ChatTheme resolveFrom(BuildContext context) {
    final theme = Theme.of(context);
    return ChatTheme(
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      appBarColor: appBarColor,
      messageBubbleColor:
          messageBubbleColor ?? theme.colorScheme.surfaceContainerHighest,
      myMessageBubbleColor:
          myMessageBubbleColor ??
          theme.colorScheme.primary.withValues(alpha: 0.12),
      messageTextColor: messageTextColor ?? theme.colorScheme.onSurface,
      myMessageTextColor: myMessageTextColor ?? theme.colorScheme.onSurface,
      timestampTextColor:
          timestampTextColor ?? theme.colorScheme.onSurfaceVariant,
      inputBackgroundColor: inputBackgroundColor,
      sendButtonColor: sendButtonColor ?? theme.colorScheme.primary,
      dateHeaderColor:
          dateHeaderColor ?? theme.colorScheme.surfaceContainerHighest,
      dateHeaderTextColor:
          dateHeaderTextColor ?? theme.colorScheme.onSurfaceVariant,
      typingIndicatorColor:
          typingIndicatorColor ?? theme.colorScheme.onSurfaceVariant,
      connectionIndicatorColor: connectionIndicatorColor,
    );
  }
}
