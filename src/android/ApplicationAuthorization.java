package com.Appaloosa.Plugin;

import android.app.Activity;

import org.apache.cordova.CallbackContext;

import appaloosa_store.com.appaloosa_android_tools.tools.interfaces.ApplicationAuthorizationInterface;

/**
 * Created by gsautreau on 15/02/2016.
 */
public class ApplicationAuthorization extends Activity implements ApplicationAuthorizationInterface {

    CallbackContext callbackContext;

    public ApplicationAuthorization(CallbackContext cbContext){
        callbackContext = cbContext;
    }

    @Override
    public void isAuthorized(appaloosa_store.com.appaloosa_android_tools.tools.models.ApplicationAuthorization authorization) {
        callbackContext.success();
    }

    @Override
    public void isNotAuthorized(appaloosa_store.com.appaloosa_android_tools.tools.models.ApplicationAuthorization authorization) {
        callbackContext.error();
    }
}
