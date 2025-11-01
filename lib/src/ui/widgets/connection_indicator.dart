import 'package:flutter/material.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({
    required this.isConnected,
    super.key,
  });

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Icon(
      isConnected ? Icons.wifi : Icons.wifi_off,
      size: 20,
      color: isConnected ? Colors.green : theme.colorScheme.error,
    );
  }
}
