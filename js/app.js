// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('starter', ['ionic', 'ngCordova']).run(function($ionicPlatform) {
    return $ionicPlatform.ready(function() {
      if (window.cordova && window.cordova.plugins.Keyboard) {
        cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      }
      if (window.StatusBar) {
        return StatusBar.styleDefault();
      }
    });
  }).controller('testController', function($log, $scope, $cordovaBarcodeScanner, $cordovaDeviceOrientation, $ionicPlatform) {
    $scope.messages = [];
    $scope.refreshHeading = function() {
      $log.debug("refreshHeading begin");
      $ionicPlatform.ready(function() {
        $log.debug("$ionicPlatform.ready begin");
        $cordovaDeviceOrientation.getCurrentHeading().then(function(result) {
          $log.debug("promise then");
          return $scope.heading = result;
        })["catch"](function(error) {
          $log.debug("promise catch");
          return $scope.error = error;
        });
        return $log.debug("$ionicPlatform.ready end");
      });
      return $log.debug("refreshHeading end");
    };
    $scope.refreshHeading();
    return $scope.scanBarcode = function() {
      $log.debug("scanBarcode begin");
      $ionicPlatform.ready(function() {
        var cor, error, error1, ref, ref1, ref2;
        $log.debug("$ionicPlatform.ready begin");
        try {
          cor = cordova;
          $scope.messages.push("cor=" + (!!cor));
          $scope.messages.push("plugins=" + (!!(cor != null ? cor.plugins : void 0)));
          $scope.messages.push("barcodescanner=" + (!!(cor != null ? (ref = cor.plugins) != null ? ref.barcodescanner : void 0 : void 0)));
          if (cor != null) {
            if ((ref1 = cor.plugins) != null) {
              if ((ref2 = ref1.barcodescanner) != null) {
                if (typeof ref2.scan === "function") {
                  ref2.scan(function(result) {
                    $log.debug("promise then");
                    return $scope.barcode = result;
                  }, function(error) {
                    $log.debug("promise catch");
                    return $scope.error = error;
                  });
                }
              }
            }
          }
        } catch (error1) {
          error = error1;
          $scope.messages.push("Error: " + error);
          $scope.error = error;
        }
        return $log.debug("$ionicPlatform.ready end");
      });
      return $log.debug("scanBarcode end");
    };
  });

}).call(this);

//# sourceMappingURL=app.js.map
