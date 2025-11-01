import 'dart:math';

extension UuidGenerator on String {
  static String generate() {
    final r = Random();
    String n() => r.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
    return '${n()}-${n()}-${n()}-${n()}';
  }
}
