import Flutter
import UIKit
import SwiftyJSON
import com_awareframework_ios_sensor_connectivity
import com_awareframework_ios_sensor_core
import awareframework_core

public class SwiftAwareframeworkConnectivityPlugin: AwareFlutterPluginCore, FlutterPlugin, AwareFlutterPluginSensorInitializationHandler, ConnectivityObserver{

    public func initializeSensor(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> AwareSensor? {
        if self.sensor == nil {
            if let config = call.arguments as? Dictionary<String,Any>{
                let json = JSON.init(config)
                self.connectivitySensor = ConnectivitySensor.init(ConnectivitySensor.Config(json))
            }else{
                self.connectivitySensor = ConnectivitySensor.init(ConnectivitySensor.Config())
            }
            self.connectivitySensor?.CONFIG.sensorObserver = self
            return self.connectivitySensor
        }else{
            return nil
        }
    }

    var connectivitySensor:ConnectivitySensor?

    public override init() {
        super.init()
        super.initializationCallEventHandler = self
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftAwareframeworkConnectivityPlugin()
        // add own channel
        super.setChannels(with: registrar,
                          instance: instance,
                          methodChannelName: "awareframework_connectivity/method",
                          eventChannelName: "awareframework_connectivity/event")

        let names = ["on_internet_on",  "on_internet_off",
                     "on_gps_on",       "on_gps_off",
                     "on_bluetooth_on", "on_bluetooth_off",
                     "on_background_refresh_on", "on_background_refresh_off",
                     "on_low_power_mode_on",     "on_low_power_mode_off",
                     "on_push_notification_on",  "on_push_notification_off",
                     "on_wifi_on",       "on_wifi_off"]
        setEventChennels(instance:instance, names:names, registrar:registrar)
        
    }

    public static func setEventChennels(instance:FlutterPlugin & FlutterStreamHandler, names:[String], registrar: FlutterPluginRegistrar){
        for name in names {
            let stream = FlutterEventChannel(name: "awareframework_connectivity/event_"+name,    binaryMessenger: registrar.messenger())
            stream.setStreamHandler(instance)
        }
    }
    
    
    public func onInternetON() {
        if let handler = self.getStreamHandler(name: "on_internet_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onInternetOFF() {
        if let handler = self.getStreamHandler(name: "on_internet_off") {
            handler.eventSink(nil)
        }
    }
    
    public func onGPSON() {
        if let handler = self.getStreamHandler(name: "on_gps_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onGPSOFF() {
        if let handler = self.getStreamHandler(name: "on_gps_off") {
            handler.eventSink(nil)
        }
    }
    
    public func onBluetoothON() {
        if let handler = self.getStreamHandler(name: "on_bluetooth_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onBluetoothOFF() {
        if let handler = self.getStreamHandler(name: "on_bluetooth_off") {
            handler.eventSink(nil)
        }
    }
    
    public func onBackgroundRefreshON() {
        if let handler = self.getStreamHandler(name: "on_background_refresh_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onBackgroundRefreshOFF() {
        if let handler = self.getStreamHandler(name: "on_background_refresh_off") {
            handler.eventSink(nil)
        }
    }
    
    public func onLowPowerModeON() {
        if let handler = self.getStreamHandler(name:  "on_low_power_mode_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onLowPowerModeOFF() {
        if let handler = self.getStreamHandler(name: "on_low_power_mode_off") {
            handler.eventSink(nil)
        }
    }
    
    public func onPushNotificationOn() {
        if let handler = self.getStreamHandler(name: "on_push_notification_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onPushNotificationOff() {
        if let handler = self.getStreamHandler(name: "on_push_notification_off") {
            handler.eventSink(nil)
        }
    }
    
    public func onWiFiON() {
        if let handler = self.getStreamHandler(name: "on_wifi_on") {
            handler.eventSink(nil)
        }
    }
    
    public func onWiFiOFF() {
        if let handler = self.getStreamHandler(name: "on_wifi_off") {
            handler.eventSink(nil)
        }
    }
}
