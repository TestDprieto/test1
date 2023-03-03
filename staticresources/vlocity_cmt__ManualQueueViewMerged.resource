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
var app = angular.module('manualQueueApp',['vlocity', 'thorIntegration', 'ngSanitize']);

app.config(function (remoteActionsProvider) {
    remoteActionsProvider.setRemoteActions(remoteActions);
});

app.config(function($provide) {
$provide.decorator('remoteActions', function($delegate, $http, thorIntegrationService, manualQueueOffPlatformCallService) {
    console.log('config on');
    var originalRemoteActions = $delegate;
    var potentiallyOffPlatformCalls = ['getItems', 'getMetaData', 'retryItems', 'completeItems', 'assignToMe', 'getActiveQueueMethod', 'getActiveQueueWithQuery','assignToQueue','assignToUser','getActiveUsersWithQuery','getActiveUserMethod','clearUserAssignment','getRecordById','getObjectTypeById','getAttributeById'];
    potentiallyOffPlatformCalls.forEach(remoteActionName => {
        remoteActionCallFn[remoteActionName] = originalRemoteActions[remoteActionName];
        originalRemoteActions[remoteActionName] = manualQueueOffPlatformCallService[remoteActionName];
    });
    return $delegate;
})
})

require('./modules/manualqueueviewmerged/service/authorizationService.js');
require('./modules/manualqueueviewmerged/service/manualQueueOffPlatformCallService.js');
require('./modules/manualqueueviewmerged/service/omPlusMetadataService.js');

require('./modules/manualqueueviewmerged/filters/newLinesFliter.js');
require('./modules/manualqueueviewmerged/filters/numberTimezoneFilter.js');

require('./modules/manualqueueviewmerged/directive/calculatedValue.js');
require('./modules/manualqueueviewmerged/directive/datetimeValue.js');
require('./modules/manualqueueviewmerged/directive/infiniteScroll.js');
require('./modules/manualqueueviewmerged/directive/linkValue.js');
require('./modules/manualqueueviewmerged/directive/manualQueueValue.js');
require('./modules/manualqueueviewmerged/directive/picklistValue.js');
require('./modules/manualqueueviewmerged/directive/progressBar.js');
require('./modules/manualqueueviewmerged/directive/referenceValue.js');
require('./modules/manualqueueviewmerged/directive/jsonValue.js');
require('./modules/manualqueueviewmerged/directive/objectTypeValue.js');
require('./modules/manualqueueviewmerged/directive/referenceToAttributeValue.js');
require('./modules/manualqueueviewmerged/directive/textValue.js');

