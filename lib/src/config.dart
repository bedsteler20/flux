import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux/src/utils.dart';
import 'package:json_theme/json_theme.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;
import 'package:yaml/yaml.dart';

class FluxConfig {
  final FluxPropertiesConfig properties;
  final FluxBreakpointsConfig breakpoints;
  final ThemeData theme;

  const FluxConfig({
    required this.properties,
    required this.breakpoints,
    required this.theme,
  });

  static Future<FluxConfig> load() async {
    SchemaValidator.enabled = !kDebugMode;
    final configFile = File("${xdg.configHome.path}/flux/flux.yaml");

    if (!configFile.existsSync()) {
      final assetContent = await rootBundle
          .loadString('packages/flux/lib/assets/default_settings.yaml');
      configFile.createSync(recursive: true);
      configFile.writeAsStringSync(assetContent);
      return FluxConfig.fromJson(loadYaml(assetContent));
    }

    try {
      final yaml = configFile.readAsStringSync();
      return FluxConfig.fromJson(loadYaml(yaml));
    } catch (e) {
      stderr.writeln('Failed to load config file: $e');
      await zenityError("Failed to load flux config ", e.toString());
      exit(1);
    }
  }

  factory FluxConfig.fromJson(YamlMap json) {
    return FluxConfig(
      properties: FluxPropertiesConfig.fromJson(json['properties']),
      breakpoints: FluxBreakpointsConfig.fromJson(json['breakpoints']),
      theme: ThemeDecoder.decodeThemeData(json['theme'])!,
    );
  }
}

class FluxPropertiesConfig {
  final bool useClientSideDecorations;

  const FluxPropertiesConfig({
    required this.useClientSideDecorations,
  });

  factory FluxPropertiesConfig.fromJson(YamlMap json) {
    return FluxPropertiesConfig(
      useClientSideDecorations: json['useClientSideDecorations'] as bool,
    );
  }
}

class FluxBreakpointsConfig {
  final num xs;
  final num sm;
  final num md;
  final num lg;
  final num xl;
  final num xxl;

  const FluxBreakpointsConfig({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  factory FluxBreakpointsConfig.fromJson(YamlMap json) {
    return FluxBreakpointsConfig(
      xs: json['xs'] as num,
      sm: json['sm'] as num,
      md: json['md'] as num,
      lg: json['lg'] as num,
      xl: json['xl'] as num,
      xxl: json['xxl'] as num,
    );
  }
}
