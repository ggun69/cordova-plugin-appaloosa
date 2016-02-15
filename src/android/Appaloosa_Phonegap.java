package com.Appaloosa.Plugin;
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
import appaloosa_store.com.appaloosa_android_tools.tools.interfaces.ApplicationAuthorizationInterface;

/**
 * Created by gsautreau on 12/02/2016.
 */
public class Appaloosa_Phonegap extends CordovaPlugin {
	
    Boolean initDone = false;
    Activity _activity;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        Log.d("INITIALIZE", "ERROR0");
        super.initialize(cordova, webView);
        Log.d("INITIALIZE", "ERROR1");
        _activity = cordova.getActivity();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        final CallbackContext _cb = callbackContext;

        if(action.equals("init")){
			Log.d("ARGUMENTS", Integer.toString( args.getInt(0)));
            Appaloosa.init(_activity.getApplication(), args.getInt(0), args.getString(1));
			Log.d("ARGUMENTS", args.getString(1));
            callbackContext.success("Initialisation effectuee");
            return true;
        }
        else if(action.equals("checkBlackList")){
            ApplicationAuthorization myAppAuthorization = new ApplicationAuthorization(callbackContext);
            Appaloosa.checkBlacklist(myAppAuthorization);
        }
        return false;
    }


}


