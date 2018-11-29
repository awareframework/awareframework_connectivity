import 'dart:async';

import 'package:flutter/services.dart';
import 'package:awareframework_core/awareframework_core.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// init sensor
class ConnectivitySensor extends AwareSensorCore {

  static const MethodChannel _connectivityMethod = const MethodChannel('awareframework_connectivity/method');
  static const EventChannel  _connectivityStream  = const EventChannel('awareframework_connectivity/event');

  static const EventChannel  _onInternetOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onInternetOn);
  static const EventChannel  _onInternetOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onInternetOff);

  static const EventChannel  _onGPSOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onGPSOn);
  static const EventChannel  _onGPSOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onGPSOff);

  static const EventChannel  _onBluetoothOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onBluetoothOn);
  static const EventChannel  _onBluetoothOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onBluetoothOff);

  static const EventChannel  _onBackgroundRefreshOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onBackgroundRefreshOn);
  static const EventChannel  _onBackgroundRefreshOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onBackgroundRefreshOff);

  static const EventChannel  _onLowPowerModeOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onLowPowerModeOn);
  static const EventChannel  _onLowPowerModeOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onLowPowerModeOff);

  static const EventChannel  _onPushNotificationOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onPushNotificationOn);
  static const EventChannel  _onPushNotificationOffStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onPushNotificationOff);

  static const EventChannel  _onWifiOnStream  = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onWifiOn);
  static const EventChannel  _onWifiOffStream = const EventChannel('awareframework_connectivity/event_'+ConnectivityKeys.onWifiOff);

  /// Init Connectivity Sensor with ConnectivitySensorConfig
  ConnectivitySensor(ConnectivitySensorConfig config):this.convenience(config);
  ConnectivitySensor.convenience(config) : super(config){
    /// Set sensor method & event channels
    super.setMethodChannel(_connectivityMethod);
  }

  /// A sensor observer instance
  Stream<Map<String,dynamic>> get onDataChanged {
     return super.getBroadcastStream(_connectivityStream, "on_data_changed").map((dynamic event) => Map<String,dynamic>.from(event));
  }

  Stream<dynamic> get onInternetOn{
    return super.getBroadcastStream(_onInternetOnStream, ConnectivityKeys.onInternetOn);
    // return _onInternetOnStream.receiveBroadcastStream([]);
  }

  Stream<dynamic> get onInternetOff{
    return super.getBroadcastStream(_onInternetOffStream, ConnectivityKeys.onInternetOff);
  }

  Stream<dynamic> get onGPSOn{
    return super.getBroadcastStream(_onGPSOnStream, ConnectivityKeys.onGPSOn);
  }

  Stream<dynamic> get onGPSOff{
    return super.getBroadcastStream(_onGPSOffStream, ConnectivityKeys.onGPSOff);
  }

  Stream<dynamic> get onBluetoothOnStream {
    return super.getBroadcastStream(_onBluetoothOnStream, ConnectivityKeys.onBluetoothOn);
  }

  Stream<dynamic> get onBluetoothOffStream{
    return super.getBroadcastStream(_onBluetoothOffStream, ConnectivityKeys.onBluetoothOff);
  }
  
  Stream<dynamic> get onBackgroundRefreshOn {
    return super.getBroadcastStream(_onBackgroundRefreshOnStream, ConnectivityKeys.onBackgroundRefreshOn);
  }

  Stream<dynamic> get onBackgroundRefreshOff{
    return super.getBroadcastStream(_onBackgroundRefreshOffStream, ConnectivityKeys.onBackgroundRefreshOff);
  }

  Stream<dynamic> get onLowPowerModeOn{
    return super.getBroadcastStream(_onLowPowerModeOnStream, ConnectivityKeys.onLowPowerModeOn);
  }

  Stream<dynamic> get onLowPowerModeOff {
    return super.getBroadcastStream(_onLowPowerModeOffStream, ConnectivityKeys.onLowPowerModeOff);
  }

  Stream<dynamic> get onPushNotificationOn {
    return super.getBroadcastStream(_onPushNotificationOnStream, ConnectivityKeys.onPushNotificationOn);
  }

  Stream<dynamic> get onPushNotificationOff {
    return super.getBroadcastStream(_onPushNotificationOffStream, ConnectivityKeys.onPushNotificationOff);
  }

  Stream<dynamic> get onWifiOn {
    return super.getBroadcastStream(_onWifiOnStream, ConnectivityKeys.onWifiOn);
  }

  Stream<dynamic> get onWifiOff {
    return super.getBroadcastStream(_onWifiOffStream, ConnectivityKeys.onWifiOff);
  }


  @override
  void cancelAllEventChannels() {
    super.cancelBroadcastStream(ConnectivityKeys.onInternetOn);
    super.cancelBroadcastStream(ConnectivityKeys.onInternetOff);
    super.cancelBroadcastStream(ConnectivityKeys.onGPSOn);
    super.cancelBroadcastStream(ConnectivityKeys.onGPSOff);
    super.cancelBroadcastStream(ConnectivityKeys.onBluetoothOn);
    super.cancelBroadcastStream(ConnectivityKeys.onBluetoothOff);
    super.cancelBroadcastStream(ConnectivityKeys.onBackgroundRefreshOn);
    super.cancelBroadcastStream(ConnectivityKeys.onBackgroundRefreshOff);
    super.cancelBroadcastStream(ConnectivityKeys.onLowPowerModeOn);
    super.cancelBroadcastStream(ConnectivityKeys.onLowPowerModeOff);
    super.cancelBroadcastStream(ConnectivityKeys.onPushNotificationOn);
    super.cancelBroadcastStream(ConnectivityKeys.onPushNotificationOff);
    super.cancelBroadcastStream(ConnectivityKeys.onWifiOn);
    super.cancelBroadcastStream(ConnectivityKeys.onWifiOff);
  }
}

