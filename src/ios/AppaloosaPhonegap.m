#import "AppaloosaPhonegap.h"
#import "OTAppaloosaAgent.h"
#import <Cordova/CDV.h>

@implementation AppaloosaPhonegap

CDVInvokedUrlCommand* commandAuthorization = nil;

- (void)initialisation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSNumber* storeId = [command.arguments objectAtIndex:0];
    NSString* storeToken = [command.arguments objectAtIndex:1];

    if (storeToken != nil && [storeToken length] > 0) {
        [[OTAppaloosaAgent sharedAgent] registerWithStoreId:[storeId stringValue]
                                             storeToken:storeToken
                                            andDelegate:self];
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
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

}

- (void)authorization:(CDVInvokedUrlCommand*)command
{
    commandAuthorization = command;
    NSLog(@"authorization");
    
    @try {
        [[OTAppaloosaAgent sharedAgent] checkAuthorizations];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}


- (void)applicationAuthorizationsAllowed{

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:commandAuthorization.callbackId];
}

- (void)applicationAuthorizationsNotAllowedWithStatus:(OTAppaloosaAutorizationsStatus)status andMessage:(NSString *)message{

    NSLog(@"Authorization error: %@", message);
    
    message = [self convertToString:status];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:commandAuthorization.callbackId];
}

- (NSString*) convertToString:(OTAppaloosaAutorizationsStatus) whichStatus {
    NSString* status = nil;
    
    switch (whichStatus) {
        case OTAppaloosaAutorizationsStatusAuthorized:
            status = @"AUTHORIZED";
            break;
            
        case OTAppaloosaAutorizationsStatusNotAuthorized:
            status = @"NOT_AUTHORIZED";
            break;
            
        case OTAppaloosaAutorizationsStatusNoNetwork:
            status = @"NO_NETWORK";
            break;
            
        case OTAppaloosaAutorizationsStatusRequestError:
            status = @"REQUEST_ERROR";
            break;
            
        case OTAppaloosaAutorizationsStatusUnknownDevice:
            status = @"UNKNOWN_DEVICE";
            break;
            
        case OTAppaloosaAutorizationsStatusUnregisteredDevice:
            status = @"UNREGISTERED_DEVICE";
            break;
            
        case OTAppaloosaAutorizationsStatusUnknown:
            status = @"UNKNOWN";
            break;
            
        default:
            break;
    }
    
    return status;
}


- (void)devPanelWithDefaultButtonAtPosition: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* position = [command.arguments objectAtIndex:0];

    @try {
        if([position isEqualToString:@"rightBottom"]){
            [[OTAppaloosaAgent sharedAgent] devPanelWithDefaultButtonAtPosition:kAppaloosaButtonPositionRightBottom];
        }else if([position isEqualToString:@"bottomRight"]){
            [[OTAppaloosaAgent sharedAgent] devPanelWithDefaultButtonAtPosition:kAppaloosaButtonPositionBottomRight];
        }
        else{
            NSLog(@"Error position dev panel");
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

}


- (void)openDevPanelController: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    @try {
        [[OTAppaloosaAgent sharedAgent] openDevPanelController];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)feedbackControllerWithDefaultButtonAtPosition: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* position = [command.arguments objectAtIndex:0];
    NSString* emailsString = [command.arguments objectAtIndex:1];
    NSArray *emails = nil;
    if(emailsString && ![emailsString isEqual:[NSNull null]]){
        emails = [emailsString componentsSeparatedByString: @","];
    }

    @try {
        if([position isEqualToString:@"rightBottom"]){
            [[OTAppaloosaAgent sharedAgent] feedbackControllerWithDefaultButtonAtPosition:kAppaloosaButtonPositionRightBottom forRecipientsEmailArray:emails];
        }else if([position isEqualToString:@"bottomRight"]){
            [[OTAppaloosaAgent sharedAgent] feedbackControllerWithDefaultButtonAtPosition:kAppaloosaButtonPositionBottomRight forRecipientsEmailArray:emails];
        }
        else{
            NSLog(@"Error position dev panel");
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)openFeedbackControllerWithRecipientsEmailArray: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* emailsString = [command.arguments objectAtIndex:0];
    NSArray *emails = nil;
    if(emailsString && ![emailsString isEqual:[NSNull null]]){
        emails = [emailsString componentsSeparatedByString: @","];
    }
    
    @try {
        [[OTAppaloosaAgent sharedAgent] openFeedbackControllerWithRecipientsEmailArray:emails];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    @catch (NSException *exception) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end