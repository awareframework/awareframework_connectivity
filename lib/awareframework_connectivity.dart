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
  Stream<Map<String,dynamic>> onDataChanged(String id) {
     return super.getBroadcastStream(_connectivityStream, "on_data_changed", id).map((dynamic event) => Map<String,dynamic>.from(event));
  }

  Stream<dynamic> onInternetOn(String id){
    return super.getBroadcastStream(_onInternetOnStream, ConnectivityKeys.onInternetOn, id);
    // return _onInternetOnStream.receiveBroadcastStream([]);
  }

  Stream<dynamic> onInternetOff(String id){
    return super.getBroadcastStream(_onInternetOffStream, ConnectivityKeys.onInternetOff, id);
  }

  Stream<dynamic> onGPSOn(String id){
    return super.getBroadcastStream(_onGPSOnStream, ConnectivityKeys.onGPSOn, id);
  }

  Stream<dynamic> onGPSOff(String id){
    return super.getBroadcastStream(_onGPSOffStream, ConnectivityKeys.onGPSOff, id);
  }

  Stream<dynamic> onBluetoothOnStream(String id) {
    return super.getBroadcastStream(_onBluetoothOnStream, ConnectivityKeys.onBluetoothOn, id);
  }

  Stream<dynamic> onBluetoothOffStream(String id) {
    return super.getBroadcastStream(_onBluetoothOffStream, ConnectivityKeys.onBluetoothOff, id);
  }
  
  Stream<dynamic> onBackgroundRefreshOn(String id) {
    return super.getBroadcastStream(_onBackgroundRefreshOnStream, ConnectivityKeys.onBackgroundRefreshOn, id);
  }

  Stream<dynamic> onBackgroundRefreshOff(String id) {
    return super.getBroadcastStream(_onBackgroundRefreshOffStream, ConnectivityKeys.onBackgroundRefreshOff, id);
  }

  Stream<dynamic> onLowPowerModeOn(String id) {
    return super.getBroadcastStream(_onLowPowerModeOnStream, ConnectivityKeys.onLowPowerModeOn, id);
  }

  Stream<dynamic> onLowPowerModeOff(String id) {
    return super.getBroadcastStream(_onLowPowerModeOffStream, ConnectivityKeys.onLowPowerModeOff, id);
  }

  Stream<dynamic> onPushNotificationOn(String id) {
    return super.getBroadcastStream(_onPushNotificationOnStream, ConnectivityKeys.onPushNotificationOn, id);
  }

  Stream<dynamic> onPushNotificationOff(String id) {
    return super.getBroadcastStream(_onPushNotificationOffStream, ConnectivityKeys.onPushNotificationOff, id);
  }

  Stream<dynamic> onWifiOn(String id) {
    return super.getBroadcastStream(_onWifiOnStream, ConnectivityKeys.onWifiOn, id);
  }

  Stream<dynamic> onWifiOff(String id) {
    return super.getBroadcastStream(_onWifiOffStream, ConnectivityKeys.onWifiOff, id);
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
  ConnectivityCard({Key key, @required this.sensor, this.cardId = "connectivity_card"}) : super(key: key);

  ConnectivitySensor sensor;
  String cardId;

  @override
  ConnectivityCardState createState() => new ConnectivityCardState();
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
    widget.sensor.onInternetOn(widget.cardId + "_internet_on").listen((event) {
      setState((){  internet = "on";  });
    });
    widget.sensor.onInternetOff(widget.cardId + "_internet_off").listen((event) {
      setState((){  internet = "off"; });
    });
    widget.sensor.onGPSOn(widget.cardId + "_gps_on").listen((event) {
      setState((){  gps = "on"; });
    });
    widget.sensor.onGPSOff(widget.cardId + "_gps_off").listen((event) {
      setState((){  gps = "off"; });
    });
    widget.sensor.onBluetoothOnStream(widget.cardId + "_bluetooth_on").listen((event) {
      setState((){  bluetooth = "on"; });
    });
    widget.sensor.onBluetoothOffStream(widget.cardId + "_bluetooth_off").listen((event) {
      setState((){  bluetooth = "off"; });
    });
    widget.sensor.onBackgroundRefreshOn(widget.cardId + "_background_refresh_on").listen((event) {
      setState((){  background = "on"; });
    });
    widget.sensor.onBackgroundRefreshOff(widget.cardId + "_background_refresh_off").listen((event) {
      setState((){  background = "off";  });
    });
    widget.sensor.onLowPowerModeOn(widget.cardId + "_low_power_on").listen((event) {
      setState((){  lowPowerMode = "on"; });
    });
    widget.sensor.onLowPowerModeOff(widget.cardId + "_low_power_off").listen((event) {
      setState((){  lowPowerMode = "off"; });
    });
    widget.sensor.onPushNotificationOn(widget.cardId + "_notification_on").listen((event) {
      setState((){  pushNotification = "on"; });
    });
    widget.sensor.onPushNotificationOff(widget.cardId + "_notification_off").listen((event) {
      setState((){  pushNotification = "off"; });
    });
    widget.sensor.onWifiOn(widget.cardId + "_wifi_on").listen((event) {
      setState((){  wifi = "on"; });
    });
    widget.sensor.onWifiOff(widget.cardId + "_wifi_off").listen((event) {
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

  @override
  void dispose() {

    widget.sensor.cancelBroadcastStream(widget.cardId + "_internet_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_internet_off");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_gps_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_gps_off");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_bluetooth_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_bluetooth_off");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_background_refresh_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_background_refresh_off");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_low_power_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_low_power_off");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_notification_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_notification_off");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_wifi_on");
    widget.sensor.cancelBroadcastStream(widget.cardId + "_wifi_off");

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
