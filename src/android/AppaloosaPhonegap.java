package com.appaloosa.cordova.plugin;
//package com.adobe.PhoneGapPlugin;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.util.Log;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import appaloosa_store.com.appaloosa_android_tools.Appaloosa;

/**
 * Created by gsautreau on 12/02/2016.
 */
public class AppaloosaPhonegap extends CordovaPlugin {
	
    Boolean initDone = false;
    Activity _activity;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        _activity = cordova.getActivity();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        final CallbackContext _cb = callbackContext;

        if(action.equals("init")){
            Appaloosa.init(_activity.getApplication(), args.getInt(0), args.getString(1));
            callbackContext.success("Init done");
            return true;
        }
        else if(action.equals("checkBlackList")){
            ApplicationAuthorizationCustom myAppAuthorization = new ApplicationAuthorizationCustom(callbackContext);
            Appaloosa.checkBlacklist(myAppAuthorization);
        }
        return false;
    }


}


