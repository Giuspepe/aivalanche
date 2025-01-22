import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_orientation_plugin/flutter_orientation_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterOrientationPlugin = FlutterOrientationPlugin();
  Timer? _timer;
  List<double>? _orientationAngles;
  double? _azimuth;
  double? _pitch;
  double? _roll;

  void fetchOrientationAngles() async {
    try {
      final angles = await FlutterOrientationPlugin().getOrientationAngles();
      if (angles != null) {
        print('Azimuth: ${angles[0]}, Pitch: ${angles[1]}, Roll: ${angles[2]}');
        setState(() {
          _orientationAngles = angles;
          _azimuth = angles[0];
          _pitch = angles[1];
          _roll = angles[2];
        });
      } else {
        print('No sensor data available yet.');
      }
    } catch (e) {
      print('Error fetching orientation: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      fetchOrientationAngles();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Azimuth: ${_azimuth?.toInt()} °'),
              Text('Pitch: ${_pitch?.toInt()} °'),
              Text('Roll: ${_roll?.toInt()} °'),
            ],
          ),
        ),
      ),
    );
  }
}
