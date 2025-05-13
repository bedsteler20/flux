import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yaru_window/yaru_window.dart';

@internal
extension YaruWindowExt on YaruWindowInstance {
  Future<void> maximizeOrRestore() async {
    final data = await state();
    if (data.isMaximized ?? false) {
      await restore();
    } else {
      await maximize();
    }
  }
}

class CallbackNavigationObserver extends NavigatorObserver {
  final void Function(Route topRoute, Route? previousTopRoute)? onDidChangeTop;
  final void Function(Route route, Route? previousRoute)? onDidPop;
  final void Function(Route route, Route? previousRoute)? onDidPush;
  final void Function(Route route, Route? previousRoute)? onDidRemove;
  final void Function(Route? newRoute, Route? oldRoute)? onDidReplace;
  final void Function(Route route, Route? previousRoute)? onDidStartUserGesture;
  final void Function()? onDidStopUserGesture;

  CallbackNavigationObserver({
    this.onDidChangeTop,
    this.onDidPop,
    this.onDidPush,
    this.onDidRemove,
    this.onDidReplace,
    this.onDidStartUserGesture,
    this.onDidStopUserGesture,
  });

  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) =>
      onDidChangeTop?.call(topRoute, previousTopRoute);

  @override
  void didPop(Route route, Route? previousRoute) =>
      onDidPop?.call(route, previousRoute);

  @override
  void didPush(Route route, Route? previousRoute) =>
      onDidPush?.call(route, previousRoute);

  @override
  void didRemove(Route route, Route? previousRoute) =>
      onDidRemove?.call(route, previousRoute);

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) =>
      onDidReplace?.call(newRoute, oldRoute);

  @override
  void didStartUserGesture(Route route, Route? previousRoute) =>
      onDidStartUserGesture?.call(route, previousRoute);

  @override
  void didStopUserGesture() => onDidStopUserGesture?.call();
}
