import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/ui/utils/uuid_generator.dart';

void main() {
  group('UuidGenerator', () {
    test('should generate UUID v4 format', () {
      final uuid = UuidGenerator.generate();

      expect(
        uuid,
        matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{8}-[0-9a-f]{8}-[0-9a-f]{8}$')),
      );
    });

    test('should generate unique UUIDs', () {
      final uuid1 = UuidGenerator.generate();
      final uuid2 = UuidGenerator.generate();
      final uuid3 = UuidGenerator.generate();

      expect(uuid1, isNot(equals(uuid2)));
      expect(uuid1, isNot(equals(uuid3)));
      expect(uuid2, isNot(equals(uuid3)));
    });

    test('should generate 100 unique UUIDs', () {
      final uuids = <String>{};

      for (var i = 0; i < 100; i++) {
        uuids.add(UuidGenerator.generate());
      }

      expect(uuids.length, 100);
    });

    test('should generate UUIDs with correct segment lengths', () {
      final uuid = UuidGenerator.generate();
      final parts = uuid.split('-');

      expect(parts.length, 4);
      expect(parts[0].length, 8);
      expect(parts[1].length, 8);
      expect(parts[2].length, 8);
      expect(parts[3].length, 8);
    });

    test('should generate lowercase hexadecimal UUIDs', () {
      final uuid = UuidGenerator.generate();

      expect(uuid, matches(RegExp(r'^[0-9a-f-]+$')));
      expect(uuid, isNot(contains(RegExp('[A-F]'))));
    });
  });
}