class ConnectivitySensorConfig extends AwareSensorConfig{
  ConnectivitySensorConfig();

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

  String internet = "---";
  String gps = "---";
  String bluetooth = "---";
  String background = "---";
  String lowPowerMode = "---";
  String pushNotification = "---";
  String wifi = "---";

  @override
  ConnectivityCardState createState() => new ConnectivityCardState();
}

class ConnectivityCardState extends State<ConnectivityCard> {

  @override
  void initState() {

    super.initState();
    // set observer
    widget.sensor.onInternetOn.listen((event) {
      setState((){  widget.internet = "on";  });
    });
    widget.sensor.onInternetOff.listen((event) {
      setState((){  widget.internet = "off"; });
    });
    widget.sensor.onGPSOn.listen((event) {
      setState((){  widget.gps = "on"; });
    });
    widget.sensor.onGPSOff.listen((event) {
      setState((){  widget.gps = "off"; });
    });
    widget.sensor.onBluetoothOnStream.listen((event) {
      setState((){  widget.bluetooth = "on"; });
    });
    widget.sensor.onBluetoothOffStream.listen((event) {
      setState((){  widget.bluetooth = "off"; });
    });
    widget.sensor.onBackgroundRefreshOn.listen((event) {
      setState((){  widget.background = "on"; });
    });
    widget.sensor.onBackgroundRefreshOff.listen((event) {
      setState((){  widget.background = "off";  });
    });
    widget.sensor.onLowPowerModeOn.listen((event) {
      setState((){  widget.lowPowerMode = "on"; });
    });
    widget.sensor.onLowPowerModeOff.listen((event) {
      setState((){  widget.lowPowerMode = "off"; });
    });
    widget.sensor.onPushNotificationOn.listen((event) {
      setState((){  widget.pushNotification = "on"; });
    });
    widget.sensor.onPushNotificationOff.listen((event) {
      setState((){  widget.pushNotification = "off"; });
    });
    widget.sensor.onWifiOn.listen((event) {
      setState((){  widget.wifi = "on"; });
    });
    widget.sensor.onWifiOff.listen((event) {
      setState((){  widget.wifi = "off"; });
    });
    // print(widget.sensor);
  }

  @override
  Widget build(BuildContext context) {
    return new AwareCard(
      contentWidget: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: new Text(
              "Internet: ${widget.internet}\n"
              "GPS: ${widget.gps}\n"
              "Bluetooth: ${widget.bluetooth}\n"
              "Background Refresh: ${widget.background}\n"
              "Low-Power Mode: ${widget.lowPowerMode}\n"
              "Push Notification: ${widget.pushNotification}\n"
              "WiFi: ${widget.wifi}"
          ),
        ),
      title: "Connectivity",
      sensor: widget.sensor
    );
  }

  @override
  void dispose() {
    widget.sensor.cancelAllEventChannels();
    super.dispose();
  }

}

class ConnectivityKeys {
  static const String onInternetOn = "on_internet_on";
  static const String onInternetOff = "on_internet_off";

  static const String onGPSOn  = "on_gps_on";
  static const String onGPSOff = "on_gps_off";

  static const String onBluetoothOn = "on_bluetooth_on";
  static const String onBluetoothOff = "on_bluetooth_off";

  static const String onBackgroundRefreshOn = "on_background_refresh_on";
  static const String onBackgroundRefreshOff = "on_background_refresh_off";

  static const String onLowPowerModeOn = "on_low_power_mode_on";
  static const String onLowPowerModeOff = "on_low_power_mode_off";

  static const String onPushNotificationOn = "on_push_notification_on";
  static const String onPushNotificationOff = "on_push_notification_off";

  static const String onWifiOn = "on_wifi_on";
  static const String onWifiOff = "on_wifi_off";
}
