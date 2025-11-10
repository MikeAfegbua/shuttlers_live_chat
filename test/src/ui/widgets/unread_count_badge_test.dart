import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/unread_count_badge.dart';

class MockRepository {
  final StreamController<int> _controller = StreamController<int>.broadcast();

  Stream<int> get onUnreadCountChanged => _controller.stream;

  void emitCount(int count) {
    _controller.add(count);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

  tearDown(() async {
    await mockRepository.dispose();
  });

  Widget buildTestWidget({
    Widget? child,
    bool showZero = false,
    int maxCount = 99,
    Color? backgroundColor,
    Color? textColor,
    Alignment alignment = Alignment.topRight,
    Offset offset = const Offset(4, -4),
  }) {
    return MaterialApp(
      home: Scaffold(
        body: UnreadCountBadge(
          countStream: mockRepository.onUnreadCountChanged,
          showZero: showZero,
          maxCount: maxCount,
          backgroundColor: backgroundColor,
          textColor: textColor,
          alignment: alignment,
          offset: offset,
          child: child ?? const Icon(Icons.chat, size: 48),
        ),
      ),
    );
  }

  group('UnreadCountBadge', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const Text('Chat'),
        ),
      );

      expect(find.text('Chat'), findsOneWidget);
    });

    testWidgets('hides badge when count is 0 by default', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('0'), findsNothing);
    });

    testWidgets('shows badge when showZero is true and count is 0', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(showZero: true));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('displays badge with correct count', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      mockRepository.emitCount(5);
      await tester.pump();

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('updates badge when count changes', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      mockRepository.emitCount(3);
      await tester.pump();
      expect(find.text('3'), findsOneWidget);

      mockRepository.emitCount(7);
      await tester.pump();
      await tester.pump();
      expect(find.text('7'), findsOneWidget);
      expect(find.text('3'), findsNothing);
    });

    testWidgets('displays 99+ when count exceeds maxCount', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      mockRepository.emitCount(150);
      await tester.pump();

      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('respects custom maxCount', (tester) async {
      await tester.pumpWidget(buildTestWidget(maxCount: 50));

      mockRepository.emitCount(75);
      await tester.pump();

      expect(find.text('50+'), findsOneWidget);
    });

    testWidgets('applies custom background color', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          backgroundColor: Colors.blue,
          showZero: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Container).last,
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, equals(Colors.blue));
    });

    testWidgets('applies custom text color', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          textColor: Colors.yellow,
          showZero: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final text = tester.widget<Text>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Text).last,
        ),
      );

      expect(text.style?.color, equals(Colors.yellow));
    });

    testWidgets('uses theme colors by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(showZero: true),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Container).last,
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, isNotNull);
    });

    testWidgets('positions badge at topRight by default', (tester) async {
      await tester.pumpWidget(buildTestWidget(showZero: true));
      await tester.pump(const Duration(milliseconds: 100));

      final align = tester.widget<Align>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Align),
        ),
      );

      expect(align.alignment, equals(Alignment.topRight));
    });

    testWidgets('respects custom alignment', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          alignment: Alignment.bottomLeft,
          showZero: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final align = tester.widget<Align>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Align),
        ),
      );

      expect(align.alignment, equals(Alignment.bottomLeft));
    });

    testWidgets('applies offset transformation', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          offset: const Offset(10, -10),
          showZero: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final transform = tester.widget<Transform>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Transform),
        ),
      );

      expect(transform.transform.getTranslation().x, equals(10));
      expect(transform.transform.getTranslation().y, equals(-10));
    });

    testWidgets('shows badge when count becomes greater than 0', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('0'), findsNothing);

      mockRepository.emitCount(1);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('hides badge when count returns to 0', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      mockRepository.emitCount(5);
      await tester.pump();
      expect(find.text('5'), findsOneWidget);

      mockRepository.emitCount(0);
      await tester.pump();
      expect(find.text('0'), findsNothing);
    });

    testWidgets('badge has rounded corners', (tester) async {
      await tester.pumpWidget(buildTestWidget(showZero: true));
      await tester.pump(const Duration(milliseconds: 100));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Container).last,
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      final borderRadius = decoration.borderRadius! as BorderRadius;
      expect(borderRadius.topLeft.x, equals(10));
    });

    testWidgets('badge has border', (tester) async {
      await tester.pumpWidget(buildTestWidget(showZero: true));
      await tester.pump(const Duration(milliseconds: 100));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(UnreadCountBadge),
          matching: find.byType(Container).last,
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.border, isNotNull);
    });

    testWidgets('handles rapid count updates', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      for (var i = 1; i <= 10; i++) {
        mockRepository.emitCount(i);
        await tester.pump();
        await tester.pump();
      }

      expect(find.text('10'), findsOneWidget);
    });
  });
}
