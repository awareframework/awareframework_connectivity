import 'dart:async';

import 'package:flutter/services.dart';
import 'package:awareframework_core/awareframework_core.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// init sensor
class ConnectivitySensor extends AwareSensorCore {

  static const MethodChannel _connectivityMethod = const MethodChannel('awareframework_connectivity/method');
  static const EventChannel  _connectivityStream  = const EventChannel('awareframework_connectivity/event');

  static const EventChannel  _onInternetOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onInternetOn);
  static const EventChannel  _onInternetOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onInternetOff);

  static const EventChannel  _onGPSOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onGPSOn);
  static const EventChannel  _onGPSOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onGPSOff);

  static const EventChannel  _onBluetoothOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onBluetoothOn);
  static const EventChannel  _onBluetoothOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onBluetoothOff);

  static const EventChannel  _onBackgroundRefreshOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onBackgroundRefreshOn);
  static const EventChannel  _onBackgroundRefreshOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onBackgroundRefreshOff);

  static const EventChannel  _onLowPowerModeOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onLowPowerModeOn);
  static const EventChannel  _onLowPowerModeOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onLowPowerModeOff);

  static const EventChannel  _onPushNotificationOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onPushNotificationOn);
  static const EventChannel  _onPushNotificationOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onPushNotificationOff);

  static const EventChannel  _onWifiOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onWifiOn);
  static const EventChannel  _onWifiOffStream = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys._onWifiOff);

  /// Init Connectivity Sensor with ConnectivitySensorConfig
  ConnectivitySensor(ConnectivitySensorConfig config):this.convenience(config);
  ConnectivitySensor.convenience(config) : super(config){
    /// Set sensor method & event channels
    super.setSensorChannels(_connectivityMethod, _connectivityStream);
  }

  /// A sensor observer instance
  Stream<Map<String,dynamic>> get onDataChanged {
     return super.receiveBroadcastStream("on_data_changed").map((dynamic event) => Map<String,dynamic>.from(event));
  }

  Stream<dynamic> get onInternetOn{
    return _onInternetOnStream.receiveBroadcastStream([ConnectivityKeys._onInternetOn]);
  }

  Stream<dynamic> get onInternetOff{
    return _onInternetOffStream.receiveBroadcastStream([ConnectivityKeys._onInternetOff]);
  }

  Stream<dynamic> get onGPSOn{
    return _onGPSOnStream.receiveBroadcastStream([ConnectivityKeys._onGPSOn]);
  }

  Stream<dynamic> get onGPSOff {
    return _onGPSOffStream.receiveBroadcastStream([ConnectivityKeys._onGPSOff]);
  }

  Stream<dynamic> get onBluetoothOnStream {
    return _onBluetoothOnStream.receiveBroadcastStream([ConnectivityKeys._onBluetoothOn]);
  }

  Stream<dynamic> get onBluetoothOffStream {
    return _onBluetoothOffStream.receiveBroadcastStream([ConnectivityKeys._onBluetoothOff]);
  }
  
  Stream<dynamic> get onBackgroundRefreshOn {
    return _onBackgroundRefreshOnStream.receiveBroadcastStream([ConnectivityKeys._onBackgroundRefreshOn]);
  }

  Stream<dynamic> get onBackgroundRefreshOff {
    return _onBackgroundRefreshOffStream.receiveBroadcastStream([ConnectivityKeys._onBackgroundRefreshOff]);
  }

  Stream<dynamic> get onLowPowerModeOn {
    return _onLowPowerModeOnStream.receiveBroadcastStream([ConnectivityKeys._onLowPowerModeOn]);
  }

  Stream<dynamic> get onLowPowerModeOff {
    return _onLowPowerModeOffStream.receiveBroadcastStream([ConnectivityKeys._onLowPowerModeOff]);
  }

  Stream<dynamic> get onPushNotificationOn {
    return _onPushNotificationOnStream.receiveBroadcastStream([ConnectivityKeys._onPushNotificationOn]);
  }

  Stream<dynamic> get onPushNotificationOff {
    return _onPushNotificationOffStream.receiveBroadcastStream([ConnectivityKeys._onPushNotificationOff]);
  }

  Stream<dynamic> get onWifiOn {
    return _onWifiOnStream.receiveBroadcastStream([ConnectivityKeys._onWifiOn]);
  }

  Stream<dynamic> get onWifiOff {
    return _onWifiOffStream.receiveBroadcastStream([ConnectivityKeys._onWifiOff]);
  }



}

