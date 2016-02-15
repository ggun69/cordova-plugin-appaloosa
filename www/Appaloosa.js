/**
 * Module exec cordova
 * @type {exports}
 */
var exec = require('cordova/exec');

var Appaloosa = {
	initialisation : function (APPALOOSA_STORE_ID, APPALOOSA_STORE_TOKEN) {
        return exec(doNothing, doNothing, "Appaloosa_Phonegap", "init", [APPALOOSA_STORE_ID, APPALOOSA_STORE_TOKEN]);
    },
};

module.exports = Appaloosa;