(function(){
  var fileNsPrefix = (function() {
    'use strict';
    var scripts = document.getElementsByTagName('script');
    var lastScript = scripts[scripts.length - 1];
    var scriptName = lastScript.src;
    var parts = scriptName.split('/');
    var partsLength = parts.length - 1;
    var thisScript = parts[partsLength--];
    if (thisScript === "") {
      thisScript = parts[partsLength--];
    }

    // Fix to handle cases where js files are inside zip files
    // https://dev-card.na31.visual.force.com/resource/1509484368000/dev_card__cardframework_core_assets/latest/cardframework.js

    //fix for finding nsPrefix in subpaths and subdomains
    if (scriptName.indexOf('__') != -1) {
      while(thisScript.indexOf('__') == -1 && partsLength >= 0) {
        thisScript = parts[partsLength];
        partsLength--;
      }
    }

    var lowerCasePrefix = thisScript.indexOf('__') == -1 ? '' : thisScript.substring(0, thisScript.indexOf('__') + 2);
    //check for the cached namespace first
    lowerCasePrefix = lowerCasePrefix === '' && localStorage.getItem('nsPrefix') ? localStorage.getItem('nsPrefix'): lowerCasePrefix;
    
    if(lowerCasePrefix !== ''){
        lowerCasePrefix = /__$/.test(lowerCasePrefix) ? lowerCasePrefix : lowerCasePrefix + '__';
    }
    if (lowerCasePrefix.length === 0) {
      return function() {
        //then check if the app has put a namespace and take that one as it is newer
        lowerCasePrefix = window.nsPrefix ? window.nsPrefix: lowerCasePrefix;
        //add the underscore if it doesn't have them    
        if(lowerCasePrefix !== ""){
            lowerCasePrefix = /__$/.test(lowerCasePrefix) ? lowerCasePrefix : lowerCasePrefix + '__';
        }  
        return lowerCasePrefix;
      };
    } else {
      var resolvedNs = null;
      return function() {
        if (resolvedNs) {
          return resolvedNs;
        }
        // hack to make scan SF objects for the correct case
        try {
          var tofind = lowerCasePrefix.replace('__', '');
          var name;
          var scanObjectForNs = function(object, alreadySeen) {
            if (object && object !== window && alreadySeen.indexOf(object) == -1) {
                alreadySeen.push(object);
                Object.keys(object).forEach(function(key) {
                  if (key === 'ns') {
                    // do ns test
                    if (typeof object[key] === 'string' && object[key].toLowerCase() === tofind) {
                      name = object[key] + '__';
                      return false;
                    }
                  }
                  if (Object.prototype.toString.call(object[key]) === '[object Array]') {
                    object[key].forEach(function(value) {
                      var result = scanObjectForNs(value, alreadySeen);
                      if (result) {
                          name = result;
                          return false;
                      }
                    });
                  } else if (typeof object[key] == 'object') {
                    var result = scanObjectForNs(object[key], alreadySeen);
                    if (result) {
                        name = result;
                        return false;
                    }
                  }
                  if (name) {
                    return false;
                  }
                });
                if (name) {
                  return name;
                }
            };
          }
          if(typeof Visualforce !== 'undefined') { //inside VF
            scanObjectForNs(Visualforce.remoting.Manager.providers, []);  
          } else {
            return lowerCasePrefix;
          }
          if (name) {
            return resolvedNs = name;
          } else {
            return resolvedNs = lowerCasePrefix;
          }
        } catch (e) {
          return lowerCasePrefix;
        }
      };
    }
  })();

  var fileNsPrefixDot = function() {
    var prefix = fileNsPrefix();
    if (prefix.length > 1) {
      return prefix.replace('__', '.');
    } else {
      return prefix;
    }
  };(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
'use strict';
var app = angular.module('OrderRelationshipVisualization', ['sldsangular', 'ngSanitize', 'ngAnimate']);
app.config(['remoteActionsProvider', function(remoteActionsProvider) {
    remoteActionsProvider.setRemoteActions(window.remoteActions || {});
}]);
require('./modules/OrderRelationshipVisualization/controller/OrderRelationshipVisualizationController.js');
require('./modules/OrderRelationshipVisualization/factory/SpinnerFactory.js');
},{"./modules/OrderRelationshipVisualization/controller/OrderRelationshipVisualizationController.js":2,"./modules/OrderRelationshipVisualization/factory/SpinnerFactory.js":3}],2:[function(require,module,exports){
var app = angular.module('OrderRelationshipVisualization');
app.controller('OrderRelationshipVisualizationController', ['$scope', 'remoteActions', '$window','Spinner',
    function (scope, remoteActions, window, spinner) {
        scope.labels = window.labels;
        scope.nsPrefix = window.configData.nsPrefix;
        scope.fieldsMap = {};
        scope.pageSize = null;
        scope.searchParam = window.amendmentOrderId.Id;
        scope.spinner = spinner;
        scope.originalOrderIds = [];
        scope.amendOrderIds =[];
        var originalOrderId, i, cartId;
        scope.init = function() {
            scope.getDisplayFields();
            scope.getOrderAmendmentHistory();
        }

        scope.getOrderAmendmentHistory = function() {
            remoteActions.getOrderAmendmentHistory(scope.searchParam,null).then(function(results) {
                originalOrderId = results.data.dataMap.OriginalOrderId;
                cartId = results.data.dataMap.cartId;
                for(i = 0; i < results.records.length; i++) {
                    if (cartId === results.records[i].fields.id.value) {
                        results.records[i].fields.id.initialCartId = cartId;
                    } 
                    if (originalOrderId === results.records[i].fields.id.value) {
                        scope.originalOrderIds.push(results.records[i]);
                    } else {
                        scope.amendOrderIds.push(results.records[i]);
                    }
                }
            });
        }
        
        scope.getDisplayFields = function() {
            spinner.showSpinner();
            remoteActions.getDisplayFields().then(function(results) {
                spinner.hideSpinner();
                scope.fieldsMap = results;
            });
        }

        scope.open = function(id) {
            if (id && id !== '') {
                window.open('/' + id);
            }
        }
    }
]);

},{}],3:[function(require,module,exports){
angular.module('OrderRelationshipVisualization')
.factory('Spinner', [
    function(){
        var spinner = false;
        return {
            getSpinner: function() {
                return spinner;
            },
            showSpinner: function() {
                spinner = true;
            },
            hideSpinner: function() {
                spinner = false;
            }
        };
    }
]);
},{}]},{},[1]);
})();
