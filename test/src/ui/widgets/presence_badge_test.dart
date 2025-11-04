import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/presence_badge.dart';

void main() {
  group('PresenceBadge', () {
    testWidgets('renders with count', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 5),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.byIcon(Icons.people_alt), findsOneWidget);
    });

    testWidgets('renders with zero count', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 0),
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget);
      expect(find.byIcon(Icons.people_alt), findsOneWidget);
    });

    testWidgets('renders with large count', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 999),
          ),
        ),
      );

      expect(find.text('999'), findsOneWidget);
      expect(find.byIcon(Icons.people_alt), findsOneWidget);
    });

    testWidgets('has correct container styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 3),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container));
      expect(
        containerWidget.padding,
        equals(const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
      );

      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.borderRadius, equals(BorderRadius.circular(12)));
    });

    testWidgets('has correct icon properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              onPrimaryContainer: Colors.blue,
            ),
          ),
          home: const Scaffold(
            body: PresenceBadge(count: 2),
          ),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.icon, equals(Icons.people_alt));
      expect(iconWidget.size, equals(18));
      expect(iconWidget.color, equals(Colors.blue));
    });

    testWidgets('uses theme colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primaryContainer: Colors.purple,
              onPrimaryContainer: Colors.white,
            ),
          ),
          home: const Scaffold(
            body: PresenceBadge(count: 7),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container));
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.purple));

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.color, equals(Colors.white));
    });

    testWidgets('has correct row layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 4),
          ),
        ),
      );

      final rowWidget = tester.widget<Row>(find.byType(Row));
      expect(rowWidget.mainAxisSize, equals(MainAxisSize.min));

      // Should have Icon, SizedBox, and Text as children
      final rowChildren = rowWidget.children;
      expect(rowChildren.length, equals(3));
      expect(rowChildren[0], isA<Icon>());
      expect(rowChildren[1], isA<SizedBox>());
      expect(rowChildren[2], isA<Text>());
    });

    testWidgets('has correct spacing between icon and text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 6),
          ),
        ),
      );

      final sizedBoxWidgets = tester.widgetList<SizedBox>(
        find.byType(SizedBox),
      );
      // Find the SizedBox that's used for spacing (width = 4)
      final spacingBox = sizedBoxWidgets.firstWhere((box) => box.width == 4);
      expect(spacingBox.width, equals(4));
    });

    testWidgets('text has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              onPrimaryContainer: Colors.red,
            ),
            textTheme: const TextTheme(
              labelMedium: TextStyle(fontSize: 14),
            ),
          ),
          home: const Scaffold(
            body: PresenceBadge(count: 8),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('8'));
      expect(textWidget.style?.color, equals(Colors.red));
      expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('handles single digit numbers', (WidgetTester tester) async {
      for (int i = 0; i <= 9; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PresenceBadge(count: i),
            ),
          ),
        );

        expect(find.text('$i'), findsOneWidget);
      }
    });

    testWidgets('handles double digit numbers', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 42),
          ),
        ),
      );

      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('is accessible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PresenceBadge(count: 3),
          ),
        ),
      );

      // Should have accessible icon and text
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('renders multiple badges correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                PresenceBadge(count: 1),
                SizedBox(width: 10),
                PresenceBadge(count: 2),
                SizedBox(width: 10),
                PresenceBadge(count: 3),
              ],
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byType(PresenceBadge), findsNWidgets(3));
      expect(find.byIcon(Icons.people_alt), findsNWidgets(3));
    });

    testWidgets('maintains consistent size with different counts', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                PresenceBadge(count: 1),
                PresenceBadge(count: 10),
                PresenceBadge(count: 100),
              ],
            ),
          ),
        ),
      );

      // All should have the same padding and styling
      final containers = tester.widgetList<Container>(find.byType(Container));
      for (final container in containers) {
        expect(
          container.padding,
          equals(const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, equals(BorderRadius.circular(12)));
      }
    });
  });
}
