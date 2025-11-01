import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/theme/chat_theme.dart';

void main() {
  group('ShuttlersChatTheme', () {
    test('should create from constructor', () {
      const theme = ShuttlersChatTheme(
        meBubble: Colors.blue,
        otherBubble: Colors.grey,
        bubbleText: Colors.black,
        typingText: Colors.grey,
        sendEnabled: Colors.green,
        sendDisabled: Colors.grey,
      );

      expect(theme.meBubble, Colors.blue);
      expect(theme.otherBubble, Colors.grey);
      expect(theme.bubbleText, Colors.black);
      expect(theme.typingText, Colors.grey);
      expect(theme.sendEnabled, Colors.green);
      expect(theme.sendDisabled, Colors.grey);
    });

    test('should create from ThemeData light', () {
      final theme = ShuttlersChatTheme.fromTheme(ThemeData.light());

      expect(theme.meBubble, isNotNull);
      expect(theme.otherBubble, isNotNull);
      expect(theme.bubbleText, isNotNull);
      expect(theme.typingText, isNotNull);
      expect(theme.sendEnabled, isNotNull);
      expect(theme.sendDisabled, isNotNull);
    });

    test('should create from ThemeData dark', () {
      final theme = ShuttlersChatTheme.fromTheme(ThemeData.dark());

      expect(theme.meBubble, isNotNull);
      expect(theme.otherBubble, isNotNull);
      expect(theme.bubbleText, isNotNull);
      expect(theme.typingText, isNotNull);
      expect(theme.sendEnabled, isNotNull);
      expect(theme.sendDisabled, isNotNull);
    });

    test('should create shuttlers brand theme', () {
      final theme = ShuttlersChatTheme.shuttlersBrand(ThemeData.light());
      const shuttlersGreen = Color(0xFF0DAC5C);

      expect(theme.meBubble, isNotNull);
      expect(theme.sendEnabled, shuttlersGreen);
    });

    test('should support copyWith', () {
      const theme = ShuttlersChatTheme(
        meBubble: Colors.blue,
        otherBubble: Colors.grey,
        bubbleText: Colors.black,
        typingText: Colors.grey,
        sendEnabled: Colors.green,
        sendDisabled: Colors.grey,
      );

      final updated = theme.copyWith(meBubble: Colors.red);

      expect(updated.meBubble, Colors.red);
      expect(updated.otherBubble, Colors.grey);
      expect(updated.bubbleText, Colors.black);
    });

    test('should support copyWith for all properties', () {
      const theme = ShuttlersChatTheme(
        meBubble: Colors.blue,
        otherBubble: Colors.grey,
        bubbleText: Colors.black,
        typingText: Colors.grey,
        sendEnabled: Colors.green,
        sendDisabled: Colors.grey,
      );

      final updated = theme.copyWith(
        meBubble: Colors.red,
        otherBubble: Colors.white,
        bubbleText: Colors.yellow,
        typingText: Colors.orange,
        sendEnabled: Colors.purple,
        sendDisabled: Colors.brown,
      );

      expect(updated.meBubble, Colors.red);
      expect(updated.otherBubble, Colors.white);
      expect(updated.bubbleText, Colors.yellow);
      expect(updated.typingText, Colors.orange);
      expect(updated.sendEnabled, Colors.purple);
      expect(updated.sendDisabled, Colors.brown);
    });

    test('should lerp between themes', () {
      const theme1 = ShuttlersChatTheme(
        meBubble: Colors.blue,
        otherBubble: Colors.grey,
        bubbleText: Colors.black,
        typingText: Colors.grey,
        sendEnabled: Colors.green,
        sendDisabled: Colors.grey,
      );

      const theme2 = ShuttlersChatTheme(
        meBubble: Colors.red,
        otherBubble: Colors.white,
        bubbleText: Colors.yellow,
        typingText: Colors.orange,
        sendEnabled: Colors.purple,
        sendDisabled: Colors.brown,
      );

      final lerped = theme1.lerp(theme2, 0.5);

      expect(lerped, isA<ShuttlersChatTheme>());
      expect(lerped.meBubble, isNotNull);
      expect(lerped.otherBubble, isNotNull);
    });

    test(
      'should lerp return same theme when other is not ShuttlersChatTheme',
      () {
        const theme = ShuttlersChatTheme(
          meBubble: Colors.blue,
          otherBubble: Colors.grey,
          bubbleText: Colors.black,
          typingText: Colors.grey,
          sendEnabled: Colors.green,
          sendDisabled: Colors.grey,
        );

        final lerped = theme.lerp(null, 0.5);

        expect(lerped, equals(theme));
      },
    );

    test('should lerp at t=0 return first theme colors', () {
      const color1 = Color(0xFF123456);
      const color2 = Color(0xFFABCDEF);

      const theme1 = ShuttlersChatTheme(
        meBubble: color1,
        otherBubble: color1,
        bubbleText: color1,
        typingText: color1,
        sendEnabled: color1,
        sendDisabled: color1,
      );

      const theme2 = ShuttlersChatTheme(
        meBubble: color2,
        otherBubble: color2,
        bubbleText: color2,
        typingText: color2,
        sendEnabled: color2,
        sendDisabled: color2,
      );

      final lerped = theme1.lerp(theme2, 0);

      expect(lerped.meBubble, color1);
      expect(lerped.otherBubble, color1);
    });

    test('should lerp at t=1 return second theme colors', () {
      const color1 = Color(0xFF123456);
      const color2 = Color(0xFFABCDEF);

      const theme1 = ShuttlersChatTheme(
        meBubble: color1,
        otherBubble: color1,
        bubbleText: color1,
        typingText: color1,
        sendEnabled: color1,
        sendDisabled: color1,
      );

      const theme2 = ShuttlersChatTheme(
        meBubble: color2,
        otherBubble: color2,
        bubbleText: color2,
        typingText: color2,
        sendEnabled: color2,
        sendDisabled: color2,
      );

      final lerped = theme1.lerp(theme2, 1);

      expect(lerped.meBubble, color2);
      expect(lerped.otherBubble, color2);
    });
  });
}
