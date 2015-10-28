## Ionic Starter App

## angular.module is a global place for creating, registering and retrieving Angular modules
## 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
## the 2nd parameter is an array of 'requires'
angular.module 'starter', ['ionic', 'ngCordova']

.run ($ionicPlatform) ->
    $ionicPlatform.ready ->
        ## Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
        ## for form inputs)
        if window.cordova && window.cordova.plugins.Keyboard
            cordova.plugins.Keyboard.hideKeyboardAccessoryBar true
        if window.StatusBar
            StatusBar.styleDefault()

.controller 'testController', ($log, $scope, $ionicPlatform, $cordovaDeviceOrientation) ->
    $scope.refreshHeading = ->
        $log.debug "refreshHeading begin"
        $ionicPlatform.ready ->
            $log.debug "$ionicPlatform.ready begin"
            $cordovaDeviceOrientation.getCurrentHeading()
            .then (result) ->
                $log.debug("promise then")
                $scope.heading = result
            .catch (error) ->
                $log.debug("promise catch")
                $scope.error = error

            $log.debug("$ionicPlatform.ready end")
        $log.debug("refreshHeading end")
    $scope.refreshHeading()
