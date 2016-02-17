/**
 * Module exec cordova
 * @type {exports}
 */
var exec = require('cordova/exec');

var Appaloosa = {
	initialisation : function (appaloosaStoreId, AppaloosaStoreToken, onSuccess, onError) {
        return exec(onSuccess, onError, "AppaloosaPhonegap", "init", [appaloosaStoreId, AppaloosaStoreToken]);
    }
};

module.exports = Appaloosa;