require('./modules/manualqueueviewmerged/controller/manualQueueController.js');
},{"./modules/manualqueueviewmerged/controller/manualQueueController.js":2,"./modules/manualqueueviewmerged/directive/calculatedValue.js":3,"./modules/manualqueueviewmerged/directive/datetimeValue.js":4,"./modules/manualqueueviewmerged/directive/infiniteScroll.js":5,"./modules/manualqueueviewmerged/directive/jsonValue.js":6,"./modules/manualqueueviewmerged/directive/linkValue.js":7,"./modules/manualqueueviewmerged/directive/manualQueueValue.js":8,"./modules/manualqueueviewmerged/directive/objectTypeValue.js":9,"./modules/manualqueueviewmerged/directive/picklistValue.js":10,"./modules/manualqueueviewmerged/directive/progressBar.js":11,"./modules/manualqueueviewmerged/directive/referenceToAttributeValue.js":12,"./modules/manualqueueviewmerged/directive/referenceValue.js":13,"./modules/manualqueueviewmerged/directive/textValue.js":14,"./modules/manualqueueviewmerged/filters/newLinesFliter.js":15,"./modules/manualqueueviewmerged/filters/numberTimezoneFilter.js":16,"./modules/manualqueueviewmerged/service/authorizationService.js":17,"./modules/manualqueueviewmerged/service/manualQueueOffPlatformCallService.js":18,"./modules/manualqueueviewmerged/service/omPlusMetadataService.js":19}],2:[function(require,module,exports){
angular.module('manualQueueApp').controller('manualQueueController', ['omPlusMetadataService', '$scope' , 'remoteActions', '$interval', '$q', function(omPlusMetadataService, $scope, remoteActions, $interval, $q) {
    console.log('start manualQueueController');
    $scope.search = {};
    $scope.notification = {};
    $scope.selectedObject = {};
    $scope.fieldsToSort = {};
    $scope.isOffplatformMode = false;
    $scope.itemProcessedCounter = {'recordsToBeProcessed': 0, 'recordProcessed': 0, 'processedSuccessfully': 0, 'processingFailed': 0, 'numberOfItemsToProcess': 0};
    $scope.extraActionsArray = [ {'label' : 'Apply to all items' , 'action' : 'applyAll'}, 
                                 {'label' : 'Apply to first records', 'action' : 'applyFirst'} ]
    $scope.actionArray = [     {'label' : 'Clear User Assignment', 'extraActions' : false, 'action' : 'clearUserAssignment', 'extraActionsOpenCheck' : false},
                               {'label' : 'Retry' , 'extraActions' : true, 'action' : 'retry', 'extraActionsOpenCheck' : false},
                               {'label' : 'Complete' , 'extraActions' : true, 'action' : 'complete', 'extraActionsOpenCheck' : false},
                               {'label' : 'Assign To Me' , 'extraActions' : true, 'action' : 'assignToMe', 'extraActionsOpenCheck' : false},
                               {'label' : 'Assign To User', 'extraActions' : false, 'action' : 'assignToUser', 'extraActionsOpenCheck' : false},
                               {'label' : 'Assign To Queue', 'extraActions' : true, 'action' : 'assignToQueue', 'extraActionsOpenCheck' : false}];
    $scope.processNameAccordingToAction = {
                        'retry': 'retry',
                        'complete': 'complete item',
                        'assignToMe': 'assign to me',
                        'assignToQueue': 'assign to queue',
                        'assignToUser': 'assign to user',
                        'clearUserAssignment': 'clear user assignment'
    }

    $scope.manualTasks = []
    $scope.columnNameMap = [];
    $scope.fieldsToDisplay = [];

    $scope.ticking = false;
    $scope.selectAllCheck = false;
    $scope.showProgressModal = false;
    $scope.isLoading = false;
    $scope.underProcessCheck = false;
    $scope.isApplyAll = false;
    $scope.isPartial = false;
    $scope.isManual = false;
    $scope.isAllLoaded = false;
    $scope.isProcessingComplete = false;
    $scope.showAssignmentModal = false;
    $scope.isSearchDropDownActive = false;
    $scope.searchMode = false;
    $scope.isFilterPanelVisible = false;
    $scope.showSpinner = true;
    $scope.filterBoxCheck = false;


    $scope.completedBatch = 0;
    $scope.totalBatch = 0;
    $scope.numberOfItemsToProcess = 0;
    $scope.calculatedStart = 0;
    $scope.calculatedEnd = 20;

    $scope.search.searchTerm = '';
    $scope.assignmentModalHeader = '';
    $scope.action = '';
    $scope.manualQueueName = '';
    $scope.notification.successMessage = '';
    $scope.notification.errorMessage = '';

            $scope.sortManualQueue = sortManualQueue;
            $scope.getDataToDisplay = getDataToDisplay;
            $scope.loadnextRecord = loadnextRecord;
            $scope.closeExtraActionsMenu = closeExtraActionsMenu;
            $scope.takeAction = takeAction;
            $scope.closeProgressModal = closeProgressModal;
            $scope.startAction = startAction;
            $scope.pickUpAndRedirect = pickUpAndRedirect;
            $scope.onSearchQueryChange = onSearchQueryChange;
            $scope.hideSearchDropDown = hideSearchDropDown;
            $scope.showSearchDropDown = showSearchDropDown;
            $scope.calculateStarting = calculateStarting;
            $scope.onResetButtonPress = onResetButtonPress;
            $scope.onSearchButtonPress = onSearchButtonPress;
            $scope.getSuggestedValues = getSuggestedValues;
            $scope.enterSearchMode = enterSearchMode;
            $scope.modelSelected = modelSelected;
            $scope.removeObject = removeObject;
            $scope.assigned = assigned;
            $scope.closeAssignmentModal = closeAssignmentModal;
            $scope.selectAll = selectAll;
            $scope.clearError = clearError;
            $scope.clearSuccess = clearSuccess;
            $scope.isManualQueueValue = isManualQueueValue;

 
            x = [];
            let regEx = '';
    let displayedFields="State__c, TimestampReady__c, Account__c, OrderFulfilmentRequest__c, AssignedToUserId__c";
    let metaData = {};
    let sortParameter = [];
    let additionalFilter = {};
    let additionalFilterReferenced = {};
    let itemsToUpdate = [];
    let batchSize = 100;
    let offSet = 0;
    let itemIdsProcessed = [];
    let idList = {};
    let deepCheckFlag = false;
    let manualQueueValueValueList = ['false', 'DATETIME', 'ID', 'REFERENCE', '0', '1', '3', '4', '5', '6', '7', '8', '10'];
    let manualQueueValueKeyList = ['customtaskexecutionurl__c', '6392296721099048977'];

    let operations = {  'retry': 'retryItems',
                        'complete': 'completeItems',
                        'assignToMe': 'assignToMe',
                        'assignToQueue': 'assignToQueue',
                        'assignToUser': 'assignToUser',
                        'clearUserAssignment': 'clearUserAssignment'
                    }

    let isExtraModalAction = {  'assignToQueue': true,
                                'assignToUser': true
                            }
    
    let extraModalOperations = {
        'assignToQueueRandom': 'getActiveQueueMethod',
        'assignToQueueQuery': 'getActiveQueueWithQuery',
        'assignToUserRandom': 'getActiveUserMethod',
        'assignToUserQuery': 'getActiveUsersWithQuery',
        'assignToQueue': 'queue',
        'assignToUser': 'user'
    }

    let notificationMessages = {
        'retry': `retried`,
        'complete': `completed`,
        'assignToMe': `picked up`,
        'assignToUser': `assigned to user`,
        'assignToQueue': `assigned to queue`,
        'clearUserAssignment': `unassigned`
    }

    let p1 = remoteActions.getMetaData(id, displayedFields).then((response) => {
        metaData = response;
        let fieldsToDisplay = [];
        $scope.isOffplatformMode = oMPlusMetaData.isOffplatformMode;
        for (let i =0; i < metaData.fieldsToDisplay.length; i++) {
        	if (fieldsToDisplay.indexOf (metaData.fieldsToDisplay[i]) < 0) {
        		fieldsToDisplay.push (metaData.fieldsToDisplay[i]);
        	}
        }
        metaData.fieldsToDisplay = fieldsToDisplay;
        if (!$scope.filterFieldsMetadata) {
            $scope.filterFieldsMetadata = metaData['filterFieldsMetaData'];
            Object.keys($scope.filterFieldsMetadata).forEach((key) => {
                let keyLowerCased = key.toLowerCase();
                if ((keyLowerCased === 'state' || keyLowerCased === 'state__c' || keyLowerCased === '7') && oMPlusMetaData.isOffplatformMode) {
                    $scope.filterFieldsMetadata[key]['value'] = oMPlusMetaData.thorLayoutConfig.defaultFilter['State'];
                    additionalFilter = oMPlusMetaData.thorLayoutConfig.defaultFilter;
                } else {
                    $scope.filterFieldsMetadata[key]['value'] = '';
                }
            });
          $scope.filterBoxCheck = Object.keys($scope.filterFieldsMetadata).length > 0;
        }
    },(error) => {
        console.log (error);
        $scope.notification.errorMessage = error;
    }).catch((error)=>{
        console.log (error);
        $scope.notification.errorMessage = error;
    });
    
    let p2 = remoteActions.getTimeZoneOffset().then ((response)=> {
    	$scope.timeZoneOffset = response || 0;
    })
    
    $q.all([p1,p2]).then ((response)=>{
    	loadnextRecord(null, null, false);
    });
    
    function loadnextRecord (reconciledOffset, reconciledLimit, isReconciling) {
        if(!$scope.isAllLoaded) {
            if(metaData && metaData.object) {
                    id = metaData.object.id;
            }
            let limit = reconciledLimit || batchSize;
            offSet = reconciledOffset != null ? reconciledOffset : $scope.manualTasks.length;
            $scope.loadingInProgress = true;
            console.log ('Loading records ' + (offSet + 1) + '-' + (offSet + limit) + '... by ' + limit + ' records');
            let userTasks = false;
            if (metaData && metaData.facet && metaData.facet.properties['6392296721099033613'] != null) userTasks = metaData.facet.properties['6392296721099033613'];
            remoteActions.getItems (id, limit, offSet, sortParameter, additionalFilter, userTasks, '', additionalFilterReferenced, displayedFields).then (function(response){
                $scope.columnNameMap = metaData['displayMap']
                $scope.fieldsToDisplay = metaData['fieldsToDisplay'];
                if( oMPlusMetaData.isOffplatformMode ) {
                    assignDataOMPlus (response, isReconciling);
                } else {
                    assignDataOMStd (response, isReconciling);
                }
                $scope.showSpinner = false;
                console.log (metaData);
                console.log (oMPlusMetaData.isOffplatformMode);
                console.log (response);
            }, (error) => {
                $scope.notification.errorMessage = error;
            })
        }
    }

    function assignDataOMPlus (response, isReconciling) {
        if (response && response.data && response.data.length > 0) {
            $scope.manualQueueName = metaData.manualQueueName = metaData.object ? metaData.object.name : '';
            if (isReconciling) {
                reconcileItems (response.data);
                return;
            }
            if ($scope.isApplyAll || $scope.isPartial){
                itemsToUpdate = [...response.data.map (item => item['id'])];
                operation ();
            } else {
                $scope.manualTasks.push(...response.data);
                $scope.manualTasks.forEach((item) => item.selected = false);
                $scope.calculateStarting ($scope.calculatedStart, 40);
            }
        } 
        if (response && response.data && (response.data.length == 0 || response.data.length < batchSize))
        {
            $scope.isAllLoaded = true;
        }
        if (($scope.isApplyAll || $scope.isPartial) && response.data.length == 0){
                afterBulkOperation ();
        }
        for (let i=0; i<metaData.fieldsToDisplay.length; i++) {
            if ($scope.fieldsToSort[$scope.fieldsToDisplay[i]]) {
                $scope.fieldsToSort[$scope.fieldsToDisplay[i]] = $scope.fieldsToSort[$scope.fieldsToDisplay[i]];
            } else {
                $scope.fieldsToSort[$scope.fieldsToDisplay[i]] = ''
            }
        }
    }

    function assignDataOMStd (response, isReconciling) {
        $scope.manualQueueName = metaData['manualQueueName'];
        nsPrefix = metaData['nsPrefix'];
        deepCheckFlag = metaData['deepCheckFlag'];
        regEx = new RegExp(nsPrefix, 'g');
        items = response['items'];
        if (isReconciling) {
            reconcileItems (response['items']);
            return;
        }
        if (items.length > 0) {
            if ($scope.isApplyAll || $scope.isPartial){
                itemsToUpdate = [...items.map (item => item['Id'])];
                operation ();
            } else {
                $scope.manualTasks.push (...items.map(flattenObject));
                $scope.calculateStarting ($scope.calculatedStart, 40);
                
            }
        }
        if (items.length == 0 || items.length < batchSize) {
            $scope.isAllLoaded = true;
        }
        for (let i=0; i<metaData.fieldsToDisplay.length; i++) {
            if ($scope.fieldsToSort[$scope.fieldsToDisplay[i]]) {
                $scope.fieldsToSort[$scope.fieldsToDisplay[i]] = $scope.fieldsToSort[$scope.fieldsToDisplay[i]];
            } else {
                $scope.fieldsToSort[$scope.fieldsToDisplay[i]] = ''
            }
        }

        if (!$scope.filterFieldsMetadata) {
          $scope.filterFieldsMetadata = metaData['filterFieldsMetaData'];
          Object.keys($scope.filterFieldsMetadata).forEach((key) => $scope.filterFieldsMetadata[key]['value'] = '');
          $scope.filterBoxCheck = Object.keys($scope.filterFieldsMetadata).length > 0;
        }
    }

    function sortManualQueue (key) {
        sortParameter = [];
        if ($scope.columnNameMap[key]['type'] !== 'TEXTAREA' && $scope.columnNameMap[key]['type']  !== '3'){
            $scope.showSpinner = true;
            if ($scope.fieldsToSort[key] === ''){
                $scope.fieldsToSort[key] = 'asc';
            } else if ($scope.fieldsToSort[key] === 'asc') {
                $scope.fieldsToSort[key] = 'desc';
            } else if ($scope.fieldsToSort[key] === 'desc') {
                $scope.fieldsToSort[key] = '';
            }
            Object.keys ($scope.fieldsToSort).forEach((key) => {
                let sortBy = {};
                if($scope.fieldsToSort[key]) {
                    if(key === 'id' && metaData.displayMap[key]['field'] === 'name') {
                        sortBy['Name'] = $scope.fieldsToSort[key];
                    } else {
                        sortBy[key] = $scope.fieldsToSort[key];
                    }
                    sortParameter.push(sortBy);
                }
            })
            resetView();
            } else {
              console.log(key+' is of type TEXTAREA which can not be sorted');
            }
    }

    function getDataToDisplay (item, key) {
        return item[metaData.displayMap[key]['field']];
    }

    function pickUpAndRedirect (url, item) {
        let contextObjectId = oMPlusMetaData.thorLayoutConfig.contextObjectId;
        item['selected'] = true;
        takeAction ('assignToMe','');
        if (url) {
            if (oMPlusMetaData.isOffplatformMode) {
            	if (oMPlusMetaData.isOffplatformMode) {
                	url = `${url}${item['id']}&contextObjectId=${contextObjectId}`;
                    window.open(baseURL + url);
                }
            } else {
                remoteActions.redirectURL1(item['id'], url).then(function(response) {
                    window.open(baseURL+response);
                    $scope.showSpinner = false;
                })
            }
        } else {
            if (oMPlusMetaData.isOffplatformMode) {
                let link = '/object/'+item.id;
                let linkToRedirectInNewTab = window.location.protocol + '//' + window.location.hostname + "/apex/XOMObjectParams#!"+link;
                window.open(linkToRedirectInNewTab);
            } else {
              window.open(baseURL+'/'+item.id);
              $scope.showSpinner = false;
            }
        }

    }

    function closeExtraActionsMenu(action) {
          $interval(function() { // closing after 100ms to allow the onClick event to happen on the menu item
              action['extraActionsOpenCheck'] = false;
          }, 300, 1);
    }

    function takeAction(action, extraAction) {
        $scope.action = action;
        $scope.isApplyAll = false;
        $scope.isPartial = false;
        $scope.isManual = false;
        if (extraAction && extraAction === 'applyAll') {
            $scope.isApplyAll = true;
            console.log (`is apply all ${$scope.isApplyAll}`);
        } else if (extraAction && extraAction === 'applyFirst') {
            $scope.isPartial = true;
            console.log (`is Pratial ${$scope.isPartial}`);
        } else {
            $scope.isManual = true;
            console.log (`is manual ${$scope.isManual}`);
        }

        if (($scope.isApplyAll || $scope.isPartial) && !isExtraModalAction[$scope.action]) {
            console.log (`show progress modal ${$scope.showProgressModal}`);
            $scope.showProgressModal = true;
        } else if ($scope.isManual && !isExtraModalAction[$scope.action]) {
            startAction ();
        } else if(isExtraModalAction[$scope.action]){
             assignToQueueModal();
        }
    }

    function operation () {
        console.log (`start operation ${$scope.action}`);
        let promises = [];
        itemsToUpdate.every(itemId => { 
            $scope.itemProcessedCounter.recordsToBeProcessed++;
            itemIdsProcessed.push (itemId);
            promises.push (performOperation (itemId));
            if ($scope.isPartial && $scope.itemProcessedCounter.numberOfItemsToProcess === $scope.itemProcessedCounter.recordsToBeProcessed) 
                return false;
            else
                return true;
        });
        console.log (`item Ids Processed ${itemIdsProcessed} and items to be processed ${$scope.itemProcessedCounter.recordsToBeProcessed}` );
    }

    function performOperation (itemId) {
        let successHandler = (response) => {
            $scope.itemProcessedCounter.recordProcessed++;
            if (response && response.failSize) {
                console.log (`${$scope.action} is failed for ${itemId} and item processed are ${$scope.itemProcessedCounter.recordProcessed}`);
                $scope.itemProcessedCounter.processingFailed++;
            } else {
                console.log (`${$scope.action} is performed for ${itemId}  and item processed are ${$scope.itemProcessedCounter.recordProcessed}`);
                $scope.itemProcessedCounter.processedSuccessfully++;
            }
            if ($scope.itemProcessedCounter.recordsToBeProcessed == $scope.itemProcessedCounter.recordProcessed) {
                afterBulkOperation ();
            }
        };
        let errorHandler = (error) => {
            console.log (`${$scope.action} has failed for ${itemId}`);
            $scope.itemProcessedCounter.recordProcessed++;
            $scope.itemProcessedCounter.processingFailed++;
            console.log (`${$scope.action} is performed for ${itemId}  and item processed are ${$scope.itemProcessedCounter.recordProcessed}`);
            if ($scope.itemProcessedCounter.recordsToBeProcessed == $scope.itemProcessedCounter.recordProcessed) {
                afterBulkOperation ();
            }
        }
        if(!isExtraModalAction[$scope.action]) {
            return remoteActions[operations[$scope.action]]([itemId])
                    .then(successHandler,errorHandler);
        } else {
            return remoteActions[operations[$scope.action]]([itemId], $scope.selectedObject.Id)
                    .then(successHandler,errorHandler);
        }
    }

    function reconcileItems (items) {
        let i = 0;
        let reconciledOffset = 0;
        console.log (`Start reconciliation of items ${items}`)
        items.every(item => {
            if(itemIdsProcessed.indexOf (item.id || item.Id) < 0) {
                return false;
            } else {
                i++;
                return true;
            }
        })
        reconciledOffset = offSet + i;
        // if ($scope.isPartial) {
        //     batchSize = $scope.itemProcessedCounter.numberOfItemsToProcess > (offSet + batchSize) ? batchSize : ($scope.itemProcessedCounter.numberOfItemsToProcess - offSet);
        // }
        console.log (`Reconciled offset will be ${reconciledOffset} and batch size is ${batchSize}`)
        loadnextRecord (reconciledOffset, batchSize, false);
    }

    function afterBulkOperation () {
        console.log (`inside after bulk operation is all loaded ${$scope.isAllLoaded}, is apply all ${$scope.isApplyAll}, is partial ${$scope.isPartial}`)
        
        if ($scope.isAllLoaded) {
            console.log(`Process of ${$scope.action} completed`);
            $scope.underProcessCheck = false;
            prepareMessage();
        } else if ($scope.isApplyAll || ($scope.isPartial && $scope.itemProcessedCounter.numberOfItemsToProcess && $scope.itemProcessedCounter.recordProcessed < $scope.itemProcessedCounter.numberOfItemsToProcess)) {
            console.log (`reconcile items offSet ${offSet}, batchSize ${batchSize}`);
            loadnextRecord (offSet, batchSize, true);
        } else {
             $scope.underProcessCheck = false;
             prepareMessage ();
        }
        if ($scope.isManual) {
            prepareMessage ();
            resetView ();
        }
    }

    function prepareMessage() {
        let numberOfFailedItem = $scope.itemProcessedCounter.processingFailed;
        let numberOFsuccessItem = $scope.itemProcessedCounter.processedSuccessfully;
        let totalItemsToProcess = $scope.itemProcessedCounter.recordsToBeProcessed;
        if (numberOfFailedItem) {
            $scope.notification.errorMessage = `${numberOfFailedItem} out of ${totalItemsToProcess} item(s) can not be ${notificationMessages[$scope.action]}`
        } else if (numberOFsuccessItem) {
            $scope.notification.successMessage = `${numberOFsuccessItem} out of ${totalItemsToProcess} item(s) has been ${notificationMessages[$scope.action]}`
        }
    }

    function getFirstItemsToBeProcessed (){
        if (!$scope.manualTasks.length) {
            return true;
        }
        if ($scope.isApplyAll || $scope.isPartial) {
            if($scope.manualTasks.length < batchSize) {
                itemsToUpdate = $scope.manualTasks.map ((item) => item['id']);
            }
            else {
                itemsToUpdate = $scope.manualTasks.slice (0, batchSize).map ((item) => item['id']);
                offSet = 0;
                $scope.isAllLoaded = false;
            }
            $scope.manualTasks = [];
        } else {
            itemsToUpdate = $scope.manualTasks.filter ((item) => item['selected']).map((item) => item['id']);
        }


    }
    function closeProgressModal () {
        $scope.showProgressModal = false;
        resetView();
    }

    function resetView(){
        $scope.underProcessCheck = false; 
        $scope.isApplyAll = false;
        $scope.isPartial = false;
        $scope.isManual = false;
        $scope.showSpinner = true;
        $scope.totalBatch = 0;
        $scope.completedBatch = 0;
        $scope.manualTasks = [];
        $scope.manTaskLoaded = [];
        offSet = 0;
        limit = batchSize;
        $scope.isAllLoaded = false;
        $scope.isLoading = false;
        $scope.selectAllCheck = false;
        $scope.itemProcessedCounter = {'recordsToBeProcessed': 0, 'recordProcessed': 0, 'processedSuccessfully': 0, 'processingFailed': 0};
        itemIdsProcessed = [];
        loadnextRecord (null, null, false);
    }

    function startAction() {
        let isItemsNotAvailableToProcess = false;
        $scope.underProcessCheck = true;
        if ($scope.isPartial && !($scope.itemProcessedCounter.numberOfItemsToProcess > 0)) {
            $scope.notification.errorMessage = `Please specify valid number of tasks to process`;
            $scope.underProcessCheck = false;
            return;
        }
        isItemsNotAvailableToProcess = getFirstItemsToBeProcessed();
        if(isItemsNotAvailableToProcess) {
            $scope.notification.errorMessage = `There are no items to process`;
            $scope.underProcessCheck = false;
            return;
        }
        if ($scope.isManual && itemsToUpdate.length === 0) {
            $scope.notification.errorMessage = `Please select tasks to process`;
            return;
        }
        operation ();
    }

    function assignToQueueModal() {
        $scope.showAssignmentModal = true;
        $scope.assignmentModalList = [];
        $scope.search.searchTerm = '';
        $scope.assignmentModalHeader = `Select ${extraModalOperations[$scope.action]} for Task`;
        $scope.selectedObject = {};
        remoteActions[extraModalOperations[$scope.action+'Random']]().then(function(response){
            $scope.assignmentModalList = response;
            $scope.userAssignmentList = response;
        },
        function(errorResponse) {
            //$scope.notification.errorMessage ='Something went wrong : '+errorResponse.message;
            console.log('errorResponse');
            console.log(errorResponse);
        })
    }

    function onSearchQueryChange() {
        // $scope.assignmentModalList = $filter('filter')($scope.userAssignmentList, {Name : $scope.search.searchTerm}).slice(0, 5);
        remoteActions[extraModalOperations[$scope.action+'Query']]($scope.search.searchTerm).then(function(response){
            $scope.assignmentModalList = response;
            $scope.userAssignmentList = response;
        },
        function(errorResponse) {
            //$scope.notification.errorMessage ='Something went wrong : '+errorResponse.message;
            console.log('errorResponse');
            console.log(errorResponse);
        })
    }


    function hideSearchDropDown() {
        $interval(function() { // closing after 100ms to allow the onClick event to happen on the menu item
            $scope.isSearchDropDownActive = false;
            $scope.searchMode = false;
        }, 300, 1);
    }
    
    function showSearchDropDown() {
        $scope.isSearchDropDownActive = true;
    }

    function modelSelected (model) {
          $scope.search.searchTerm = model.Name;
          $scope.selectedObject = model;
    } 
    function enterSearchMode () {
        $scope.searchMode = true;
    }
    function removeObject () {
        $scope.search.searchTerm = '';
        $scope.selectedObject = {};
    }

    function assigned () {
        if($scope.selectedObject.Id){
            if ($scope.isManual) {
                startAction ();
            }
            $scope.closeAssignmentModal(false);
            if ($scope.isApplyAll || $scope.isPartial) {
                $scope.showProgressModal = true;
            }
        }
        else {
          $scope.notification.errorMessage ='Please select from dropdown';
        }
      }
      
    $scope.$watch('selectAllCheck', function(){
         $scope.selectAll();
    })

    function closeAssignmentModal (isResetView) {
        $scope.showAssignmentModal = false;
        if(isResetView) {
            resetView ();
        }
    }

    function selectAll () {
          console.log('selectall called '+$scope.selectAllCheck);
          if ($scope.selectAllCheck) {
            $scope.items = $scope.manualTasks.map((item) => { 
                      item.selected = true;
                      return item;
                    });
          } else {
            $scope.items = $scope.manualTasks.map((item) => { 
                      item.selected = false;
                      return item;        
                    });
          }
          console.log($scope.items);
    }

    function getSuggestedValues (attribute) {
          if ((attribute.type === 'REFERENCE' || attribute.type === 'ID') && !idList[attribute['field']] && !deepCheckFlag) {
            remoteActions.getSuggestedValues(attribute['field'], id).then(
              function(successResponse) {
                var itemsList = successResponse.map(flattenObject);
                idList[attribute['field']] = itemsList.map(item => item[attribute['field']]).filter(id => id);
                console.log('idList');
                console.log(idList);
              },
              function(errorResponse) {
                // $scope.notification.errorMessage ='Something went wrong : '+errorResponse.message;
                console.log('errorResponse');
                console.log(errorResponse);
              }
            )
          }
        }

    function onSearchButtonPress () {
        $scope.showSpinner = true;
        additionalFilterReferenced = {};
        additionalFilter = {};
        var keys = Object.keys($scope.filterFieldsMetadata);
        for (let i=0; i<keys.length; i++) {
          let fieldMetaData = $scope.filterFieldsMetadata[keys[i]];
          if (fieldMetaData['value'] && (fieldMetaData['type'] === 'REFERENCE' || fieldMetaData['type'] === 'ID') && !deepCheckFlag) {
            additionalFilterReferenced[keys[i]] = idList[keys[i]].filter(id => id.includes(fieldMetaData['value']));
          } else if (fieldMetaData['value']) {
            additionalFilter[fieldMetaData['field']] = fieldMetaData['value'];
          }
        }
        console.log('additionalFilterReferenced');
        console.log(additionalFilterReferenced);
        console.log('additionalFilter');
        console.log(additionalFilter);
        resetView();
    }

    function onResetButtonPress () {
        // $scope.showSpinner = true;
        Object.keys($scope.filterFieldsMetadata).forEach((key) => $scope.filterFieldsMetadata[key]['value'] = '');
        additionalFilter = null;
        additionalFilterReferenced = null;
        resetView();
    }

    function calculateStarting (calculatedStart, calculatedEnd) {
        $scope.manTaskLoaded = [];
        $scope.manTaskLoaded.length = $scope.manualTasks.length;
        let start = Math.floor(calculatedStart);
        for (i = start; i < start+40 && i < $scope.manualTasks.length; i++) {
            $scope.manTaskLoaded[i] = $scope.manualTasks [i];
        }
        $scope.ticking = true;
    }

    function clearError () {
        $scope.notification.errorMessage = '';
    }
    function clearSuccess () {
        $scope.notification.successMessage = '';
    }

    function isManualQueueValue (value, key) {
        if (manualQueueValueValueList.indexOf (value['type']) >= 0 || manualQueueValueKeyList.indexOf (key) >= 0 || value['isCalculated'] === 'true') {
            return false;
        }
        return true;
    }

    flattenObject = (obj, prefix = '') =>
        Object.keys(obj).reduce((acc, k) => {
        let pre = prefix.length ? prefix + '.' : '';
        if (typeof obj[k] === 'object') 
          Object.assign(acc, flattenObject(obj[k], pre + k));
        else 
          acc[(pre + k).replace(regEx,'').toLowerCase()] = obj[k];
        acc.selected = false;
        return acc;
      }, {})
}])
},{}],3:[function(require,module,exports){
angular.module('manualQueueApp').directive('calculatedValue', function($sce){
    return {
        template: `<span ng-bind-html = 'trustedValue'></span>`,
        scope: {
            value: '=value'
        },
        link: function (scope, element, attr, controller, transcludeFn) {
            scope.trustedValue = $sce.trustAsHtml(scope.value);
        }
    }
})
},{}],4:[function(require,module,exports){
angular.module('manualQueueApp').directive('datetimeValue', function() {
    return {
        template: `{{value}}`,
        scope: {
            value: '=value',
            attribute: '=attribute',
            offset: '=offset'
        },
        link: function (scope, element, attrs, controller, transcludeFn) {
            let timeZoneOffset = scope.offset;
        	let dates = new Date (new Date (scope.value).getTime() + new Date().getTimezoneOffset()*60000 + timeZoneOffset);
            let formattedDate = dates;
            let options = {year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric'};
            if(dates instanceof Date && !isNaN(dates)){
                scope.value = new Intl.DateTimeFormat('en-US', options).format(dates);
            }
        }
    }
})
},{}],5:[function(require,module,exports){
 angular.module('manualQueueApp').directive('infiniteScroll', function() {
    return function(scope, elm, attr) {
        var raw = elm[0];
        elm.bind('scroll', function() {
            if (raw.scrollTop + raw.offsetHeight >= raw.scrollHeight) {
                scope.$apply(attr.infiniteScroll);
            }
            if (raw.scrollTop > 0) {
                let diff = raw.scrollTop;
                scope.calculatedStart = diff/27;
                scope.calculatedEnd = 40;
                scope.ticking = false;
                if (!scope.ticking) {
                    setTimeout(scope.$apply (attr.lazyLoadToView), 200);
                }
            } else {
                scope.calculatedStart = 0;
                scope.calculatedEnd = 40;
                scope.$apply (attr.lazyLoadToView), 200
            }
        });
    };
});
},{}],6:[function(require,module,exports){
angular.module('manualQueueApp').directive('jsonValue', function() {
    return {
        template:   `{{value}}`,
        scope: {
            value: '=value',
        },
        link: function link(scope, element) {
            function highlightJson(json) {
                if (typeof json != 'string') {
                    json = JSON.stringify(json, null, 2);
                }
                if (json == null) {
                    return '';
                }

                return json.replace(/(^\s*?)("([^"\\]|\\.)*":)/gm, '$1<span class="key">$2</span>')
                    .replace(/(.*<\/span>\s)?(".*")(,)?$/gm, '$1<span class="string">$2</span>$3')
                    .replace(/\b(true|false)\b(,)?$/gm, '<span class="boolean">$1</span>$2')
                    .replace(/\b(null)\b(,)?$/gm, '<span class="null">$1</span>$2');
            };

            console.log('json element', element);
            element[0].innerHTML = '<pre class="json">' + highlightJson(newVal) + '</pre>';
        }
    }
})
},{}],7:[function(require,module,exports){
angular.module('manualQueueApp').directive('linkValue', function ($location) {
    return {
        template:   `<a ng-if="attribute.attribute.id == '4412964684871651968' || attribute.type === 'REFERENCE' || attribute.type === 'ID'" href="{{linkToRedirectInNewTab}}" target = "_blank">{{value}}</a>
                    <div ng-if="attribute.attribute.id != '4412964684871651968' && attribute.type !== 'REFERENCE' && attribute.type !== 'ID'" class="slds-truncate">
                        <p ng-repeat="line in (value | newlines | textTimeZoneFilter:offset) track by $index">{{line}}</p>
                    </div>`,
        scope: {
            item: "=item",
            attribute: "=attribute",
            key: "=key"
        },
        link: function link(scope, element, attrs, controller, transcludeFn) {
            scope.value = scope.item[scope.attribute['field']];
            if (oMPlusMetaData.isOffplatformMode) {
                scope.link = '/object/'+scope.item.id;
                scope.linkToRedirectInNewTab = window.location.protocol + '//' + window.location.hostname + "/apex/XOMObjectParams#!"+scope.link;
            }
            else {
                scope.linkToRedirectInNewTab = '/'+scope.item[scope.key];
            }
        }
    }
})
},{}],8:[function(require,module,exports){
angular.module('manualQueueApp').directive('manualQueueValue',function() {
    return {
        restrict: 'E',
        scope: {
            item: "=item",
            attribute: "=attribute",
        },
        link: function (scope, elem, attrs) {
            scope.value = scope.item[scope.attribute.field];
            if (oMPlusMetaData.isOffplatformMode) {
                scope.value =  scope.item[scope.attribute.field] ? scope.item[scope.attribute.field] : scope.item.searchableFields[scope.attribute.field];
            }
        },
        template : '{{value}}'
    }
})
},{}],9:[function(require,module,exports){
angular.module('manualQueueApp').directive('objectTypeValue', function(remoteActions) {
    return {
        template:   `<a href="{{linkToRedirectInNewTab}}" target = '_blank' ng-click = "redirectLink()">
                        {{objectTypeValue.name}}
                    </a>`,
        scope: {
            value: '=value',
        },
        link: function (scope, element) {
            if (scope.value) {
                remoteActions.getObjectTypeById (scope.value)
                .then(function success(objectType){
                    scope.objectTypeValue = objectType;
                    // element.html('<a href="#!/objectType/'+newVal+'">'+objectType.name+'</a>')
                    scope.linkToRedirectInNewTab = window.location.protocol + '//' + window.location.hostname + "/apex/XOMObjectParams#!/objectType/"+scope.objectTypeValue.id;
                });
            } else {
                scope.objectTypeValue = null;
            }

            scope.redirectLink = function()
            {
                window.open (window.location.protocol + '//' + window.location.hostname + "/apex/XOMObjectParams#!/objectType/"+scope.objectTypeValue.id);
            }
        }
    }
})
},{}],10:[function(require,module,exports){
angular.module('manualQueueApp').directive('picklistValue', function() {
    return {
        template: `{{textValue}}`,
        scope: {
            value: '=value',
            options: '=options'
        },
        link: function (scope, element, attrs, controller, transcludeFn) {
            let arr = scope.options.filter((option) => option.id == scope.value);
            scope.textValue = arr[0].value;
        }
    }
})
},{}],11:[function(require,module,exports){
angular.module('manualQueueApp').directive('progressBar', [function () {
      return {
            restrict: 'E',
            scope: {
              curVal: '@',
              maxVal: '@'
            },
            template: `<div class='slds-progress-bar'>
                            <div class='slds-progress-bar__value'></div>
                        </div>`,    

            link: function ($scope, element, attrs) {
              function updateProgress() {
                var progress = 0;
                  if ($scope.maxVal) {
                      progress = Math.min($scope.curVal, $scope.maxVal) / $scope.maxVal * element.find('.slds-progress-bar').width();
                  }
                  element.find('.slds-progress-bar__value').css('width', progress);          
              }
              $scope.$watch('curVal', updateProgress);
              $scope.$watch('maxVal', updateProgress);        
            }
      };  
  }]);
},{}],12:[function(require,module,exports){
angular.module('manualQueueApp').directive('referenceToAttributeValue', function(remoteActions) {
    return {
        template:   `{{attributeValue.name}}`,
        scope: {
            value: '=value',
        },
        link: function (scope, element) {
            if(scope.value){
                remoteActions.getAttributeById(scope.value)
                    .then(function success(attribute){
                        scope.attributeValue = attribute;
                    });
            }else{
                scope.attributeValue = null;
            }
        }
    }
})
},{}],13:[function(require,module,exports){
angular.module('manualQueueApp').directive('referenceValue', function(remoteActions, $compile) {
    return {
        scope: {
            value: '=value',
        },
        link: function (scope, element) {
            element.html('');
            if(scope.value){
                if(!Array.isArray(scope.value)){
                    newVal = [scope.value];
                }
                for(let referenceId of newVal){
                    let linkToRedirectInNewTab = window.location.protocol + '//' + window.location.hostname + "/apex/XOMObjectParams#!/object/"+referenceId;
                    let referenceLinkElement = angular.element(document.createElement('a'));
                    referenceLinkElement.html('<a href="'+linkToRedirectInNewTab+'" ng-click = "redirectLink(\''+referenceId+'\')">'+referenceId+'</a>');
                    element.append($compile(referenceLinkElement)(scope));
                    element.append('<br />');
                    remoteActions.getRecordById(referenceId)
                    .then(function success(record){
                        referenceLinkElement.html('<a href="'+linkToRedirectInNewTab+'" ng-click = "redirectLink(\''+referenceId+'\')">'+record+'</a>')
                        $compile(referenceLinkElement)(scope);
                    }, function failure(response){
                        notificationService.raiseError("Error while fetching referenced object");
                        console.log(response);
                    });
                }
            }
            scope.redirectLink = function(referenceId)
            {
                window.open(window.location.protocol + '//' + window.location.hostname + "/apex/XOMObjectParams#!/object/"+referenceId);
            }        
        }
    }
})
},{}],14:[function(require,module,exports){
angular.module('manualQueueApp').directive('textValue', function(remoteActions) {
    return {
        template:   `<div ng-if="attribute.id != '4412964684871651968'" class="slds-truncate">
                        <p ng-repeat="line in (value | newlines | textTimeZoneFilter:this:offset) track by $index">{{line}}</p>
                    </div>`,
        scope: {
            value: "=value",
            attribute: "=attribute",
            offset:"=offset"
        },
    }
})
},{}],15:[function(require,module,exports){
angular.module('manualQueueApp').filter('newlines', function() {
    return function(text) {
        if(text === undefined) return text;
        if(text == null) return text;
        return text.split(/\n/g);
    };
})
},{}],16:[function(require,module,exports){
angular.module('manualQueueApp').filter('textTimeZoneFilter', function() {
    return function (text, offset) {
        if (Array.isArray(text)) {
            for (var x = 0; x < text.length; x++) {
                text[x] = convertTextDateToDate(text[x]);
            }
        }
        return text;

        function convertTextDateToDate(text) {
            try {
                //df1 : YYYY-MM-DD HH:mm:ss.SSSSSS+Z
                //df2 : YYYY-MM-DDTHH:mm:SS.sss+Z
                var df1 = {
                    regex: "^(([0-9]{4}))[-\\/](0[1-9]|1[0-2])[-\\/](0[1-9]|1[0-9]|2[0-9]|3[0-1])\\s(([0-9]{2}))[:](([0-9]{2}))[:](([0-9]{2}))[.](([0-9]{5,6}))[+](([0-9]{2}))"
                    , format: "YYYY-MM-DD HH:mm:ss.SSSSSS"
                };
                var df2 = {
                    regex: '^(([0-9]{4}))[-\\/](0[1-9]|1[0-2])[-\\/](0[1-9]|1[0-9]|2[0-9]|3[0-1])[T](([0-9]{2}))[:](([0-9]{2}))[:](([0-9]{2}))[.](([0-9]{3}))[Z]'
                    , format: "YYYY-MM-DDTHH:mm:ss.SSS"
                };
                var patterns = [df1, df2];

                for (var x = 0; x < patterns.length; x++) {
                    var re = new RegExp(patterns[x].regex);
                    var match = text.match(re);
                    if (match != null && match !== undefined && match.length > 0) {
                        var dateText = match[0];
                        let timeZoneOffset = offset;
                        let dates = new Date (new Date (dateText).getTime() + new Date().getTimezoneOffset()*60000 + timeZoneOffset);
                        let formattedDate = dates;
                        let options = {year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric'};
                        if(dates instanceof Date && !isNaN(dates)){
                            formattedDate = new Intl.DateTimeFormat('en-US', options).format(dates);
                        }
                        text = text.replace(dateText, formattedDate);
                        break;
                    }
                }

            } catch (e) {
                console.error(e);
            }
            return text;
        }
    };

})
},{}],17:[function(require,module,exports){
angular.module('manualQueueApp').service('authorizationService', ['thorIntegrationService' ,(thorIntegrationService) => {
    return {
        retryOperation : (fn, remoteActions, reject, resolve, arguments, remoteActionName) => {
            thorIntegrationService.isOffplatformMode(remoteActions)
            .then((uiMode) => {
                oMPlusMetaData.isOffplatformMode = uiMode;
                if(uiMode){
                    return thorIntegrationService.getOffplatformUrl(remoteActions)
                    .then((uiServicesUrl) => {
                        oMPlusMetaData.uiServicesUrl = uiServicesUrl;
                        return thorIntegrationService.retryOperationInCaseAuthenticationError(fn, uiServicesUrl);
                    })
                    .then((success)=>{
                        console.log('successfully authorized');
                    },(error) => 
                    {   
                        if (error.status === 401)
                            reject ('Authentication Error');
                        else if (response.data != undefined && response.data.exception == 'com.vlocity.xom.common.security.authorisation.UnauthorizedAccessException') {
                            reject ('Autherization Error');
                        }
                        else if (error.status === 400)
                            reject ('Global key '+oMPlusMetaData.globalKey+' does not exist, please check if catalog is synchronized');
                        else 
                            reject ('Something went wrong');
                    })
                }
                else if(remoteActionCallFn[remoteActionName]) {
                        return remoteActionCallFn[remoteActionName].apply(this, arguments).then((response) => {
                            resolve (response);
                        });
                } else 
                    reject('No such remote action exist');
            },(error) => {
                reject (error);
            })
        }
    }
}])
},{}],18:[function(require,module,exports){
angular.module('manualQueueApp').service('manualQueueOffPlatformCallService', ['$http','authorizationService','$q', 'omPlusMetadataService', function($http, authorizationService, $q, omPlusMetadataService) {
    let attributeById = {};
    let recordById = {};
    let recordByObjectId = {};
    return {
        getItems : function () {
                var args = [].slice.call(arguments);
                let id = arguments[0];
                let limit = arguments[1];
                let offset = arguments[2];
                let sorting = arguments[3];
                let filter = arguments[4];
                let tasksForUser = arguments[5];
                return $q((resolve, reject) => { 
                    authorizationService.retryOperation(
                        () => {
                            let url = '/queues/'+id+"/manualTasks";
                            if (tasksForUser) {
                                url = '/users/'+id+"/manualTasks";
                            }
                            url = url + '?limit=' + encodeURIComponent(limit) + '&offset=' + encodeURIComponent(offset) + '&sort=' + encodeURIComponent(JSON.stringify(sorting)) + '&filter=' + encodeURIComponent(JSON.stringify(filter));
                            return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.omApiPrefix + url, withCredentials: true})
                            .then((response) => {
                                resolve(response);
                                return response;
                            },(error) => {
                                reject(error);
                            })
                            .catch((error) => {
                                throw error;
                                reject(error);
                            });
                        }
                        , this, reject, resolve, args, 'getItems')
                })
            },
        getMetaData : function () {
                var args = [].slice.call(arguments);
                var manualQueueMetadata = {};
                let activeTab = {};

                return $q((resolve, reject) => {
                    authorizationService.retryOperation(
                        () => {
                            return $http.get(oMPlusMetaData.uiServicesUrl + '/security/v1/auth/openid/session/validate/ui', {withCredentials: true})
                            .then(function success (response) { 
                                return $http({method : 'GET', url : oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+'/objects/findByGlobalKey/'+oMPlusMetaData.globalKey, withCredentials: true});
                            })
                            .then(function (response) {
                                console.log(response);
                                let object = response.data;
                                manualQueueMetadata.object = object;
                                return $http({method: 'GET', url : oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.metaDataApiPrefix+'/objecttypes/'+ object.objectTypeId, withCredentials: true});
                            })
                            .then(response => {
                                console.log(response);
                                objectType = response.data;
                                manualQueueMetadata.objectType = objectType;
                                let tabs = [];
                                for(let tabId of objectType.ui.tabs){
                                    tabs.push($http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+'/objects/'+tabId, withCredentials: true}));
                                }
                                return $q.all(tabs);
                            })
                            .then(response => {
                                console.log(response);
                                let tabs = response;
                                for(let tab of tabs){
                                    if(tab.data.id == '4412964684871513729'){
                                        activeTab = tab.data;
                                    }
                                }
                                if(activeTab == undefined){
                                    throw {data: {message: "Tab with ID 4412964684871513729 is not found on this record"}};
                                }
                                manualQueueMetadata.activeTab = activeTab;
                                let url = '/objects/4412964684871513729/children';
                                return $http({ method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+url, withCredentials: true});
                            })
                            .then(activeTabFacets => {
                                console.log(activeTabFacets);
                                manualQueueMetadata.facet = activeTabFacets.data[0];
                                activeTab.facets = activeTabFacets.data;
                                omPlusMetadataService.loadMetaData(manualQueueMetadata, resolve, reject)
                            })
                            .catch(function failure (response) {
                                throw response;
                                reject (error);
                            });
                        }, this, reject, resolve, arguments, 'getMetaData'
                    );
                })
            },
        retryItems: function() {
            var args = [].slice.call(arguments);
            let taskId = arguments[0][0];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'POST', url: oMPlusMetaData.uiServicesUrl+'/ordermanagement/v1/tasks/' + taskId + '/switchToReady', withCredentials: true})
                                    .then((response) => {
                                        resolve(response);
                                        return response;
                                    },(error) => {
                                        reject(error);
                                    })
                                    .catch((error) => {
                                        throw error;
                                        reject(error);
                                    });
                        }
                        , this, reject, resolve, args, 'retryItems')
                    }
                );
        },
        completeItems: function() {
            var args = [].slice.call(arguments);
            let taskId = arguments[0][0];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'POST', url: oMPlusMetaData.uiServicesUrl+'/ordermanagement/v1/tasks/' + taskId + '/complete', withCredentials: true})
                                    .then((response) => {
                                        resolve(response);
                                        return response;
                                    },(error) => {
                                        reject(error);
                                    })
                                    .catch((error) => {
                                        throw error;
                                        reject(error);
                                    });
                        }
                        , this, reject, resolve, args, 'completeItems')
                    });
        },
        assignToMe: function() {
            var args = [].slice.call(arguments);
            let taskId = arguments[0][0];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'POST', url: oMPlusMetaData.uiServicesUrl+'/ordermanagement/v1/tasks/' + taskId + '/assigntome', withCredentials: true})
                                    .then((response) => {
                                        resolve(response);
                                        return response;
                                    },(error) => {
                                        reject(error);
                                    })
                                    .catch((error) => {
                                        throw error;
                                        reject(error);
                                    });
                        }
                        , this, reject, resolve, args, 'assignToMe')
                    });
        },
        clearUserAssignment: function() {
            var args = [].slice.call(arguments);
            let taskId = arguments[0][0];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'POST', url: oMPlusMetaData.uiServicesUrl+'/ordermanagement/v1/tasks/' + taskId + '/clearUserAssignment', withCredentials: true})
                                    .then((response) => {
                                        resolve(response);
                                        return response;
                                    },(error) => {
                                        reject(error);
                                    })
                                    .catch((error) => {
                                        throw error;
                                        reject(error);
                                    });
                        }
                        , this, reject, resolve, args, 'clearUserAssignment')
                    });
        },
        assignToQueue: function() {
            var args = [].slice.call(arguments);
            let recordId = arguments[0][0];
            let selectedId = arguments[1];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+'/objects/'+recordId, withCredentials: true})
                                .then((response) => {
                                    let record = response.data;
                                    let selectedId = arguments[1];
                                    record.assignedToManualQueueId = selectedId;
                                    return $http({method: 'PUT', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+ '/objects/' + recordId , data: record, withCredentials: true})
                                },(error) => {
                                        reject(error);
                                })
                                .then((response) => {
                                    resolve(response);
                                    return response;
                                },(error) => {
                                        reject(error);
                                })
                                .catch((error) => {
                                    throw error;
                                    reject(error);
                                });
                    }
                , this, reject, resolve, args, 'assignToQueue')
            });
        },
        getActiveQueueMethod: function () {
            var args = [].slice.call(arguments);
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+ '/objects/showRandom' , params : { objectTypeId : '4412964684871505537' }, withCredentials: true})
                            .then((response) => {
                                let records = [];
                                if (response && response.data) {
                                    records.push(...response.data.map ((record) => {
                                        return {'Id': record.id, 'Name': record.name}
                                    }))
                                }
                                resolve(records);
                                return records;
                            },(error) => {
                                        reject(error);
                            })
                            .catch((error) => {
                                throw error;
                                reject(error);
                            });
                    }
                , this, reject, resolve, args, 'getActiveQueueMethod')
            });
        },
        getActiveQueueWithQuery: function () {
            var args = [].slice.call(arguments);
            let searchString = arguments[0];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+ '/objects/search/'+encodeURIComponent(searchString) , params : { objectTypeId : '4412964684871505537' }, withCredentials: true})
                            .then((response) => {
                                let records = [];
                                if (response && response.data) {
                                    records.push(...response.data.map ((record) => {
                                        return {'Id': record.id, 'Name': record.name}
                                    }))
                                }
                                resolve(records);
                                return records;
                            },(error) => {
                                reject(error);
                            })
                            .catch((error) => {
                                throw error;
                                reject(error);
                            });
                    }
                , this, reject, resolve, args, 'getActiveQueueWithQuery')
            });
        },
        getActiveUserMethod: function () {
            var args = [].slice.call(arguments);
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+ '/objects/showRandom' , params : { objectTypeId : '976718169186085890' }, withCredentials: true})
                            .then((response) => {
                                let records = [];
                                if (response && response.data) {
                                    records.push(...response.data.map ((record) => {
                                        return {'Id': record.id, 'Name': record.name}
                                    }))
                                }
                                resolve(records);
                                return records;
                            },(error) => {
                                reject(error);
                            })
                            .catch((error) => {
                                throw error;
                                reject(error);
                            });
                    }
                , this, reject, resolve, args, 'getActiveUserMethod')
            });
        },
        getActiveUsersWithQuery: function () {
            var args = [].slice.call(arguments);
            let searchString = arguments[0];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+ '/objects/search/'+encodeURIComponent(searchString) , params : { objectTypeId : '976718169186085890' }, withCredentials: true})
                            .then((response) => {
                                let records = [];
                                if (response && response.data) {
                                    records.push(...response.data.map ((record) => {
                                        return {'Id': record.id, 'Name': record.name}
                                    }))
                                }
                                resolve(records);
                                return records;
                            },(error) => {
                                reject(error);
                            })
                            .catch((error) => {
                                throw error;
                                reject(error);
                            });
                    }
                , this, reject, resolve, args, 'getActiveUsersWithQuery')
            });
        },
        assignToUser: function() {
            var args = [].slice.call(arguments);
            let recordId = arguments[0][0];
            let selectedId = arguments[1];
            return $q((resolve, reject) => {
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+'/objects/'+recordId, withCredentials: true})
                                .then((response) => {
                                    let record = response.data;
                                    let selectedId = arguments[1];
                                    record.assignedToUserId = selectedId; // Assigned To
                                    record.state = '4412964684870484606';
                                    return $http({method: 'PUT', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+ '/objects/' + recordId , data: record, withCredentials: true})
                                },(error) => {
                                    reject(error);
                                })
                                .then((response) => {
                                    resolve(response);
                                    return response;
                                },(error) => {
                                    reject(error);
                                })
                                .catch((error) => {
                                    throw error;
                                    reject(error);
                                });
                    }
                , this, reject, resolve, args, 'assignToUser')
            });
        },
        getRecordById: function() {
            var args = [].slice.call(arguments);
            let recordId = arguments[0];
            return $q((resolve, reject) => {
                if(recordById[recordId]) {
                    resolve (recordById[recordId]);
                }
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.activeRecordApiPrefix+'/objects/'+recordId, withCredentials: true})
                                .then((response) => {
                                    let record = response.data;
                                    recordById[recordId] = record.name;
                                    resolve(record.name);
                                },(error) => {
                                    reject(error);
                                })
                                .catch((error) => {
                                    throw error;
                                });
                    }
                , this, reject, resolve, args, 'getRecordById')
            });
        },
        getObjectTypeById: function() {
            var args = [].slice.call(arguments);
            let record = arguments[0];
            return $q((resolve, reject) => {
                if (recordByObjectId[record.objectTypeId]) {
                    resolve (recordByObjectId[record.objectTypeId]);
                }
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url : oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.metaDataApiPrefix+'/objecttypes/'+ record.objectTypeId, withCredentials: true})
                        .then((response) => {
                                    let record = response.data;
                                    recordByObjectId[record.objectTypeId] = record;
                                    resolve(record);
                                },(error) => {
                                    reject(error);
                                })
                                .catch((error) => {
                                    throw error;
                                });
                    }
                , this, reject, resolve, args, 'getObjectTypeById')
            });
        },
        getAttributeById: function() {
            var args = [].slice.call(arguments);
            let recordId = arguments[0];
            return $q((resolve, reject) => {
                if(attributeById[recordId]) {
                    resolve (attributeById[recordId]);
                }
                authorizationService.retryOperation(
                    () => { 
                        return $http({method: 'GET', url : oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.metaDataApiPrefix+'/attributes/'+ recordId, withCredentials: true})
                        .then((response) => {
                                    let record = response.data;
                                    attributeById[recordId] = record;
                                    resolve(record);
                                },(error) => {
                                    reject(error);
                                })
                                .catch((error) => {
                                    throw error;
                                });
                    }
                , this, reject, resolve, args, 'getAttributeById')
            });
        },
    }
}])
},{}],19:[function(require,module,exports){
angular.module('manualQueueApp').service('omPlusMetadataService', [ 'thorIntegrationService', 'authorizationService', '$http', '$q' , function( thorIntegrationService, authorizationService, $http, $q) {

    this.loadMetaData = function (metadata, resolve, reject){
        let displayedAttributes = metadata.facet.properties['4412964684871197307'];
        let attributeIds = ["4412964684871651968", "4412964684871661184", "4412964684871661185"];
        let filterEnabledAttribute = metadata.facet.properties['976718169186104467'];
        let filterAttributes = metadata.object.properties['4412964684872072916'];
        let dispFilterAttributes = metadata.object.properties['6392296721099047951'];
        metadata.displayedAttributes = [];
        metadata.displayedFilterAttributes = [];
        metadata.filterEnabledAttribute = filterEnabledAttribute;
        metadata.filterAttributes = [];
        metadata.fieldsToDisplay = [];
        metadata.displayMap = {};
        metadata.filterFieldsMetaData = {};
        if(displayedAttributes){
            if(Array.isArray(displayedAttributes)){
                attributeIds = displayedAttributes;
            }else{
                attributeIds = displayedAttributes.split(',');
            }
        }
        function compileMetadata(metaData) {
            metaData.manualQueueName = metaData.object ? metaData.object.name : '';
            metaData.fieldsToDisplay.push(...metaData['displayedFilterAttributes'].map(attribute => {
                metaData.displayMap[attribute.key] = {
                        label: attribute.label,
                        type: attribute.dataType,
                        isCalculated: 'false',
                        field: attribute.key,
                        attrtibute: attribute
                }
                return attribute.key
            }))
            metaData.fieldsToDisplay.unshift(...metaData['displayedAttributes'].map(attribute => {
                    metaData.displayMap[attribute.id] = {
                        label: attribute.name,
                        type: attribute.dataType,
                        isCalculated: 'false',
                        field: attribute.columnName,
                        attribute: attribute
                    }
                    return attribute.id
                }));
            metaData['filterAttributes'].forEach(attribute => {
                metaData.filterFieldsMetaData[attribute.key] = {
                    label: attribute.label,
                    type: '',
                    isCalculated: 'false',
                    field: attribute.key
                }
            });
            console.log(metaData);
            resolve(metaData);
        }
        metadata.loadAttributesToProperty = function(attrIds, attributesProperty) {
            let columnIndex = 0;
            let promises = [];
            for(let attributeId of attrIds){
                let columnIndexCopy = JSON.parse(JSON.stringify(columnIndex));
                attributesProperty[columnIndexCopy] = {
                    id: Math.random().toString(36).slice(2)
                };
                columnIndex++;
                promises.push($http({method: 'get', url: oMPlusMetaData.uiServicesUrl+oMPlusMetaData.apiPrefixes.metaDataApiPrefix+ '/attributes/' +attributeId, withCredentials: true})
                    .then(function success(attribute){
                        attributesProperty[columnIndexCopy] = attribute.data;
                        return attribute.data;
                    }));
            }
            $q.all(promises).then(function(response) {
                compileMetadata(metadata);
            }).catch((error) => {
                reject(error);
            });
        }
        metadata.loadAttributesToProperty(attributeIds, metadata.displayedAttributes);
        metadata.loadFilterAttributes = function(attrs, filterProps) {
            let columnIndex = 0;
            for(let attrString of attrs){
                let attrArray = attrString.split(" as ");
                let attribute = new Object();
                attribute.key = attrArray[0].trim();
                attribute.label = JSON.parse(attrArray[1].trim());
                filterProps[columnIndex] = attribute;
                columnIndex++;
            }
            console.log(filterProps);
        }

        if(filterEnabledAttribute) {
            if(filterAttributes) {
                if(Array.isArray(filterAttributes)){
                    attributeIds = filterAttributes;
                }else{
                    attributeIds = filterAttributes.split(',');
                }
                metadata.loadFilterAttributes(attributeIds, metadata.filterAttributes);
            }
            if(dispFilterAttributes) {
                if(Array.isArray(dispFilterAttributes)){
                    attributeIds = dispFilterAttributes;
                }else{
                    attributeIds = dispFilterAttributes.split(',');
                }
                metadata.loadFilterAttributes(attributeIds, metadata.displayedFilterAttributes);
            }
        }
    };
}])
},{}]},{},[1]);
})();
