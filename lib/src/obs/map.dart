import 'dart:collection';

import 'package:flutter/material.dart';

class ListenableMap<K, V> with MapMixin<K, V>, ChangeNotifier {
  final Map<K, V> _map;

  ListenableMap([Map<K, V> map = const {}]) : _map = map;

  @override
  V? operator [](Object? key) {
    return _map[key];
  }

  @override
  void operator []=(K key, V value) {
    _map[key] = value;
    notifyListeners();
  }

  @override
  void clear() {
    _map.clear();
    notifyListeners();
  }

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V? remove(Object? key) {
    final value = _map.remove(key);
    notifyListeners();
    return value;
  }
}
