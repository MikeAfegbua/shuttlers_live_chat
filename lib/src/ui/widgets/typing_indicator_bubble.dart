import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';

class TypingIndicatorBubble extends StatelessWidget {
  const TypingIndicatorBubble({
    required this.typingText,
    super.key,
  });

  final String typingText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatTheme = ChatThemeProvider.of(context);

    final indicatorColor =
        chatTheme.typingIndicatorColor ?? theme.colorScheme.onSurfaceVariant;

    return Align(
      alignment: Alignment.centerLeft,
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
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              typingText,
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: indicatorColor,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: indicatorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
