import 'dart:collection';

import 'package:flutter/material.dart';

class ListenableList<T> with ListMixin<T>, ChangeNotifier {
  final List<T> _list;

  ListenableList([List<T> list = const []]) : _list = list;

  @override
  int get length => _list.length;

  @override
  set length(int newLength) {
    _list.length = newLength;
    notifyListeners();
  }

  @override
  T operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, T value) {
    _list[index] = value;
    notifyListeners();
  }
}
