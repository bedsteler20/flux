import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:meta/meta.dart';
import 'package:yaru_window/yaru_window.dart';

class Flux {
  @internal
  static late final YaruWindowInstance yaruWindow;

  @internal
  static late final bool showMinimizeButton;
  @internal
  static late final bool showMaximizeButton;

  static Future<void> ensureInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    yaruWindow = await YaruWindow.ensureInitialized();
    await yaruWindow.hideTitle();
    final gsettings = GSettings("org.gnome.desktop.wm.preferences");
    final buttonLayout = (await gsettings.get("button-layout")).asString();
    showMinimizeButton = buttonLayout.contains("minimize");
    showMaximizeButton = buttonLayout.contains("maximize");
  }
}
