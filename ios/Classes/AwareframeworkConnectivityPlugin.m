#import "AwareframeworkConnectivityPlugin.h"
#import <awareframework_connectivity/awareframework_connectivity-Swift.h>

@implementation AwareframeworkConnectivityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAwareframeworkConnectivityPlugin registerWithRegistrar:registrar];
}
@end
