import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_orientation_plugin_method_channel.dart';

abstract class FlutterOrientationPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterOrientationPluginPlatform.
  FlutterOrientationPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterOrientationPluginPlatform _instance = MethodChannelFlutterOrientationPlugin();

  /// The default instance of [FlutterOrientationPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterOrientationPlugin].
  static FlutterOrientationPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterOrientationPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterOrientationPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Abstract method for getting orientation angles.
  Future<List<double>?> getOrientationAngles() {
    throw UnimplementedError('getOrientationAngles() has not been implemented.');
  }
}
