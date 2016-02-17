/**
 * Module exec cordova
 * @type {exports}
 */
var exec = require('cordova/exec');

var Appaloosa = {
	initialisation : function (appaloosaStoreId, AppaloosaStoreToken, onSuccess, onError) {
        return exec(onSuccess, onError, "AppaloosaPhonegap", "init", [appaloosaStoreId, AppaloosaStoreToken]);
    },
	
	checkBlacklist : function (onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "checkBlackList", []);
	},
	
	startAnalytics : function (onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "startAnalytics", []);
	},
	
	autoUpdate : function (leaveTheChoice, onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "autoUpdate", []);
	},
	
	autoUpdateWithMessage : function (title, message, onSuccess, onError){
		return exec(onSuccess, onError, "AppaloosaPhonegap", "autoUpdateWithMessage", [title, message]);
	}
};

module.exports = Appaloosa;