import 'dart:async';

import 'package:flutter/services.dart';
import 'package:awareframework_core/awareframework_core.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


/// The Connectivity measures the acceleration applied to the sensor
/// built-in into the device, including the force of gravity.
///
/// Your can initialize this class by the following code.
/// ```dart
/// var sensor = ConnectivitySensor();
/// ```
///
/// If you need to initialize the sensor with configurations,
/// you can use the following code instead of the above code.
/// ```dart
/// var config =  ConnectivitySensorConfig();
/// config
///   ..debug = true
///   ..frequency = 100;
///
/// var sensor = ConnectivitySensor.init(config);
/// ```
///
/// Each sub class of AwareSensor provides the following method for controlling
/// the sensor:
/// - `start()`
/// - `stop()`
/// - `enable()`
/// - `disable()`
/// - `sync()`
/// - `setLabel(String label)`
///
/// `Stream<ConnectivityData>` allow us to monitor the sensor update
/// events as follows:
///
/// ```dart
/// sensor.onDataChanged.listen((data) {
///   print(data)
/// }
/// ```
///
/// In addition, this package support data visualization function on Cart Widget.
/// You can generate the Cart Widget by following code.
/// ```dart
/// var card = ConnectivityCard(sensor: sensor);
/// ```
class ConnectivitySensor extends AwareSensor {

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


  static StreamController<dynamic> connectivityStreamController = StreamController<dynamic>();

  static StreamController<dynamic> onInternetOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic> onInternetOffStreamController= StreamController<dynamic>();

  static StreamController<dynamic> onGPSOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic> onGPSOffStreamController= StreamController<dynamic>();

  static StreamController<dynamic> onBluetoothOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic> onBluetoothOffStreamController= StreamController<dynamic>();

  static StreamController<dynamic> onBackgroundRefreshOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic> onBackgroundRefreshOffStreamController= StreamController<dynamic>();

  static StreamController<dynamic>  onLowPowerModeOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic>  onLowPowerModeOffStreamController= StreamController<dynamic>();

  static StreamController<dynamic> onPushNotificationOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic> onPushNotificationOffStreamController= StreamController<dynamic>();

  static StreamController<dynamic>  onWifiOnStreamController= StreamController<dynamic>();
  static StreamController<dynamic>  onWifiOffStreamController= StreamController<dynamic>();

  bool internet = false;
  bool gps      = false;
  bool bluetooth = false;
  bool background = false;
  bool lowPowerMode = false;
  bool pushNotification = false;
  bool wifi = false;

  /// Init Connectivity Sensor without a configuration file
  ///
  /// ```dart
  /// var sensor = ConnectivitySensor.init(null);
  /// ```
  ConnectivitySensor():this.init(null);

  /// Init Connectivity Sensor with ConnectivitySensorConfig
  ///
  /// ```dart
  /// var config =  ConnectivitySensorConfig();
  /// config
  ///   ..debug = true
  ///   ..frequency = 100;
  ///
  /// var sensor = ConnectivitySensor.init(config);
  /// ```
  ConnectivitySensor.init(ConnectivitySensorConfig config) : super(config){
    /// Set sensor method
    super.setMethodChannel(_connectivityMethod);
  }

  /// An event channel for monitoring connectivity events.
  ///
  /// `Stream<dynamic>` allow us to monitor connectivity events
  /// events as follows:
  ///
  /// ```dart
  /// sensor.onInternetOn.listen((event) {
  ///
  /// }
  ///
  StreamController<dynamic> initStreamController(StreamController<dynamic> controller){
    controller.close();
    controller = StreamController<dynamic>();
    return controller;
  }

  Stream<dynamic> get onInternetOn{
    return initStreamController(onInternetOnStreamController).stream;
  }

  Stream<dynamic> get onInternetOff{
    return initStreamController(onInternetOffStreamController).stream;
  }

  Stream<dynamic> get onGPSOn{
    return initStreamController(onGPSOnStreamController).stream;
  }

  Stream<dynamic> get onGPSOff{
    return initStreamController(onGPSOffStreamController).stream;
  }

  Stream<dynamic> get onBluetoothOnStream {
    return initStreamController(onBluetoothOnStreamController).stream;
  }

  Stream<dynamic> get onBluetoothOffStream{
    return initStreamController(onBluetoothOffStreamController).stream;
  }
  
  Stream<dynamic> get onBackgroundRefreshOn {
    return initStreamController(onBackgroundRefreshOnStreamController).stream;
  }

  Stream<dynamic> get onBackgroundRefreshOff{
    return initStreamController(onBackgroundRefreshOffStreamController).stream;
  }

