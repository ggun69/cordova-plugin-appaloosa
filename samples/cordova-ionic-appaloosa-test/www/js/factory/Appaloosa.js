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
     * @param leaveTheChoice
     */
    function autoUpdate(leaveTheChoice){

        if(_isInitialized && _isAuthorized){

            _Appaloosa.autoUpdateWithMessage("Attention", "Voulez-vous télécharger la mise à jour maintenant?" , function () {
                console.log("Auto update setted");
            }, function (errorMsg) {
                console.warning(errorMsg);
            });
        }
        else{
            $log.info('Veuillez vérifier vos autorisations');
        }
    }


    // ####################################### //
    // ################# API ################# //
    // ####################################### //

    return {
        init                    : init,
        checkBlacklist          : checkBlacklist,
        startAnalytics          : startAnalytics,
        autoUpdate              : autoUpdate,
        autoUpdateWithMessage   : autoUpdateWithMessage
    };
});
