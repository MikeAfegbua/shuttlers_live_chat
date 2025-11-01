import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttlers_live_chat/src/data/services/outbox.dart';

void main() {
  late Outbox outbox;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    outbox = Outbox();
    await outbox.init();
  });

  group('Outbox', () {
    test('should initialize with empty queue', () {
      expect(outbox.isEmpty, isTrue);
      expect(outbox.length, 0);
    });

    test('should add item to queue', () async {
      final item = OutboxItem(clientId: 'client1', text: 'Hello');
      await outbox.add(item);

      expect(outbox.isEmpty, isFalse);
      expect(outbox.length, 1);
      expect(outbox.peekAll().first.clientId, 'client1');
      expect(outbox.peekAll().first.text, 'Hello');
    });

    test('should remove item by client ID', () async {
      final item1 = OutboxItem(clientId: 'client1', text: 'Hello');
      final item2 = OutboxItem(clientId: 'client2', text: 'World');

      await outbox.add(item1);
      await outbox.add(item2);

      expect(outbox.length, 2);

      await outbox.removeById('client1');

      expect(outbox.length, 1);
      expect(outbox.peekAll().first.clientId, 'client2');
    });

    test('should persist queue to SharedPreferences', () async {
      final item = OutboxItem(clientId: 'client1', text: 'Hello');
      await outbox.add(item);

      final newOutbox = Outbox();
      await newOutbox.init();

      expect(newOutbox.length, 1);
      expect(newOutbox.peekAll().first.clientId, 'client1');
      expect(newOutbox.peekAll().first.text, 'Hello');
    });

    test('should clear queue when all items removed', () async {
      final item1 = OutboxItem(clientId: 'client1', text: 'Hello');
      final item2 = OutboxItem(clientId: 'client2', text: 'World');

      await outbox.add(item1);
      await outbox.add(item2);

      await outbox.removeById('client1');
      await outbox.removeById('client2');

      expect(outbox.isEmpty, isTrue);
      expect(outbox.length, 0);
    });

    test('should emit changes through stream', () async {
      final item = OutboxItem(clientId: 'client1', text: 'Hello');

      final events = <List<OutboxItem>>[];
      final subscription = outbox.changes.listen(events.add);

      await outbox.add(item);
      await outbox.removeById('client1');

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(events.length, 2);
      expect(events[0].length, 1);
      expect(events[1].isEmpty, isTrue);

      await subscription.cancel();
    });

    test('should serialize and deserialize OutboxItem correctly', () {
      final item = OutboxItem(clientId: 'client1', text: 'Hello World');
      final json = item.toJson();

      expect(json['clientId'], 'client1');
      expect(json['text'], 'Hello World');

      final restored = OutboxItem.fromJson(json);
      expect(restored.clientId, 'client1');
      expect(restored.text, 'Hello World');
    });
  });
}
