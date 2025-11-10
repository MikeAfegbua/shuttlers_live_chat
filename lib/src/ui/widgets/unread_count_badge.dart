import 'package:flutter/material.dart';

class UnreadCountBadge extends StatelessWidget {
  const UnreadCountBadge({
    required this.countStream,
    required this.child,
    this.backgroundColor,
    this.textColor,
    this.showZero = false,
    this.maxCount = 99,
    this.alignment,
    this.offset,
    super.key,
  });

  final Stream<int> countStream;
  final Widget child;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showZero;
  final int maxCount;
  final Alignment? alignment;
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<int>(
      stream: countStream,
      initialData: 0,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        final shouldShow = count > 0 || showZero;

        return Badge(
          isLabelVisible: shouldShow,
          label: Text(
            count > maxCount ? '$maxCount+' : '$count',
            style: theme.textTheme.labelSmall?.copyWith(
              color: textColor ?? theme.colorScheme.onError,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: backgroundColor ?? theme.colorScheme.error,
          textColor: textColor ?? theme.colorScheme.onError,
          alignment: alignment,
          offset: offset,
          child: child,
        );
      },
    );
  }
}
