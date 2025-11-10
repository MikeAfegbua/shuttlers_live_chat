import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/typing_indicator_bubble.dart';

void main() {
  group('TypingIndicatorBubble', () {
    Widget wrapWithTheme(Widget child) {
      return MaterialApp(
        home: ChatThemeProvider(
          theme: const ChatTheme(),
          child: Scaffold(body: child),
        ),
      );
    }

    testWidgets('renders typing text', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'John is typing...',
          ),
        ),
      );

      expect(find.text('John is typing...'), findsOneWidget);
    });

    testWidgets('has correct alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'Someone is typing...',
          ),
        ),
      );

      final alignWidget = tester.widget<Align>(find.byType(Align));
      expect(alignWidget.alignment, equals(Alignment.centerLeft));
    });

    testWidgets('has correct container styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'User is typing...',
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
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'Multiple users are typing...',
          ),
        ),
      );

      final rowWidget = tester.widget<Row>(find.byType(Row));
      expect(rowWidget.mainAxisSize, equals(MainAxisSize.min));

      final rowChildren = rowWidget.children;
      expect(rowChildren.length, equals(3));
      expect(rowChildren[0], isA<Text>());
      expect(rowChildren[1], isA<SizedBox>());
      expect(rowChildren[2], isA<SizedBox>());
    });

    testWidgets('shows circular progress indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'Typing...',
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.strokeWidth, equals(2));
    });

    testWidgets('has circular progress indicator in sized box', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'Typing...',
          ),
        ),
      );

      final sizedBoxFinder = find.descendant(
        of: find.byType(Row),
        matching: find.byType(SizedBox),
      );

      expect(sizedBoxFinder, findsNWidgets(2));

      final sizedBoxWidgets =
          tester.widgetList<SizedBox>(sizedBoxFinder).toList();
      expect(sizedBoxWidgets[0].width, equals(8));
      expect(sizedBoxWidgets[1].width, equals(14));
      expect(sizedBoxWidgets[1].height, equals(14));
    });

    testWidgets('maintains proper spacing', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: 'Loading...',
          ),
        ),
      );

      final sizedBoxWidgets =
          tester
              .widgetList<SizedBox>(
                find.descendant(
                  of: find.byType(Row),
                  matching: find.byType(SizedBox),
                ),
              )
              .toList();

      expect(sizedBoxWidgets.length, equals(2));
      expect(sizedBoxWidgets[0].width, equals(8));
      expect(sizedBoxWidgets[1].width, equals(14));
      expect(sizedBoxWidgets[1].height, equals(14));
    });

    testWidgets('respects custom typing text', (WidgetTester tester) async {
      const customText = 'Agent is responding...';

      await tester.pumpWidget(
        wrapWithTheme(
          const TypingIndicatorBubble(
            typingText: customText,
          ),
        ),
      );

      expect(find.text(customText), findsOneWidget);
    });

    testWidgets('uses theme color for indicator', (WidgetTester tester) async {
      const testColor = Colors.purple;

      await tester.pumpWidget(
        const MaterialApp(
          home: ChatThemeProvider(
            theme: ChatTheme(typingIndicatorColor: testColor),
            child: Scaffold(
              body: TypingIndicatorBubble(
                typingText: 'Typing...',
              ),
            ),
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.color, equals(testColor));
    });
  });
}
