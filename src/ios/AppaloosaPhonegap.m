#import "AppaloosaPhonegap.h"
#import <Cordova/CDV.h>

@implementation AppaloosaPhonegap

- (void)init:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    int storeId = [command.arguments objectAtIndex:0];
    NSString* storeToken = [command.arguments objectAtIndex:1];

    if (storeToken != nil && [storeToken length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:storeToken];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end