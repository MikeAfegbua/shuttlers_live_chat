import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({
    required this.isConnected,
    super.key,
  });

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatTheme = ChatThemeProvider.of(context);

    final defaultColor = isConnected ? Colors.green : theme.colorScheme.error;

    return Icon(
      isConnected ? Icons.wifi : Icons.wifi_off,
      size: 20,
      color: chatTheme.connectionIndicatorColor ?? defaultColor,
    );
  }
}
