import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:xdg_desktop_portal/xdg_desktop_portal.dart';
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
    try {
      final client = XdgDesktopPortalClient();
      final buttonLayout = (await client.settings
              .read("org.gnome.desktop.wm.preferences", "button-layout"))
          .asVariant()
          .asString();
      showMinimizeButton = buttonLayout.contains("minimize");
      showMaximizeButton = buttonLayout.contains("maximize");
    } catch (e) {
      showMinimizeButton = true;
      showMaximizeButton = true;
    }
  }
}
