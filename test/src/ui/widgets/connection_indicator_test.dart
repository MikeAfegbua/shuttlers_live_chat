import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme_provider.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/connection_indicator.dart';

void main() {
  group('ConnectionIndicator', () {
    Widget wrapWithTheme(Widget child) {
      return MaterialApp(
        home: ChatThemeProvider(
          theme: const ChatTheme(),
          child: Scaffold(body: child),
        ),
      );
    }

    testWidgets('shows connected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const ConnectionIndicator(isConnected: true),
        ),
      );

      expect(find.byIcon(Icons.wifi), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsNothing);

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.icon, equals(Icons.wifi));
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
          home: const ChatThemeProvider(
            theme: ChatTheme(),
            child: Scaffold(
              body: ConnectionIndicator(isConnected: false),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsNothing);

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.icon, equals(Icons.wifi_off));
      expect(iconWidget.size, equals(20));
    });

    testWidgets('has correct icon size', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const ConnectionIndicator(isConnected: true),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.size, equals(20));
    });

    testWidgets('toggles between states', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const ConnectionIndicator(isConnected: true),
        ),
      );

      expect(find.byIcon(Icons.wifi), findsOneWidget);

      await tester.pumpWidget(
        wrapWithTheme(
          const ConnectionIndicator(isConnected: false),
        ),
      );

      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsNothing);
    });

    testWidgets('renders in app bar context', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChatThemeProvider(
            theme: const ChatTheme(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Test'),
                actions: const [
                  ConnectionIndicator(isConnected: true),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ConnectionIndicator), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsOneWidget);
    });
  });
}
