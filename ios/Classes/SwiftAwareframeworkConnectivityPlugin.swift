import Flutter
import UIKit
import com_awareframework_ios_sensor_connectivity
import com_awareframework_ios_sensor_core
import awareframework_core

public class SwiftAwareframeworkConnectivityPlugin: AwareFlutterPluginCore, FlutterPlugin, AwareFlutterPluginSensorInitializationHandler, ConnectivityObserver{

    public func initializeSensor(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> AwareSensor? {
        if self.sensor == nil {
            if let config = call.arguments as? Dictionary<String,Any>{
                self.connectivitySensor = ConnectivitySensor.init(ConnectivitySensor.Config(config))
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
        
        super.setMethodChannel(with: registrar, instance: instance, channelName: "awareframework_connectivity/method")
        
        let eventChannels = ["awareframework_connectivity/event",
                             "awareframework_connectivity/event_on_internet_on",
                             "awareframework_connectivity/event_on_internet_off",
                             "awareframework_connectivity/event_on_gps_on",
                             "awareframework_connectivity/event_on_gps_off",
                             "awareframework_connectivity/event_on_bluetooth_on",
                             "awareframework_connectivity/event_on_bluetooth_off",
                             "awareframework_connectivity/event_on_background_refresh_on",
                             "awareframework_connectivity/event_on_background_refresh_off",
                             "awareframework_connectivity/event_on_low_power_mode_on",
                             "awareframework_connectivity/event_on_low_power_mode_off",
                             "awareframework_connectivity/event_on_push_notification_on",
                             "awareframework_connectivity/event_on_push_notification_off",
                             "awareframework_connectivity/event_on_wifi_on",
                             "awareframework_connectivity/event_on_wifi_off"]
        super.setEventChannels(with: registrar, instance: instance, channelNames: eventChannels)
    }

    public static func setEventChennels(instance:FlutterPlugin & FlutterStreamHandler, names:[String], registrar: FlutterPluginRegistrar){
        for name in names {
            let stream = FlutterEventChannel(name: "awareframework_connectivity/event_"+name,    binaryMessenger: registrar.messenger())
            stream.setStreamHandler(instance)
        }
    }
    
    
    public func onInternetON() {
        if let handlers = self.getStreamHandlers(name: "on_internet_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onInternetOFF() {
        if let handlers = self.getStreamHandlers(name: "on_internet_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onGPSON() {
        if let handlers = self.getStreamHandlers(name: "on_gps_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onGPSOFF() {
        if let handlers = self.getStreamHandlers(name: "on_gps_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onBluetoothON() {
        if let handlers = self.getStreamHandlers(name: "on_bluetooth_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onBluetoothOFF() {
        if let handlers = self.getStreamHandlers(name: "on_bluetooth_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onBackgroundRefreshON() {
        if let handlers = self.getStreamHandlers(name: "on_background_refresh_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onBackgroundRefreshOFF() {
        if let handlers = self.getStreamHandlers(name: "on_background_refresh_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onLowPowerModeON() {
        if let handlers = self.getStreamHandlers(name:  "on_low_power_mode_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onLowPowerModeOFF() {
        if let handlers = self.getStreamHandlers(name: "on_low_power_mode_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onPushNotificationOn() {
        if let handlers = self.getStreamHandlers(name: "on_push_notification_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onPushNotificationOff() {
        if let handlers = self.getStreamHandlers(name: "on_push_notification_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onWiFiON() {
        if let handlers = self.getStreamHandlers(name: "on_wifi_on") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onWiFiOFF() {
        if let handlers = self.getStreamHandlers(name: "on_wifi_off") {
            for handler in handlers {
                handler.eventSink(nil)
            }
        }
    }
}
