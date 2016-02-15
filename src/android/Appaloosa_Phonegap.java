package com.Appaloosa.Plugin;
//package com.adobe.PhoneGapPlugin;

import android.app.Activity;
import android.app.Application;
import android.content.Context;

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
public class Appaloosa_Phonegap extends CordovaPlugin {

    Boolean initDone = false;
    Context _activity;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        _activity = cordova.getActivity();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if (action.equals("echo")) {
            String message = args.getString(0);
            this.echo(message, callbackContext);
            return true;

        }else if(action.equals("init")){
            callbackContext.success("Initialisation effectuee");
            Appaloosa.init(_activity.getApplication(), args.getInt(0), args.getString(1));
            return true;
        }
        else if(action.equals("checkBlackList")){
            ApplicationAuthorization myAppAuthorization = new ApplicationAuthorization(callbackContext);
            Appaloosa.checkBlacklist(myAppAuthorization);
        }
        return false;
    }


    private void echo(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }


    private void checkBlacklist(){
        Appaloosa.checkBlacklist(_activity);
    }


}


