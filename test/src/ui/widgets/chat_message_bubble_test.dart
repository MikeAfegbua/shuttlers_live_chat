import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/data/models/chat_message.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/chat_message_bubble.dart';

void main() {
  group('ChatMessageBubble', () {
    late ChatMessage testMessage;

    setUp(() {
      testMessage = ChatMessage(
        id: 'msg-123',
        clientId: 'client-456',
        tripId: 'trip-789',
        userId: 'user-abc',
        username: 'TestUser',
        text: 'Hello world!',
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );
    });

    testWidgets('renders message from other user', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: false,
            ),
          ),
        ),
      );

      expect(find.text('Hello world!'), findsOneWidget);

      expect(find.text('TestUser'), findsOneWidget);

      expect(find.text('10:30 AM'), findsOneWidget);
    });

    testWidgets('renders message from current user', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: true,
            ),
          ),
        ),
      );

      expect(find.text('Hello world!'), findsOneWidget);

      expect(find.text('TestUser'), findsNothing);

      expect(find.text('10:30 AM'), findsOneWidget);
    });

    testWidgets('renders pending message with reduced opacity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: true,
              deliveryStatus: 'sending',
            ),
          ),
        ),
      );

      expect(find.text('Hello world!'), findsOneWidget);

      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, equals(0.5));
    });

    testWidgets('renders sent message with reduced opacity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: true,
              deliveryStatus: 'sent',
            ),
          ),
        ),
      );

      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, equals(0.5));
    });

    testWidgets('renders delivered message with full opacity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: true,
              deliveryStatus: 'delivered',
            ),
          ),
        ),
      );

      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, equals(1.0));
    });

    testWidgets('renders message without delivery status with full opacity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: true,
            ),
          ),
        ),
      );

      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, equals(1.0));
    });

    testWidgets('aligns my messages to the right', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: true,
            ),
          ),
        ),
      );

      final alignWidget = tester.widget<Align>(find.byType(Align));
      expect(alignWidget.alignment, equals(Alignment.centerRight));
    });

    testWidgets('aligns other messages to the left', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: false,
            ),
          ),
        ),
      );

      final alignWidget = tester.widget<Align>(find.byType(Align));
      expect(alignWidget.alignment, equals(Alignment.centerLeft));
    });

    testWidgets('has correct container styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatMessageBubble(
              message: testMessage,
              isMe: false,
            ),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(
        find.descendant(
          of: find.byType(Align),
          matching: find.byType(Container),
        ),
      );

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

    testWidgets('handles long text gracefully', (WidgetTester tester) async {
      final longMessage = testMessage.copyWith(
        text:
            'This is a very long message that should wrap to multiple lines and test the flexible widget behavior within the bubble.',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              child: ChatMessageBubble(
                message: longMessage,
                isMe: false,
              ),
            ),
          ),
        ),
      );

      expect(
        find.textContaining('This is a very long message'),
        findsOneWidget,
      );

      expect(find.byType(Flexible), findsOneWidget);
    });

    testWidgets('shows different styling for current user vs others', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ChatMessageBubble(
                  key: const Key('my-message'),
                  message: testMessage,
                  isMe: true,
                ),
                ChatMessageBubble(
                  key: const Key('other-message'),
                  message: testMessage,
                  isMe: false,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Hello world!'), findsNWidgets(2));

      expect(find.text('TestUser'), findsOneWidget);
    });
  });
}
