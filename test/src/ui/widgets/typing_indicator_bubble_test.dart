import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/typing_indicator_bubble.dart';

void main() {
  group('TypingIndicatorBubble', () {
    testWidgets('renders typing text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'John is typing...',
            ),
          ),
        ),
      );

      expect(find.text('John is typing...'), findsOneWidget);
    });

    testWidgets('has correct alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Someone is typing...',
            ),
          ),
        ),
      );

      final alignWidget = tester.widget<Align>(find.byType(Align));
      expect(alignWidget.alignment, equals(Alignment.centerLeft));
    });

    testWidgets('has correct container styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'User is typing...',
            ),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container));
      expect(
        containerWidget.margin,
        equals(const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
      );
      expect(
        containerWidget.padding,
        equals(const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
      );

      final decoration = containerWidget.decoration! as BoxDecoration;
      expect(decoration.borderRadius, equals(BorderRadius.circular(12)));
    });

    testWidgets('has correct row layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Multiple users are typing...',
            ),
          ),
        ),
      );

      final rowWidget = tester.widget<Row>(find.byType(Row));
      expect(rowWidget.mainAxisSize, equals(MainAxisSize.min));

      // Should have Text, SizedBox, and SizedBox (containing CircularProgressIndicator) as children
      final rowChildren = rowWidget.children;
      expect(rowChildren.length, equals(3));
      expect(rowChildren[0], isA<Text>());
      expect(rowChildren[1], isA<SizedBox>());
      expect(rowChildren[2], isA<SizedBox>());
    });

    testWidgets('has correct spacing between text and indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Bob is typing...',
            ),
          ),
        ),
      );

      final sizedBoxWidgets = tester.widgetList<SizedBox>(
        find.byType(SizedBox),
      );
      final spacingBox = sizedBoxWidgets.firstWhere((box) => box.width == 8);
      expect(spacingBox.width, equals(8));
    });

    testWidgets('has circular progress indicator with correct properties', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Alice is typing...',
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.strokeWidth, equals(2));

      // Check the SizedBox containing the progress indicator
      final indicatorContainer = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ),
      );
      expect(indicatorContainer.width, equals(14));
      expect(indicatorContainer.height, equals(14));
    });

    testWidgets('text has correct italic styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Someone is typing...',
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Someone is typing...'));
      expect(textWidget.style?.fontStyle, equals(FontStyle.italic));
    });

    testWidgets('uses theme colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surfaceContainerHighest: Colors.lightBlue,
            ),
          ),
          home: const Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Typing...',
            ),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container));
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.lightBlue));
    });

    testWidgets('handles different typing texts', (WidgetTester tester) async {
      const typingTexts = [
        'John is typing...',
        'Multiple users are typing...',
        'Someone is typing',
        'typing...',
        'User123 is composing a message...',
      ];

      for (final text in typingTexts) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TypingIndicatorBubble(
                typingText: text,
              ),
            ),
          ),
        );

        expect(find.text(text), findsOneWidget);
      }
    });

    testWidgets('handles empty typing text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: '',
            ),
          ),
        ),
      );

      // Should still render the structure
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('handles long typing text', (WidgetTester tester) async {
      const longText =
          'This is a very long typing indicator text that should be handled gracefully by the widget';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: TypingIndicatorBubble(
                  typingText: longText,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text(longText), findsOneWidget);
    });

    testWidgets('renders consistently in different layouts', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TypingIndicatorBubble(typingText: 'First user is typing...'),
                SizedBox(height: 10),
                TypingIndicatorBubble(typingText: 'Second user is typing...'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('First user is typing...'), findsOneWidget);
      expect(find.text('Second user is typing...'), findsOneWidget);
      expect(find.byType(TypingIndicatorBubble), findsNWidgets(2));
      expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    });

    testWidgets('is accessible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'John is typing...',
            ),
          ),
        ),
      );

      // Should have accessible text and progress indicator
      expect(find.text('John is typing...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('progress indicator animates', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Loading...',
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // The progress indicator should be animating by default
      // We can test that it exists and has the right properties
      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.value, isNull); // Indeterminate progress
    });

    testWidgets('maintains visual consistency across different themes', (
      WidgetTester tester,
    ) async {
      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Dark theme typing...',
            ),
          ),
        ),
      );

      expect(find.text('Dark theme typing...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Test with light theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: TypingIndicatorBubble(
              typingText: 'Light theme typing...',
            ),
          ),
        ),
      );

      expect(find.text('Light theme typing...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
