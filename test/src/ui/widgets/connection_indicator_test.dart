import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/connection_indicator.dart';

void main() {
  group('ConnectionIndicator', () {
    testWidgets('shows connected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ConnectionIndicator(isConnected: true),
          ),
        ),
      );

      // Should show wifi icon
      expect(find.byIcon(Icons.wifi), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsNothing);

      // Should have green color for connected state
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.icon, equals(Icons.wifi));
      expect(iconWidget.color, equals(Colors.green));
      expect(iconWidget.size, equals(20));
    });

    testWidgets('shows disconnected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              error: Colors.red,
            ),
          ),
          home: const Scaffold(
            body: ConnectionIndicator(isConnected: false),
          ),
        ),
      );

      // Should show wifi_off icon
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsNothing);

      // Should have error color for disconnected state
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.icon, equals(Icons.wifi_off));
      expect(iconWidget.color, equals(Colors.red));
      expect(iconWidget.size, equals(20));
    });

    testWidgets('has correct icon size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ConnectionIndicator(isConnected: true),
          ),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.size, equals(20));
    });

    testWidgets('renders with different themes', (WidgetTester tester) async {
      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark().copyWith(
            colorScheme: ThemeData.dark().colorScheme.copyWith(
              error: Colors.orange,
            ),
          ),
          home: const Scaffold(
            body: ConnectionIndicator(isConnected: false),
          ),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.color, equals(Colors.orange));
    });

    testWidgets('is accessible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ConnectionIndicator(isConnected: true),
          ),
        ),
      );

      // Should have Icon widget which is inherently accessible
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('handles state changes', (WidgetTester tester) async {
      bool isConnected = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    ConnectionIndicator(isConnected: isConnected),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isConnected = !isConnected;
                        });
                      },
                      child: const Text('Toggle'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Initially connected
      expect(find.byIcon(Icons.wifi), findsOneWidget);

      // Tap to toggle
      await tester.tap(find.text('Toggle'));
      await tester.pumpAndSettle();

      // Now disconnected
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsNothing);
    });
  });
}