  Stream<dynamic> get onLowPowerModeOn{
    return initStreamController(onLowPowerModeOnStreamController).stream;
  }

  Stream<dynamic> get onLowPowerModeOff {
    return initStreamController(onLowPowerModeOffStreamController).stream;
  }

  Stream<dynamic> get onPushNotificationOn {
    return initStreamController(onPushNotificationOnStreamController).stream;
  }

  Stream<dynamic> get onPushNotificationOff {
    return initStreamController(onPushNotificationOffStreamController).stream;
  }

  Stream<dynamic> get onWifiOn {
    return initStreamController(onWifiOnStreamController).stream;
  }

  Stream<dynamic> get onWifiOff {
    return initStreamController(onWifiOffStreamController).stream;
  }

  @override
  Future<Null> start() {
    super.getBroadcastStream(_onInternetOnStream, ConnectivityKeys.onInternetOn).listen((event){
      if(!onInternetOnStreamController.isClosed){
        internet = true;
        onInternetOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onInternetOffStream, ConnectivityKeys.onInternetOff).listen((event){
      if(!onInternetOffStreamController.isClosed){
        internet = false;
        onInternetOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onGPSOnStream, ConnectivityKeys.onGPSOn).listen((event){
      if(!onGPSOnStreamController.isClosed){
        gps = true;
        onGPSOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onGPSOffStream, ConnectivityKeys.onGPSOff).listen((event){
      if(!onGPSOffStreamController.isClosed){
        gps = false;
        onGPSOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onBluetoothOnStream, ConnectivityKeys.onBluetoothOn).listen((event){
      if(!onBluetoothOnStreamController.isClosed){
        bluetooth = true;
        onBluetoothOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onBluetoothOffStream, ConnectivityKeys.onBluetoothOff).listen((event){
      if(!onBluetoothOffStreamController.isClosed){
        bluetooth = false;
        onBluetoothOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onBackgroundRefreshOnStream, ConnectivityKeys.onBackgroundRefreshOn).listen((event){
      if(!onBackgroundRefreshOnStreamController.isClosed){
        background = true;
        onBackgroundRefreshOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onBackgroundRefreshOffStream, ConnectivityKeys.onBackgroundRefreshOff).listen((event){
      if(!onBackgroundRefreshOffStreamController.isClosed){
        background = false;
        onBackgroundRefreshOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onLowPowerModeOnStream, ConnectivityKeys.onLowPowerModeOn).listen((event){
      if(!onLowPowerModeOnStreamController.isClosed){
        lowPowerMode = true;
        onLowPowerModeOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onLowPowerModeOffStream, ConnectivityKeys.onLowPowerModeOff).listen((event){
      if(!onLowPowerModeOffStreamController.isClosed){
        lowPowerMode = false;
        onLowPowerModeOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onPushNotificationOnStream, ConnectivityKeys.onPushNotificationOn).listen((event){
      if(!onPushNotificationOnStreamController.isClosed){
        pushNotification = true;
        onPushNotificationOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onPushNotificationOffStream, ConnectivityKeys.onPushNotificationOff).listen((event){
      if(!onPushNotificationOffStreamController.isClosed){
        pushNotification = false;
        onPushNotificationOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onWifiOnStream, ConnectivityKeys.onWifiOn).listen((event){
      if(!onWifiOnStreamController.isClosed){
        wifi = true;
        onWifiOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onWifiOffStream, ConnectivityKeys.onWifiOff).listen((event){
      if(!onWifiOffStreamController.isClosed){
        wifi = false;
        onWifiOffStreamController.add(event);
      }
    });
    return super.start();
  }

  @override
  Future<Null> stop() {
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
    return super.stop();
  }
}


/// A configuration class of ConnectivitySensor
///
/// You can initialize the class by following code.
///
/// ```dart
/// var config =  ConnectivitySensorConfig();
/// config
///   ..debug = true
///   ..frequency = 100;
/// ```
class ConnectivitySensorConfig extends AwareSensorConfig{
  ConnectivitySensorConfig();

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    return map;
  }
}

/// A data model of ConnectivitySensor
///
/// This class converts sensor data that is Map<String,dynamic> format, to a
/// sensor data object.
///
class ConnectivityCard extends StatefulWidget {
  ConnectivityCard({Key key, @required this.sensor}) : super(key: key);

  ConnectivitySensor sensor;

  String internet   = "---";
  String gps        = "---";
  String bluetooth  = "---";
  String background = "---";
  String lowPowerMode     = "---";
  String pushNotification = "---";
  String wifi       = "---";

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
