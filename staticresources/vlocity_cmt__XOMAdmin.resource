(function(){
  var fileNsPrefix = (function() {
    'use strict';    
    var lastScript;
    try {
      // Locker vNext uses `document.currentScript` instead of `document.getElementsByTagName`
      // We first check for vNext as the legacy code breaks and won't load with locker next.
      // If `currentScript` is undefined or not set, it means we are in legacy locker.
      lastScript = document.currentScript;
    } catch (err){
      console.info('Locker vNext is not enabled');
    }

    if(!lastScript) {
      var scripts = document.getElementsByTagName('script');
      lastScript = scripts[scripts.length - 1];
    }


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
var module = angular.module('xomadmin', ['vlocity', 'sldsangular', 'ngSanitize', 'ngAnimate', 'ngRoute', 'thorIntegration'])
    .config(['remoteActionsProvider','$compileProvider', '$routeProvider', function(remoteActionsProvider, $compileProvider, $routeProvider) {
        remoteActionsProvider.setRemoteActions(window.remoteActions || {});
        $compileProvider.debugInfoEnabled(true); // Remove debug info (angularJS >= 1.3)

        console.log('Configuring routes');

        $routeProvider
                .when('/', {
                    templateUrl: 'XOMAdmin.tpl.html',
                    controller: 'XOMAdminController'
                })
                .when('/configureLayouts', {
                    templateUrl: 'XOMConfigureLayouts.tpl.html',
                    controller: 'XOMConfigureLayoutsController'
                })
                .otherwise({
                    redirectTo: '/'
                });

    }])
    .run(['$route', function() {}]);
    
require('./modules/xomadmin/controller/XOMAdminController.js');
require('./modules/xomadmin/controller/XOMConfigureLayoutsController.js');
require('./modules/xomadmin/templates/templates.js');
},{"./modules/xomadmin/controller/XOMAdminController.js":2,"./modules/xomadmin/controller/XOMConfigureLayoutsController.js":3,"./modules/xomadmin/templates/templates.js":4}],2:[function(require,module,exports){
angular.module('xomadmin').controller('XOMAdminController',
    [
        '$scope', '$window', '$location', '$timeout', 'remoteActions', 'config', '$http',
        'thorIntegrationService', 'labelsSyncService', '$q',
        function($scope, $window, $location, $timeout, remoteActions, config, $http,
                 thorIntegrationService, labelsSyncService, $q)
        {

            var BATCH_SIZE = 300;
            var MAX_OBJECT_COUNT_THRESHOLD = 50000;
            var COMPLETED_JOBS_COUNT_THRESHOLD = 3;
            $scope.isSyncDeltaStarted = false;
            $scope.isSyncInprogress = false;
            $scope.isSyncPreparing = false;
            $scope.isThorEnabled = config.isThorEnabled == 'true';
            $scope.isDeltaTrackingEnabled = config.isDeltaTrackingEnabled == 'true';
            $scope.isDevEnabled = /devMode=true/.exec(window.location.search);
            $scope.isRetryJobScheduled = false;
            $scope.showSpinner = false;
            $scope.showMsg = false;
            var completeJobsCount = 0;

            $scope.isDPInfoHidden = true;
            $scope.dataPurgeConfigData = {};
            $scope.dataPurgeStatus = {};

            console.log('Config:', config);
            console.log('Scope: ', $scope);

            var activateProgressBarItem = function (currIndex)
            {
                $scope.progressBar.currentIndex = currIndex;
                if($scope.progressBar.currentIndex >= 0 && $scope.progressBar.currentIndex < $scope.progressBar.milestones.length)
                {
                    console.log('activating step: ', currIndex);
                    $scope.progressBar.milestones[currIndex].status = "Active";
                    $scope.progressBar.stageDescription = $scope.progressBar.milestones[currIndex].description;
                    console.log('activated step: ', $scope.progressBar.milestones[currIndex]);
                } else {
                    console.log('skip activating item - index is out of range', currIndex)
                }
            }

            var completeProgressBarItem = function (currIndex)
            {
                if(currIndex >= 0 && currIndex < $scope.progressBar.milestones.length)
                {
                    console.log('completing step: ', currIndex);
                    console.log('completed step: ', $scope.progressBar.milestones[currIndex]);
                    $scope.progressBar.milestones[currIndex].status = "Completed";
                } else {
                    console.log('skip completing item - index is out of range', currIndex)
                }
            };

            var updateProgressBar = function (currentValue)
            {
                //update barValue
                console.log('set current value: ', $scope.progressBar.currentValue);
                $scope.progressBar.currentValue = currentValue;
                // $scope.progressBar.barValue = 100 * $scope.progressBar.currentValue / $scope.progressBar.totalCount;
                console.log('progressBar.milestones.length: ' +  $scope.progressBar.milestones.length);
                $scope.progressBar.barValue = 100 * ($scope.progressBar.currentIndex + 1) / $scope.progressBar.milestones.length;
                console.log('percent complete: ', $scope.progressBar.barValue);
                // update item status
                //$scope.progressBar.currIdx = Math.floor($scope.progressBar.milestones.length * currentValue / $scope.progressBar.totalCount) + 2;
                console.log('milestone reached: ', $scope.progressBar.currentIndex);
                completeProgressBarItem($scope.progressBar.currentIndex);
                activateProgressBarItem($scope.progressBar.currentIndex+1)
                //console.log('progress update: ', $scope.progressBar);
            };

            var allJobs = new Map();

            var updateProcessingText = function (currentJob)
            {
                allJobs.set(currentJob.Id, currentJob);
                
                var estimate = 0;
                for (var k in allJobs.keys()) {
                    if(k == currentJob.Id) {
                        estimate += currentJob.JobItemsProcessed;
                    } else {
                        if(allJobs.get(k).TotalJobItems > 1) {                            
                            estimate += allJobs.get(k).TotalJobItems;
                        } else {
                            estimate += allJobs.get(k).TotalJobItems - 1;
                        }
                    }
                }
                console.log('estimate: ', estimate);
                estimate *= (BATCH_SIZE * 0.75); // 0.75 will decrease estimate on purpose
                if(estimate > $scope.progressBar.totalCount) {
                    estimate = $scope.progressBar.totalCount;
                    updateProgressBar(3);
                } else if(estimate < 0) {
                    estimate = 0;
                }
                
                if(currentJob.Status == "Processing") {
                    $scope.progressBar.stageDescription = "Current job items processed " + currentJob.JobItemsProcessed + " of " + currentJob.TotalJobItems;
                } else {
                    $scope.progressBar.stageDescription = "Job is in " + currentJob.Status + " Status";
                }
                $scope.progressBar.currentValue = 'About ' + estimate; 

            };

            $scope.forcePopulateSyncDelta = function()
            {
                console.log('Force populate Sync Delta.');
                allJobs = new Map();

                var sliceBatch = function(scope, start)
                {
                    console.log('Preparing batch starting with', start);
                    console.log('Catalog objects types to sync:', scope.length);
                    var pos = 0;
                    var request = [];

                    for (var i = 0; i < scope.length; i++)
                    {
                        var item = scope[i];
                        //console.log('Pos', pos, 'item', item);
                        var itemReq = '';

                        for (var j = 0; j<item.ids.length; j++)
                        {
                            //console.log('Pos', pos, 'objId', item.ids[j]);
                            if (pos>=start)
                            {
                                // console.log('Starting');
                                if (!itemReq)
                                {
                                    // console.log('New sObjType');
                                    itemReq = {
                                        sObjTypeName: item.sObjTypeName,
                                        ids: []
                                    };

                                    $scope.progressBar.milestones[$scope.progressBar.currentIndex].description
                                        = "Processing " + item.sObjTypeName + " " + start + '..' + (start+BATCH_SIZE);
                                    $scope.progressBar.stageDescription = $scope.progressBar.milestones[$scope.progressBar.currentIndex].description;

                                    request.push(itemReq);
                                }

                                if (pos >= start + BATCH_SIZE)
                                {
                                    return request;
                                }

                                itemReq.ids.push(item.ids[j]);
                            }

                            pos++;
                        }
                    }

                    return request;
                }

                var populateSyncDelta = function(scope, start)
                {
                    if($scope.isRestartSyncProcess)
                    {
                        console.log('terminated current populateSyncDelta and restarted forceSyncProcess');

                        $scope.forcePopulateSyncDelta();
                    }
                    else
                    {
                        updateProgressBar(start);
                        var request = sliceBatch(scope, start);

                        console.log('Creating deltas for ', request);

                        if (request.length > 0)
                        {
                            remoteActions.populateSyncDelta(JSON.stringify(request)).then(function()
                            {
                                // updateProgressBar(start+BATCH_SIZE);
                                populateSyncDelta(scope, start+BATCH_SIZE);
                            }).catch(function(err)
                            {
                                console.error(err);
                                handleError("Error" + err.message);
                            });
                        }
                        else
                        {
                            // Finished
                            $scope.isSyncInprogress = false;
                            updateProgressBar($scope.progressBar.totalCount);
                            showSuccessMsg("Sync Delta Objects were generated successfully");
                        }
                    }
                };

                function checkJobStatus() {
                    if($scope.isRestartSyncProcess)
                    {
                        console.log('terminating current populateSyncDelta process...');
                        //update current sObject for job to terminate and restart
                        remoteActions.restartSyncDeltaJob()
                            .then(function(response)
                            {
                                console.log('aborted sync job', response);
                                $scope.isRestartSyncProcess = false;
                                // check sync delta job status again
                                $scope.isJobAbortedForRestart = true;
                                $scope.progressBar.stageDescription = 'Generate Sync Delta has been restarted';
                                console.log('start sync process again in 5 seconds.....', response);
                                //start sync process again
                                setTimeout(checkJobStatus, 5000);

                            });
                    } else {
                        console.log('checking job status...');
                        remoteActions.getJobStatus('')
                            .then(function(response)
                            {
                                $scope.jobStatus = response;
                                console.log('current job status:', response);

                                // informative text
                                if ($scope.jobStatus.Status == 'Completed' && completeJobsCount < COMPLETED_JOBS_COUNT_THRESHOLD)
                                {
                                    console.log('job has completed, will check if there are no subsequent job in 3 secs...');
                                    completeJobsCount++;
                                    $scope.progressBar.stageDescription ='Sync Delta Job is Completed, checking next jobs...';
                                    updateProcessingText($scope.jobStatus);
                                    setTimeout(checkJobStatus, 3000);
                                } else if ($scope.jobStatus.Status == 'Completed' && completeJobsCount >= COMPLETED_JOBS_COUNT_THRESHOLD)
                                {
                                    console.log('process has finished, updating bar value to total: ', $scope.progressBar.totalCount);
                                    updateProgressBar($scope.progressBar.totalCount);
                                    $scope.isSyncInprogress = false;
                                    $scope.isSyncPreparing = false;
                                    $scope.progressBar.stageDescription ='Sync Delta Objects were generated successfully';
                                    showSuccessMsg("Sync Delta Objects were generated successfully");
                                } else if ($scope.jobStatus.Status == 'Failed' || ($scope.jobStatus.Status == 'Aborted' && !$scope.isJobAbortedForRestart))
                                {
                                    handleError("Gen Sync Delta Job is " + $scope.jobStatus.Status
                                        + ". Error details: " + $scope.jobStatus.ExtendedStatus);
                                }
                                else if ($scope.jobStatus.Status == 'Aborted' && $scope.isJobAbortedForRestart)
                                {
                                    $scope.isJobAbortedForRestart = false;
                                    console.log('scheduling new job again');
                                    $scope.progressBar.currentIndex = 0;
                                    $scope.progressBar.currentValue = 0;
                                    allJobs = new Map();
                                    completeJobsCount = 0;
                                    // schedule new job again
                                    remoteActions.scheduleSyncDeltaJobForType('DRBundle__c', BATCH_SIZE)
                                        .then(function(response)
                                        {
                                            $scope.isSyncPreparing = false;
                                            $scope.isSyncInprogress = true;
                                            console.log('schedule response', response);

                                            if (response.status == 'Failed')
                                            {
                                                handleError('Generate Sync Delta job scheduling has failed (): ' + response.message);
                                            } else {
                                                updateProgressBar(0);

                                                // if good - iterate and check job status periodically (every 5 sec) until complete
                                                checkJobStatus();
                                            }
                                        }).catch(function(err)
                                        {
                                            console.error(err);
                                            handleError("Error" + err.message);
                                        });

                                } else
                                {
                                    console.log('job is running...');
                                    updateProcessingText($scope.jobStatus);
                                    setTimeout(checkJobStatus, 5000);
                                }
                            })
                            .catch(function(err)
                            {
                                console.error(err);
                                handleError("Error: " + err.message);
                            });
                    }
                }

                var cleanup = function (cont) {
                    console.log('Cleaning up');

                    remoteActions.cleanupSyncDelta().then(function (result) {
                        if (result) {
                            console.log('cleaning sync delta objects is completed');
                            completeProgressBarItem(1);
                            cont();
                        }
                        else {
                            // Not finished yet, retrying
                            cleanup(cont);
                        }

                    }).catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error" + err.message);
                    });
                }

                $scope.isSyncDeltaStarted = true;
                $scope.isSyncInprogress = false;
                $scope.isSyncPreparing = true;
                $scope.isRestartSyncProcess = false;

                var createProgressBar = function (syncItemCounts) {
                    console.log('generating ProgressBar');
                    // calculate grand total
                    var totalCounts = 0;
                    for (var i = 0; i < syncItemCounts.length; i++) {
                        var item = syncItemCounts[i];
                        totalCounts  += item.count;
                        console.log('object: ' + item.sObjTypeName + ', count: ' + item.count);
                    }
                    console.log('totals: ', totalCounts);

                    //Prefill progressBar milestones based on totalCounts and batchSize
                    var syncItems = [];
                    if(totalCounts >= MAX_OBJECT_COUNT_THRESHOLD)
                    {
                        //if async then add 1 step to track by job status
                        syncItems.push({index: 3, status:"Inactive", description: "Generate sync delta"})
                    } else
                    {
                        // if sync progress the add steps based on total counts
                        var milestoneNum = Math.ceil(totalCounts / BATCH_SIZE);
                        for(var i = 0; i <= milestoneNum; i++)
                        {
                            syncItems.push({index: i + 3, status:"Inactive", description: "Generate sync delta"})
                        }
                        console.log('milestones size: ', syncItems.length);
                    }

                    // create progress bar
                    $scope.progressBar.totalCount = totalCounts;
                    $scope.progressBar.milestones = $scope.progressBar.milestones.concat(syncItems);
                    console.log('progress bar: ', $scope.progressBar);
                };


                // get catalog object counts counts
                $scope.startSyncProcess = function ()
                {
                    console.log('Started generate sync delta process');
                    $scope.progressBar =
                        {
                            barValue: 0,
                            totalCount: 0,
                            currentValue: 0,
                            currentIndex:0,
                            stageDescription: "Process is not started",
                            milestones:
                                [
                                    {index:1, status: "Incomplete", description: "Counting catalog objects..."},
                                    // {index:2, status: "Incomplete", description: "Cleaning existing sync delta objects..."},
                                    {index:2, status: "Incomplete", description: "Fetching scope of catalog objects to sync..."}
                                ]
                        };

                    activateProgressBarItem(0);
                    remoteActions.getCountsForSyncDelta()
                        .then(function(syncItemCounts)
                        {
                            $scope.showSpinner = false;
                            console.log('catalog object counts: ', syncItemCounts);
                            createProgressBar(syncItemCounts);
                            updateProgressBar(0);
                            // if total count > 5000 then start asynchronous prcess
                            if($scope.progressBar.totalCount >= MAX_OBJECT_COUNT_THRESHOLD)
                            {
                                console.log('sfdc limit for objects exceeded: will trigger asynchronous job');
                                //activateProgressBarItem(2);
                                $scope.progressBar.stageDescription ='Generate sync delta objects using batch job';
                                $scope.progressBar.currentValue = 0;
                                remoteActions.scheduleSyncDeltaJobForType('DRBundle__c', BATCH_SIZE)
                                    .then(function(response)
                                    {
                                        $scope.isSyncPreparing = false;
                                        $scope.isSyncInprogress = true;
                                        console.log('schedule response', response);

                                        if (response.status == 'Failed')
                                        {
                                            handleError('Generate Sync Delta job scheduling has failed: ' + response.message);
                                        } else {
                                            updateProgressBar(0);

                                            // if good - iterate and check job status periodically (every 5 sec) until complete
                                            checkJobStatus();
                                        }
                                    }).catch(function(err)
                                {
                                    console.error(err);
                                    handleError("Error" + err.message);
                                });

                            } else
                            {
                                //removed sync delta cleanup step because it deletes existing delta history and OM+ become out of sync
                                // cleanup(function()
                                // {
                                console.log("progress bar: ", $scope.progressBar);
                                //iterate through sObjects and populate sync deltas in batches - ignore large batches
                                // Don't forget to populate sync deltas
                                console.log('Starting to populate sync deltas');
                                //activateProgressBarItem(2);
                                remoteActions.calcScopeForSyncDelta()
                                    .then(function(scope)
                                    {
                                        $scope.isSyncPreparing = false;
                                        $scope.isSyncInprogress = true;
                                        populateSyncDelta(scope, 0);
                                    }).catch(function(err)
                                {
                                    console.error(err);
                                    handleError("Error" + err.message);
                                });
                                // });
                            }
                        }).catch(function(err)
                        {
                            console.error(err);
                            handleError("Error" + err.message);
                        });
                };

                $scope.startSyncProcess();

            };

            $scope.restartPopulateSyncDelta = function()
            {
                console.log('terminate sync process and restart from the beginning');
                $scope.isRestartSyncProcess = true;
                $scope.isSyncInprogress = false;
                $scope.isSyncPreparing = true;
            }

            $scope.cleanupSyncDelta = function()
            {

                console.log('Cleanup Sync Delta');

                $scope.showSpinner = true;
                $scope.showMsg = false;

                remoteActions.cleanupSyncDelta().then(function(result)
                {
                    if (result)
                    {
                        $scope.showSpinner = false;
                        showSuccessMsg("Sync Delta Objects were deleted successfully");
                    }
                    else
                    {
                        // Not finished yet, retrying
                        $scope.cleanupSyncDelta();
                    }

                }).catch(function(err)
                {
                    console.error(err);
                    $scope.showSpinner = false;
                    handleError("Error" + err.message);
                });

            }

            $scope.ensureGlobalKeys = function()
            {

                console.log('Ensure Global Keys');

                $scope.showSpinner = true;
                $scope.showMsg = false;

                function _ensureGlobalKeys(idx) {

                    remoteActions.ensureGlobalKeysBatch(idx).then(function (idx) {
                        if (idx < 0 ) {
                            $scope.showSpinner = false;
                            showSuccessMsg("All Catalog objects are ensured to have Global Key set");
                        }
                        else {
                            // Have not finished yet
                            _ensureGlobalKeys(idx);
                        }
                    }).catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error" + err.message);
                    });

                }

                _ensureGlobalKeys(0);


            }


            $scope.createDataRaptorBundlesForBackSync = function()
            {
                $scope.showSpinner = true;
                $scope.showMsg = false;

                remoteActions.createDataRaptorBundlesForBackSync().then(function()
                {
                    $scope.showSpinner = false;
                    showSuccessMsg("Vlocity DataRaptor Bundler for Thor sync was created successfully");
                }).catch(function(err)
                {
                    console.error(err);
                    $scope.showSpinner = false;
                    handleError("Error" + err.message);
                });
            }

            $scope.syncCatalog = function()
            {
                $window.location.href = config.syncCatalogPage;
            }

            $scope.checkEnvStatus = function()
            {
                $window.location.href = config.checkEnvStatusPage;
            };

            $scope.configureLayouts = function()
            {
                $location.path('/configureLayouts');
            }

            $scope.downloadSyncDeltas = function()
            {
                $scope.showSpinner = true;
                $scope.showMsg = false;
                console.log('Download deltas');

                remoteActions.getBatch(200).then(function(json)
                {
                    $scope.showSpinner = false;
                    console.log('JSON: ', json);
                    var blob = new Blob([JSON.stringify(json)], {type: "application/json;charset=utf-8"});
                    var fileName = new Date().toLocaleString();
                    saveAs(blob, fileName + ".json");
                    console.log('Saving ' + fileName);
                }).catch(function(err)
                {
                    console.error(err);
                    $scope.showSpinner = false;
                    handleError("Error" + err.message);
                });
            }

            $scope.syncLabels = function()
            {
                var labelsUrl = config.labelsUrl;
                var uiServicesURL = config.uiServicesUrl;

                $scope.showSpinner = true;
                $scope.showMsg = false;

                function sync(labelsResponse) {

                    console.log(labelsResponse);

                    var labels = labelsResponse.data;

                    console.log(labels);

                    var xmlDoc = document.implementation.createDocument("http://soap.sforce.com/2006/04/metadata", "CustomLabels");

                    function addNode(parentNode, nodeName, value) {
                        var node = xmlDoc.createElement(nodeName);
                        node.appendChild(xmlDoc.createTextNode(value));
                        parentNode.appendChild(node);
                    }

                    for (var i = 0; i < labels.length; i++) {
                        var label = labels[i];
                        var name = label.name, title = label.title;

                        var labelsNode = xmlDoc.createElementNS("http://soap.sforce.com/2006/04/metadata", "labels");
                        xmlDoc.documentElement.appendChild(labelsNode);

                        addNode(labelsNode, 'categories', 'Thor');
                        addNode(labelsNode, 'fullName', name);
                        addNode(labelsNode, 'language', 'en_US');
                        addNode(labelsNode, 'protected', false);
                        addNode(labelsNode, 'shortDescription', label.type + ': ' + title);
                        addNode(labelsNode, 'value', title);

                    }

                    var s = new XMLSerializer();
                    var xml = s.serializeToString(xmlDoc);

                    console.log(xml);

                    var zip = new JSZip();

                    zip.file('labels/CustomLabels.labels', xml);

                    zip.file('package.xml', '<?xml version="1.0" encoding="UTF-8"?>\n' +
                        '<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n' +
                        '\t<types>\n' +
                        '\t\t<members>*</members>\n' +
                        '\t\t<name>CustomLabels</name>\n' +
                        '\t</types>\n' +
                        '\t<version>45.0</version>' +
                        '</Package>');

                    var base64Zip = zip.generate({type: 'base64'});

                    var conn = new jsforce.Connection({ accessToken: config.accessToken });

                    conn.metadata.pollInterval = 3000;
                    conn.metadata.pollTimeout = 120000;

                    conn.metadata.deploy(base64Zip, {singlePackage: true, allowMissingFiles: true})
                        .complete(function (err, result) {

                            console.log('Deployment completed', err, result);
                            if (err)
                            {
                                handleError("Warning: Label deployment took over 2 minutes. See deployment progress in Setup > Deployment Status");
                                $timeout(function()
                                {
                                    $scope.showSpinner = false;
                                });
                            }
                            else
                            {
                                if (result.success == true)
                                {
                                    $scope.isSynced = true;
                                    $scope.refreshLabelsCache();
                                }
                                else
                                {
                                    $scope.outcome = "error";
                                    var msg = "Error: " + result.numberComponentErrors + " out of " +
                                        totalComponents + " components failed. See Setup > Deployment Status for details";
                                    handleError(msg);
                                    $timeout(function()
                                    {
                                        $scope.showSpinner = false;
                                    });
                                }
                            }
                        });
                }

                thorIntegrationService.retryOperationInCaseAuthenticationError(
                    function() {
                        return labelsSyncService.getLabels().then(function(labels)
                        {
                            sync(labels);
                            $scope.refreshLabelsCache();
                        })
                    }, uiServicesURL
                ).catch(function(err)
                {
                    console.error('Error while retrieving labels', err);
                    $scope.showSpinner = false;
                    handleError("Error occurs while retrieving labels from Thor");
                    return $q.reject(err);
                });;
            }

            $scope.refreshLabelsCache = function ()
            {
                var conn = new jsforce.Connection({ accessToken: config.accessToken });

                conn.metadata.pollInterval = 3000;
                conn.metadata.pollTimeout = 120000;

                $scope.showSpinner = true;
                $scope.showMsg = false;

                conn.metadata.list({type: 'CustomLabel', folder: null}, 40)
                    .then(function (data, err)
                    {

                        $scope.showSpinner = true;
                        if(err)
                        {
                            console.error(err);
                            $scope.showSpinner = false;
                            handleError("Timeout: operation took over 2 minutes.");
                        }

                        console.log(data);

                        var labels = [];

                        for(var i = 0; i<data.length; i++)
                        {
                            var label = data[i].fullName;
                            labels.push(label);
                        }

                        console.log('Refreshing cache', labels);

                        // Let's update the cache
                        remoteActions.refreshCustomLabelsCache(labels)
                            .then(function(data, err)
                                    {
                                        console.log('/Refreshing cache', data, err);
                                        $scope.showSpinner = false;
                                        var msg;
                                        if ($scope.isSynced) {
                                            msg = "Thor labels were synced with SFDC successfully";
                                            $scope.isSynced = false;
                                        }
                                        else
                                            msg = "Custom labels cache was refreshed successfully";
                                        showSuccessMsg(msg);
                                    }).catch(function(err)
                                    {
                                        console.error(err);
                                        $scope.showSpinner = false;
                                        handleError("Error" + err.message);
                                    });

                    });
            }

            $scope.closeMsg = function ()
            {
                $scope.showMsg = false;
            }

            $scope.openEncryptionKeysPage = function ()
            {
                // open encryption Keys Page in a separate window
                console.log('opening Encryption Keys Page URL');
                $window.location.href = config.manageEncryptionKeysPage;
            }

            $scope.openManageSecretsPage = function () {
                console.log('opening Manage Secrets Page URL');
                if (document.referrer.indexOf(".lightning.force.com") > 0) {
                    $window.location.href = 'apex/n/'+config.namespacePrefix+'XOMManageSecrets';
                } else {
                    $window.location.href = 'apex/'+config.namespacePrefix+'XOMManageSecrets';
                }
            }

            $scope.openXOMOmplDBQueryPage = function () {
                console.log('opening OMPL DB Query Runner URL');
                $window.location.href = config.omplDBQueryPage;
            }

            var handleError = function(mesg)
            {
                $scope.Message = mesg;
                $scope.outcome = "error";
                $scope.showMsg = true;
                $scope.isSyncPreparing = false;
                $scope.isSyncInprogress = false;
            }

            var showSuccessMsg = function(mesg)
            {
                $scope.outcome = "success";
                $scope.Message = mesg;
                $scope.showMsg = true;
                $timeout(function() {
                    $scope.showMsg = false;
                 }, 10000);
            }

            $scope.updateOrchQueuesCnt = function()
            {
                $scope.showSpinner = true;

                function _updateOrchQueuesCnt(retries)
                {

                    console.log('Update Orchestration Queues count: retry = ' + retries);
                    if (retries > 20)
                    {
                        $scope.showSpinner = false;
                        $scope.hasErrors = true;
                        $scope.errorMessage = "Can't lock OrchestrationQueues. Please try again later";
                    }
                    else
                    {
                        remoteActions.updateOrchQueuesCnt().then(function(success)
                        {
                            if (!success)
                            {
                                _updateOrchQueuesCnt(retries + 1);
                            }
                            else
                            {
                                $scope.showSpinner = false;
                            }
                        });
                    }
                }

                _updateOrchQueuesCnt(0);
            };

            $scope.startRetryJob = function ()
            {
                $scope.showSpinner = true;

                remoteActions.startJob('OM Integration Retry Job')
                    .then(function(data, err)
                    {
                        console.log('Started retry batch job...', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg(data.message);
                        $scope.isRetryJobScheduled = true;
                    })
                    .catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                        $scope.isRetryJobScheduled = false;
                    });
            }

            $scope.stopRetryJob = function ()
            {
                $scope.showSpinner = true;

                remoteActions.stopJob('OM Integration Retry Job')
                    .then(function(data, err)
                    {
                        console.log('Stopping retry batch job...', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg("OM Integration Retry Job has been stopped");
                        $scope.isRetryJobScheduled = false;
                    })
                    .catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                        $scope.isRetryJobScheduled = true;
                    });
            }

            $scope.scheduleJeopardyManagementJobs = function ()
            {
                $scope.showSpinner = true;

                remoteActions.scheduleJeopardyManagementJobs()
                    .then(function(data, err)
                    {
                        console.log('Creating jeopardy management triggers and queueing apex batch jobs', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg("Jeopardy Management Job has been scheduled");
                    })
                    .catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });

            }

            $scope.scheduleOrchFutureDatedJobs = function ()
            {
                $scope.showSpinner = true;

                remoteActions.scheduleOrchFutureDatedJobs()
                    .then(function(data, err)
                    {
                        console.log('Creating Future Dated  triggers and queueing apex batch jobs', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg("Future Dated (Process After) Job has been scheduled");
                    })
                    .catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });

            }

            $scope.abortOrchFutureDatedJobs = function ()
            {
                $scope.showSpinner = true;

                remoteActions.abortOrchFutureDatedJobs()
                    .then(function(data, err)
                    {
                        console.log('Stopping Future Dated Jobs', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg("Future Dated (Process After) Job has been stopped");
                    })
                    .catch(function(err)
                    {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });
            }

            $scope.scheduleOrchestrationRecoveryJobs = function () {
                $scope.showSpinner = true;

                remoteActions.scheduleOrchestrationRecoveryJobs()
                    .then(function (data, err) {
                        console.log('Queueing orchestration recovery jobs', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg("Orchestration Recovery Job has been scheduled");
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });
            }

            $scope.stopDataPurgeJobs = function () {
                $scope.showSpinner = true;
                console.log('Aborting data purge jobs');

                remoteActions.stopDataPurgeJobs()
                    .then(function (data) {
                        console.log('SUCCESS - Aborted data purge jobs', data);
                        $scope.showSpinner = false;
                        if(data.status == 'SUCCESS')
                        {
                            showSuccessMsg('Stopped existing Data Purge jobs');
                        } else {
                            showSuccessMsg('No Data Purge jobs to abort');
                        }
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });
            }

            function getDataPurgeJobStatus()
            {
                //retrieve status
                remoteActions.getDataPurgeStatus()
                    .then(function (data) {
                        console.log('SUCCESS - retrieved data purge status', data);
                        $scope.dataPurgeStatus = data;
                        $scope.showSpinner = false;
                        if(!$scope.isDPInfoHidden) //TODO: check status of the job and dont refresh if completed?
                        {
                            console.log('will retrieve status again in 5 seconds...');
                            setTimeout(getDataPurgeJobStatus, 5000);
                        }
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("ERROR retrieving data purge status: " + err.message);
                    });
            }

            function getDataPurgeConfigData()
            {
                //retrieve config data
                remoteActions.getDataPurgeConfigData()
                    .then(function (data, err) {
                        console.log('SUCCESS - retrieved config data', data, err);
                        $scope.dataPurgeConfigData = data;
                        $scope.showSpinner = false;
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("ERROR retrieving data purge config data: " + err.message);
                    });
            }

            $scope.scheduleDataPurgeJobs = function () {
                $scope.showSpinner = true;
                console.log('Queueing data purge jobs');

                remoteActions.scheduleDataPurgeJobs()
                    .then(function (data, err) {
                        console.log('SUCCESS - Queued data purge jobs', data, err);
                        $scope.showSpinner = false;
                        showSuccessMsg(data);
                        // update status and config data
                        getDataPurgeConfigData();
                        getDataPurgeJobStatus();
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });
            }

            $scope.viewDataPurgeJobProgress = function ()
            {
                $scope.isDPInfoHidden = !$scope.isDPInfoHidden;
                console.log('show data purge status: ', $scope.isDPInfoHidden);

                if(!$scope.isDPInfoHidden)
                {
                    $scope.showSpinner = true;
                    //retrieve config data
                    getDataPurgeConfigData();
                    getDataPurgeJobStatus();
                }
            }

            // Update Odin integration status

            const ODIN_INTERFACE_STATUSES = ['Not configured', 'Configured for Order Management Standard', 'Configured for Order Management Plus'];

            const ODIN_STATUS_CODES = ['red', 'green', 'green'];

            function setOdinStatus(odinStatus) {
                $scope.odinStatus = odinStatus;
                $scope.odinStatusLabel = ODIN_INTERFACE_STATUSES[odinStatus];
                $scope.odinStatusColor = ODIN_STATUS_CODES[odinStatus];
            }

            function checkOdinStatus() {
                remoteActions.checkOdinConfig()
                    .then(function (odinStatus, err) {
                        setOdinStatus(odinStatus);
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });
            }

            setOdinStatus(0);
            checkOdinStatus();

            $scope.configureOdin = function(mode) {
                $scope.showSpinner = true;

                remoteActions.configureOdin(mode)
                    .then (checkOdinStatus)
                    .then (function() {
                        $scope.showSpinner = false;
                        showSuccessMsg("CPQ/Order Management interface has been successfully configured");
                    })
                    .catch(function (err) {
                        console.error(err);
                        $scope.showSpinner = false;
                        handleError("Error " + err.message);
                    });
            }


            $scope.cleanAttrOverridesStages = ['Collect Attribute Overrides', 'Generate Sync Deltas', 'Sync with OM Plus'];
            $scope.cleanAttrOverridesStatus = {
                started: false,
                progress: 0,
                stageIdx: 0
            }

            $scope.cleanAttrOverrides = function () {
                $scope.cleanAttrOverridesStatus = {
                    started: false,
                    progress: 0,
                    stageIdx: 0
                };

                function parseCSV(csv) {
                    var lines = csv.split('\n');

                    console.log('Lines', lines);

                    if (lines.length == 0) {
                        console.error('Wrong response format');
                        return [];
                    }

                    var rx = /^"([^"]+)","([^"]+)"$/;

                    const header = lines[0];

                    var headerMatch;

                    var fieldNames = [];

                    if (headerMatch = rx.exec(header)) {
                        for (var i = 1; i < headerMatch.length; i++) {
                            fieldNames.push(headerMatch[i]);
                        }
                    } else {
                        console.error('Header can\'t be matched', header);
                        return [];
                    }

                    // Remove the header
                    lines.shift();

                    const results = lines.filter(line => {
                        return line;
                    })
                    .map(line => {
                        var m;
                        if (m = rx.exec(line)) {

                            var record = {};

                            for (var i = 1; i < m.length; i++) {
                                var name = fieldNames[i-1];
                                var value = m[i];
                                record[name] = value;
                            }

                            return record;
                        } else {
                            console.error("Line does not match", line);
                            return {};
                        }
                    })
                    console.log('Res0', results);
                    return results;
                }

                // Splits full scope of records into batches
                // Bulk API restricts batch size with 10000
                function splitChunks(records, chunkSize) {

                    const totalSize = records.length;

                    const res = [];

                    for (let i=0; i < totalSize; i += chunkSize) {
                        res.push(records.slice( i , i + chunkSize));
                    }

                    return res;

                }

                function batchCreateSyncDeltaRecords(conn, attributeAssignments) {

                    console.log('Creating deltas...');

                    var syncDeltas = attributeAssignments.map (aa => {
                       var obj = {};
                       obj[config.namespacePrefix + 'ObjectId__c'] = aa['Id'];
                       obj[config.namespacePrefix + 'Action__c'] = 'Delete';

                       var payload = {};
                       payload['VlocityRecordSObjectType'] = 'AttributeAssignment__c';
                       payload['GlobalKey__c'] = aa[config.namespacePrefix + 'GlobalKey__c'];
                       obj[config.namespacePrefix + 'Data__c'] = JSON.stringify(payload);
                       return obj;
                    });

                    console.log('Sync deltas', syncDeltas);

                    const job = conn.bulk.createJob(config.namespacePrefix + "SyncDeltaObject__c", "insert");

                    const chunks = splitChunks(syncDeltas, 10000);

                    console.log('Chunks', chunks);

                    const totalRecords = syncDeltas.length;
                    const totalChunks = chunks.length;

                    let processedRecords = 0;
                    let queuedChunks = 0;

                    function updateProgress() {
                        const START = 50;
                        const QUEUEING = 20;
                        const PROCESSING = 30;
                        const progress = START + QUEUEING * queuedChunks/totalChunks + PROCESSING * processedRecords/totalRecords;
                        $scope.cleanAttrOverridesStatus.progress = progress;
                        console.log('Processed %', progress);
                    }

                    return $q.all(chunks.map(chunk => {
                        return $q((resolve, reject) => {

                            const batch = job.createBatch();
                            batch.execute(chunk)
                                .on("error", function(batchInfo) { // fired when batch request is queued in server.
                                    console.log('Error, batchInfo:', batchInfo);
                                    reject(batchInfo);
                                })
                                .on("queue", function(batchInfo) { // fired when batch request is queued in server.
                                    console.log('queue, batchInfo:', batchInfo);
                                    queuedChunks++;
                                    updateProgress();
                                    batch.poll(5000 /* interval(ms) */, 180000 /* timeout(ms) */); // start polling - Do not poll until the batch has started
                                })
                                .on("response", function(rets) { // fired when batch finished and result retrieved
                                    var allGood = true;
                                    for (var i=0; i < rets.length; i++) {
                                        if (!rets[i].success) {
                                            allGood = false;
                                            console.log("#" + (i+1) + " error occurred, message = " + rets[i].errors.join(', '));
                                        }
                                    }

                                    console.log('Processed', rets.length);

                                    processedRecords += rets.length;
                                    updateProgress();

                                    if (allGood) {
                                        console.log('Sync Deltas have been successfully created');
                                        resolve(true);
                                    } else {
                                        console.log('Not all good');
                                        resolve(false);
                                    }


                                });
                        });
                    }));

                }

                function collectAttributeAssignments(conn) {
                    return $q((resolve, reject) => {
                        var job = conn.bulk.createJob(config.namespacePrefix + "AttributeAssignment__c", "query");
                        var batch = job.createBatch();

                        batch.execute("SELECT Id, " + config.namespacePrefix + "GlobalKey__c FROM " +
                            config.namespacePrefix+"AttributeAssignment__c where " + config.namespacePrefix +"isOverride__c = true");
                        batch.on('error', err => {
                            reject(err);
                        });
                        batch.on("queue", function(batchInfo) { // fired when batch request is queued in server.
                            console.log('batchInfo:', batchInfo);
                            $scope.cleanAttrOverridesStatus.progress = 10;
                            batchId = batchInfo.id;
                            jobId = batchInfo.jobId;
                            batch.poll(1000 /* interval(ms) */, 240000 /* timeout(ms) */); // start polling
                            batch.on("response", function(rets) {
                                rets.map(r => {
                                    console.log('Processing response', r);
                                    conn.bulk._request({
                                        method: 'GET',
                                        path: "/job/" + jobId + "/batch/" + batchId + "/result/" + r.id,
                                        responseType: "application/octet-stream"
                                    })
                                    .then(res => {
                                        $scope.cleanAttrOverridesStatus.progress = 40;
                                        console.log('Result', res);
                                        resolve(parseCSV(res));
                                    })
                                });
                            });
                        });
                    });
                }

                console.log('Starting the Spring cleaning');

                var conn0 = new jsforce.Connection({ accessToken: config.accessToken });

                conn0.query('select InstanceName from Organization')
                    .then (rec => {
                        console.log('Rec', rec);
                        const pod = rec.records[0].InstanceName;
                        const conn = new jsforce.Connection({ accessToken: config.accessToken, instanceUrl: 'https://' + pod + '.salesforce.com/' });
                        conn.bulk.pollTimeout = 180000;

                        $scope.cleanAttrOverridesStatus.started = true;

                        collectAttributeAssignments(conn)
                            .then(attributeAssignments => {
                                // throw "Test2";
                                $scope.cleanAttrOverridesStatus.progress = 50;
                                $scope.cleanAttrOverridesStatus.stageIdx = 1;
                                return batchCreateSyncDeltaRecords(conn, attributeAssignments)
                            })
                            .then(res => {

                                $scope.cleanAttrOverridesStatus.progress = 99;

                                let allGood = true;

                                for (let i = 0; i < res.length; i++) {
                                    if (!res[i]) {
                                        allGood = false;
                                        break;
                                    }
                                }

                                if (!allGood) {
                                    handleError('Sync Delta Objects generation was partially successful. Please check the JavaScript console');
                                }

                                console.log('All is processed');
                            })
                            .then(() => {
                                return remoteActions.forceStartCatalogSyncBatchJob()
                            })
                            .then(s => {
                                console.log('Starting sync job', s);
                                $scope.cleanAttrOverridesStatus.progress = 100;
                                $scope.cleanAttrOverridesStatus.started = false;
                            })
                            .catch(err => {
                                console.error('Error', err);
                                handleError('Override Attribute Assignment cleanup error: ' + err);
                            });
                    });

            }
        }

    ]);

},{}],3:[function(require,module,exports){
angular.module('xomadmin').controller('XOMConfigureLayoutsController',
    [
        '$scope', '$q', '$location', '$timeout', 'config', 'remoteActions',
        function($scope, $q, $location, $timeout, config, remoteActions)
        {
            console.log('XOMCOnfigureLayoutsController');

            var namespacePrefix = config.namespacePrefix;

            var packageRecordTypesAvailability =
                {
                    'OrchestrationItemDefinition__c':
                    [
                        {
                            recordType: namespacePrefix+'OrchestrationItemDefinition__c.'+namespacePrefix+'Callout',
                            default: false,
                            visible: true
                        },
                        {
                            recordType: namespacePrefix+'OrchestrationItemDefinition__c.'+namespacePrefix+'AutoTask',
                            default: false,
                            visible: true
                        },
                        {
                            recordType: namespacePrefix+'OrchestrationItemDefinition__c.'+namespacePrefix+'Milestone',
                            default: true,
                            visible: true
                        },
                        {
                            recordType: namespacePrefix+'OrchestrationItemDefinition__c.'+namespacePrefix+'ManualTask',
                            default: false,
                            visible: true
                        },
                        {
                            recordType: namespacePrefix+'OrchestrationItemDefinition__c.'+namespacePrefix+'PushEvent',
                            default: false,
                            visible: true
                        },
                        {
                            recordType: namespacePrefix+'OrchestrationItemDefinition__c.'+namespacePrefix+'SubPlan',
                            default: false,
                            visible: true
                        }
                    ],
                    'Product2':
                    [
                        {
                            recordType: 'Product2.' + namespacePrefix + 'Product',
                            default: true,
                            visible: true
                        },
                        {
                            recordType: 'Product2.' + namespacePrefix + 'Class',
                            default: false,
                            visible: true
                        }
                    ]
                };

            var packageLayoutAssignments = {
                'XOM Base': {
                    'Order':
                        [
                            {
                                layout: 'Order-' + namespacePrefix + (config.isInsurance?'Order %28Vlocity Insurance%29 Layout V2':'Order %28Vlocity XOM%29 Layout V12')
                            }
                        ],
                    'InventoryItem__c':
                        config.isInsurance?
                            [
                            ]:
                            [
                                {
                                    layout: namespacePrefix + 'InventoryItem__c-' + namespacePrefix +'Inventory Item %28Vlocity XOM%29 Layout'
                                }
                            ],
                    'ManualQueue__c':
                        [
                            {
                                layout: namespacePrefix + 'ManualQueue__c-' + namespacePrefix + (config.isInsurance?'Manual Queue %28Vlocity Insurance%29 Layout V2':'Manual Queue %28Vlocity XOM%29 Layout V8')
                            }
                        ],
                    'OrchestrationItem__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationItem__c-' + namespacePrefix + (config.isInsurance?'Orchestration Item %28Vlocity Insurance%29 Layout V5':'Orchestration Item %28Vlocity XOM%29 Layout V4')
                            }
                        ],
                    'OrchestrationPlanDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlanDefinition__c-' + namespacePrefix + (config.isInsurance?'Orchestration Plan Definition %28Vlocity Insurance%29 Layout':'Orchestration Plan Definition %28Vlocity XOM%29 Layout')
                            }
                        ],
                    'OrchestrationPlan__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlan__c-' + namespacePrefix + (config.isInsurance?'Orchestration Plan %28Vlocity Insurance%29 Layout':'Orchestration Plan %28Vlocity XOM%29 Layout V3')
                            }
                        ],
                    'OrchestrationDependency__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationDependency__c-' + namespacePrefix + 'Orchestration Dependency %28Vlocity XOM%29 Layout V2'
                            }
                        ],
                    'AssignmentRule__c':
                        [
                            {
                                layout: namespacePrefix + 'AssignmentRule__c-' + namespacePrefix + 'Manual Queue Assignment Rule %28Vlocity XOM%29 Layout V3'
                            }
                        ]
                },
                'XOM Admin': {
                    'AssignmentRule__c':
                        [
                            {
                                layout: namespacePrefix + 'AssignmentRule__c-' + namespacePrefix + 'Manual Queue Assignment Rule %28Vlocity XOM%29 Layout V3'
                            }
                        ],
                    'Order':
                        [
                            {
                                layout: 'Order-' + namespacePrefix + (config.isInsurance?'Order %28Vlocity Insurance%29 Layout V2':'Order %28Vlocity XOM%29 Layout V12')
                            }
                        ],
                    'FulfilmentRequest__c':
                    [
                        {
                            layout: namespacePrefix + 'FulfilmentRequest__c-' + namespacePrefix + 'Fulfilment Request %28Vlocity XOM%29 Layout'
                        },
                        {
                            layout: namespacePrefix + 'FulfilmentRequest__c-' + namespacePrefix + 'Fulfilment Request %28Vlocity XOM%29 Layout',
                            recordType: namespacePrefix + 'FulfilmentRequest__c.' + namespacePrefix + 'FulfilmentRequest'
                        },
                        {
                            layout: namespacePrefix + 'FulfilmentRequest__c-' + namespacePrefix + 'Fulfilment Request %28Vlocity XOM%29 Layout',
                            recordType: namespacePrefix + 'FulfilmentRequest__c.' + namespacePrefix + 'ServiceQualificationRequest'
                        }
                    ],
                    'IntegrationRetryPolicy__c':
                        [
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix + 'Monotonous Retry Policy Layout'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix + 'No Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'NoRetryPolicy'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix + 'Monotonous Forever Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'MonotonousForeverRetryPolicy'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix + 'Monotonous Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'MonotonousRetryPolicy'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix + 'Staggered Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'StaggeredRetryPolicy'
                            }
                        ],
                    'InventoryItem__c':
                        config.isInsurance?
                            [
                            ]:
                            [
                                {
                                    layout: namespacePrefix + 'InventoryItem__c-' + namespacePrefix +'Inventory Item %28Vlocity XOM%29 Layout'
                                }
                            ],
                    'DecompositionRelationship__c':
                        [
                            {
                                layout: namespacePrefix + 'DecompositionRelationship__c-' + namespacePrefix +'Decomposition Relationship %28Vlocity XOM%29 Layout V5'
                            }
                        ],
                    'OrchestrationItemDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix + (config.isInsurance?'Orchestration Item Definition %28Vlocity Insurance%29 Layout':'Orchestration Item Definition %28Vlocity XOM%29 Layout V8')
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix + (config.isInsurance?'Orchestration Item Definition %28Vlocity Insurance%29 Layout':'Orchestration Item Definition %28Vlocity XOM%29 Layout V8'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'Milestone'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Auto Task %28Vlocity Insurance%29 Layout':'Auto Task %28Vlocity XOM%29 Layout V8'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'AutoTask'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Callout %28Vlocity Insurance%29 Layout':'Callout %28Vlocity XOM%29 Layout V13'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'Callout'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Manual Task %28Vlocity Insurance%29 Layout V2':'Manual Task %28Vlocity XOM%29 Layout V9'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'ManualTask'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Push Event %28Vlocity Insurance%29 Layout V2':'Push Event %28Vlocity XOM%29 Layout V9'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'PushEvent'
                            }
                        ],
                    'OrchestrationItem__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationItem__c-' + namespacePrefix + (config.isInsurance?'Orchestration Item %28Vlocity Insurance%29 Layout V5':'Orchestration Item %28Vlocity XOM%29 Layout V4')
                            }
                        ],
                    'OrchestrationPlan__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlan__c-' + namespacePrefix + (config.isInsurance?'Orchestration Plan %28Vlocity Insurance%29 Layout':'Orchestration Plan %28Vlocity XOM%29 Layout V3')
                            }
                        ],
                    'Product2':
                        [
                            {
                                layout: 'Product2-' + namespacePrefix + (config.isInsurance?'Product %28Vlocity Insurance%29 Layout V2':'Product %28Vlocity XOM%29 Layout V6')
                            },
                            {
                                layout: 'Product2-' + namespacePrefix + (config.isInsurance?'Product %28Vlocity Insurance%29 Layout V2':'Product %28Vlocity XOM%29 Layout V6'),
                                recordType: 'Product2.' + namespacePrefix + 'Product'
                            },
                            {
                                layout: 'Product2-' + namespacePrefix + (config.isInsurance?'Product %28Vlocity Insurance%29 Layout V2':'Product %28Vlocity XOM%29 Layout V6'),
                                recordType: 'Product2.' + namespacePrefix + 'Class'
                            }
                        ],
                    'OrchestrationScenario__c':
                    [
                        {
                            layout: namespacePrefix + 'OrchestrationScenario__c-' + namespacePrefix + 'Orchestration Scenario %28Vlocity XOM%29 Layout V2'
                        }
                    ],
                    'System__c':
                    [
                        {
                            layout: namespacePrefix + 'System__c-' + namespacePrefix + 'System %28Vlocity XOM%29 Layout'
                        }
                    ],
                    'ManualQueue__c':
                        [
                            {
                                layout: namespacePrefix + 'ManualQueue__c-' + namespacePrefix + (config.isInsurance?'Manual Queue %28Vlocity Insurance%29 Layout V2':'Manual Queue %28Vlocity XOM%29 Layout V8')
                            }
                        ],
                    'ItemImplementation__c':
                        [
                            {
                                layout: namespacePrefix + 'ItemImplementation__c-' + namespacePrefix + 'Item Implementation %28Vlocity XOM%29 Layout V3'
                            }
                        ],
                    'OrchestrationPlanDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlanDefinition__c-' + namespacePrefix + 'Orchestration Plan Definition %28Vlocity XOM%29 Layout'
                            }
                        ],
                    'SystemInterface__c':
                        [
                            {
                                layout:namespacePrefix + 'SystemInterface__c-' + namespacePrefix + 'System Interface %28Vlocity XOM%29 Layout'
                            }
                        ],
                     'FulfilmentRequestDecompRelationship__c':
                        [
                            {
                                layout:namespacePrefix + 'FulfilmentRequestDecompRelationship__c-' + namespacePrefix + 'Fulfilment Request Decomp Relationship %28Vlocity XOM%29 Layout'
                            }
                    	],
                     'FulfilmentRequestLine__c':
                        [
                             {
                                 layout:namespacePrefix + 'FulfilmentRequestLine__c-' + namespacePrefix + 'Fulfilment Request Line %28Vlocity XOM%29 Layout'
                             }
                     	],
                     'FulfilmentRequestLineDecompRelationship__c':
                        [
                             {
                                 layout:namespacePrefix + 'FulfilmentRequestLineDecompRelationship__c-' + namespacePrefix + 'Fulfilment Request Line Decomp Relationship %28Vlocity XOM%29 Layout'
                             }
                        ],
                     'InventoryItemDecompositionRelationship__c':
                        [
                             {
                                 layout:namespacePrefix + 'InventoryItemDecompositionRelationship__c-' + namespacePrefix + 'Inventory Item Decomposition Relationship %28Vlocity XOM%29 Layout'
                             }
                        ],
                     'OrchestrationQueueAssignmentRule__c':
                        [
                             {
                                 layout:namespacePrefix + 'OrchestrationQueueAssignmentRule__c-' + namespacePrefix + 'Orchestration Queue Assignment Rule %28Vlocity XOM%29 Layout'
                             }
                        ],
                     'OrchestrationPlan__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlan__c-' + namespacePrefix + (config.isInsurance?'Orchestration Plan %28Vlocity Insurance%29 Layout' : 'Orchestration Plan %28Vlocity XOM%29 Layout V3')
                            }
                        ],
                     'OrchestrationQueue__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationQueue__c-' + namespacePrefix + 'Orchestration Queue %28Vlocity XOM%29 Layout V2'
                            }
                        ],
                    'OrchestrationPlanDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlanDefinition__c-' + namespacePrefix + (config.isInsurance?'Orchestration Plan Definition %28Vlocity Insurance%29 Layout':'Orchestration Plan Definition %28Vlocity XOM%29 Layout')
                            }
                        ]
                },
                'Thor Admin': {
                    'Order':
                        [
                            {
                                layout: 'Order-'+namespacePrefix+'Order %28Vlocity Thor%29 Layout V5'
                            }
                        ],
                    'FulfilmentRequest__c':
                    [
                        {
                            layout: namespacePrefix + 'FulfilmentRequest__c-' + namespacePrefix + 'Fulfilment Request %28Vlocity XOM%29 Layout'
                        },
                        {
                            layout: namespacePrefix + 'FulfilmentRequest__c-' + namespacePrefix + 'Fulfilment Request %28Vlocity XOM%29 Layout',
                            recordType: namespacePrefix + 'FulfilmentRequest__c.' + namespacePrefix + 'FulfilmentRequest'
                        },
                        {
                            layout: namespacePrefix + 'FulfilmentRequest__c-' + namespacePrefix + 'Fulfilment Request %28Vlocity XOM%29 Layout',
                            recordType: namespacePrefix + 'FulfilmentRequest__c.' + namespacePrefix + 'ServiceQualificationRequest'
                        }
                    ],
                    'InventoryItem__c':
                        config.isInsurance?
                            [
                            ]:
                            [
                                {
                                    layout: namespacePrefix + 'InventoryItem__c-' + namespacePrefix +'Inventory Item %28Vlocity XOM%29 Layout'
                                }
                            ],
                    'DecompositionRelationship__c':
                        [
                            {
                                layout: namespacePrefix + 'DecompositionRelationship__c-' + namespacePrefix +'Decomposition Relationship %28Vlocity XOM%29 Layout V4'
                            }
                        ],
                    'OrchestrationItemDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix + (config.isInsurance?'Orchestration Item Definition %28Vlocity Insurance%29 Layout':'Orchestration Item Definition %28Vlocity XOM%29 Layout V8')
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix + (config.isInsurance?'Orchestration Item Definition %28Vlocity Insurance%29 Layout':'Orchestration Item Definition %28Vlocity XOM%29 Layout V8'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'Milestone'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Auto Task %28Vlocity Insurance%29 Layout':'Auto Task %28Vlocity XOM%29 Layout V8'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'AutoTask'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Callout %28Vlocity Insurance%29 Layout':'Callout %28Vlocity XOM%29 Layout V13'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'Callout'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Manual Task %28Vlocity Insurance%29 Layout V2':'Manual Task %28Vlocity XOM%29 Layout V9'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'ManualTask'
                            },
                            {
                                layout: namespacePrefix + 'OrchestrationItemDefinition__c-' + namespacePrefix +
                                    (config.isInsurance?'Push Event %28Vlocity Insurance%29 Layout V2':'Push Event %28Vlocity XOM%29 Layout V9'),
                                recordType: namespacePrefix + 'OrchestrationItemDefinition__c.' + namespacePrefix + 'PushEvent'
                            }
                        ],
                    'Product2':
                        [
                            {
                                layout: 'Product2-' + namespacePrefix + 'Product %28Vlocity Thor%29 Layout V2'
                            },
                            {
                                layout: 'Product2-' + namespacePrefix + 'Product %28Vlocity Thor%29 Layout V2',
                                recordType: 'Product2.' + namespacePrefix + 'Product'
                            },
                            {
                                layout: 'Product2-' + namespacePrefix + 'Product %28Vlocity Thor%29 Layout V2',
                                recordType: 'Product2.' + namespacePrefix + 'Class'
                            }
                        ],
                    'OrchestrationScenario__c':
                    [
                        {
                            layout: namespacePrefix + 'OrchestrationScenario__c-' + namespacePrefix + 'Orchestration Scenario %28Vlocity XOM%29 Layout'
                        }
                    ],
                    'ErrorCodeNamespace__c':
                        [
                            {
                                layout: namespacePrefix + 'ErrorCodeNamespace__c-' + namespacePrefix + 'Error Code Namespace %28Vlocity XOM%29 Layout'
                            }
                        ],
                    'IntegrationRetryPolicy__c':
                        [
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix +'Monotonous Forever Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'MonotonousForeverRetryPolicy'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix +'Monotonous Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'MonotonousRetryPolicy'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix +'No Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'NoRetryPolicy'
                            },
                            {
                                layout: namespacePrefix + 'IntegrationRetryPolicy__c-' + namespacePrefix +'Staggered Retry Policy Layout',
                                recordType: namespacePrefix + 'IntegrationRetryPolicy__c.' + namespacePrefix + 'StaggeredRetryPolicy'
                            }
                        ],
                    'System__c':
                    [
                        {
                            layout: namespacePrefix + 'System__c-' + namespacePrefix + 'System %28Vlocity XOM%29 Layout'
                        }
                    ],
                    'ManualQueue__c':
                        [
                            {
                                layout: namespacePrefix + 'ManualQueue__c-' + namespacePrefix + 'Manual Queue %28Vlocity XOM%29 Layout V7'
                            }
                        ],
                    'ItemImplementation__c':
                        [
                            {
                                layout: namespacePrefix + 'ItemImplementation__c-' + namespacePrefix + 'Item Implementation %28Vlocity Thor%29 Layout'
                            }
                        ],
                    'OrchestrationPlanDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlanDefinition__c-' + namespacePrefix + 'Orchestration Plan Definition %28Vlocity XOM%29 Layout'
                            }
                        ],
                    'OperatingHoursEntry__c':
                        [
                            {
                                layout: namespacePrefix + 'OperatingHoursEntry__c-' + namespacePrefix + 'Standard Operating Hours Entry %28Vlocity Thor%29 Layout'
                            },
                            {
                                layout: namespacePrefix + 'OperatingHoursEntry__c-' + namespacePrefix +'Standard Operating Hours Entry %28Vlocity Thor%29 Layout',
                                recordType: namespacePrefix + 'OperatingHoursEntry__c.' + namespacePrefix + 'Standard'
                            },
                            {
                                layout: namespacePrefix + 'OperatingHoursEntry__c-' + namespacePrefix +'Exception Operating Hours Entry %28Vlocity Thor%29 Layout',
                                recordType: namespacePrefix + 'OperatingHoursEntry__c.' + namespacePrefix + 'Exception'
                            }
                        ],
                    'SystemInterface__c':
                        [
                            {
                                layout:namespacePrefix + 'SystemInterface__c-' + namespacePrefix + 'System Interface %28Vlocity XOM%29 Layout'
                            }
                        ],
                    'FulfilmentRequestDecompRelationship__c':
                        [
                           {
                                layout:namespacePrefix + 'FulfilmentRequestDecompRelationship__c-' + namespacePrefix + 'Fulfilment Request Decomp Relationship %28Vlocity XOM%29 Layout'
                           }
                      	],
                    'FulfilmentRequestLine__c':
                        [
                           {
                                layout:namespacePrefix + 'FulfilmentRequestLine__c-' + namespacePrefix + 'Fulfilment Request Line %28Vlocity XOM%29 Layout'
                           }
                        ],
                    'FulfilmentRequestLineDecompRelationship__c':
                        [
                           {
                                layout:namespacePrefix + 'FulfilmentRequestLineDecompRelationship__c-' + namespacePrefix + 'Fulfilment Request Line Decomp Relationship %28Vlocity XOM%29 Layout'
                           }
                        ],
                    'InventoryItemDecompositionRelationship__c':
                        [
                           {
                                layout:namespacePrefix + 'InventoryItemDecompositionRelationship__c-' + namespacePrefix + 'Inventory Item Decomposition Relationship %28Vlocity XOM%29 Layout'
                           }
                        ],
                    'OrchestrationQueueAssignmentRule__c':
                        [
                           {
                                layout:namespacePrefix + 'OrchestrationQueueAssignmentRule__c-' + namespacePrefix + 'Orchestration Queue Assignment Rule %28Vlocity XOM%29 Layout'
                           }
                        ]                 
                },
                'Thor Base':  {
                    'Order':
                        [
                            {
                                layout: 'Order-'+namespacePrefix+'Order %28Vlocity Thor%29 Layout V5'
                            }
                        ],
                    'InventoryItem__c':
                        [
                            {
                                layout: namespacePrefix + 'InventoryItem__c-' + namespacePrefix +'Inventory Item %28Vlocity XOM%29 Layout'
                            }
                        ],
                    'ManualQueue__c':
                        [
                            {
                                layout: namespacePrefix + 'ManualQueue__c-' + namespacePrefix + 'Manual Queue %28Vlocity Thor%29 Layout V3'
                            }
                        ],
                    'OrchestrationPlanDefinition__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationPlanDefinition__c-' + namespacePrefix + 'Orchestration Plan Definition %28Vlocity XOM%29 Layout'
                            }
                        ]
                },
                     'OrchestrationQueue__c':
                        [
                            {
                                layout: namespacePrefix + 'OrchestrationQueue__c-' + namespacePrefix + 'Orchestration Queue %28Vlocity XOM%29 Layout V2'
                            }
                        ]
            }

            $scope.profiles = [];

            $scope.profileOptions = [
                'None', 'XOM Base', 'XOM Admin'
            ];

            $scope.showSpinner = false;
            $scope.showMsg = false;

            if (config.isThorEnabled == 'true')
            {
                $scope.profileOptions.push('Thor Base');
                $scope.profileOptions.push('Thor Admin');
            }

            var conn = new jsforce.Connection({ accessToken: config.accessToken });

            $scope.retrieveProfiles = function ()
            {
                var id2fullName = {};

                conn.metadata.list({type: 'Profile'}, '39.0')
                    .then(function(res)
                      {
                        console.log(res);

                        for (var i = 0; i < res.length; i++)
                        {
                            id2fullName[res[i].id] = res[i].fullName;
                        }

                        return conn.query('select Id, Name, UserLicense.name from Profile where UserLicense.name = \'Salesforce\'');

                      })
                    .then(function(res)
                    {
                        for (var i = 0; i < res.records.length; i++)
                        {
                            res.records[i].fullName = id2fullName[res.records[i].Id];
                        }

                        console.log(res);

                        $scope.$apply(function()
                        {

                            $scope.profiles.length = 0;

                            var current;

                            for (var i = 0; i < res.records.length; i++)
                            {

                                if (i % 3 == 0)
                                {
                                    current = [];
                                    $scope.profiles.push(current);
                                }

                                current.push({
                                    Name: res.records[i].Name,
                                    Id: res.records[i].Id,
                                    FullName: res.records[i].fullName,
                                    xom: 'None'
                                });
                            }

                        });
                    })
                    .catch(function(err)
                    {
                        console.log('Error', err);
                    });

            }

            function stripNamespace(name)
            {
                var parts = name.split('__');


                if (parts.length > 1)
                {
                    // I.e. aaa__c
                    if (parts[1] == 'c')
                    {
                        return name;
                    }
                    else
                    {
                        return parts[1];
                    }
                }
                else
                {
                    return name;
                }
            }

            function updateProfile(zip, profileSettings)
            {

                console.log('Profile settings ', profileSettings);

                var profileName = profileSettings.name;

                var profileType = profileSettings.type;

                var zipFile = zip.file('profiles/' + profileName + '.profile');

                if (!zipFile)
                {
                    console.log('Profile ' + profileName +' is not found');
                }

                var xml = zipFile.asText();

                var xmlDoc = new DOMParser().parseFromString(xml,"text/xml");

                var rootNode = xmlDoc.getElementsByTagName('Profile')[0];

                var recordTypeNodes = rootNode.getElementsByTagName('recordTypeVisibilities');

                var recordTypeNodesToRemove = [];

                for (var i = 0; i<recordTypeNodes.length; i++)
                {
                    var objectType = stripNamespace(recordTypeNodes[i].getElementsByTagName('recordType')[0].childNodes[0].nodeValue.split('.')[0]);

                    if (packageRecordTypesAvailability[objectType])
                    {
                        recordTypeNodesToRemove.push(recordTypeNodes[i]);
                    }

                }

                for (var i = 0; i < recordTypeNodesToRemove.length; i++)
                {
                    rootNode.removeChild(recordTypeNodesToRemove[i]);
                }

                for (var objectType in packageRecordTypesAvailability)
                {
                    var assignments = packageRecordTypesAvailability[objectType];

                    for (var i=0; i < assignments.length; i++)
                    {
                        var assignment = assignments[i];

                        var assignmentNode = xmlDoc.createElement('recordTypeVisibilities');
                        rootNode.insertBefore(assignmentNode, recordTypeNodes[0]);

                        var defaultNode = xmlDoc.createElement('default');
                        assignmentNode.appendChild(defaultNode);
                        defaultNode.appendChild(xmlDoc.createTextNode(assignment['default']));

                        var visibleNode = xmlDoc.createElement('visible');
                        assignmentNode.appendChild(visibleNode);
                        visibleNode.appendChild(xmlDoc.createTextNode('true'));

                        var recordTypeNode = xmlDoc.createElement('recordType');
                        assignmentNode.appendChild(recordTypeNode);
                        recordTypeNode.appendChild(xmlDoc.createTextNode(assignment['recordType']));
                    }
                }

                var layoutAssignmentsNodesToRemove = [];

                var layoutAssignmentsNodes = rootNode.getElementsByTagName('layoutAssignments');

                var standardLayoutAssignments = packageLayoutAssignments[profileType];

                for (var i = 0; i< layoutAssignmentsNodes.length; i++)
                {
                    var layoutAssignmentsNode = layoutAssignmentsNodes[i];

                    var objectType, recordType;

                    var layoutNode = layoutAssignmentsNode.getElementsByTagName('layout')[0];

                    objectType = stripNamespace(layoutNode.childNodes[0].nodeValue.split('-')[0]);

                    if (standardLayoutAssignments[objectType])
                    {
                        layoutAssignmentsNodesToRemove.push(layoutAssignmentsNode);
                    }


                }

                for (var i = 0; i < layoutAssignmentsNodesToRemove.length; i++)
                {
//                    console.log('Removing layout assignments ', layoutAssignmentsNodesToRemove[i]);
                    rootNode.removeChild(layoutAssignmentsNodesToRemove[i]);
                }

                // Now lets setup layoutAssignments
                for (var assignment in standardLayoutAssignments)
                {
                    if (standardLayoutAssignments.hasOwnProperty(assignment))
                    {

                        console.log ('>>>> Assigment ', assignment);

                        var pageAssignments = standardLayoutAssignments[assignment];

                        for (var i=0; i < pageAssignments.length; i++)
                        {

                            var pageAssignment = pageAssignments[i];

                            console.log ('>>>> PageAssigment ', pageAssignment);

                            var newAssignment = xmlDoc.createElement('layoutAssignments');
                            rootNode.insertBefore(newAssignment, layoutAssignmentsNodes[0]);

                            var newLayout = xmlDoc.createElement('layout');
                            newAssignment.appendChild(newLayout);

                            newLayout.appendChild(xmlDoc.createTextNode(pageAssignment['layout']));

                            var recordType = pageAssignment['recordType'];

                            if (recordType)
                            {
                                var newRecordType = xmlDoc.createElement('recordType');
                                newAssignment.appendChild(newRecordType);

                                newRecordType.appendChild(xmlDoc.createTextNode(recordType));
                            }

                        }

                    }
                }

                var s = new XMLSerializer();

                var xml = s.serializeToString(xmlDoc);

                console.log(xml);

                zip.file('profiles/' + profileName + '.profile', xml);
            }

            function updateZip(zipfile, profilesSettings)
            {
                var zip = new JSZip(zipfile, {base64: true});

                for (var i = 0; i < profilesSettings.length; i++)
                {
                    updateProfile(zip, profilesSettings[i]);
                }

                zip.remove('objects');
                zip.remove('layouts');

                console.log ('Zip', zip);

                return zip.generate();

            }

            function setupProfiles(profilesSettings, cont)
            {

                var profilesToUpdate = [];

                for (var i = 0; i < profilesSettings.length; i++)
                {
                    profilesToUpdate.push(profilesSettings[i].name);
                }

                console.log('Profiles to update', profilesToUpdate);

                conn.metadata.retrieve({ packageNames: [], singlePackage: true,
                                        unpackaged:
                                            {   version: '45.0',
                                                types:
                                                [
                                                    {members: profilesToUpdate, name: 'Profile'},
                                                    {members: ['*'], name: 'CustomObject'},
                                                    {members: ['*'], name: 'Layout'}
                                                ]}},
                function(err, data)
                {
                    // console.log('Err', err);
                    // console.log('Data', data);

                    function checkRetrievalStatus(id, cont)
                    {

                        conn.metadata.checkRetrieveStatus(id, function(err, status)
                        {
                            console.log('Status', status);
                            if (status.done == "false")
                            {
                                checkRetrievalStatus(id, cont);
                            }
                            else
                            {
                                cont(status);
                            }

                        })
                    }

                    checkRetrievalStatus(data.id, function(status)
                    {
                        console.log('End status: ', status);
                        var base64upload = updateZip(status.zipFile, profilesSettings);

                        function checkDeploy(id, cont)
                        {
                            conn.metadata.checkDeployStatus(id, function(err, res)
                            {
                                if (err)
                                {
                                    console.log('Error', err);
                                }
                                else
                                {
                                    console.log('Check Deploy Res', res);
                                    if (res.done == "true")
                                    {
                                        cont(res);
                                    }
                                    else
                                    {
                                        checkDeploy(id, cont);
                                    }
                                }
                            });

                        }

                        conn.metadata.pollInterval = 3000;
                        conn.metadata.pollTimeout = 240000;

                        conn.metadata.deploy(base64upload, {singlePackage: true, allowMissingFiles: true, rollbackOnError: true})
                           .complete(function(err, result) {
                                if (err) {
                                    console.error(err);
                                    $scope.Message = "Warning: Layout deployment took over 4 minutes. See deployment progress in Setup > Deployment Status";
                                    $scope.outcome = "error";
                                } else {
                                    if (result.success == true) {
                                        $scope.outcome = "success";
                                        $scope.Message = "Layouts were successfully assigned to Profiles selected";
                                        $timeout(function() {
                                            $scope.showMsg = false;
                                         }, 5000);
                                    } else {
                                        $scope.outcome = "error";
                                        var totalComponents = result.numberComponentErrors + result.numberComponentsDeployed;
                                        $scope.Message = "Error: " + result.numberComponentErrors + " out of " +
                                            totalComponents + " components failed. See Setup > Deployment Status for details";
                                    }
                                }
                                $scope.showMsg = true;
                                cont();
                              });
                        });

                });

            }

            $scope.save = function ()
            {

                console.log('Save!');

                $scope.showMsg = false;
                $scope.showSpinner = true;

                var profilesSettings = [];

                for(var i = 0; i < $scope.profiles.length; i++)
                {
                    for (var j = 0; j < $scope.profiles[i].length; j++)
                    {
                        if (packageLayoutAssignments[$scope.profiles[i][j].xom])
                        {
                            profilesSettings.push({name: $scope.profiles[i][j].FullName, type: $scope.profiles[i][j].xom});
                        }
                    }
                }

                setupProfiles(profilesSettings, function()
                {
                    $timeout(function()
                        {
                            $scope.showSpinner = false;
                        });
                });

            }

            $scope.cancel = function()
            {
                $location.path('/');
            }

            $scope.closeMsg = function ()
            {
                $scope.showMsg = false;
            }

            $scope.retrieveProfiles();

        }
    ]);


},{}],4:[function(require,module,exports){
angular.module("xomadmin").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("XOMAdmin.tpl.html",'<div>\n    <div class="slds-clearfix slds-p-around--small">\n    </div>\n    <div style="height: 4rem;" ng-show="showMsg">\n        <div class="slds-notify_container slds-is-relative">\n            <div class="slds-notify slds-notify_toast slds-theme_{{outcome}}" role="alert">\n                <span class="slds-assistive-text">{{outcome}}</span>\n                <span class="slds-icon_container slds-icon-utility-{{outcome}} slds-m-right_small slds-no-flex slds-align-top">\n                    <svg ng-if="outcome == \'success\'"class="slds-icon slds-icon_small" aria-hidden="true">\n                        <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#success" />\n                    </svg>\n                    <svg ng-if="outcome == \'error\'"class="slds-icon slds-icon_small" aria-hidden="true">\n                        <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#error" />\n                    </svg>\n                </span>\n                <div class="slds-notify__content">\n                    <h2 class="slds-text-heading_small ">{{Message}}.</h2>\n                </div>\n                <button class="slds-button slds-button_icon slds-notify__close slds-button_icon-inverse" title="Close" ng-click="closeMsg()">\n                    <svg class="slds-button__icon slds-button__icon_large" aria-hidden="true">\n                        <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#close" />\n                    </svg>\n                    <span class="slds-assistive-text">Close</span>\n                </button>\n            </div>\n        </div>\n    </div>\n    <div class="slds-theme--shade">\n        <div class="job-wrapper slds-p-around--medium">\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <div><b>CPQ/Order Management Interface status:</b></div><div ng-style="{color:odinStatusColor}">{{odinStatusLabel}} </div>\n                        </div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="configureOMStd" type="button" ng-click="configureOdin(1)" class="slds-button  slds-button--brand">Configure for Order Management Standard</button>\n                        <button id="configureOMPL" type="button" ng-click="configureOdin(2)" class="slds-button  slds-button--brand">Configure for Order Management Plus</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="createEpcObjectClassesStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Apply Record Types and Page Layout Assignments</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Configures (or restores) Record Types visibility and Page Layouts for Vlocity XOM</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="configureLayouts" type="button" ng-click="configureLayouts()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="createEpcObjectClassesStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Check OM Plus Environment Status</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Retrieves OM Plus Environment Status Information</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="checkEnvStatus" type="button" ng-click="checkEnvStatus()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="checkEnvStatusStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Synchronize Catalog with OM Plus</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Synchronizes an associated OM Plus instance with OM Plus</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="syncCatalog" type="button" ng-click="syncCatalog()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="createEpcDefaultLayoutsStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isDeltaTrackingEnabled" >\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Delete Sync Delta Objects</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Deletes all Sync Delta Objects</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="cleanupSyncDeltaBtn" type="button" ng-click="cleanupSyncDelta()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="cleanupSyncDeltaMsg" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isDeltaTrackingEnabled" >\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Generate Sync Delta Objects</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Regenerates Sync Delta Objects for the whole catalog</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="forcePopulateSyncDeltaBtn" type="button" ng-if="!isSyncInprogress"\n                                ng-disabled="isSyncPreparing" ng-click="forcePopulateSyncDelta()" class="slds-button  slds-button--brand">Start</button>\n                        <button id="restartPopulateSyncDeltaBtn" type="button" ng-if="isSyncInprogress"\n                                ng-click="restartPopulateSyncDelta()" class="slds-button  slds-button--brand">Restart</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="forcePopulateSyncDeltaMsg" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                        <div ng-if="!hasErrors" class="alert alert-danger" role="alert">{{infoMessage}}</div>\n                    </div>\n                </div>\n                <div ng-if="isSyncDeltaStarted">\n                    <hr/>\n                    <div class="row">\n                        <div id="forcePopulateSyncDeltaProgress" class="slds-grid slds-grid_align-spread slds-p-bottom_x-small">\n                            <div class="slds-progress">\n                                <ol class="slds-progress__list">\n                                    <li ng-class="{\'slds-progress__item\': true, \'slds-is-active\': syncItem.status == \'Active\', \'slds-is-completed\': syncItem.status == \'Completed\'}"\n                                        ng-repeat="syncItem in progressBar.milestones track by syncItem.index">\n                                        <button class="slds-button slds-progress__marker"\n                                                title="Step {{syncItem.index}} - {{syncItem.status}}: {{syncItem.description}}"\n                                                aria-describedby="step-{{syncItem.index}}-tooltip">\n                                            <span class="slds-assistive-text">Step {{syncItem.index}} - {{syncItem.status}}</span>\n                                        </button>\n                                    </li>\n                                </ol>\n                                <div class="slds-progress-bar slds-progress-bar_x-small" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0" role="progressbar">\n                                    <span class="slds-progress-bar__value" ng-style="{\'width\': progressBar.barValue + \'%\' }">\n                                      <span class="slds-assistive-text">Progress: {{progressBar.barValue}}%</span>\n                                    </span>\n                                </div>\n                            </div>\n                        </div>\n                        <div class="demo-only" style="width: 30rem;">\n                            <article class="slds-tile">\n                                \x3c!--<h3 class="slds-tile__title slds-truncate" title="Salesforce UX"><a href="javascript:void(0);">Salesforce UX</a></h3>--\x3e\n                                <div class="slds-tile__detail">\n                                    <dl class="slds-list_horizontal slds-wrap">\n                                        <dt class="slds-item_label slds-text-color_weak slds-truncate" title="Progress Status">Current Step:</dt>\n                                        <dd class="slds-item_detail slds-truncate" title="Progress Status">{{progressBar.stageDescription}}</dd>\n                                        <dt class="slds-item_label slds-text-color_weak slds-truncate" title="Scope">Processed:</dt>\n                                        <dd class="slds-item_detail slds-truncate" title="Scope">{{progressBar.currentValue}} of {{progressBar.totalCount}}</dd>\n                                    </dl>\n                                </div>\n                            </article>\n                        </div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isDeltaTrackingEnabled" >\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Generate Global Keys</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Ensures that all Catalog objects have Global Key set</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="genGlobalKeysBtn" type="button" ng-click="ensureGlobalKeys()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="genGlobalKeysMsg" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled" >\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Create Vlocity DataRaptor Bundles for OM Plus sync</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Creates or (fully re-creates) Vlocity DataRaptor Bundler for OM Plus sync</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="forcePopulateSyncDelta" type="button" ng-click="createDataRaptorBundlesForBackSync()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="deleteEpcDefaultLayoutsStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isDevEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Download sync deltas</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Downloads last 200 sync deltas as a file</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="downloadSyncDetas" type="button" ng-click="downloadSyncDeltas()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="deleteEpcDefaultLayoutsStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Synchronize I18n labels and Refresh Cache</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Downloads all labels from OM Plus and sync them to SFDC</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="syncLabels" type="button" ng-click="syncLabels()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="deleteEpcDefaultLayoutsStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Update Orchestration Queues Counters</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Updates number of active Orchestration Items against Orchestration Queues</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="updateOrchQueuesCount" type="button" ng-click="updateOrchQueuesCnt()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="updateOrchQueuesCountStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            \x3c!--<div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Refresh I18n cache</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Refreshes Custom Labels cache</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="syncLabels" type="button" ng-click="refreshLabelsCache()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="deleteEpcDefaultLayoutsStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>--\x3e\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Manage Encryption Keys</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Navigate to Manage Encryption Keys Page</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="openEncryptionKeysPage" type="button" ng-click="openEncryptionKeysPage()" class="slds-button  slds-button--brand">Open</button>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Manage Secrets</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Navigate to Manage Secrets Page</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="openManageSecretsPage" type="button" ng-click="openManageSecretsPage()" class="slds-button  slds-button--brand">Open</button>\n                    </div>\n                </div>\n            </div>\n\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="!isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Schedule Integration Retry Job</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Start or stop Integration Retry Job. Job is run every minute and processes up to 100 failed items on each run. Interval, scope and batchsize are changed in XOMSetup custom settings (OrchestrationRetryJobIntervalMins, OrchestrationRetryJobScope, OrchestrationRetryJobBatchSize)</div>\n                    </div>\n                    <div class="job-start slds-float--right" ng-if="!isRetryJobScheduled">\n                        <button id="startRetryJobs" type="button" ng-click="startRetryJob()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                    <div class="job-start slds-float--right" ng-if="isRetryJobScheduled">\n                        <button id="stopRetryJobs" type="button" ng-click="stopRetryJob()" class="slds-button  slds-button--brand">Stop</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="retryJobStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n\n\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">OM Plus DB Query Runner</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Navigate to OM Plus DB Query Runner Page</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="openXOMOmplDBQueryPage" type="button" ng-click="openXOMOmplDBQueryPage()" class="slds-button  slds-button--brand">Open</button>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="!isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Schedule Jeopardy Management Job</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Schedule Jeopardy Management Job using SchedulerJobTimeIntervalMins defined in XOMSetup custom settings</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="scheduleJmJobs" type="button" ng-click="scheduleJeopardyManagementJobs()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="jmJobSchedulingStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            \x3c!-- Orch Future dated order --\x3e\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="!isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Schedule Future-Dated Tasks Job</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Schedule the job using OrchFutureDatedIntervalMins defined in XOMSetup custom settings</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="scheduleFDJobs" type="button" ng-click="scheduleOrchFutureDatedJobs()"\n                                class="slds-button  slds-button--brand">Start</button>\n                        <button id="stopFDJobs" type="button" ng-click="abortOrchFutureDatedJobs()"\n                                class="slds-button slds-button--brand">Stop Jobs</button>\n                    </div>\n\n                </div>\n                <div class="row">\n                    <div id="fdJobSchedulingStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            \x3c!-- ----------------------- --\x3e\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="!isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Schedule Orchestration Recovery Job</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Schedule Orchestration Recovery Job to execute periodically\n                            (period is defined in XOMSetup custom settings as OrchestrationRecoveryWaitPeriodMins)</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="scheduleOmRecoveryJobs" type="button" ng-click="scheduleOrchestrationRecoveryJobs()" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="omJobSchedulingStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="!isThorEnabled">\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Orchestration Data Purge Job</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small"> Orchestration Data Purge Job Management</div>\n                    </div>\n                    \x3c!-- TODO: Add warning with data purge job description and a confirmation dialog--\x3e\n                    <div class="job-start slds-float--right">\n                        <button id="scheduleOmDataPurgeJobs" type="button" ng-click="scheduleDataPurgeJobs()"\n                                class="slds-button slds-button--brand">Schedule</button>\n                        <button id="stopOmDataPurgeJobs" type="button" ng-click="stopDataPurgeJobs()"\n                                class="slds-button slds-button--brand">Stop Jobs</button>\n                        <button ng-if="isDPInfoHidden" id="ViewOmDataPurgeJobsProgress" type="button" ng-click="viewDataPurgeJobProgress()"\n                                class="slds-button slds-button--brand" aria-controls="dp-info-id">Show Status\n                        </button>\n                        <button ng-if="!isDPInfoHidden" id="HideOmDataPurgeJobsProgress" type="button" ng-click="viewDataPurgeJobProgress()"\n                                class="slds-button slds-button--brand" aria-controls="dp-info-id">Hide Status\n                        </button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="scheduleOmDataPurgeStatus" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n\n                <div ng-if="!isDPInfoHidden" class="demo-only" style="width:30rem">\n                    <article class="slds-tile slds-media">\n                        <div class="slds-media__figure">\n                            <span class="slds-icon_container" title="Data Purge Job Status">\n                                <svg class="slds-icon slds-icon-text-default" aria-hidden="true">\n                                    <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#info"></use>\n                                </svg>\n                            </span>\n                        </div>\n                        <div class="slds-media__body">\n                            <h3 class="slds-tile__title slds-truncate" title="Process Status">\n                                \x3c!--TODO: Url to XOMParameters--\x3e\n                                <a href="javascript:void(0);">Process Status</a>\n                            </h3>\n                                <dl class="slds-dl_horizontal">\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="Job Status">Job Status:</dt>\n                                    <dd ng-class="{\'slds-dl_horizontal__detail\': true, \'slds-text-color_error\': dataPurgeStatus.jobStatus == \'Not Scheduled\'}" title="Current Job Status"> {{ dataPurgeStatus.jobStatus }} </dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="Last Job Status">Last Job Status:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Progress Status">{{ dataPurgeStatus.lastJobStatus }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="JobStarted">Started at:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Job Started At">{{ dataPurgeStatus.startedAt }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="JobFinished">Finished at:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Job Finished At">{{ dataPurgeStatus.finishedAt }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="NextRunAt">Next Run At:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Next Run Time">{{ dataPurgeStatus.nextRunAt }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="item1">Records Deleted By Type:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Last Run Stats per Object Type">\n                                        <ul>\n                                            <li class="slds-item" ng-repeat="scopeItem in dataPurgeConfigData.scope">{{ scopeItem }} {{ dataPurgeStatus.progress[scopeItem] }}</li>\n                                        </ul>\n                                    </dd>\n                                </dl>\n                        </div>\n                    </article>\n\n                    <article class="slds-tile slds-media">\n                        <div class="slds-media__figure">\n                            <span class="slds-icon_container" title="Data Purge Custom Settings > XOMSetup">\n                                <svg class="slds-icon slds-icon-text-default" aria-hidden="true">\n                                    <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#settings"></use>\n                                </svg>\n                            </span>\n                        </div>\n                        <div class="slds-media__body">\n                            <h3 class="slds-tile__title slds-truncate" title="Settings">\n                                \x3c!--TODO: Url to XOMSetup--\x3e\n                                <a href="javascript:void(0);">Settings</a>\n                            </h3>\n                            <div class="slds-tile__detail">\n                                <dl class="slds-dl_horizontal slds-wrap">\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="Objects Scope">Objects Scope:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Objects Scope Values">\n                                        <ul>\n                                            <li class="slds-item" ng-repeat="scopeItem in dataPurgeConfigData.scope">{{ scopeItem }}</li>\n                                        </ul>\n                                    </dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="Age">Age Days:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="Age Description">{{ dataPurgeConfigData.ageDays }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="ActivatedtatusFilterEnabled">Remove Activated Only?:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="ActivatedStatusFilterEnabledValue">{{ dataPurgeConfigData.isStatusFilterEnabled }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="JobFrequency">Job Frequency Hours:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="JobFrequency Description">{{ dataPurgeConfigData.jobFrequencyHours }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="Runtime">Maximum Process Run Time Mins:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="RuntimeValue">{{ dataPurgeConfigData.maxProcessRunTimeMins }}</dd>\n                                    <dt class="slds-dl_horizontal__label slds-text-color_weak" title="BatchSize">Batch Size:</dt>\n                                    <dd class="slds-dl_horizontal__detail" title="BatchSizeValue">{{ dataPurgeConfigData.batchSize  }}</dd>\n                                </dl>\n                            </div>\n                        </div>\n                    </article>\n                </div>\n            </div>\n\n            <div class="job-section slds-m-top--x-small slds-has-divider--bottom" ng-if="isThorEnabled && isDeltaTrackingEnabled">\n                <div ng-if="cleanAttrOverridesStatus.started">\n                    <hr/>\n                    <div class="row">\n                        <div id="forcePopulateSyncDeltaProgress" class="slds-grid slds-grid_align-spread slds-p-bottom_x-small">\n                            <div class="slds-progress">\n                                <ol class="slds-progress__list">\n                                    <li ng-class="{\'slds-progress__item\': true, \'slds-is-active\': $index == cleanAttrOverridesStatus.stageIdx, \'slds-is-completed\': $index < cleanAttrOverridesStatus.stageIdx}"\n                                        ng-repeat="stage in cleanAttrOverridesStages track by stage">\n                                        <button class="slds-button slds-progress__marker"\n                                                title={{stage}}>\n\x3c!--                                            <span class="slds-assistive-text">Step {{$index}} - Done!</span>--\x3e\n                                        </button>\n                                    </li>\n                                </ol>\n                                <div class="slds-progress-bar slds-progress-bar_x-small" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0" role="progressbar">\n                                            <span class="slds-progress-bar__value" ng-style="{\'width\': \'\' + cleanAttrOverridesStatus.progress + \'%\' }">\n                                              <span class="slds-assistive-text">Progress: {{cleanAttrOverridesStatus.progress}}%</span>\n                                            </span>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n                </div>\n                <div class="job-content slds-clearfix">\n                    <div class="job-detail slds-float--left">\n                        <div class="job-label">\n                            <a href="javascript:void(0)">Clean Attribute Overrides from OM Plus</a>\n                        </div>\n                        <div class="job-desc slds-m-top--x-small">Generates delete Sync Delta Objects to remove unnecessary Override Attribute Assignments from OM Plus</div>\n                    </div>\n                    <div class="job-start slds-float--right">\n                        <button id="cleanAttrOverrides" type="button" ng-click="cleanAttrOverrides()" ng-disabled="cleanAttrOverridesStatus.started" class="slds-button  slds-button--brand">Start</button>\n                    </div>\n                </div>\n                <div class="row">\n                    <div id="omCleanAttrBindings" class="col-md-12 col-sm-12 col-xs-12">\n                        <div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n</div>\n<div class="slds-spinner_container" ng-show="showSpinner">\n    <div class="slds-spinner--brand slds-spinner slds-spinner--large" aria-hidden="false" role="alert">\n        <div class="slds-spinner__dot-a"></div>\n        <div class="slds-spinner__dot-b"></div>\n    </div>\n</div>'),$templateCache.put("XOMConfigureLayouts.tpl.html",'<div class="_slds-align--absolute-center">\n    <div class="slds-panel">\n        <form class="slds-form--compound">\n            <div class="slds-panel__section slds-has-divider--bottom">\n                <div class="slds-form-element__row">\n                    <div class="slds-form-element slds-size--1-of-1 slds-clearfix">\n                        <button class="slds-button slds-button--brand slds-float--right"\n                                ng-disabled="readOnly" ng-click="cancel()">Cancel</button>\n                        <button class="slds-button slds-button--brand slds-float--right slds-m-right--medium"\n                                ng-disabled="readOnly" ng-click="save()">Update</button>\n                    </div>\n\n                </div>\n            </div>\n            <div style="height: 4rem;" ng-show="showMsg">\n                <div class="slds-notify_container slds-is-relative">\n                    <div class="slds-notify slds-notify_toast slds-theme_{{outcome}}" role="alert">\n                        <span class="slds-assistive-text">{{outcome}}</span>\n                        <span class="slds-icon_container slds-icon-utility-{{outcome}} slds-m-right_small slds-no-flex slds-align-top">\n                            <svg ng-if="outcome == \'success\'"class="slds-icon slds-icon_small" aria-hidden="true">\n                                <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#success" />\n                            </svg>\n                            <svg ng-if="outcome == \'error\'"class="slds-icon slds-icon_small" aria-hidden="true">\n                                <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#error" />\n                            </svg>\n                        </span>\n                        <div class="slds-notify__content">\n                            <h2 class="slds-text-heading_small ">{{Message}}.</h2>\n                        </div>\n                        <button class="slds-button slds-button_icon slds-notify__close slds-button_icon-inverse" title="Close" ng-click="closeMsg()">\n                            <svg class="slds-button__icon slds-button__icon_large" aria-hidden="true">\n                                <use xlink:href="/_slds/icons/utility-sprite/svg/symbols.svg#close" />\n                            </svg>\n                            <span class="slds-assistive-text">Close</span>\n                        </button>\n                    </div>\n                </div>\n            </div>\n            <div class="slds-panel__section slds-has-divider--bottom">\n                <h3 class="slds-text-heading--small slds-m-bottom--medium">Profiles Assignments</h3>\n                <div class="slds-form-element__row" ng-repeat="profileChunk in profiles">\n                    <div class="slds-form-element slds-size--1-of-3" ng-repeat="profile in profileChunk track by profile.Id">\n                        <div class="slds-form-element slds-lookup slds-is-open">\n                            <label class="slds-form-element__label" ng-bind="profile.Name"></label>\n                            <div class="slds-form-element__control">\n                                <div class="slds-select_container">\n                                    <select class="slds-select"\n                                            ng-model="profile.xom"\n                                            ng-options="item for item in profileOptions">\n                                    </select>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n\n        </form>\n    </div>\n</div>\n<div class="slds-spinner_container" ng-show="showSpinner">\n    <div class="slds-spinner--brand slds-spinner slds-spinner--large" aria-hidden="false" role="alert">\n        <span class="slds-assistive-text">Deploying layouts</span>\n        <div class="slds-spinner__dot-a"></div>\n        <div class="slds-spinner__dot-b"></div>\n    </div>\n</div>')}]);

},{}]},{},[1]);
})();
