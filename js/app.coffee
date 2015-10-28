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

.controller 'testController', ($log, $scope,
    #
                               $cordovaBarcodeScanner
                               $cordovaBatteryStatus
                               $cordovaDeviceOrientation
                               $ionicPlatform) ->
    $scope.messages = []
    $scope.battery =
        level: "unknown"
        isPlugged: "unknown"

    $scope.refreshHeading = ->
        $ionicPlatform.ready ->
            $cordovaDeviceOrientation.getCurrentHeading()
            .then (result) ->
                $scope.heading = result
            .catch (error) ->
                $scope.error = error

    $scope.refreshHeading()

    $scope.scanBarcode = ->
        $log.debug "scanBarcode begin"
        $ionicPlatform.ready ->
            $log.debug "$ionicPlatform.ready begin"
            try
                cor = `cordova`
                $scope.barcode = cor
                $scope.messages.push "cor=" + (not not cor)
                $scope.messages.push "plugins=" + (not not cor?.plugins)
                $scope.messages.push "barcodescanner=" + (not not cor?.plugins?.barcodescanner)
                cor?.plugins?.barcodescanner?.scan?(
                    (result) ->
                        $log.debug("promise then")
                        $scope.barcode = result
                , (error) ->
                    $log.debug("promise catch")
                    $scope.error = error
                )

                $scope.messages.push "$cordovaBarcodeScanner=" + (not not $cordovaBarcodeScanner)
            #                $cordovaBarcodeScanner.scan()
            #                .then (result) ->
            #                    $log.debug("promise then")
            #                    $scope.barcode = result
            #                , (error) ->
            #                    $log.debug("promise catch")
            #                    $scope.error = error
            catch error
                $scope.messages.push "Error: " + error
                $scope.error = error

            $log.debug("$ionicPlatform.ready end")
        $log.debug("scanBarcode end")

    $ionicPlatform.ready ->
        $scope.$on "$cordovaBatteryStatus:status", (result) ->
            $scope.battery.level = result.level
            $scope.battery.isPlugged = result.isPlugged
