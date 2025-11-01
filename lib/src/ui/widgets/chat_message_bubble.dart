import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme.dart';
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
    final chatTheme =
        theme.extension<ShuttlersChatTheme>() ??
        ShuttlersChatTheme.shuttlersBrand(theme);

    final isPending = deliveryStatus == 'sending' || deliveryStatus == 'sent';
    final opacity = isPending ? 0.5 : 1.0;

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
            color:
                isMe
                    ? theme.colorScheme.primary.withValues(alpha: .12)
                    : theme.colorScheme.surfaceContainerHighest,
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
                        color: chatTheme.bubbleText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    message.createdAt.toLocal().formatTime(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
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
