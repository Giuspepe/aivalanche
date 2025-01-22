import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'flutter_orientation_plugin_platform_interface.dart';

// Enum to show whether to return angles in radians or degrees
enum AngleUnit {
  radians,
  degrees,
}

/// An implementation of [FlutterOrientationPluginPlatform] that uses method channels.
class MethodChannelFlutterOrientationPlugin
    extends FlutterOrientationPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_orientation_plugin');

  @override
  Future<List<double>?> getOrientationAngles(
      {AngleUnit unit = AngleUnit.degrees}) async {
    final anglesRadians =
        (await methodChannel.invokeMethod<List<dynamic>>('getOrientationAngles'))?.cast<double>();
    switch (unit) {
      case AngleUnit.radians:
        return anglesRadians;
      case AngleUnit.degrees:
        return anglesRadians?.map((angle) => angle * 180 / math.pi).toList();
    }
  }
}
