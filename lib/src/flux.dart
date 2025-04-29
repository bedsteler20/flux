import 'package:flux/flux.dart';
import 'package:flux/src/config.dart';
import 'package:meta/meta.dart';
import 'package:yaru_window/yaru_window.dart';

class Flux {
  @internal
  static late final YaruWindowInstance yaruWindow;

  static late final FluxConfig config;

  static Future<void> ensureInitialized() async {
    config = await FluxConfig.load();
    yaruWindow = await YaruWindow.ensureInitialized();
    _setupBreakpoints();
    await _setupWindow();
  }

  static Future<void> _setupWindow() async {
    if (config.properties.useClientSideDecorations) {
      await yaruWindow.hideTitle();
    }
  }

  static void _setupBreakpoints() {
    XS = FluxBreakpoint(config.breakpoints.xs.toDouble());
    SM = FluxBreakpoint(config.breakpoints.sm.toDouble());
    MD = FluxBreakpoint(config.breakpoints.md.toDouble());
    LG = FluxBreakpoint(config.breakpoints.lg.toDouble());
    XL = FluxBreakpoint(config.breakpoints.xl.toDouble());
    XXL = FluxBreakpoint(config.breakpoints.xxl.toDouble());
  }
}
