import 'package:flutter/material.dart';

@immutable
class ShuttlersChatTheme extends ThemeExtension<ShuttlersChatTheme> {
  const ShuttlersChatTheme({
    required this.meBubble,
    required this.otherBubble,
    required this.bubbleText,
    required this.typingText,
    required this.sendEnabled,
    required this.sendDisabled,
  });
  factory ShuttlersChatTheme.fromTheme(ThemeData theme) {
    final cs = theme.colorScheme;
    final on = theme.textTheme.bodyMedium?.color ?? cs.onSurface;

    return ShuttlersChatTheme(
      meBubble: cs.primary.withValues(alpha: .14),
      otherBubble: cs.surfaceContainerHighest,
      bubbleText: on,
      typingText: (theme.textTheme.bodySmall?.color ?? on).withValues(
        alpha: .7,
      ),
      sendEnabled: cs.primary,
      sendDisabled: on.withValues(alpha: .38),
    );
  }

  factory ShuttlersChatTheme.shuttlersBrand(ThemeData theme) {
    const shuttlersGreen = Color(0xFF0DAC5C);
    final base = ShuttlersChatTheme.fromTheme(theme);
    return base.copyWith(
      meBubble: shuttlersGreen.withValues(alpha: .16),
      sendEnabled: shuttlersGreen,
    );
  }

  final Color meBubble;
  final Color otherBubble;
  final Color bubbleText;
  final Color typingText;
  final Color sendEnabled;
  final Color sendDisabled;

  @override
  ShuttlersChatTheme copyWith({
    Color? meBubble,
    Color? otherBubble,
    Color? bubbleText,
    Color? typingText,
    Color? sendEnabled,
    Color? sendDisabled,
  }) {
    return ShuttlersChatTheme(
      meBubble: meBubble ?? this.meBubble,
      otherBubble: otherBubble ?? this.otherBubble,
      bubbleText: bubbleText ?? this.bubbleText,
      typingText: typingText ?? this.typingText,
      sendEnabled: sendEnabled ?? this.sendEnabled,
      sendDisabled: sendDisabled ?? this.sendDisabled,
    );
  }

  @override
  ShuttlersChatTheme lerp(ThemeExtension<ShuttlersChatTheme>? other, double t) {
    if (other is! ShuttlersChatTheme) return this;
    return ShuttlersChatTheme(
      meBubble: Color.lerp(meBubble, other.meBubble, t)!,
      otherBubble: Color.lerp(otherBubble, other.otherBubble, t)!,
      bubbleText: Color.lerp(bubbleText, other.bubbleText, t)!,
      typingText: Color.lerp(typingText, other.typingText, t)!,
      sendEnabled: Color.lerp(sendEnabled, other.sendEnabled, t)!,
      sendDisabled: Color.lerp(sendDisabled, other.sendDisabled, t)!,
    );
  }
}

// final light = ThemeData(
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: const Color(0xFF0DAC5C),
//     brightness: Brightness.light,
//   ),
//   extensions: [ShuttlersChatTheme.shuttlersBrand(ThemeData.light())],
// );

// final dark = ThemeData(
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: const Color(0xFF0DAC5C),
//     brightness: Brightness.dark,
//   ),
//   extensions: [ShuttlersChatTheme.shuttlersBrand(ThemeData.dark())],
// );
