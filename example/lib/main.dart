import 'package:flutter/material.dart';

import 'package:awareframework_connectivity/awareframework_connectivity.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ConnectivitySensor sensor;
  ConnectivitySensorConfig config;

  @override
  void initState() {
    super.initState();

    config = ConnectivitySensorConfig()
      ..debug = true;

    sensor = new ConnectivitySensor.init(config);

    sensor.start();

  }

  @override
  Widget build(BuildContext context) {


    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Plugin Example App'),
          ),
          body: new ConnectivityCard(sensor: sensor,)
      ),
    );
  }
}
