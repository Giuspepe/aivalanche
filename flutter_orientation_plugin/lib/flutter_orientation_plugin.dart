import 'flutter_orientation_plugin_platform_interface.dart';

class FlutterOrientationPlugin {
  /// Gets the orientation angles in a list (1. azimuth, 2. pitch, 3. roll).
  Future<List<double>?> getOrientationAngles() {
    return FlutterOrientationPluginPlatform.instance.getOrientationAngles();
  }
}
