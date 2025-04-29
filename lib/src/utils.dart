import 'dart:io';

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

Future<void> zenityError(String title, String message) async {
  await Process.run('zenity', ['--error', '--title', title, '--text', message]);
}