class ConnectivitySensorConfig extends AwareSensorConfig{
  ConnectivitySensorConfig();

  /// TODO

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    return map;
  }
}

/// Make an AwareWidget
class ConnectivityCard extends StatefulWidget {
  ConnectivityCard({Key key, @required this.sensor}) : super(key: key);

  ConnectivitySensor sensor;

  @override
  ConnectivityCardState createState() => new ConnectivityCardState();
}


class ConnectivityKeys {
  static const String _onInternetOn = "on_internet_on";
  static const String _onInternetOff = "on_internet_off";

  static const String _onGPSOn  = "on_gps_on";
  static const String _onGPSOff = "on_gps_off";

  static const String _onBluetoothOn = "on_bluetooth_on";
  static const String _onBluetoothOff = "on_bluetooth_off";

  static const String _onBackgroundRefreshOn = "on_background_refresh_on";
  static const String _onBackgroundRefreshOff = "on_background_refresh_off";

  static const String _onLowPowerModeOn = "on_low_power_mode_on";
  static const String _onLowPowerModeOff = "on_low_power_mode_off";

  static const String _onPushNotificationOn = "on_push_notification_on";
  static const String _onPushNotificationOff = "on_push_notification_off";

  static const String _onWifiOn = "on_wifi_on";
  static const String _onWifiOff = "on_wifi_off";
}


class ConnectivityCardState extends State<ConnectivityCard> {

  String internet = "---";
  String gps = "---";
  String bluetooth = "---";
  String background = "---";
  String lowPowerMode = "---";
  String pushNotification = "---";
  String wifi = "---";

  @override
  void initState() {

    super.initState();
    // set observer
    widget.sensor.onInternetOn.listen((event) {
      setState((){  internet = "on";  });
    });
    widget.sensor.onInternetOff.listen((event) {
      setState((){  internet = "off"; });
    });
    widget.sensor.onGPSOn.listen((event) {
      setState((){  gps = "on"; });
    });
    widget.sensor.onGPSOff.listen((event) {
      setState((){  gps = "off"; });
    });
    widget.sensor.onBluetoothOnStream.listen((event) {
      setState((){  bluetooth = "on"; });
    });
    widget.sensor.onBluetoothOffStream.listen((event) {
      setState((){  bluetooth = "off"; });
    });
    widget.sensor.onBackgroundRefreshOn.listen((event) {
      setState((){  background = "on"; });
    });
    widget.sensor.onBackgroundRefreshOff.listen((event) {
      setState((){  background = "off";  });
    });
    widget.sensor.onLowPowerModeOn.listen((event) {
      setState((){  lowPowerMode = "on"; });
    });
    widget.sensor.onLowPowerModeOff.listen((event) {
      setState((){  lowPowerMode = "off"; });
    });
    widget.sensor.onPushNotificationOn.listen((event) {
      setState((){  pushNotification = "on"; });
    });
    widget.sensor.onPushNotificationOff.listen((event) {
      setState((){  pushNotification = "off"; });
    });
    widget.sensor.onWifiOn.listen((event) {
      setState((){  wifi = "on"; });
    });
    widget.sensor.onWifiOff.listen((event) {
      setState((){  wifi = "off"; });
    });
    // print(widget.sensor);
  }

  @override
  Widget build(BuildContext context) {
    return new AwareCard(
      contentWidget: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: new Text("Internet: $internet\nGPS: $gps\nBluetooth: $bluetooth\nBackground Refresh: $background\nLow-Power Mode: $lowPowerMode\nPush Notification: $pushNotification\nWiFi: $wifi"),
        ),
      title: "Connectivity",
      sensor: widget.sensor
    );
  }

}
