angular.module('starter.controllers', [])

    .controller('MainController', function($scope,AppaloosaService) {

        // With the new view caching in Ionic, Controllers are only called
        // when they are recreated or on app start, instead of every page change.
        // To listen for when this page is active (for example, to refresh data),
        // listen for the $ionicView.enter event:
        //$scope.$on('$ionicView.enter', function(e) {
        //});

        // Form data for the login modal

        $scope.testController = "testController";

        AppaloosaService.init();
        AppaloosaService.checkBlacklist();
        AppaloosaService.startAnalytics();
        AppaloosaService.autoUpdateWithMessage("Updata available", "Your app have to be updated")

        console.log(window);


    });
