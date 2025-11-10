import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';
import 'package:shuttlers_live_chat/src/core/utils/date_formatters.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    required this.isMe,
    this.deliveryStatus,
    super.key,
  });

  final ChatMessage message;
  final bool isMe;
  final String? deliveryStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatTheme = ChatThemeProvider.of(context);

    final isPending = deliveryStatus == 'sending' || deliveryStatus == 'sent';
    final opacity = isPending ? 0.5 : 1.0;

    final bubbleColor =
        isMe
            ? (chatTheme.myMessageBubbleColor ??
                theme.colorScheme.primary.withValues(alpha: 0.12))
            : (chatTheme.messageBubbleColor ??
                theme.colorScheme.surfaceContainerHighest);

    final textColor =
        isMe
            ? (chatTheme.myMessageTextColor ?? theme.colorScheme.onSurface)
            : (chatTheme.messageTextColor ?? theme.colorScheme.onSurface);

    final timestampColor =
        chatTheme.timestampTextColor ?? theme.colorScheme.onSurfaceVariant;

    return Opacity(
      opacity: opacity,
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(
                  message.username,
                  style: theme.textTheme.labelSmall,
                ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      message.text,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    message.createdAt.toLocal().formatTime(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: timestampColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
