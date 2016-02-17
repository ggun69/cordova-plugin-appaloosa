/**
 * @author nhodicq@sqli.com
 * @module starter
 * @description Service pour l'utilisation du SDK de Appaloosa
 */
angular.module('starter.service', [])
    .factory('AppaloosaService', function ($log) {

    // ####################################### //
    // ############ PRIVATE MODEL ############ //
    // ####################################### //

    /**
     * interface de conmmincation avec le plugin
     * analytics fourni par Apicil
     */
    var _Appaloosa;

    /**
     * Le service est-il initialisé ?
     * @type {boolean}
     * @private
     */
    var _isInitialized = false;

    /**
     * L'app est-elle blacklistée?
     * @type {boolean}
     * @private
     */
    var _isAuthorized = false;


    // ####################################### //
    // ############ PUBLIC BUSINESS ########## //
    // ####################################### //

    /**
     * Initialisation du service
     * @param Appaloosa : interface de conmmunication avec le SDK fourni par Appaloosa
     */
    function init(Appaloosa, appaloosaStoreId, appaloosaStoreToken) {

        if (window.Appaloosa) {

            _Appaloosa = Appaloosa;

            // Affichage de la version
            _Appaloosa.initialisation(appaloosaStoreId, appaloosaStoreToken,
            function(msg){
                console.log(msg);
                _isInitialized = true;
            },
            function(){
                console.log("erreur initialisation");
            });

        } else {
            $log.info('Appaloosa n\'est pas défini');
        }
    }

    /**
     * This will check your authorization.
     * Via Appaloosa web admin on https://www.appaloosa-store.com, you can manage a per device access. It works by sending device information to the Appaloosa servers.
     * In case of an offline access to your app, the status is read from a protected file on the device.
     */
    function checkBlacklist(){
       if(_isInitialized){
           _Appaloosa.checkBlacklist(function (status){
                   console.log(status);
                   _isAuthorized = true;
               },
               function (errorMessage){
                   console.warning("Non autorisé: " + errorMessage);
               })
       }
    }

    /**
     * Allows you to gather intel on the way people use your app.
     * Various user events will be recorded and sent asynchronously to our servers.
     * The graphs will be displayed in the admin view. Note that statistics may appear with delay.
     */
    function startAnalytics(){
        if(_isInitialized && _isAuthorized){
            _Appaloosa.startAnalytics(function (){
                    console.log("Analytics start sucessfully");
                },
                function (errorMessage){
                    console.warning(errorMessage);
                });
        }
        else{
            $log.info('Veuillez vérifier vos autorisations');
        }
    }

    /**
     * Allows you to encourage updates by forcing the download of the new update when the application starts
     */
    function autoUpdate(){

        if(_isInitialized && _isAuthorized){

            _Appaloosa.autoUpdate(function () {
                console.log("Auto update setted");
            }, function (errorMsg) {
                console.warning(errorMsg);
            });
        }
        else{
            $log.info('Veuillez vérifier vos autorisations');
        }
    }

    /**
     * Leave the choice to the user to download or not the update
     */
    function autoUpdateWithMessage(title, message){

        if(_isInitialized && _isAuthorized){

            _Appaloosa.autoUpdateWithMessage(title, message , function () {
                console.log("Auto update setted");
            }, function (errorMsg) {
                console.warning(errorMsg);
            });
        }
        else{
            $log.info('Veuillez vérifier vos autorisations');
        }
    }

    /**
     * Close application
     */
    function closeApplication(){
        _Appaloosa.closeApplication();
    }


    // ####################################### //
    // ################# API ################# //
    // ####################################### //

    return {
        init                    : init,
        checkBlacklist          : checkBlacklist,
        startAnalytics          : startAnalytics,
        autoUpdate              : autoUpdate,
        autoUpdateWithMessage   : autoUpdateWithMessage,
        closeApplication        : closeApplication
    };
});
