// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flux/flux.dart';
import 'package:meta/meta.dart';

class FluxBreakpoint {
  final double value;
  
  @internal
  const FluxBreakpoint(this.value);
}
late final FluxBreakpoint XS;
late final FluxBreakpoint SM;
late final FluxBreakpoint MD;
late final FluxBreakpoint LG;
late final FluxBreakpoint XL;
late final FluxBreakpoint XXL;

extension ContextExtension on BuildContext {
  FluxConfig get fluxConfig => Flux.config;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Brightness get brightness => theme.brightness;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
  Orientation get orientation => mediaQuery.orientation;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  bool get isDark => brightness == Brightness.dark;
  bool get isLight => brightness == Brightness.light;

  bool isScreenSize(FluxBreakpoint breakpoint) => width >= breakpoint.value;
  double breakpoint(FluxBreakpoint breakpoint) => breakpoint.value;
}
