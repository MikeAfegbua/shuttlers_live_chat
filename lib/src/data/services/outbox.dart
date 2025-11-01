import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OutboxItem {
  OutboxItem({required this.clientId, required this.text});
  factory OutboxItem.fromJson(Map<String, dynamic> json) => OutboxItem(
    clientId: json['clientId'] as String,
    text: json['text'] as String,
  );

  final String clientId;
  final String text;

  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'text': text,
  };
}

class Outbox {
  static const _storageKey = 'shuttlers_chat_outbox';
  final _q = <OutboxItem>[];
  final _stream = StreamController<List<OutboxItem>>.broadcast();
  bool _initialized = false;

  Stream<List<OutboxItem>> get changes => _stream.stream;

  Future<void> init() async {
    if (_initialized) return;
    await _loadFromStorage();
    _initialized = true;
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      if (jsonString != null) {
        final jsonList = json.decode(jsonString) as List;
        _q
          ..clear()
          ..addAll(
            jsonList.map((e) => OutboxItem.fromJson(e as Map<String, dynamic>)),
          );
        _stream.add(List.unmodifiable(_q));
      }
    } on Exception catch (_) {}
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _q.map((item) => item.toJson()).toList();
      await prefs.setString(_storageKey, json.encode(jsonList));
    } on Exception catch (_) {}
  }

  Future<void> add(OutboxItem item) async {
    _q.add(item);
    _stream.add(List.unmodifiable(_q));
    await _saveToStorage();
  }

  List<OutboxItem> peekAll() => List.unmodifiable(_q);

  Future<void> removeById(String clientId) async {
    _q.removeWhere((e) => e.clientId == clientId);
    _stream.add(List.unmodifiable(_q));
    await _saveToStorage();
  }

  bool get isEmpty => _q.isEmpty;
  int get length => _q.length;
}
