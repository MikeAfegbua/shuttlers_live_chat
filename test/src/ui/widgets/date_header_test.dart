import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/date_header.dart';

void main() {
  group('DateHeader', () {
    Widget wrapWithTheme(Widget child) {
      return MaterialApp(
        home: ChatThemeProvider(
          theme: const ChatTheme(),
          child: Scaffold(body: child),
        ),
      );
    }

    testWidgets('renders date text', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const DateHeader(text: 'Today'),
        ),
      );

      expect(find.text('Today'), findsOneWidget);
    });

    testWidgets('has correct styling and layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const DateHeader(text: 'Yesterday'),
        ),
      );

      expect(find.byType(DateHeader), findsOneWidget);

      final containerWidgets = tester.widgetList<Container>(
        find.byType(Container),
      );
      final containerWidget = containerWidgets.firstWhere(
        (container) =>
            container.padding ==
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      );
      expect(
        containerWidget.padding,
        equals(const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
      );

      final decoration = containerWidget.decoration! as BoxDecoration;
      expect(decoration.borderRadius, equals(BorderRadius.circular(12)));
    });

    testWidgets('displays different date strings', (WidgetTester tester) async {
      const testDates = [
        'Today',
        'Yesterday',
        'Monday, Jan 15',
        'December 25, 2023',
        '2024-01-01',
      ];

      for (final dateText in testDates) {
        await tester.pumpWidget(
          wrapWithTheme(
            DateHeader(text: dateText),
          ),
        );

        expect(find.text(dateText), findsOneWidget);
      }
    });

    testWidgets('handles empty string', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const DateHeader(text: ''),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('handles long text', (WidgetTester tester) async {
      const longText =
          'This is a very long date header text that might wrap to multiple lines';

      await tester.pumpWidget(
        wrapWithTheme(
          const SizedBox(
            width: 200,
            child: DateHeader(text: longText),
          ),
        ),
      );

      expect(find.text(longText), findsOneWidget);
    });

    testWidgets('uses theme colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surfaceContainerHighest: Colors.blue,
              onSurfaceVariant: Colors.purple,
            ),
            textTheme: const TextTheme(
              labelSmall: TextStyle(fontSize: 12),
            ),
          ),
          home: const ChatThemeProvider(
            theme: ChatTheme(),
            child: Scaffold(
              body: DateHeader(text: 'Today'),
            ),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container));
      final decoration = containerWidget.decoration! as BoxDecoration;
      expect(decoration.color, equals(Colors.blue));
    });

    testWidgets('is accessible', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const DateHeader(text: 'Today'),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
    });

    testWidgets('renders in different contexts', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const Column(
            children: [
              DateHeader(text: 'First Header'),
              SizedBox(height: 20),
              DateHeader(text: 'Second Header'),
            ],
          ),
        ),
      );

      expect(find.text('First Header'), findsOneWidget);
      expect(find.text('Second Header'), findsOneWidget);
      expect(find.byType(DateHeader), findsNWidgets(2));
    });

    testWidgets('maintains layout consistency', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const Column(
            children: [
              DateHeader(text: 'Short'),
              DateHeader(text: 'Medium length text'),
              DateHeader(
                text:
                    'Very long text that should still be formatted consistently',
              ),
            ],
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, equals(3));

      for (final container in containers) {
        expect(
          container.padding,
          equals(const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
        );
        final decoration = container.decoration! as BoxDecoration;
        expect(decoration.borderRadius, equals(BorderRadius.circular(12)));
      }
    });
  });
}
