import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatTheme = ChatThemeProvider.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color:
              chatTheme.dateHeaderColor ??
              theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: theme.textTheme.labelSmall?.copyWith(
            color:
                chatTheme.dateHeaderTextColor ??
                theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
