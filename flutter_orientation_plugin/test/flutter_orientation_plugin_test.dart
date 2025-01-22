import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_orientation_plugin/flutter_orientation_plugin.dart';
import 'package:flutter_orientation_plugin/flutter_orientation_plugin_platform_interface.dart';
import 'package:flutter_orientation_plugin/flutter_orientation_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterOrientationPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterOrientationPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterOrientationPluginPlatform initialPlatform = FlutterOrientationPluginPlatform.instance;

  test('$MethodChannelFlutterOrientationPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterOrientationPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterOrientationPlugin flutterOrientationPlugin = FlutterOrientationPlugin();
    MockFlutterOrientationPluginPlatform fakePlatform = MockFlutterOrientationPluginPlatform();
    FlutterOrientationPluginPlatform.instance = fakePlatform;

    expect(await flutterOrientationPlugin.getPlatformVersion(), '42');
  });
}
