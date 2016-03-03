#import "AppaloosaPhonegap.h"
#import "OTAppaloosaAgent.h"
#import <Cordova/CDV.h>

@implementation AppaloosaPhonegap

- (void)initialisation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSNumber* storeId = [command.arguments objectAtIndex:0];
    NSString* storeToken = [command.arguments objectAtIndex:1];

    if (storeToken != nil && [storeToken length] > 0) {
        [[OTAppaloosaAgent sharedAgent] registerWithStoreId:[storeId stringValue]
                                             storeToken:storeToken
                                            andDelegate:self];
                                            NSLog(@"INIT DONE \n");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:storeToken];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)autoUpdate: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    @try {
        [[OTAppaloosaAgent sharedAgent] checkUpdates];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

}

- (void)authorization:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    @try {
        [[OTAppaloosaAgent sharedAgent] checkAuthorizations];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
}

@end