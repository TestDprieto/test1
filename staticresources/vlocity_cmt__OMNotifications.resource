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
var app = angular.module('OMNotifications', ['sldsangular', 'ngSanitize', 'ngAnimate']);
app.config(['remoteActionsProvider', function(remoteActionsProvider) {
    remoteActionsProvider.setRemoteActions(window.remoteActions || {});
}]);
require('./modules/OMNotifications/controller/OMNotificationsController.js');
require('./modules/OMNotifications/templates/templates.js');
require('./modules/OMNotifications/factory/SpinnerFactory.js');
},{"./modules/OMNotifications/controller/OMNotificationsController.js":2,"./modules/OMNotifications/factory/SpinnerFactory.js":3,"./modules/OMNotifications/templates/templates.js":4}],2:[function(require,module,exports){
var app = angular.module('OMNotifications');
app.controller('OMNotificationsController', ['$scope', 'remoteActions', '$window','Spinner',
    function (scope, remoteActions, window, spinner) {
        scope.labels = window.labels;
        scope.nsPrefix = window.configData.nsPrefix;
        scope.notificationList = [];
        scope.fieldsMap = {};
        scope.pageSize = null;
        scope.searchParam = '';
        scope.spinner = spinner;

        scope.init = function() {
            scope.getDisplayFields();
            scope.getOMNotifications();
        }

        scope.getOMNotifications = function() {
            remoteActions.searchOrderEvents(scope.searchParam,scope.pageSize).then(function(results) {
                scope.notificationList = results.records;
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
angular.module('OMNotifications')
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

},{}],4:[function(require,module,exports){
angular.module("OMNotifications").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("OMNotificationsTable.tpl.html",'<div class="slds-col slds-grid slds-grid--vertical-stretch">\n    \x3c!-- SPINNER --\x3e\n    <div class="slds-spinner_container" ng-show="spinner.getSpinner()">\n        <div class="slds-spinner_brand slds-spinner slds-spinner_large" aria-hidden="false" role="alert">\n            <div class="slds-spinner__dot-a"></div>\n            <div class="slds-spinner__dot-b"></div>\n        </div>\n    </div>\n    <div ng-if="notificationList && notificationList.length !== 0" class="slds-col">\n        <table class="slds-table slds-table_bordered slds-table_cell-buffer slds-m-top_small">\n            <thead>\n                <tr class="slds-text-heading_label">\n                    <th scope="col" data-title="{{label}}" ng-repeat="(field, label) in fieldsMap">\n                        <div class="slds-truncate">{{label}}</div>\n                    </th>\n                </tr>\n            </thead>\n            <tbody>\n                <tr scope="row" ng-repeat="notification in notificationList">\n                    <td class="slds-cell-wrap" ng-repeat="(field, detail) in fieldsMap">\n                        <div ng-if="detail ===\'Order\'"> \n                            <a href="#" ng-click="open(notification.fields[field].value)">{{notification.fields[field].label}}</a>\n                        </div>\n                        <span class="om-notifications-long-text-wrap" ng-if="detail!==\'Order\'">{{notification.fields[field].label}}</span>\n                    </td>\n                </tr>\n            </tbody>\n        </table>\n    </div>\n    <div ng-if="!notificationList || notificationList.length === 0" class="slds-col slds-theme_shade">\n        <div class="slds-m-around_medium slds-text-align_center">{{labels.NoOrderManagementNotification}}</div>\n    </div>\n</div>\n')}]);

},{}]},{},[1]);
})();
