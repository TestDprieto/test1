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
var app = angular.module('QueuedOrders', ['sldsangular', 'ngSanitize', 'ngAnimate']);
app.config(['remoteActionsProvider', function(remoteActionsProvider) {
    remoteActionsProvider.setRemoteActions(window.remoteActions || {});
}]);

require('./modules/QueuedOrders/controller/QueuedOrdersController.js');
require('./modules/QueuedOrders/factory/MessageService.js');
require('./modules/QueuedOrders/factory/SpinnerFactory.js');
require('./modules/QueuedOrders/templates/templates.js');

},{"./modules/QueuedOrders/controller/QueuedOrdersController.js":2,"./modules/QueuedOrders/factory/MessageService.js":3,"./modules/QueuedOrders/factory/SpinnerFactory.js":4,"./modules/QueuedOrders/templates/templates.js":5}],2:[function(require,module,exports){
var app = angular.module('QueuedOrders');
app.controller('QueuedOrdersController', ['$scope', '$sldsModal', 'remoteActions', '$window', 'MessageService', 'Spinner', '$filter',
    function (scope, modal, remoteActions, window, messageService, spinner, filter) {
        scope.SLDSICON = window.SLDSICON;
        scope.labels = window.labels;
        scope.nsPrefix = window.configData.nsPrefix;
        scope.orderList = [];
        scope.fieldsMap = {};
        scope.spinner = spinner;
        scope.sortField = scope.nsPrefix + 'RequestedStartDate__c';
        scope.isAsc = true;
        scope.searchParam = '';
        scope.pagination = {
            currentPage: 1,
            totalCount: 0,
            totalPages: 0,
            pageSize: 20,
            start: 1,
            end: 20
        }

        scope.init = function() {
            scope.getDisplayFields();
            scope.getQueuedOrders();
        }

        scope.getQueuedOrders = function() {
            spinner.showSpinner();
            scope.getRecordCount();
            var offset = (scope.pagination.currentPage - 1) * scope.pagination.pageSize;
            remoteActions.getQueuedOrders(scope.searchParam, scope.pagination.pageSize, offset, scope.sortField, scope.isAsc).then(function(results) {
                scope.orderList = results;
                spinner.hideSpinner();
            });
        }

        scope.getRecordCount = function() {
            remoteActions.getRecordCount(scope.searchParam).then(function(results) {
                scope.pagination.totalCount = parseInt(results);
                scope.updatePagination();
            });
        }

        scope.updatePagination = function() {
            var p = scope.pagination;
            p.totalPages = parseInt(p.totalCount / p.pageSize) + (p.totalCount % p.pageSize != 0 ? 1 : 0);
            p.start = ((p.currentPage - 1 ) * p.pageSize) + 1;
            p.end = ((p.currentPage * p.pageSize) > p.totalCount) ? p.totalCount : (p.currentPage * p.pageSize);
        }

        scope.nextPage = function() {
            scope.pagination.currentPage++;
            scope.getQueuedOrders();
        }

        scope.previousPage = function() {
            scope.pagination.currentPage--;
            scope.getQueuedOrders();
        }

        scope.jumpToPage = function() {
            if (scope.pagination.currentPage < 1) {
                scope.pagination.currentPage = 1;
            }
            if (scope.pagination.totalPages !== 0 && (scope.pagination.currentPage > scope.pagination.totalPages)) {
                scope.pagination.currentPage = scope.pagination.totalPages;
            }

            scope.getQueuedOrders();
        }

        scope.getDisplayFields = function() {
            remoteActions.getDisplayFields().then(function(results) {
                scope.fieldsMap = results;
            });
        }

        scope.open = function(id) {
            if (id && id !== '') {
                window.open('/' + id);
            }
        }

        scope.forceSubmitOrder = function(order) {
            var modalScope = scope.$new();
            modalScope.confirmationTitle = scope.labels.QueuedOrderHeaderLabel;
            modalScope.confirmationMsg = scope.labels.ForceSubmitOrderMessage;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.confirmActionLbl = scope.labels.ForceSubmitLabel;
            modalScope.confirmationClass = 'slds-theme_warning';
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.confirmAction = function() {
                confirmationModal.hide();
                var orderName = order.Name ? order.Name : order.OrderNumber;
                messageService.infoToast(scope.labels.SubmittingLabel + ' ' + orderName);
                remoteActions.forceSubmitOrder(order.Id).then(function(results) {
                    var result = angular.fromJson(results);
                    result = result[order.Id];
                    if(result.hasError)
                    {
                        messageService.errorToast(orderName, result.errorMessage + ' ' + filter('date')(order[scope.nsPrefix + 'RequestedStartDate__c'], 'MMMM d, y h:mm a'));
                    }
                    else {
                        if(result.CheckoutWithOM) {
                            if(result.errorStatus == 'OK') {
                                messageService.successToast(orderName + ' ' + scope.labels.SubmittedSuccLabel, result.errorMessage);
                            } else {
                                messageService.errorToast(orderName + scope.labels.SubmitFailedLabel, result.errorMessage);
                            }
                        } else {
                            var cpqResult = result.message;
                            if(cpqResult) {
                                if(cpqResult.severity === 'SUCCESS' || cpqResult.severity === 'INFO') {
                                    messageService.successToast(orderName + ' ' + scope.labels.SubmittedSuccLabel, cpqResult.message);
                                } else {
                                    messageService.errorToast(orderName + ' ' + scope.labels.SubmitFailedLabel, cpqResult.message);
                                }
                            } else {
                                messageService.successToast(orderName + ' ' + scope.labels.SubmittedSuccLabel);
                            }
                        }
                        scope.getQueuedOrders();
                    }
                });
            };
            var confirmationModal = modal({
                templateUrl: 'ConfirmationModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
            });
        }

        scope.submitAll = function() {

            var modalScope = scope.$new();
            modalScope.confirmationTitle = scope.labels.QueuedOrderHeaderLabel;
            modalScope.confirmationMsg = scope.labels.SubmitOrderAllMessage;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.confirmActionLbl = scope.labels.QueuedOrderSubmitBatchLabel;
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.confirmAction = function() {
                confirmationModal.hide();
                messageService.infoToast(scope.labels.BatchSubmitMessage);
                remoteActions.submitAllOrders().then(function(results) {
                    messageService.successToast(results);
                });
            };
            var confirmationModal = modal({
                templateUrl: 'ConfirmationModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
            });
        }

        scope.refresh = function() {
            scope.searchParam = '';
            scope.getQueuedOrders();
        }

        scope.scheduleSubmitJob = function() {

            var modalScope = scope.$new();
            modalScope.confirmationTitle = scope.labels.QueuedOrderHeaderLabel;
            modalScope.confirmationMsg = scope.labels.SubmitOrderAllMessage;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.confirmActionLbl = scope.labels.ScheduleFDOBatchJobLabel;
            modalScope.SLDSICON = scope.SLDSICON;
            remoteActions.getScheduleFDOSubmitBatch().then(function(results) {
                if(results.length > 0) {
                    modalScope.scheduled = results[0];
                }
            });
            modalScope.confirmAction = function(cronTriggerExpression) {
                confirmationModal.hide();
                messageService.infoToast('Scheduling...');
                if(!cronTriggerExpression) {
                    cronTriggerExpression = '';
                }
                remoteActions.scheduleFDOSubmitBatch(cronTriggerExpression).then(function(results) {
                    if(results.hasError) {
                        messageService.errorToast(results.message);
                    } else {
                        messageService.successToast(results.message);
                    }
                });
            };
            var confirmationModal = modal({
                templateUrl: 'ScheduleSubmitJob.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
            });
        }
    }
]);

},{}],3:[function(require,module,exports){
var app = angular.module('QueuedOrders');
app.service('MessageService',['$sldsToast', '$sldsPrompt', '$window',
    function MessageService(toast, prompt, window) {
        MessageService.prototype.openAlertWindow = function (title, message) {
            deletePrompt = prompt({
                title: title,
                content: message,
                theme: 'error',
                show: true,
                buttons: [{
                    label: window.labels.OKLabel,
                    type: 'neutral',
                    action: function() {
                        deletePrompt.hide();
                    }
                }]
            });
        };

        MessageService.prototype.openSuccessWindow = function (title, message) {
            prompt({
                title: title,
                content: message,
                theme: 'success',
                show: true,
                buttons: [{
                    label: window.labels.OKLabel,
                    type: 'neutral',
                    action: function() {
                        deletePrompt.hide();
                    }
                }]
            });
        };

        MessageService.prototype.successToast = function (title, content) {
            return toast({
                title: title,
                content: content,
                severity: 'success',
                icon: 'success',
                templateUrl: 'SldsToast.tpl.html',
                autohide: true,
                show: true
            });
        };

        MessageService.prototype.errorToast = function (title, content) {
            return toast({
                title: title,
                content: content,
                severity: 'error',
                icon: 'error',
                templateUrl: 'SldsToast.tpl.html',
                autohide: false,
                show: true
            });
        };

        MessageService.prototype.warningToast = function (title, content) {
            return toast({
                title: title,
                content: content,
                severity: 'warning',
                icon: 'warning',
                templateUrl: 'SldsToast.tpl.html',
                autohide: false,
                show: true
            });
        };

        MessageService.prototype.infoToast = function (title, content) {
            return toast({
                title: title,
                content: content,
                severity: 'info',
                icon: 'info',
                templateUrl: 'SldsToast.tpl.html',
                autohide: true,
                show: true
            });
        };
    }
]);

},{}],4:[function(require,module,exports){
angular.module('QueuedOrders')
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

},{}],5:[function(require,module,exports){
angular.module("QueuedOrders").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("QueuedOrdersTable.tpl.html",'<div class="slds-grid slds-form--inline" ng-if="orderList && orderList.length !== 0">\n    <div class="slds-size_1-of-1">\n        <div class="slds-float--left">\n            <span>Showing {{pagination.start}} - {{pagination.end}} of {{pagination.totalCount}} results</span>\n        </div>\n\n        <div class="slds-float--right">\n            <button class="slds-button slds-button--icon slds-m-right_x-small" ng-disabled="pagination.currentPage <= 1" ng-click="previousPage()">\n                <slds-button-svg-icon sprite="\'utility\'" size="\'medium\'" icon="\'left\'"></slds-button-svg-icon>\n                <span class="slds-assistive-text">Previous Page</span>\n            </button>\n            <span>\n                Page\n                <span class="slds-form-element__control">\n                    <input type="number" ng-model="pagination.currentPage" ng-change="jumpToPage()" class="slds-input page-number"/>\n                </span>\n                of {{pagination.totalPages}}\n            </span>\n            <button class="slds-button slds-button--icon slds-m-left_x-small" ng-disabled="pagination.currentPage >= pagination.totalPages" ng-click="nextPage()">\n                <slds-button-svg-icon sprite="\'utility\'" size="\'medium\'" icon="\'right\'"></slds-button-svg-icon>\n                <span class="slds-assistive-text">Next Page</span>\n            </button>\n        </div>\n    </div>\n</div>\n<div class="slds-col slds-grid slds-grid--vertical-stretch">\n    \x3c!-- SPINNER --\x3e\n    <div class="slds-spinner_container" ng-show="spinner.getSpinner()">\n        <div class="slds-spinner_brand slds-spinner slds-spinner_large" aria-hidden="false" role="alert">\n            <div class="slds-spinner__dot-a"></div>\n            <div class="slds-spinner__dot-b"></div>\n        </div>\n    </div>\n\n    <div ng-if="orderList && orderList.length !== 0" class="slds-col">\n        <table class="slds-table slds-table_bordered slds-table_cell-buffer slds-m-top_small">\n            <thead>\n                <tr class="slds-text-heading_label">\n                    <th scope="col" data-title="{{label}}" ng-repeat="(field, label) in fieldsMap">\n                        <div class="slds-truncate">{{label}}</div>\n                    </th>\n                    <th scope="col" data-title="Account">\n                        <div class="slds-truncate">{{labels.AccountLabel}}</div>\n                    </th>\n                    <th scope="col" data-title="Action">\n                        <div class="slds-truncate">{{labels.ActionLabel}}</div>\n                    </th>\n                </tr>\n            </thead>\n            <tbody>\n                <tr scope="row" ng-repeat="order in orderList">\n                    <td class="slds-cell-wrap" ng-repeat="(field, detail) in fieldsMap">\n                        <div ng-if="field === \'OrderNumber\'">\n                            <a href="#" ng-click="open(order.Id)">{{order[field]}}</a>\n                        </div>\n                        <div ng-if="field === nsPrefix + \'RequestedStartDate__c\'">\n\n                            {{order[field] | date : \'MMMM d, y h:mm a\'}}\n                        </div>\n                        <div ng-if="field !== \'OrderNumber\' && field !== nsPrefix + \'RequestedStartDate__c\'">\n                            {{order[field]}}\n                        </div>\n                    </td>\n\n                    <td class="slds-cell-wrap">\n                        <a href="#" ng-click="open(order.Account.Id)">{{order.Account.Name}}</a>\n                    </td>\n                    <td class="slds-cell-wrap">\n                        <button class="slds-button slds-button_primary" ng-click="forceSubmitOrder(order)">{{labels.ForceSubmitLabel}}</button>\n                    </td>\n                </tr>\n            </tbody>\n        </table>\n    </div>\n\n    <div ng-if="!orderList || orderList.length === 0" class="slds-col slds-theme_shade">\n        <div class="slds-m-around_medium slds-text-align_center">{{labels.NoOrderInQueueMessage}}</div>\n    </div>\n</div>\n'),$templateCache.put("ScheduleSubmitJob.tpl.html",'<section role="dialog" tabindex="-1" aria-labelledby="modal-heading-01" aria-modal="true" aria-describedby="modal-content-id-1" class="schedule-submit slds-modal slds-fade-in-open slds-modal_medium">\n    <div class="slds-modal__container">\n        <header class="slds-modal__header" ng-class="confirmationClass">\n            <button class="slds-button slds-button_icon slds-modal__close slds-button_icon-inverse" title="Close" ng-click="$hide()">\n                <slds-button-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'large\'"></slds-button-svg-icon>\n            </button>\n            <h2 class="slds-text-heading_medium slds-hyphenate">{{confirmationTitle}}</h2>\n        </header>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div class="slds-page-header" ng-if="!scheduled">\n                Submit Order Batch is not scheduled.\n            </div>\n            <div class="slds-page-header" ng-if="scheduled">\n                <div class="slds-grid">Scheduled Details</div>\n                <ul class="slds-grid slds-page-header__detail-row">\n                    <li class="slds-page-header__detail-block">\n                        <p class="slds-text-title slds-truncate slds-m-bottom_xx-small" title="Scheduled On">Scheduled On</p>\n                        <p class="slds-text-body_regular slds-truncate" title="{{scheduled.StartTime | date : \'MMMM d, y h:mm a\'}}">{{scheduled.StartTime | date : \'MMMM d, y h:mm a\'}}</p>\n                    </li>\n                    <li class="slds-page-header__detail-block">\n                        <p class="slds-text-title slds-truncate slds-m-bottom_xx-small" title="Current Job Status">Current Job Status</p>\n                        <p class="slds-text-body_regular slds-truncate" title="{{scheduled.State}}">{{scheduled.State}}</p>\n                    </li>\n                    <li class="slds-page-header__detail-block">\n                        <p class="slds-text-title slds-truncate slds-m-bottom_xx-small" title="Next Fire Time">Next Fire Time</p>\n                        <p class="slds-text-body_regular slds-truncate" title="{{scheduled.NextFireTime | date : \'MMMM d, y h:mm a\'}}">{{scheduled.NextFireTime | date : \'MMMM d, y h:mm a\'}}</p>\n                    </li>\n                    <li class="slds-page-header__detail-block">\n                        <p class="slds-text-title slds-truncate slds-m-bottom_xx-small" title="Previous Fire Time">Previous Fire Time</p>\n                        <p class="slds-text-body_regular slds-truncate" title="{{scheduled.PreviousFireTime | date : \'MMMM d, y h:mm a\'}}">{{scheduled.PreviousFireTime | date : \'MMMM d, y h:mm a\'}}</p>\n                    </li>\n                    <li class="slds-page-header__detail-block">\n                        <p class="slds-text-title slds-truncate slds-m-bottom_xx-small" title="Previous Fire Time">Cron Expression</p>\n                        <p class="slds-text-body_regular slds-truncate" title="{{scheduled.CronExpression}}">{{scheduled.CronExpression}}</p>\n                    </li>\n                </ul>\n            </div>\n            <div class="slds-page-header slds-m-top_small">\n                <div class="slds-grid" ng-if="scheduled">Reschedule Batch</div>\n                <div class="slds-grid" ng-if="!scheduled">Schedule Batch</div>\n                <div class="slds-grid slds-page-header__detail-row">\n                    <div class="slds-form-element slds-page-header__detail-block">\n                        <label class="slds-form-element__label" for="input-01">Cron Expression(optional)</label>\n                        <div class="slds-form-element__control">\n                            <input id="input-01" type="text" class="slds-input" ng-model="cronTriggerExpression" placeholder="0 0 * * * ?">\n                            <div class="slds-form-element__help">Default value: 0 0 * * * ?</div>\n                        </div>\n                    </div>\n                    <div class="slds-page-header__detail-block slds-p-top_medium">\n                        <button type="button" class="slds-button slds-button_brand" ng-click="confirmAction(cronTriggerExpression)">Schedule</button>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n</section>\n<div class="slds-backdrop slds-backdrop_open"></div>\n'),$templateCache.put("ConfirmationModal.tpl.html",'<section role="dialog" tabindex="-1" aria-labelledby="modal-heading-01" aria-modal="true" aria-describedby="modal-content-id-1" class="slds-modal slds-fade-in-open">\n    <div class="slds-modal__container">\n        <header class="slds-modal__header" ng-class="confirmationClass">\n            <button class="slds-button slds-button_icon slds-modal__close slds-button_icon-inverse" title="Close" ng-click="$hide()">\n                <slds-button-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'large\'"></slds-button-svg-icon>\n            </button>\n            <h2 class="slds-text-heading_medium slds-hyphenate">{{confirmationTitle}}</h2>\n        </header>\n        <div class="slds-modal__content slds-p-around_medium">\n            <p ng-bind-html="confirmationMsg"></p>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral" ng-click="$hide()">{{cancelActionLbl}}</button>\n            <button type="button" class="slds-button slds-button_brand" ng-click="confirmAction()">{{confirmActionLbl}}</button>\n        </div>\n    </div>\n</section>\n<div class="slds-backdrop slds-backdrop_open"></div>\n')}]);

},{}]},{},[1]);
})();
