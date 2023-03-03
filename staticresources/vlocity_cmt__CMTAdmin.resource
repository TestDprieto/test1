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
var app = angular.module('CMTAdmin', ['vlocity', 'sldsangular', 'fieldLookupUI', 'ngSanitize', 'ngAnimate']);
app.config(['remoteActionsProvider', function(remoteActionsProvider) {
    remoteActionsProvider.setRemoteActions(window.remoteActions || {});
}]);
app.config(['$locationProvider', function($locationProvider) {
    $locationProvider.html5Mode(true);
}]);

require('./modules/CMTAdmin/controller/CMTAdminController.js');
require('./modules/CMTAdmin/controller/AdminConsoleController.js');
require('./modules/CMTAdmin/controller/CustomSettingsController.js');
require('./modules/CMTAdmin/controller/EnableFeaturesController.js');
require('./modules/CMTAdmin/directive/BatchJob.js');
require('./modules/CMTAdmin/factory/BasicFactory.js');
require('./modules/CMTAdmin/factory/BasicService.js');
require('./modules/CMTAdmin/templates/templates.js');

},{"./modules/CMTAdmin/controller/AdminConsoleController.js":2,"./modules/CMTAdmin/controller/CMTAdminController.js":3,"./modules/CMTAdmin/controller/CustomSettingsController.js":4,"./modules/CMTAdmin/controller/EnableFeaturesController.js":5,"./modules/CMTAdmin/directive/BatchJob.js":6,"./modules/CMTAdmin/factory/BasicFactory.js":7,"./modules/CMTAdmin/factory/BasicService.js":8,"./modules/CMTAdmin/templates/templates.js":9}],2:[function(require,module,exports){
var app = angular.module('CMTAdmin');
app.controller('AdminConsoleController', ['$scope', '$rootScope', '$window', '$timeout', '$sldsModal', 'BasicService', 'remoteActions', '$window', 'ActiveMenu', '$sldsToast',
	function (scope, rootScope, window, timeout, modal, basicService, remoteActions, window, activeMenu, sldsToast) {
		scope.asyncApexJobFieldsLabels = window.asyncApexJobFieldsLabels;
		rootScope.asyncApexJobFieldsLabels = window.asyncApexJobFieldsLabels;
		scope.labels = window.labels;
		rootScope.labels = window.labels;
		scope.configData = window.configData;
		rootScope.configData = window.configData;
		scope.module = {};
		scope.activeMenu = 0;
		scope.rootAccountJobsList = [];
        scope.translationJobsList = [];
		scope.XLIBatchJobValidationList = [];
		scope.refreshPriceBookJobList = [];
		scope.upgradeTab = {};
		scope.upgradeTab.attributesBindingObjects = null;
		scope.upgradeTab.upgradableObjectFilterList = [];
		scope.upgradeTab.createRelationshipHeaderFiltersList = [];
		scope.upgradeTab.productFilterList = [];
        scope.configResult = {};
        scope.translationCacheJobsList = {};
		scope.cacheableAPIJobsList = [];
		scope.cacheMigrationJobsList = [];
		scope.regenerateCacheAPIRecordsJobsList = [];
		scope.jobWrapper = {};
		scope.populateRequestedStartDatesJobsList = [];
		scope.populateMissingActionFieldInXLIsJobsList = [];

		scope.jobType = {
			rootPCIJob: {
				label: labels.RootPCIUpgrade,
				desc: labels.RootPCIUpgradeDesc,
				methodName: 'startRootProductChildItemJob',
				listName: 'rootProductChildItemJobs'
			},
			sellingDatesJob: {
				label: labels.PopulateSellingPeriodDates,
				desc: labels.PopulateSellingPeriodDesc,
				methodName: 'startPopulateSellingPeriodDatesJob',
				listName: 'populateSellingPeriodDatesJobs'
			},
			requestedStartDatesJob: {
				label: labels.PopulateRequestedStartDates,
				desc: labels.PopulateRequestedStartDatesDesc,
				methodName: 'startPopulateRequestedStartDatesJobs',
				listName: 'populateRequestedStartDatesJobs'
			},
			updateGlobalKeyPathJob: {
				label: labels.CMTAdminPopulateGlobalKeyPathJob,
				desc: labels.CMTAdminPopulateGlobalKeyPathJobDesc,
				methodName: 'startPopulateGKPathJobs',
				listName: 'populateGKPathJobs'
			},
			updateEncryptAttrJob: {
				label: labels.CMTAdminUpdateEncryptAttrJob,
				desc: labels.CMTAdminUpdateEncryptAttrJobDesc,
				methodName: 'startUpdateEncryptAttrJob',
				listName: 'updateEncryptAttrJobs'
			},
			actionUpgradeJob: {
				label: labels.PopulateMissingActionInXLIs,
				desc: labels.PopulateMissingActionInXLIsDesc,
				methodName: 'populateMissingActionFieldInXLIs',
				listName: 'populateMissingActionFieldInXLIsJobs'
			},
			catalogCodeUpgradeJob: {
				label: labels.PopulateCatalogCode,
				desc: labels.PopulateCatalogCodeDesc,
				methodName: 'startPopulateCatalogCodeBatchJob',
				listName: 'populateCatalogCodeBatchJobs'
			},
			workSetUpgradeJob: {
				label: labels.WorkSetItemUpgradeLabel,
				desc: labels.WorkSetItemUpgradeDesc,
				methodName: 'startWorkSetItemUpgradeBatchJob',
				listName: 'workSetItemUpgradeBatchJobs',
				additionalInput: {}
			},
			globalGroupKeyPathJob: {
				label: labels.PopulateProductHierarchyGroupKeyPathJob,
				desc: labels.PopulateProductHierarchyGroupKeyPathJobDesc,
				methodName: 'startPopulateProdHierarchyGrpKeyPathJob',
				listName: 'PopulateProdHierarchyGrpKeyPathJobs'
			},
			versionFieldsJob: {
				label: labels.PopulateNewFieldsJob,
				desc: labels.PopulateNewFieldsJobDesc,
				methodName: 'startVersioningUpgradeBatchJob',
				listName: 'VersioningUpgradeBatchJobs',
				additionalInput: {},
				additionalData: {}
			},
			relationshipJob: {
				label: labels.CreateRelationshipRecords,
				desc: labels.CreateRelationshipRecordsDesc,
				methodName: 'startCreateRelationshipRecords',
				listName: 'createRelationshipRecordsJobs',
				additionalInput: {},
				additionalData: {}
			},
			prodAttrJob: {
				label: labels.ProductAttributesConversion,
				desc: labels.ProductAttributesConversionDesc,
				methodName: 'startConvertProductJSONToV2',
				listName: 'convertProductJSONToV2Jobs',
				additionalInput: {},
				additionalData: {}
			},
			lineAttrJob: {
				label: labels.LineItemAttributesConversion,
				desc: labels.LineItemAttributesConversionDesc,
				methodName: 'startConvertXliJSONToV2',
				listName: 'convertXliJSONToV2Jobs',
				additionalInput: {},
				additionalData: {}
			},
			multiServiceUpgradeJob: {
				label: labels.MutiServiceUpgradeLabel,
				desc: labels.MutiServiceUpgradeDesc,
				methodName: 'startMultiServiceUpgrade',
				listName: 'multiServiceUpgradeJobs'
			},
			pricingFieldJob: {
				label: labels.UpgradePricingFieldsLabel,
				desc: labels.UpgradePricingFieldsDesc,
				methodName: 'startUpgradePricingFieldJob',
				listName: 'upgradePricingFieldJobs',
				additionalInput: {},
				additionalData: {
					objectList: [
						{
							id: 'opportunity',
							label: 'Opportunity'
						},
						{
							id: 'quote',
							label: 'Quote'
						},
						{
							id: 'order',
							label: 'Order'
						}
					]
				}
			}
		}

		scope.initApp = function(name, label) {
			scope.module.name = name;
			scope.module.label = label;
			scope.$parent.spinner.showSpinner();
			scope.refreshBatchJobLists();
			scope.$parent.spinner.hideSpinner();
			scope.initializeJobWrapper();
			scope.getUpgradeData();
		};

        scope.getUpgradeData = function() {
            var parameters = {};
            parameters.methodName = "getUpgradeData";
            var remoteOptions = {};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters = JSON.stringify(parameters);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				var prodAttrData = scope.jobType.prodAttrJob.additionalData;
				var prodAttrInput = scope.jobType.prodAttrJob.additionalInput;
				prodAttrData.productFieldsList = result.productFieldsList;
				prodAttrData.queryFiltersOperatorsMap = result.queryFiltersOperatorsMap;
				prodAttrData.productFilterList = [];
				prodAttrData.productFilterList.push({});

				prodAttrData.buildRelQuery = function() {
					prodAttrInput.productFiltersListString = buildQuery(prodAttrData.productFilterList);
				}

				var lineAttrData = scope.jobType.lineAttrJob.additionalData;
				var lineAttrInput = scope.jobType.lineAttrJob.additionalInput;
				lineAttrData.upgradableObjectNamesMap = result.upgradableObjectNamesMap;
				lineAttrData.upgradableObjectsFieldsMap = result.upgradableObjectsFieldsMap;
				lineAttrData.queryFiltersOperatorsMap = result.queryFiltersOperatorsMap;
				lineAttrData.upgradableObjectFilterList = [];
				lineAttrData.upgradableObjectFilterList.push({});

				lineAttrData.buildRelQuery = function() {
					lineAttrInput.xliFiltersListString = buildQuery(lineAttrData.upgradableObjectFilterList);
				}

				lineAttrData.resetFilterList = function() {
					lineAttrData.upgradableObjectFilterList = [];
					lineAttrData.upgradableObjectFilterList.push({});
					lineAttrInput.xliFiltersListString = "";
				}
				
				var relJobData = scope.jobType.relationshipJob.additionalData;
				var relJobInput = scope.jobType.relationshipJob.additionalInput;
                relJobData.orderFieldsList = result.orderFieldsList;
                relJobData.queryFiltersOperatorsMap = result.queryFiltersOperatorsMap;
				relJobData.createRelationshipHeaderFiltersList = [];
				relJobData.createRelationshipHeaderFiltersList.push({});

				relJobData.buildRelQuery = function() {
					relJobInput.createRelationshipHeaderFiltersListString = buildQuery(relJobData.createRelationshipHeaderFiltersList);;
				}

				//version upgrade job
				var versionData = scope.jobType.versionFieldsJob.additionalData;
				versionData.upgradableVersionObjectNamesMap = result.upgradableVersionObjectNamesMap;
				versionData.lifecycleStatusMap = result.lifecycleStatusMap;
				versionData.versionObjectFilterList = {};
				versionData.upgradableVersionObjectsFieldsMap = result.upgradableVersionObjectsFieldsMap;
            });
		}

		function buildQuery(filterList) {
			var filterStringOuput = "";
			if(!filterList)
			{
				return;
			}
			var fList = [];
			for(var i=0;i< filterList.length; i++)
			{
				if(!filterList[i].fieldName
						|| !filterList[i].operator
						|| !filterList[i].value )
				{
					break;
				}
				var filterString = "";
				filterString += filterList[i].fieldName + ' ';
				var operatorString = filterList[i].operator;
				operatorString = operatorString.replace("[0]", filterList[i].value);
				filterString += operatorString;
				fList.push(filterString);
			}
			filterStringOuput = fList.join(" AND ");
			return filterStringOuput;
		}

		scope.resetVersionFilterList = function() {
            scope.upgradeTab.versionObjectFilterList = [];
            scope.upgradeTab.versionObjectFilterList.push({});
            scope.upgradeTab.objectFiltersListString = "";
        }

        scope.buildVersionQueryFilter = function(filtersListInput, checkObjectName) {
            var filterStringOuput = "";
            if(!filtersListInput)
            {
                return;
            }
            var filtersList = [];
            for(var i=0;i< filtersListInput.length; i++)
            {
                if((checkObjectName && !scope.upgradeTab.objectString)
                    || !filtersListInput[i].fieldName
                    || !filtersListInput[i].operator
                    || !filtersListInput[i].value )
                {
                    break;
                }
                var filterString = "";
                filterString += filtersListInput[i].fieldName + ' ';
                var operatorString = filtersListInput[i].operator;
                operatorString = operatorString.replace("[0]", filtersListInput[i].value);
                filterString += operatorString;
                filtersList.push(filterString);
            }
            filterStringOuput = filtersList.join(" AND ");
            return filterStringOuput;
        }

		scope.loadAPIMetadataCAJob = function() {
			var parameters = {};
            parameters.methodName = "loadAPIMetadataCAJob";
            var remoteOptions = {};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters = JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.LoadAPIMetadataCAJob, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.LoadAPIMetadataCAJob, result.errorMessage);
                } else {
                    basicService.successToast(labels.LoadAPIMetadataCAJob, labels.SuccessfullyCompletedLabel);
                }
            }, function(error) {
                toast.hide();
                basicService.errorToast(labels.LoadAPIMetadataCAJob, labels.CouldntStartLabel);
            });
		};

		scope.showCAJobListPopup = function(jobType) {
			var parameters = {};
            parameters.methodName =  "getCAJobList";
            var remoteOptions = {};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters = JSON.stringify(parameters);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                if(result.hasErrors) {
                    basicService.errorToast(labels.PopulateCacheCAJob, result.errorMessage);
                } else {
                    var modalScope = scope.$new();
					modalScope.confirmActionLbl = scope.labels.OKLabel;
		            modalScope.confirmationTitle = scope.labels.PopulateCacheCAJob;
		            modalScope.cancelActionLbl = scope.labels.CancelLabel;
		            modalScope.SLDSICON = scope.SLDSICON;
		            modalScope.caJobList = [];
                    modalScope.allSelected = false;
                    modalScope.okBtnDisabled = true;
                    modalScope.currentStartTime = result.effectiveStartTime;
                    modalScope.effectiveStartTime = {'value': result.effectiveStartTime};
					modalScope.expirationTime = {'value': result.expirationTime};
					modalScope.filters = result.filters;
                    modalScope.effectiveStartTimeLbl = scope.labels.EffectiveStartDate;
                    modalScope.expirationTimeLbl = scope.labels.ExpirationDate;
                    modalScope.columnTitles = [scope.labels.Name,scope.labels.LastEffectiveStartDate,scope.labels.LastExpirationDate,scope.labels.LastCachedDate];
		            for (var i = 0; i < result.caJobInfo.length; i++)
		            {
		            	var caJob = {};
		            	caJob['JobId'] = i;
		            	caJob['Name'] = result.caJobInfo[i]['Name'];
                        caJob['LastEffectiveStartTime'] = result.caJobInfo[i]['LastEffectiveStartTime'];
                        caJob['LastExpirationTime'] = result.caJobInfo[i]['LastExpirationTime'];
                        caJob['LastCachedTime'] = result.caJobInfo[i]['LastCachedTime'];
		            	caJob['Selected'] = false;
		            	modalScope.caJobList[i] = caJob;
		            }
		            modalScope.confirmAction = function() {
		            	var selectedList = [];
		            	for (var i = 0; i < modalScope.caJobList.length; i++)
		            	{
			                if (modalScope.caJobList[i].Selected) {
			                    selectedList.push(modalScope.caJobList[i].Name);
			                }
						}
						var appliedFilters = {};
						for (var i = 0; i < modalScope.filters.length; i++)
		            	{
							if(modalScope.filters[i].SelectedAll === false)
							{
								var appliedFilter = [];
								appliedFilters[modalScope.filters[i].Name] = appliedFilter;
								for (var j = 0; j < modalScope.filters[i].Options.length; j++)
								{
									if(modalScope.filters[i].Options[j].Selected)
									{
										appliedFilter.push(modalScope.filters[i].Options[j].Value);
									}
								}
							}
						}
		            	confirmModal.hide();

		            	scope.populateCacheCAJob(selectedList, modalScope.effectiveStartTime.value, modalScope.expirationTime.value, appliedFilters);
					};
					
                    modalScope.selectAll = function(value) {
                        for (var i = 0; i < modalScope.caJobList.length; i++) {
                            modalScope.caJobList[i].Selected = value;
						}
						
						modalScope.okBtnDisabled = (!modalScope.processCacheableJobConfirmation());                        
					};

					modalScope.selectFilters = function(filter, filterOption, value, forAll) {
						if(forAll === true)
						{
							for(var i = 0; i < filter.Options.length; i++) {
								filter.Options[i].Selected = value;
							}
						}
						else
						{
							filterOption.Selected = value;
						}
						modalScope.okBtnDisabled = (!modalScope.processCacheableJobConfirmation());
					};

					modalScope.processCacheableJobConfirmation = function() {
						enableForFilters = false;
						for (var i = 0; i < modalScope.filters.length; i++)
						{
							if(modalScope.filters[i].SelectedAll === false)
							{
								for (var j = 0; j < modalScope.filters[i].Options.length; j++)
								{
									if(modalScope.filters[i].Options[j].Selected)
									{
										enableForFilters = true;
										break;
									}
								}
							}
							else if(modalScope.filters[i].SelectedAll)
							{
								enableForFilters = true;
							}
						}
			
						var enableForJobList = false;
						
						for (var i = 0; i < modalScope.caJobList.length; i++)
                        {
                            if (modalScope.caJobList[i].Selected)
                            {
                                enableForJobList = true;
                                break;
                            }
                        }

						if (enableForJobList == true && enableForFilters == true) {
							return true;
						} else {
							return false;
						} 
					}

                    modalScope.validateCheck = function() {
                        var foundOne = modalScope.processCacheableJobConfirmation();
                        
                        if (modalScope.effectiveStartTime.value && !isNaN(modalScope.effectiveStartTime.value) &&
                            modalScope.expirationTime.value && !isNaN(modalScope.expirationTime.value) && foundOne) {
                            if (modalScope.effectiveStartTime.value < modalScope.currentStartTime ||
                                modalScope.expirationTime.value < modalScope.currentStartTime ||
                                modalScope.expirationTime.value <= modalScope.effectiveStartTime.value) {
                                modalScope.okBtnDisabled = true;
                            } else {
                                modalScope.okBtnDisabled = false;
                            }
                        } else {
                            modalScope.okBtnDisabled = true;
                        }
                    };
		            var confirmModal = modal({
		                templateUrl: 'CAJobListModal.tpl.html',
		                backdrop: 'static',
		                scope: modalScope,
		                show: true
		            });
                }
            }, function(error) {

            });
	}


		scope.deleteQuasiRecordsPopup = function(jobType) {
			var modalScope = scope.$new();
			var yesterday = new Date(new Date().getTime() - (24 * 60 * 60 * 1000));

			modalScope.creationTimeLbl = scope.labels.QuasiEntriesCreationTimeDeletion;
			modalScope.recordsCreationDateTime = scope.labels.RecordsCreationDateTime;
			modalScope.expirationTime = {'value': yesterday.getTime() };
			modalScope.currentStartTime = Date.now();
			modalScope.okBtnDisabled = false;
			modalScope.cancelActionLbl = scope.labels.CancelLabel;
			modalScope.confirmActionLbl = scope.labels.OKLabel;

			var confirmModal = modal({
                templateUrl: 'QuasiRecordsModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
			
			modalScope.confirmAction = function() {
				confirmModal.hide();
				scope.deleteQuasiRecordsResponse(null, null, modalScope.expirationTime.value);
			};
			
			modalScope.validateCheck = function() {
				if (modalScope.expirationTime.value && !isNaN(modalScope.expirationTime.value)) {
					if (modalScope.expirationTime.value > modalScope.currentStartTime) {
						modalScope.okBtnDisabled = true;
					} else {
						modalScope.okBtnDisabled = false;
					}
				} else {
					modalScope.okBtnDisabled = true;
				}
			};
		}
		scope.regenerateCacheAPIRecordsJobDataProcessing = function (result)
			{
				var regenerateCacheAPIRecordsJobsListCat= {};
				let nonCompletedStates = new Set(['Processing', 'Holding', 'Queued', 'Preparing']);
				if(result.regenerateCacheAPIRecordsJobs.length > 0) {
					var count = 0;
					regenerateCacheAPIRecordsJobsListCat[count] = {};
					if(result.regenerateCacheAPIRecordsJobs.length > 0) {
						let failedRecords = 0;
						result.regenerateCacheAPIRecordsJobs.forEach(function(record,index){
							let jobName = null;
							if(typeof record != "undefined" && typeof record.ApexClass != "undefined" ) {
								jobName = record.ApexClass.Name;
								if(record.ApexClass.Name == "DeriveCMAggregateEntityBatch" && (result.regenerateCacheAPIRecordsJobs.length >(index+1))){
									regenerateCacheAPIRecordsJobsListCat[count][jobName] = record;
									regenerateCacheAPIRecordsJobsListCat[count][jobName].jobData = [];
									regenerateCacheAPIRecordsJobsListCat[count][jobName].jobData[record.Id] = record.status;
									count++;
									regenerateCacheAPIRecordsJobsListCat[count] = {};
									return ;
								}
								if(typeof  regenerateCacheAPIRecordsJobsListCat[count][jobName] != "undefined") {
									if(regenerateCacheAPIRecordsJobsListCat[count][jobName].JobItemsProcessed != "undefined" && record.JobItemsProcessed) {
										regenerateCacheAPIRecordsJobsListCat[count][jobName].JobItemsProcessed = regenerateCacheAPIRecordsJobsListCat[count][jobName].JobItemsProcessed +record.JobItemsProcessed;
									}
									if(regenerateCacheAPIRecordsJobsListCat[count][jobName].NumberOfErrors != "undefined" && record.NumberOfErrors) {
										regenerateCacheAPIRecordsJobsListCat[count][jobName].NumberOfErrors = regenerateCacheAPIRecordsJobsListCat[count][jobName].NumberOfErrors +record.NumberOfErrors;
									}
									if(regenerateCacheAPIRecordsJobsListCat[count][jobName].TotalJobItems != "undefined" && record.TotalJobItems) {
										regenerateCacheAPIRecordsJobsListCat[count][jobName].TotalJobItems = regenerateCacheAPIRecordsJobsListCat[count][jobName].TotalJobItems +record.TotalJobItems;
									}
									if(regenerateCacheAPIRecordsJobsListCat[count][jobName].CreatedDate != "undefined" && record.CreatedDate) {
										if(regenerateCacheAPIRecordsJobsListCat[count][jobName].CreatedDate > record.CreatedDate) {
											regenerateCacheAPIRecordsJobsListCat[count][jobName].CreatedDate = record.CreatedDate; 
										}
									}
									if(regenerateCacheAPIRecordsJobsListCat[count][jobName].CompletedDate != "undefined" && record.CompletedDate) {
										if(regenerateCacheAPIRecordsJobsListCat[count][jobName].CompletedDate < record.CompletedDate) {
											regenerateCacheAPIRecordsJobsListCat[count][jobName].CompletedDate = record.CompletedDate; 
										}
									}

									if(record.status == 'Failed'){
										failedRecords += 1;
									}

									if (regenerateCacheAPIRecordsJobsListCat[count][jobName].Status == null)
									{
										regenerateCacheAPIRecordsJobsListCat[count][jobName].Status = 'Completed';
									}
									else
									{
										if (nonCompletedStates.has(record.Status))
										{
											regenerateCacheAPIRecordsJobsListCat[count][jobName].Status = 'Processing';
										}
									}

									if(typeof record.ExtendedStatus != "undefined" && record.ExtendedStatus != null) {
										if(typeof regenerateCacheAPIRecordsJobsListCat[count][jobName].ExtendedStatus != "undefined" && regenerateCacheAPIRecordsJobsListCat[count][jobName].ExtendedStatus != null) {
											regenerateCacheAPIRecordsJobsListCat[count][jobName].ExtendedStatus = regenerateCacheAPIRecordsJobsListCat[count][jobName].ExtendedStatu +" "+ record.ExtendedStatus;
										}
										regenerateCacheAPIRecordsJobsListCat[count][jobName].ExtendedStatus=record.ExtendedStatus;
									}

								} else {
									regenerateCacheAPIRecordsJobsListCat[count][jobName] = record;
									regenerateCacheAPIRecordsJobsListCat[count][jobName].jobData = [];
									regenerateCacheAPIRecordsJobsListCat[count][jobName].jobData[record.Id] = record.status;
								}
								// if(Object.keys(regenerateCacheAPIRecordsJobsListCat[count]).length === 0 && regenerateCacheAPIRecordsJobsListCat[count].constructor === Object ) {
								// 	regenerateCacheAPIRecordsJobsListCat.splice(count, 1);
								// }
								
							}
						});
						if(failedRecords == result.regenerateCacheAPIRecordsJobs.length){
							regenerateCacheAPIRecordsJobsListCat[count][jobName].Status = 'Failed';
						}
					}
				}
				return regenerateCacheAPIRecordsJobsListCat;
			}		
		scope.regenerateCacheAPIRecordsJob = function() {
			var parameters = {};
            parameters.methodName = "regenerateCacheAPIRecordsJobs";
            var remoteOptions = {};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
			remoteOptions.parameters = JSON.stringify(parameters);
			var toast = basicService.infoToast(labels.RegenerateCachedAPIRecords, labels.StartingLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.regenerateCacheAPIRecordsJobsList = scope.regenerateCacheAPIRecordsJobDataProcessing(result);
                if(result.hasErrors) {
                    basicService.errorToast(labels.RegenerateCachedAPIRecords, result.errorMessage);
                } else {
					var isCompleted = true;
					for(var i=0; i < scope.regenerateCacheAPIRecordsJobsList.length; i++ )
                    {
						if(scope.regenerateCacheAPIRecordsJobsList[i].Status == 'Running' || scope.regenerateCacheAPIRecordsJobsList[i].Status == 'Holding')
						{
							isCompleted = false;
						}
					}
					if(isCompleted) {
						basicService.successToast(labels.RegenerateCachedAPIRecords, labels.SuccessfullyCompletedLabel);
					}
					else{
						basicService.successToast(labels.RegenerateCachedAPIRecords, labels.RunningLabel);
					}
					toast.hide();
				}
            }, function(error) {
                toast.hide();
                basicService.errorToast(labels.RegenerateCachedAPIRecords, labels.CouldntStartLabel);
            });
		};

		scope.cacheMigrationJobs = function() {
			var parameters = {};
            parameters.methodName = "cacheMigrationJobs";
            var remoteOptions = {};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters = JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.CacheMigrationJobs, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.cacheMigrationJobsList = result.cacheMigrationJobs;
				toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.CacheMigrationJobs, result.errorMessage);
                } else {
                    basicService.successToast(labels.CacheMigrationJobs, labels.SuccessfullyCompletedLabel);
                }
            }, function(error) {
                toast.hide();
                basicService.errorToast(labels.CacheMigrationJobs, labels.CouldntStartLabel);
            });
		};
		
		scope.populateCacheCAJob = function(selectedList, effectiveStartTime, expirationTime, filters) {
			var parameters = {};
            parameters.methodName = "populateCacheCAJob";
            parameters.selectedList = selectedList;
            parameters.effectiveStartTime = effectiveStartTime;
			parameters.expirationTime = expirationTime;
			parameters.filters = filters;
            var remoteOptions = {};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters = JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.PopulateCacheCAJob, labels.StartingLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.PopulateCacheCAJob, result.errorMessage);
                } else {
                    for(var i=0; i < result.cacheableAPIJobs.length; i++ )
                    {
                        for(var apiName in result.cacheableAPIJobs[i])
                        {
                            result.cacheableAPIJobs[i][apiName]['Name'] = apiName;
                            scope.cacheableAPIJobsList.push(result.cacheableAPIJobs[i][apiName]);
                        }
                    }
                    
                    basicService.successToast(labels.PopulateCacheCAJob, labels.RunningLabel);
                }
            }, function(error) {
				toast.hide();
				// ECOM-684 - Adding the error message to the error toast.
                basicService.errorToast(labels.PopulateCacheCAJob, labels.CouldntStartLabel + " : <br>" + error.message);
            });
		};

        scope.startTranslationJob = function() {
            var parameters = {};
            parameters.methodName =  "startTranslationJob";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.CreateTranslationJobLabel, labels.StartingLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                toast.hide();
                if(result.hasErrors) {
                    //show errors
                    basicService.errorToast(labels.CreateTranslationJobLabel, result.errorMessage);
                } else {
                    scope.translationJobsList = result.translationJobs;
                    basicService.successToast(labels.CreateTranslationJobLabel, labels.RunningLabel);
                }
            }, function(error) {
                toast.hide();
                basicService.errorToast(labels.CreateTranslationJobLabel, labels.CouldntStartLabel);
            });
        };
        scope.startTranslationCacheJob = function() {
            var parameters = {};
            parameters.methodName =  "startTranslationCacheJob";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.CreateTranslationCacheJobLabel, labels.StartingLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                toast.hide();
                if(result.hasErrors) {
                    //show errors
                    basicService.errorToast(labels.CreateTranslationCacheJobLabel, result.errorMessage);
                } else {
                    scope.translationCacheJobsList = result.translationCacheJobs;
                    basicService.successToast(labels.CreateTranslationCacheJobLabel, labels.RunningLabel);
                }
            }, function(error) {
                toast.hide();
                basicService.errorToast(labels.CreateTranslationCacheJobLabel, labels.CouldntStartLabel);
            });
        };

		scope.initializeJobWrapper = function() {
			scope.jobWrapper.startRootAccountJob = {
									callBack: scope.startRootAccountJob,
									jobListToggle: false,
									label: scope.labels.AccountHierarchyMaintenance
								};
			scope.jobWrapper.resetInterfaceImplementations = {
									callBack: scope.resetInterfaceImplementations,
									jobListToggle: false,
									label: scope.labels.InterfaceImplementationMaintenanceRestore
								};
			scope.jobWrapper.mergeInterfaceImplementations = {
									callBack: scope.mergeInterfaceImplementations,
									jobListToggle: false,
									label: scope.labels.InterfaceImplementationMaintenanceMerge
								};
			scope.jobWrapper.resetFieldMaps = {
									callBack: scope.resetFieldMaps,
									jobListToggle: false,
									label: scope.labels.FieldMapsMaintenance
								};
			scope.jobWrapper.resetObjectMaps = {
									callBack: scope.resetObjectMaps,
									jobListToggle: false,
									label: scope.labels.ObjectMapMaintenance
								};
			scope.jobWrapper.startXLIBatchValidationJob = {
									callBack: scope.startXLIBatchValidationJob,
									jobListToggle: false,
									label: scope.labels.BatchValidation
								};
			scope.jobWrapper.resetXLIBatchValidationData = {
									callBack: scope.resetXLIBatchValidationData,
									jobListToggle: false,
									label: scope.labels.ResetXLIValiatonData
								};
			scope.jobWrapper.startProductHierarchyJob = {
									callBack: scope.startProductHierarchyJob,
									jobListToggle: false,
									label: scope.labels.ProductHierarchyMaintenanceTitle
								};
			scope.jobWrapper.clearPlatformCache = {
									callBack: scope.clearPlatformCache,
									jobListToggle: false,
									label: scope.labels.ClearManagedPlatformCache
								};
			scope.jobWrapper.refreshPriceBook = {
									callBack: scope.refreshPriceBook,
									jobListToggle: false,
									label: scope.labels.RefreshPricebook
								};
			scope.jobWrapper.ReportNullSpecTypeBatchJob = {
									callBack: scope.ReportNullSpecTypeBatchJob,
									jobListToggle: false,
									label: scope.labels.AuditProductSpecificationType
								};
			scope.jobWrapper.ReportMismatchedSpecTypeBatchJob = {
									callBack: scope.ReportMismatchedSpecTypeBatchJob,
									jobListToggle: false,
									label: scope.labels.AuditProductStructure
								};											
		}

		scope.confirmationPopup = function(jobType) {
			var modalScope = scope.$new();
			modalScope.confirmActionLbl = scope.labels.OKLabel;
            modalScope.confirmationMsg = scope.labels.MaintenanceJobRunWarning;
            modalScope.confirmationTitle = jobType.label;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.confirmAction = function() {
            	jobType.jobListToggle = true;
            	confirmModal.hide();
            	jobType.callBack();
            };
            var confirmModal = modal({
                templateUrl: 'ConfirmationModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
            });
		}
		scope.confirmationEmailSendingPopup = function(jobType) {
			var modalScope = scope.$new();
			modalScope.confirmActionLbl = scope.labels.OKLabel;
            modalScope.confirmationMsg = scope.labels.EmailSendingConfirmation;
            modalScope.confirmationTitle = jobType.label;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.confirmAction = function() {
            	jobType.jobListToggle = true;
            	confirmModal.hide();
            	jobType.callBack();
            };
            var confirmModal = modal({
                templateUrl: 'ConfirmationModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
            });
		}

		scope.startRootAccountJob = function() {
			var parameters = {};
        	parameters.methodName =  "startRootAccountJob";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.ResolveRootAccounts, labels.StartingLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.rootAccountJobsList = result.resolveRootAccountsJobs;
				toast.hide();
				basicService.successToast(labels.ResolveRootAccounts, labels.RunningLabel);
			}, function(error) {
				toast.hide();
				basicService.errorToast(labels.ResolveRootAccounts, labels.CouldntStartLabel);
			});
		};

		scope.startAttributesBindingJob = function() {
			var parameters = {};
        	parameters.methodName =  "startAttributesBindingJob";
        	parameters.objectNames =  scope.upgradeTab.attributesBindingObjects;
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.attributesBindingJobsList = result.attributesBindingJobs;

			});
		};

		scope.startProductHierarchyJob = function() {
			var parameters = {};
			parameters.methodName =  "startProductHierarchyJob";
			parameters.deleteOldData = scope.upgradeTab.deleteOldData;
			var remoteOptions ={};
			remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
			remoteOptions.parameters =  JSON.stringify(parameters);
			var toast = basicService.infoToast(labels.ProductHierarchyMaintenanceTitle, labels.StartingLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.productHierarchyJobsList = result.resolveProductHierarchyJobs;
				toast.hide();
				basicService.successToast(labels.ProductHierarchyMaintenanceTitle, labels.RunningLabel);
			}, function(error) {
				toast.hide();
				basicService.errorToast(labels.ProductHierarchyMaintenanceTitle, labels.CouldntStartLabel);
			});
		};

		// validate the startAttributesBindingJob form
		scope.validateInput = function() {
			if(scope.upgradeTab.attributesBindingObjects != null){
				return false;
			}else{
				return true;
			}
		};

		scope.startXLIBatchValidationJob = function() {
			var parameters = {};
        	parameters.methodName =  "startXLIBatchValidationJob";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.StartBatchJobValidation, labels.StartingLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.XLIBatchJobValidationList = result.xliBatchValidationJobs;
				toast.hide();
				basicService.successToast(labels.StartBatchJobValidation, labels.RunningLabel);
			});
		};

		scope.resetXLIBatchValidationData = function() {
			var parameters = {};
        	parameters.methodName =  "resetXLIBatchValidtionData";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.ResetXLIValiatonData, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.ResetXLIValiatonData, result.errorMessage);
				} else {
					basicService.successToast(labels.ResetXLIValiatonData, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.clearPlatformCache = function() {
			var parameters = {};
        	parameters.methodName =  "clearPlatformCache";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.ClearManagedPlatformCache, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.ClearManagedPlatformCache, result.errorMessage);
				} else {
					basicService.successToast(labels.ClearManagedPlatformCache, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.refreshPriceBook = function() {
			var parameters = {};
			parameters.methodName =  "refreshPriceBook";
			var remoteOptions ={};
			remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
			remoteOptions.parameters =  JSON.stringify(parameters);
			var toast = basicService.infoToast(labels.RefreshPricebook, labels.StartingLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.refreshPriceBookJobList = result.productAttributesBatchJobs;
				toast.hide();
				basicService.successToast(labels.RefreshPricebook, labels.RunningLabel);
			});
		};

		scope.importEpcObjectsLayouts = function() {
			var path = '/apex/'+scope.nsPrefix+'DataPacksHome?dataPackDataPublicId=DP_CPQ_EpcDefaultObjects&dataPackDataPublicSource=Vlocity%20Resource'
			window.open(path, '_blank');
		};
		scope.importProductReportIP = function() {
            var path = '/apex/'+scope.nsPrefix+'DataPacksHome?dataPackDataPublicId=DP_UPC_Product_Report_IP&dataPackDataPublicSource=Vlocity%20Resource'
            window.open(path, '_blank');
        };
		scope.importPricingPlanData = function() {
			var path = '/apex/'+scope.nsPrefix+'DataPacksHome?dataPackDataPublicId=DP_CPQ_PricingPlanDefaultData&dataPackDataPublicSource=Vlocity%20Resource'
			window.open(path, '_blank');
		};

		scope.createEpcObjectClasses = function() {
			var parameters = {};
        	parameters.methodName =  "createEpcObjectClasses";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.CreateDefaultObjectClass, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.CreateDefaultObjectClass, result.errorMessage);
				} else {
					basicService.successToast(labels.CreateDefaultObjectClass, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.createEpcDefaultLayouts = function() {
			var parameters = {};
        	parameters.methodName =  "createEpcDefaultLayouts";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.CreateDefaultLayout, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.CreateDefaultLayout, result.errorMessage);
				} else {
					basicService.successToast(labels.CreateDefaultLayout, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.deleteEpcDefaultLayouts = function() {
			var parameters = {};
        	parameters.methodName =  "deleteEpcDefaultLayouts";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.DeleteDefaultObjectLayouts, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.DeleteDefaultObjectLayouts, result.errorMessage);
				} else {
					basicService.successToast(labels.DeleteDefaultObjectLayouts, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.generateEPCGlobalKeys = function() {
			var parameters = {};
        	parameters.methodName = "generateEPCGlobalKeys";
            var remoteOptions ={};
            remoteOptions.apexType = scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters = JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.GenerateGlobalKey, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.GenerateGlobalKey, result.errorMessage);
				} else {
					basicService.successToast(labels.GenerateGlobalKey, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.createDefaultPricingVariables = function() {
			var parameters = {};
        	parameters.methodName =  "createDefaultPricingVariables";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.CreateDefaultPVB, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.CreateDefaultPVB, result.errorMessage);
				} else {
					basicService.successToast(labels.CreateDefaultPVB, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.createDefaultContextualAdjustmentData = function() {
			var parameters = {};
        	parameters.methodName =  "createDefContextualAdjData";
            var remoteOptions ={};

            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.CreateContextualAdjustmentData, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.CreateContextualAdjustmentData, result.errorMessage);
				} else {
					scope.hasErrors = false;
					basicService.successToast(labels.CreateContextualAdjustmentData, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.resetInterfaceImplementations = function() {
			var parameters = {};
        	parameters.methodName =  "resetInterfaceImplementations";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.InterfaceImplementationMaintenanceRestore, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.InterfaceImplementationMaintenanceRestore, result.errorMessage);
				} else {
					basicService.successToast(labels.InterfaceImplementationMaintenanceRestore, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.mergeInterfaceImplementations = function() {
			var parameters = {};
        	parameters.methodName =  "mergeInterfaceImplementations";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.InterfaceImplementationMaintenanceMerge, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.InterfaceImplementationMaintenanceMerge, result.errorMessage);
				} else {
					basicService.successToast(labels.InterfaceImplementationMaintenanceMerge, labels.SuccessfullyCompletedLabel);
				}
			});
		};


		scope.resetFieldMaps = function() {
			var parameters = {};
        	parameters.methodName =  "resetFieldMaps";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
        	var toast = basicService.infoToast(labels.FieldMapsMaintenance, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.FieldMapsMaintenance, result.errorMessage);
				} else {
					basicService.successToast(labels.FieldMapsMaintenance, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.resetObjectMaps = function() {
			var parameters = {};
        	parameters.methodName =  "resetObjectMaps";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.ObjectMapMaintenance, labels.RunningLabel);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				toast.hide();
				if(result.hasErrors) {
					basicService.errorToast(labels.ObjectMapMaintenance, result.errorMessage);
				} else {
					basicService.successToast(labels.ObjectMapMaintenance, labels.SuccessfullyCompletedLabel);
				}
			});
		};

		scope.refreshBatchJobLists = function() {
			var parameters = {};
        	parameters.methodName =  "refreshBatchJobLists";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.rootAccountJobsList = result.resolveRootAccountsJobs;
				scope.XLIBatchJobValidationList = result.xliBatchJobs;
				scope.attributesBindingJobsList = result.attributesBindingJobs;
				scope.rootProductChildItemJobsList = result.rootProductChildItemJobs;
				//scope.jobType.rootPCIJob.records = result.rootProductChildItemJobs;
				for(let key in scope.jobType) {
					scope.jobType[key].records = result[scope.jobType[key].listName];
				}
				
				result.regenerateCacheAPIRecordsJobs.sort(function(a,b) {return b.CreatedDate - a.CreatedDate});
				scope.regenerateCacheAPIRecordsJobsList = scope.regenerateCacheAPIRecordsJobDataProcessing(result);
				scope.productHierarchyJobsList = result.resolveProductHierarchyJobs;
				scope.populateSellingPeriodDatesJobsList = result.populateSellingPeriodDatesJobs;
				scope.deleteExpiredCacheJobsList = result.deleteExpiredCacheJobs;
				scope.deleteQuasiRecordsJobsList = result.deleteQuasiRecordsJobs;
				//scope.regenerateCacheAPIRecordsJobsList = regenerateCacheAPIRecordsJobsListCat;
				scope.cacheMigrationJobsList = result.cacheMigrationJobs;
				scope.refreshPriceBookJobList = result.productAttributesBatchJobs;
                scope.translationJobsList = result.translationJobs;
                scope.translationCacheJobsList = result.translationCacheJobs;
                scope.convertProductJSONToV2JobsList = result.convertProductJSONToV2Jobs;
                scope.convertXliJSONToV2JobsList = result.convertXliJSONToV2Jobs;
                scope.createRelationshipRecordsJobsList = result.createRelationshipRecordsJobs;
				scope.cacheableAPIJobsList = [];
				scope.ReportNullSpecTypeBatchJobsList = result.ReportNullSpecTypeBatchJobs;
				scope.ReportMismatchedSpecTypeBatchJobsList = result.ReportMismatchedSpecTypeBatchJobs;

                for(var i=0; i < result.cacheableAPIJobs.length; i++ )
                {
                    for(var apiName in result.cacheableAPIJobs[i])
                    {
                        result.cacheableAPIJobs[i][apiName]['Name'] = apiName;
                        scope.cacheableAPIJobsList.push(result.cacheableAPIJobs[i][apiName]);
                    }
                }
                
                scope.populateRequestedStartDatesJobsList = result.populateRequestedStartDatesJobs;
                scope.populateMissingActionFieldInXLIsJobsList = result.populateMissingActionFieldInXLIsJobs;
                scope.populateGKPathJobsList = result.populateGKPathJobs;
				scope.updateEncryptAttrJobsList = result.updateEncryptAttrJobs;
				scope.populateCatalogCodeJobsList = result.populateCatalogCodeJobs;
                scope.workSetItemUpgradeBatchJobsList = result.workSetItemUpgradeBatchJobs;
				scope.VersioningUpgradeBatchJobsList = result.VersioningUpgradeBatchJobs;
				scope.PopulateProdHierarchyGrpKeyPathJobsList = result.PopulateProdHierarchyGrpKeyPathJobs;
				//console.log(scope.XLIBatchJobValidationList);
				if(activeMenu.getActiveMenu() === 'MaintenanceJob.tpl.html' ||
					activeMenu.getActiveMenu() === 'UpgradeJob.tpl.html' ||
                    activeMenu.getActiveMenu() === 'MLSJob.tpl.html' ||
                    activeMenu.getActiveMenu() === 'CAJob.tpl.html') {
					timeout(scope.refreshBatchJobLists, 3000);
				}
			});
		};

		scope.refreshXLIBatchJobValidationLists = function() {
			var parameters = {};
        	parameters.methodName =  "refreshXLIBatchJobLists";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
        	remoteOptions.parameters =  JSON.stringify(parameters);
			remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
				scope.XLIBatchJobValidationList = result.xliBatchJobValidationList;
				//debugger;
				//console.log(scope.XLIBatchJobValidationList);
				if(activeMenu.getActiveMenu() === 'MaintenanceJob.tpl.html' || activeMenu.getActiveMenu() === 'UpgradeJob.tpl.html') {
					timeout(scope.refreshXLIBatchJobValidationLists, 3000);
				}

			});
		};

        scope.deleteOldCacheResponse = function() {
            var parameters = {};
            parameters.methodName =  "startDeleteExpiredCacheJobs";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.DeleteExpiredAPICache, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                scope.deleteExpiredCacheJobsList = result.deleteExpiredCacheJobs;
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.DeleteExpiredAPICache, result.errorMessage);
                } else {
                    basicService.successToast(labels.DeleteExpiredAPICache, labels.SuccessfullyCompletedLabel);
                }
            });
		};

		scope.deleteQuasiRecordsResponse = function(query, conditions, expirationTime) {
            var parameters = {'query': query, 'conditions' : conditions, 'expirationTime' : expirationTime};
            parameters.methodName =  "startDeleteQuasiRecordsJobs";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.DeleteQuasiRecords, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                scope.deleteQuasiRecordsJobsList = result.deleteQuasiRecordsJobs;
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.DeleteQuasiRecords, result.errorMessage);
                } else {
                    basicService.successToast(labels.DeleteQuasiRecords, labels.SuccessfullyCompletedLabel);
                }
            });
        };
		
        scope.loadDefaultObjectFieldsConfigMLS = function() {
            var parameters = {};
            parameters.methodName =  "loadDefaultObjectFieldsConfigMLS";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.LoadDefaultObjectFieldMLS, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.LoadDefaultObjectFieldMLS, result.errorMessage);
                } else {
                    basicService.successToast(labels.LoadDefaultObjectFieldMLS, labels.SuccessfullyCompletedLabel);
                }
            });
        };
		scope.addOrderLineItemJob = function() {
			scope.$parent.spinner.showSpinner();
			remoteActions.AddXLITime().then(function(result) {
				scope.$parent.spinner.hideSpinner();
				scope.result = result;
				if(result.hasErrors) {
					scope.errorMessage = result.errorMessage;
					scope.hasErrors = true;
				} else {
					scope.hasErrors = false;
				}
			}, function(error) {
				if(result.hasErrors) {
					scope.errorMessage = result.errorMessage;
					scope.hasErrors = true;
				} else {
					scope.hasErrors = false;
				}
			});
		};

		scope.testConfigurationsJob = function() {
			scope.$parent.spinner.showSpinner();
			remoteActions.testConfigurationsJob().then(function(result) {
				scope.$parent.spinner.hideSpinner();
				scope.configResult = result.mapResult;
				if(result.hasError) {
					scope.errorMessage = result.errorMessage;
					scope.hasError = true;
				} else {
					scope.hasError = false;
				}
			}, function(error) {
				if(result.hasError) {
					scope.errorMessage = result.errorMessage;
					scope.hasError = true;
				} else {
					scope.hasError = false;
				}
			});
		};
        
        scope.createDefaultTimePolicy = function() {
            var parameters = {};
            parameters.methodName =  "createDefaultTimePolicy";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.CMTAdminCreateDefaultTPJob, labels.StartingLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                scope.createDefaultTPJobsList = result.createDefaultTPJobs;
                toast.hide();
                basicService.successToast(labels.CMTAdminCreateDefaultTPJob, labels.RunningLabel);
            }, function(error) {
                toast.hide();
                basicService.errorToast(labels.CMTAdminCreateDefaultTPJob, labels.CouldntStartLabel);
            });
        };
		
		scope.ReportNullSpecTypeBatchJob = function() {
            var parameters = {};
            parameters.methodName =  "startReportNullSpecTypeBatchJob";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.AuditProductSpecificationType, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                scope.ReportNullSpecTypeBatchJobsList = result.ReportNullSpecTypeBatchJobs;
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.AuditProductSpecificationType, result.errorMessage);
                } else {
                    basicService.successToast(labels.AuditProductSpecificationType, labels.SuccessfullyCompletedLabel);
                }
            });
		};
		
		scope.ReportMismatchedSpecTypeBatchJob = function() {
            var parameters = {};
            parameters.methodName =  "startReportMismatchedSpecTypeBatchJob";
            var remoteOptions ={};
            remoteOptions.apexType =  scope.configData.telcoAdminConsoleClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
            var toast = basicService.infoToast(labels.AuditProductStructure, labels.RunningLabel);
            remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                scope.ReportMismatchedSpecTypeBatchJobsList = result.ReportMismatchedSpecTypeBatchJobs;
                toast.hide();
                if(result.hasErrors) {
                    basicService.errorToast(labels.AuditProductStructure, result.errorMessage);
                } else {
                    basicService.successToast(labels.AuditProductStructure, labels.SuccessfullyCompletedLabel);
                }
            });
		};
	}
]);

},{}],3:[function(require,module,exports){
var app = angular.module('CMTAdmin');
app.controller('CMTAdminController', ['$scope', '$sldsModal', 'BasicService', 'PageSpinner', 'ActiveMenu', 'remoteActions', '$window',
	function (scope, modal, basicService, spinner, activeMenu, remoteActions, window) {
		scope.SLDSICON = window.SLDSICON;
		scope.labels = window.labels;
		scope.nsPrefix = window.configData.nsPrefix;
		scope.configurations = [];
		scope.selectedConfigurationIndex = 0;
		scope.spinner = spinner;
		scope.sectionList = [];
		scope.activeMenu = activeMenu;
		scope.showClickedMenu = function(menu) {
			activeMenu.setActiveMenu(menu);
		};

		scope.initApp = function() {
			scope.spinner.showSpinner();
			remoteActions.getAdminOptions().then(function(results) {
		        if(results.hasError) {
					basicService.openAlertWindow(scope.labels.CMTAdminError, error);
				}else{
					scope.sectionList = results.result;
				}
				scope.spinner.hideSpinner();
			}, function(error) {
				scope.spinner.hideSpinner();
				basicService.openAlertWindow(scope.labels.CMTAdminError, error);
			});
		};
	}
]);

},{}],4:[function(require,module,exports){
var app = angular.module('CMTAdmin');
app.controller('CustomSettingsController', ['$scope', '$sldsModal', 'BasicService', 'remoteActions', '$window', 'fieldLookupService', '$filter',
	function (scope, modal, basicService, remoteActions, window, fieldLookupService, filter) {
		scope.SLDSICON = window.SLDSICON;
		scope.labels = window.labels;
		scope.subModuleList = [];
		scope.module = {};
		scope.activeTab = 0;
		scope.search = {'name': ''};
		scope.allObjectList = [];
		scope.objectAndFieldNameToLabel = {};
		scope.booleanSelectionOptions = [{"value":true,"label":"Yes"},{"value":false,"label":"No"}];
		scope.nsPrefix = window.configData.nsPrefix;
		scope.isDuplicateSequence = false;
		scope.tab = {
			index: 0
		};

		scope.$watch('tab.index', function(newValue, oldValue) {
			//get records on tab changes
			scope.activeTab = newValue;
			scope.getCustomSettingsRecord();
		});

		scope.getViewOption = function(fieldName) {
			if(fieldName === scope.nsPrefix + 'ObjectName__c'
			 || fieldName === scope.nsPrefix + 'Object_Name__c') {
				return 1;
			} else if(fieldName === scope.nsPrefix + 'FieldName__c') {
				return 2;
			} else {
				return 0;
			}
		};

		scope.getFieldLabel = function(record) {
			var objectAPIName = record[scope.nsPrefix + 'ObjectName__c'];
			if(!objectAPIName) {
				objectAPIName = record[scope.nsPrefix + 'Object_Name__c'];
			}
			var fieldAPIName = record[scope.nsPrefix + 'FieldName__c'];
			var objMap = scope.objectAndFieldNameToLabel[objectAPIName];

			if(objMap && objMap[fieldAPIName]) {
				return objMap[fieldAPIName];
			}
			return fieldAPIName;
		};

		scope.getObjectLabel = function(objectAPIName) {
			var objlabel = scope.objectAndFieldNameToLabel[objectAPIName];
			if(objlabel && objlabel[objectAPIName]) {
				return objlabel[objectAPIName];
			}
			return objectAPIName;
		};

		scope.filterList = function(item) {
			if(scope.search.name === '') {
				return true;
			}
			var fields = [];
			fields.push(item[scope.nsPrefix + 'ObjectName__c']);
			fields.push(item[scope.nsPrefix + 'Object_Name__c']);
			fields.push(item[scope.nsPrefix + 'IsEditable__c']);
			fields.push(item[scope.nsPrefix + 'Popup_Page_Id__c']);
			fields.push(item[scope.nsPrefix + 'SetupValue__c']);
			fields.push(item[scope.nsPrefix + 'Value__c']);
			fields.push(item[scope.nsPrefix + 'Sequence__c']);
			fields.push(item[scope.nsPrefix + 'FieldName__c']);
			if(scope.subModuleList[scope.activeTab].name === 'configurations') {
				// add name field
				fields.push(item.Name);
			}

			return scope.find(fields);
		};
		scope.find = function(fields) {
			for(var i=0; i<fields.length; i++) {
				if(fields[i]) {
					var m = (fields[i] + '').toLowerCase().match(scope.search.name.toLowerCase());
					if(m && m.length > 0) {
						return true;
					}
				}
			}
			return false;
		};
		scope.verifyDuplicate = function(propertyName) {
	        var sorted, i;
	        var records = scope.subModuleList[scope.activeTab].records;
	        var isInvalid = false;
	        sorted = records.concat().sort(function (a, b) {
	            if (a[propertyName] > b[propertyName]) return 1;
	            if (a[propertyName] < b[propertyName]) return -1;
	            return 0;
	        });
	        for(i = 0; i < records.length; i++) {
	            sorted[i].isDuplicate = ((sorted[i-1] && sorted[i-1][propertyName] == sorted[i][propertyName]) || (sorted[i+1] && sorted[i+1][propertyName] == sorted[i][propertyName]));
	            if(sorted[i].isDuplicate && !isInvalid) {
	            	isInvalid = sorted[i].isDuplicate;
	            }
	        }
	        scope.isDuplicate = isInvalid;
	    };
		scope.getMetadata = function() {
			scope.spinner.showSpinner();
			remoteActions.getCustomSettingsMetadata(scope.module.name).then(function(results) {
		        if(results.hasError){
					basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
					scope.$parent.spinner.hideSpinner();
				}else{
					var module = results.result[0];
					scope.module = module;
					scope.subModuleList = module.subModuleList;
					scope.getCustomSettingsRecord();
				}

			}, function(error) {
				scope.$parent.spinner.hideSpinner();
				basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
			});
		};
		scope.getCustomSettingsRecord = function() {
			if(!scope.subModuleList[scope.activeTab]) {
				return ;
			}
			scope.$parent.spinner.showSpinner();
			var objectAPI = scope.subModuleList[scope.activeTab].objectAPI;
			var feature = scope.subModuleList[scope.activeTab].feature;
			remoteActions.getCustomSettingsRecord(objectAPI, feature).then(function(results) {
				if(results.hasError) {
					basicService.openAlertWindow(scope.labels.CustomSettingsError, results.errorMessage);
				} else {
					scope.subModuleList[scope.activeTab].records = results.result;
					var objectMap = {};
					if(results.result) {
						for(var i=0; i<results.result.length; i++) {
							var objectName = results.result[i][scope.nsPrefix + 'ObjectName__c'];
							var object_Name = results.result[i][scope.nsPrefix + 'Object_Name__c'];
							var fieldName = results.result[i][scope.nsPrefix + 'FieldName__c'];
							if(!objectName) {
								objectName = object_Name;
							}

							if(!objectMap[objectName]) {
								objectMap[objectName] = [];
							}
							if(!objectMap[objectName][fieldName]) {
								objectMap[objectName].push(fieldName);
							}
						}
						if(!angular.equals(objectMap, {})) {
							scope.getObjectAndFieldsLabel(objectMap);
						} else {
							scope.$parent.spinner.hideSpinner();
						}
					} else {
						scope.$parent.spinner.hideSpinner();
					}
				}
			}, function(error) {
				scope.$parent.spinner.hideSpinner();
				basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
			});
		};
		scope.getObjectAndFieldsLabel = function(objectMap) {
			//console.log(objectMap);
			remoteActions.getObjectAndFieldsLabel(objectMap).then(function(result) {
				scope.objectAndFieldNameToLabel = result.mapResult;
				scope.$parent.spinner.hideSpinner();
			});
		}
		scope.initApp = function(name) {
			scope.module.name = name;
			scope.getMetadata();
			scope.getObjectList();
		};
		scope.getObjectList = function() {
			var parameters = {};
            parameters.methodName =  'getGlobalDescribe';
            var remoteOptions ={};
            remoteOptions.apexType =  window.configData.adminClassType;
            remoteOptions.parameters =  JSON.stringify(parameters);
			remoteActions.getObjectList(remoteOptions).then(function(result) {
				scope.allObjectList = JSON.parse(result.objectsDescribeListJSON.toString().replace('\n', ''));
				scope.allObjectList = filter('orderBy')(scope.allObjectList, 'label');
			}, function(err) {
				basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
			});
		};
		scope.delete = function(record, index) {
			var objectAPI = scope.subModuleList[scope.activeTab].objectAPI;
			var customsettingsID = record.Id;
			//var modalInstance = modal();
			var modalScope = scope.$new();
            modalScope.confirmationTitle = scope.labels.DeleteCustomSettingsLabel;
            modalScope.confirmationMsg = scope.labels.DeleteCustomSettingsWarningMessage;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.confirmActionLbl = scope.labels.DeleteLabel;
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.confirmAction = function() {
            	deleteModal.hide();
            	var records = scope.subModuleList[scope.activeTab].records;
                if(customsettingsID) {
                    scope.$parent.spinner.showSpinner();
					remoteActions.deleteCustomSettings(customsettingsID, objectAPI).then(function(results){
						scope.$parent.spinner.hideSpinner();
						if(results.hasError){
							basicService.openAlertWindow(scope.labels.CustomSettingsError, results.errorMessage);
						} else {
							for (var i = 0; i < records.length; i++) {
							    if (records[i].Id === customsettingsID) {
							        records.splice(i, 1);
							        break;
							    }
							}
						}
	                }, function(error) {
	                	scope.$parent.spinner.hideSpinner();
	                    basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
	                });
				} else {
					records = records.splice(index, 1);
				}
            };
			var deleteModal = modal({
                templateUrl: 'ConfirmationModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
		};
		scope.checkSaveMode = function() {
			var save = false;
			var records = scope.subModuleList[scope.activeTab].records;
			if(records) {
				for(var i=0; i<records.length; i++) {
					if(records[i].editMode) {
						save = true;
						break;
					}
				}
			}
			return !save;
		};
		scope.add = function(records) {
			if(!records){
				records = [];
			}
			records.push(scope.createEmptyRecord());
		};
		scope.createEmptyRecord = function() {
			var record = {};
			var metaDataList = scope.subModuleList[scope.activeTab].metaDataList;
			for(var i=0; i<metaDataList.length; i++) {
				record[metaDataList[i].name] = '';
			}
			record.editMode = true;
			return record;
		};
		scope.fixLookupRecordBeforeSave = function(records) {
			for(var i=0; i<records.length; i++) {
				delete records[i].isDuplicate;
				delete records[i].editMode;
			}
		};
		scope.fixConfigRecordBeforeSave = function(records) {
			for(var i=0; i<records.length; i++) {
				delete records[i].isDuplicate;
				delete records[i].editMode;
			}
		};
		scope.fixFieldRecordBeforeSave = function(records) {
			for(var i=0; i<records.length; i++) {
				var sequence = records[i][scope.nsPrefix + 'Sequence__c'];
				if(!sequence) {
					records[i][scope.nsPrefix + 'Sequence__c'] = 0;
				}
				var feature = scope.subModuleList[scope.activeTab].feature;
				records[i][scope.nsPrefix + 'Feature__c'] = feature;
				delete records[i].isDuplicate;
				delete records[i].editMode;
			}
		};
		scope.save = function() {
			scope.$parent.spinner.showSpinner();
			var objectAPI = scope.subModuleList[scope.activeTab].objectAPI;
			var records = [];
			//get only edited records
			for(var i=0; i<scope.subModuleList[scope.activeTab].records.length; i++) {
				var record = scope.subModuleList[scope.activeTab].records[i];
				if(record.editMode) {
					records.push(record);
				}
			}
			var name = scope.subModuleList[scope.activeTab].name;
			if(name === 'displayFields' || name === 'queryFields' || name === 'updateFields') {
				scope.fixFieldRecordBeforeSave(records);
			} else if(name === 'lookupFields') {
				scope.fixLookupRecordBeforeSave(records);
			} else if(name === 'configurations') {
				scope.fixConfigRecordBeforeSave(records);
			}
			remoteActions.saveCustomSettings(objectAPI, angular.toJson(records)).then(function(results) {
				if(results.hasError){
					scope.$parent.spinner.hideSpinner();
					basicService.openAlertWindow(scope.labels.CustomSettingsError, results.errorMessage);
				} else{
					//saved
					scope.getCustomSettingsRecord();
				}
			}, function(error) {
				scope.$parent.spinner.hideSpinner();
				basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
			});
		};
		scope.convertFieldSelName = function(fieldName) {
			var cFields = [];
			var names = fieldName.split(".");
			if(names.length > 1) {
				for(var i=0; i<names.length; i++) {
					if(names[i].indexOf('__c') !== -1 && i < names.length - 1){
						cFields.push(names[i].replace('__c','__r'));
					} else if (i < names.length - 1){
						cFields.push(names[i].substring(0, names[i].length-2));
					} else{
						cFields.push(names[i]);
					}
				}
			} else {
				cFields.push(fieldName);
			}
			return cFields.join(".");
		};
		scope.openFieldSelection = function (record) {
			var modalScope = scope.$new();
            modalScope.confirmationTitle = scope.labels.FieldSelectionLabel;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.confirmActionLbl = scope.labels.SaveLabel;
            modalScope.objectName = record[scope.nsPrefix + 'ObjectName__c'] || record[scope.nsPrefix + 'Object_Name__c'];
            modalScope.fieldName = scope.convertFieldSelName(record[scope.nsPrefix + 'FieldName__c']);
            modalScope.selectedFields = [];
            modalScope.nsPrefix = scope.nsPrefix;
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.confirmAction = function() {
                //
                var fieldInfo = scope.parseFields(modalScope.selectedFields);
                record.fieldName = fieldInfo.label;
                record[scope.nsPrefix + 'FieldName__c'] = fieldInfo.apiName;
                fieldSelectionModal.hide();
            };
			var fieldSelectionModal = modal({
				templateUrl: 'FieldSelectionModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
		};
		scope.parseFields = function(selectedFields) {
			var fieldName = [];
			var fieldApiNames = [];
			var fieldType = null;
			var numberOfFields = selectedFields.length;
			var lastReferenceObject = null;
			for (i = 0; i < numberOfFields; i++) {
				var fieldInfo = selectedFields[i];
				if(fieldInfo.type === 'reference'){
					lastReferenceObject = fieldInfo.referenceTo[0];
				}
				// if it's a reference field and there is an element after it
				if(fieldInfo.type === 'reference' && i < numberOfFields - 1){
					if(fieldInfo.name.indexOf('__c') !== -1){
						fieldName.push(fieldInfo.name.replace('__c','__r'));

					}else{
						fieldName.push(fieldInfo.name.substring(0,fieldInfo.name.length-2));

					}
				} else {
					fieldName.push(fieldInfo.name);

				}
				fieldType = fieldInfo.type;
				fieldApiNames.push(fieldInfo.name);
			}
			var fullFieldName = '';
			for (i = 0; i < fieldName.length; i++) {
				fullFieldName += fieldName[i];
				if(i !==  fieldName.length-1){
					fullFieldName += '.';
				}

			}
			retVal = {};
			retVal.fullFieldName = fullFieldName;
			retVal.fieldType = fieldType;
			retVal.lastReferenceObject = lastReferenceObject;
			if(fieldApiNames.length > 0) {
				retVal.apiName = fieldApiNames.join(".");
			}
			return retVal;
		};
		scope.openPageSelection = function(record) {
			var modalScope = scope.$new();
            modalScope.confirmationTitle = scope.labels.PageSelectionLabel;
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.confirmActionLbl = scope.labels.SaveLabel;
            modalScope.pageWrapper = {page:{}};
            modalScope.pageWrapper.page.Name = record[scope.nsPrefix + 'Popup_Page_Id__c'];
            modalScope.nsPrefix = scope.nsPrefix;
            modalScope.SLDSICON = scope.SLDSICON;
            scope.$parent.spinner.hideSpinner();
            modalScope.search = '';
            modalScope.confirmAction = function() {
                record[scope.nsPrefix + 'Popup_Page_Id__c'] = modalScope.pageWrapper.page.Name;
                pageSelectionModal.hide();
            };
            modalScope.init = function() {
            	modalScope.getPageList('');
            };
            modalScope.searchPage = function(search) {
            	modalScope.getPageList(search);
            };
            modalScope.getPageList = function(search) {
            	scope.$parent.spinner.showSpinner();
            	remoteActions.getPageList(search).then(function(results) {
					if(results.hasError){
						basicService.openAlertWindow(scope.labels.CustomSettingsError, results.errorMessage);
					} else{
						//saved
						modalScope.pageList = results.result;
					}
					scope.$parent.spinner.hideSpinner();
				}, function(error) {
					scope.$parent.spinner.hideSpinner();
					basicService.openAlertWindow(scope.labels.CustomSettingsError, error);
				});
            };
			var pageSelectionModal = modal({
				templateUrl: 'PageSelectionModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
			modalScope.init();
		};
	}
]);

},{}],5:[function(require,module,exports){
var app = angular.module('CMTAdmin');
app.controller('EnableFeaturesController', ['$scope', '$sldsModal', 'BasicService', 'remoteActions', '$window',
    function (scope, modal, basicService, remoteActions, window) {
        scope.SLDSICON = window.SLDSICON;
        scope.labels = window.labels;
        scope.nsPrefix = window.configData.nsPrefix;
        scope.loyaltyPoints = {};
        scope.featureList;
        scope.module = {};

        scope.initApp = function(name, label) {
            scope.module.name = name;
            scope.module.label = label;
            scope.getMetadata();
        };
        scope.getMetadata = function() {
            scope.$parent.spinner.showSpinner();
            remoteActions.getCustomSettingsMetadata(scope.module.name).then(function(results) {
                if(results.hasError){
                    basicService.openAlertWindow(scope.labels.EnableFeatureError, error);
                    scope.$parent.spinner.hideSpinner();
                }else{
                    var module = results.result[0];
                    scope.module = module;
                    scope.subModule = module.subModuleList[0];
                    scope.getCustomSettingsRecord();
                }
            }, function(error) {
                basicService.openAlertWindow(scope.labels.EnableFeatureError, error);
                scope.$parent.spinner.hideSpinner();
            });
        };
        scope.getCustomSettingsRecord = function() {
            var objectAPI = scope.subModule.objectAPI;
            var feature = scope.subModule.feature;
            remoteActions.getCustomSettingsRecord(objectAPI, feature).then(function(results) {
                if(results.hasError) {
                    basicService.openAlertWindow(scope.labels.EnableFeatureError, results.errorMessage);
                } else {
                    scope.featureList = results.result;
                }
                scope.$parent.spinner.hideSpinner();
            }, function(error) {
                scope.$parent.spinner.hideSpinner();
                basicService.openAlertWindow(scope.labels.EnableFeatureError, error);
            });
        };
        scope.enableDisableFeature = function(f) {
            var feature = angular.copy(f);
            var modalScope = scope.$new();
            if(feature.isEnabled) {
                modalScope.confirmActionLbl = scope.labels.Enable;
                modalScope.confirmationMsg = scope.labels.EnableSettingWarning;
                modalScope.confirmationTitle = scope.labels.Enable+ ' '+ feature.label;
                if(feature.enablingMessage) {
                    modalScope.confirmationMsg = feature.enablingMessage; 
                }
            } else {
                modalScope.confirmActionLbl = scope.labels.Disable;
                if(feature.warningMessage){
                    modalScope.confirmationMsg = feature.warningMessage;
                } else {
                    modalScope.confirmationMsg = 'Are you sure want to disable this setting?';
                }
                modalScope.confirmationClass = 'slds-theme_warning';
                modalScope.confirmationTitle = scope.labels.Disable + ' ' + feature.label;
            }
            modalScope.cancelActionLbl = scope.labels.CancelLabel;
            modalScope.isCancelActionRequried = true;
            modalScope.SLDSICON = scope.SLDSICON;
            modalScope.cancelAction = function() {
                f.isEnabled = !f.isEnabled;
                confirmModal.hide();
            };
            modalScope.confirmAction = function() {
                feature[scope.nsPrefix + 'SetupValue__c'] = feature.isEnabled + '';
                delete feature['label'];
                delete feature['warningMessage'];
                delete feature['isEnabled'];
                delete feature['enablingMessage'];
                var objectAPI = scope.subModule.objectAPI;
                confirmModal.hide();
                scope.$parent.spinner.showSpinner();
                remoteActions.saveCustomSettings(objectAPI, angular.toJson(feature)).then(function(results) {
                    if(results.hasError){
                        basicService.openAlertWindow(scope.labels.EnableFeatureError, results.errorMessage);
                    } else {
                        if(f.isEnabled) {
                            basicService.openSuccessWindow(f.label, scope.labels.EnableFeatureSuccessMessage);
                        } else {
                            basicService.openSuccessWindow(f.label, scope.labels.DisableFeatureSuccessMessage);
                        }
                    }
                    scope.$parent.spinner.hideSpinner();
                }, function(error) {
                    scope.$parent.spinner.hideSpinner();
                    basicService.openAlertWindow(scope.labels.EnableFeatureError, error);
                });
            };
            var confirmModal = modal({
                templateUrl: 'ConfirmationModal.tpl.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
            });
        }
    }
]);

},{}],6:[function(require,module,exports){
var app = angular.module('CMTAdmin');
app.directive('batchJob',['remoteActions', 'BasicService', function(remoteActions, basicService){
    return {
        restrict: 'E',
        scope: {
            jobDetails: '=',
            inputTemplate: '=?'
        },
        templateUrl: 'BatchJob.tpl.html',
        controller: function($scope, $rootScope) {
            
            //set few labels
            $scope.labels = $rootScope.labels;
            $scope.asyncApexJobFieldsLabels = $rootScope.asyncApexJobFieldsLabels;

            $scope.startBatch = function() {
                var parameters = {};
                parameters.methodName =  $scope.jobDetails.methodName;
                parameters.batchSize = $scope.batchSize;
                if($scope.jobDetails.additionalInput) {
                    console.log($scope.jobDetails.additionalInput);
                    for(var i in $scope.jobDetails.additionalInput) {
                        parameters[i] = $scope.jobDetails.additionalInput[i];
                    }
                }
                var remoteOptions ={};
                remoteOptions.apexType =  $rootScope.configData.telcoAdminConsoleClassType;
                remoteOptions.parameters =  JSON.stringify(parameters);
                var toast = basicService.infoToast($scope.jobDetails.label, $rootScope.labels.StartingLabel);
                remoteActions.telcoAdminConsloleInvokeMethod(remoteOptions).then(function(result) {
                    $scope.jobDetails.records = result[$scope.jobDetails.listName];
                    toast.hide();
                    basicService.successToast($scope.jobDetails.label, $rootScope.labels.RunningLabel);
                }, function(error) {
                    toast.hide();
                    basicService.errorToast($scope.jobDetails.label, $rootScope.labels.CouldntStartLabel);
                });
            }
        }
    }
}]);

},{}],7:[function(require,module,exports){
angular.module('CMTAdmin')
.factory('PageSpinner', [
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
angular.module('CMTAdmin')
.factory('ActiveMenu', [
	function(){
		var menuTemplate = 'Dashboard.tpl.html';
		return {
			getActiveMenu: function() {
				return menuTemplate;
			},
			setActiveMenu: function(menu) {
				menuTemplate = menu + '.tpl.html';
			}
		};
	}
]);
// This module is necessary to pass salesforce merged valued to directives in static resources.
//used for the field Lookup Directive
angular.module('parameters',[])
	.factory('ParametersFactory', ['$window', function(window){
		var factory = {};
		factory.getRemoteInvokeMethod = function(){
			return window.configData.adminInvokeMethod;
		
		};
		
		factory.getClassType = function(){
			return window.configData.adminClassType;
		
		};
		
		factory.getLoadingImg = function(){
			return window.configData.waitingImage;
		};
		
		factory.getNsPrefix = function(){
			return window.configData.nsPrefix;
		};
		
		return factory;
	
	}]);
},{}],8:[function(require,module,exports){
var app = angular.module('CMTAdmin');
app.service('BasicService',['$sldsModal', '$sldsToast', '$sldsPrompt', '$window', function BasicService(modal, toast, prompt, window) {

    BasicService.prototype.openAlertWindow = function (title, message) {
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

    BasicService.prototype.openSuccessWindow = function (title, message) {
        deletePrompt = prompt({
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

    BasicService.prototype.successToast = function (title, content) {
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

    BasicService.prototype.errorToast = function (title, content) {
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

    BasicService.prototype.warningToast = function (title, content) {
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

    BasicService.prototype.infoToast = function (title, content) {
        return toast({
            title: title,
            content: content,
            severity: 'info',
            icon: 'info',
            templateUrl: 'SldsToast.tpl.html',
            autohide: false,
            show: true
        });
    };
}]);

},{}],9:[function(require,module,exports){
angular.module("CMTAdmin").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("UpgradePricingFieldJob.tpl.html",'<batch-job job-details="jobType.pricingFieldJob" input-template="\'pricingFieldJobAdditionalInput.html\'"></batch-job>\n\n<script type="text/ng-template" id="pricingFieldJobAdditionalInput.html">\n    <div ng-init="additionalInput = jobDetails.additionalInput; additionalData = jobDetails.additionalData">\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-3">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminObjectToUpgrade}}</label>\n                <div class="slds-form-element__control">\n                    <select ng-required="true" class="slds-select"\n                        ng-model="additionalInput.objectName"\n                        ng-options="obj.id as obj.label for obj in additionalData.objectList">\n                    </select>\n                </div>\n            </div>\n        </div>\n    </div>\n<\/script>'),$templateCache.put("ReportJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'reportJobs\',labels.CMTOptionReportJobsLabel)">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="job-wrapper">\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="#">{{labels.AuditProductSpecificationType}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.AuditProductSpecificationTypeDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="confirmationEmailSendingPopup(jobWrapper.ReportNullSpecTypeBatchJob);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div> \n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="#">{{labels.AuditProductStructure}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.AuditProductStructureDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="confirmationEmailSendingPopup(jobWrapper.ReportMismatchedSpecTypeBatchJob);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("UpgradeJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'upgradeJobs\',labels.CMTOptionUpgradeJobsLabel)">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\n    <batch-job job-details="jobType.rootPCIJob"></batch-job>\n    \n    <batch-job job-details="jobType.sellingDatesJob"></batch-job>\n\n    <batch-job job-details="jobType.requestedStartDatesJob"></batch-job>\n\n    <batch-job job-details="jobType.updateGlobalKeyPathJob"></batch-job>\n    \n    <batch-job job-details="jobType.updateEncryptAttrJob"></batch-job>\n\n    <ng-include  src="\'AttributeUpgradeJob.tpl.html\'"></ng-include>\n\n    <ng-include src="\'RelationshipUpgradeJob.tpl.html\'"></ng-include>\n\n    <batch-job job-details="jobType.actionUpgradeJob"></batch-job>\n\n    <batch-job job-details="jobType.catalogCodeUpgradeJob"></batch-job>\n\n    <ng-include src="\'WorkSetUpgradeJob.tpl.html\'"></ng-include>\n\n    <ng-include src="\'VersioningUpgradeJob.tpl.html\'"></ng-include>\n\n    <batch-job job-details="jobType.multiServiceUpgradeJob"></batch-job>\n\n    <ng-include src="\'UpgradePricingFieldJob.tpl.html\'"></ng-include>\n</div>\n'),$templateCache.put("QuasiRecordsModal.tpl.html",'<section role="dialog" tabindex="-1" aria-labelledby="modal-heading-01" aria-modal="true" aria-describedby="modal-content-id-1" class="slds-modal slds-fade-in-open">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header" ng-class="confirmationClass">\n            <slds-button-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'large\'" extra-classes="\'slds-modal__close slds-button_icon-inverse\'" ng-click="$hide()"></slds-button-svg-icon>\n            <h2 class="slds-text-heading_medium slds-hyphenate">{{labels.DeleteQuasiRecords}}</h2>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div class="job-desc slds-m-top_xx-small">{{creationTimeLbl}}</div>\n            <div class="slds-m-left_small slds-form-element slds-m-top_small">\n                <div class="job-desc slds-m-top_xx-small">{{recordsCreationDateTime}}</div>\n                <div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_right">\n                    <div class="slds-form-element__control">\n                        <input type="text" class="slds-input slds-size--1-of-2 vloc-dt-date"\n                            id="text-input-03"\n                            ng-model="expirationTime.value"\n                            slds-date-picker="true"\n                            data-date-format="M/d/yyyy"\n                            data-date-type="number" data-container=".via-slds" ng-change="validateCheck()"/>\n                        <input type="text" class="slds-input slds-size--1-of-2 vloc-dt-time"\n                            id="text-input-04"\n                            ng-model="expirationTime.value"\n                            slds-time-picker="true"\n                            data-time-format="h:mm a"\n                            data-time-type="number" data-container=".via-slds" ng-change="validateCheck()"/>\n                    </div>\n                </div>\n            </div>\n        </div>\n        <div class="slds-modal__footer"> \n            <button type="button" class="slds-button slds-button--neutral" ng-click="$hide()">{{cancelActionLbl}}</button> \n            <button type="button" class="slds-button slds-button--neutral slds-button--brand" ng-disabled="okBtnDisabled" ng-click="confirmAction()">{{confirmActionLbl}}</button> \n        </div>\n    </div>\n</section>'),$templateCache.put("EnableFeatures.tpl.html",'<div ng-controller="EnableFeaturesController" ng-init="initApp(\'EnableFeatures\', \'Enable Features\')">\n    <div ng-include="\'SubHeader.tpl.html\'"></div>\n    <div class="scroll-vertical slds-theme_shade">\n        <div class="job-wrapper slds-p-around_medium" ng-repeat="feature in featureList">\n            <div class="slds-grid slds-theme_default slds-p-around_small">\n                <div class="slds-size_1-of-2 slds-p-top_x-small">\n                    <span ng-bind="feature.label"></span>\n                </div>\n                <div class="slds-size_1-of-2">\n                    <div class="slds-float_right slds-form-element">\n                        <label class="slds-checkbox_toggle slds-grid">\n                            <input type="checkbox" name="checkbox" aria-describedby="toggle-desc" ng-model="feature.isEnabled"\n                            ng-change="enableDisableFeature(feature)" />\n                            <span id="toggle-desc" class="slds-checkbox_faux_container" aria-live="assertive">\n                                <span class="slds-checkbox_faux"></span>\n                                <span class="slds-checkbox_on">{{labels.EnabledLabel}}</span>\n                                <span class="slds-checkbox_off">{{labels.DisabledLabel}}</span>\n                            </span>\n                        </label>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("PageSelectionModal.tpl.html",'<div class="page-selection slds-modal slds-fade-in-open" aria-hidden="false" role="dialog">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header">\n            <button class="slds-button slds-button_icon-inverse slds-modal__close" ng-click="$hide()">\n                <svg aria-hidden="true" class="slds-button__icon slds-button__icon_large">\n                    <use xlink:href="{{SLDSICON.CLOSE}}"></use>\n                </svg>\n                <span class="slds-assistive-text">{{labels.Close}}</span>\n            </button>\n            <h2 class="slds-text-heading_medium">{{confirmationTitle}}</h2>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div class="slds-spinner_container" ng-if="showLoading">\n                <div class="slds-spinner_brand slds-spinner slds-spinner_medium" aria-hidden="false" role="alert">\n                    <div class="slds-spinner__dot-a"></div>\n                    <div class="slds-spinner__dot-b"></div>\n                </div>\n            </div>\n            <div class="search-wrapper" ng-if="!showLoading">\n                <svg aria-hidden="true" class="slds-icon">\n                    <use xlink:href="{{SLDSICON.SEARCH}}"></use>\n                </svg>\n                <input type="search" placeholder="Search" ng-model="search"/>\n                <button class="slds-button" ng-click="searchPage(search)">{{labels.SearchLabel}}</button>\n            </div>\n            <table class="table-wrapper slds-table slds-table_bordered slds-table_cell-buffer slds-m-top_medium" ng-if="!showLoading && pageList && pageList.length !== 0">\n                <thead>\n                    <tr class="slds-text-heading_label">\n                        <th scope="col">\n                            <div class="slds-truncate">{{labels.SelectLabel}}</div>\n                        </th>\n                        <th scope="col">\n                            <div class="slds-truncate">{{labels.NameLabel}}</div>\n                        </th>\n                        <th scope="col">\n                            <div class="slds-truncate">{{labels.LabelLabel}}</div>\n                        </th>\n                        <th scope="col">\n                            <div class="slds-truncate">{{labels.ApiVersionLabel}}</div>\n                        </th>\n                    </tr>\n                </thead>\n                <tbody>\n                    <tr ng-repeat="p in pageList track by $index">\n                        <td style="width:10%;">\n                            <input type="radio" ng-model="pageWrapper.page" ng-value="p" name="vfpage">\n                        </td>\n                        <td style="width:30%;">\n                            <div class="slds-truncate">{{p.Name}}</div>\n                        </td>\n                        <td style="width:30%;">\n                            <div class="slds-truncate">{{p.MasterLabel}}</div>\n                        </td>\n                        <td style="width:30%;">\n                            <div class="slds-truncate">{{p.ApiVersion}}</div>\n                        </td>\n                    </tr>\n                </tbody>\n            </table>\n            <div class="error" ng-if="!showLoading && (!pageList || pageList.length === 0)">\n                <p>{{labels.NoPageFoundError}}</p>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral" ng-click="$hide()">{{cancelActionLbl}}</button>\n            <button type="button" class="slds-button slds-button_neutral slds-button_brand" ng-click="confirmAction()" ng-disabled="!pageWrapper.page.Name || pageWrapper.page.Name === \'\' ">{{confirmActionLbl}}</button>\n        </div>\n    </div>\n</div>\n<div class="slds-backdrop slds-backdrop_open"></div>\n'),$templateCache.put("Module.tpl.html",'<div class="slds-p-around_small" ng-if="!showLoading">\n\t<ng-form name="moduleForm">\n\t\t<div class="slds-input-has-icon slds-input-has-icon_left">\n\t\t\t<slds-svg-icon sprite="\'utility\'" icon="\'search\'" extra-classes="\'slds-input__icon slds-input__icon_left\'"></slds-svg-icon>\n\t\t\t<input type="search" placeholder="{{labels.SearchLabel}}"\n\t\t\tng-model="search.name" class="slds-input">\n\t\t</div>\n\t\t<table class="slds-table slds-table_bordered slds-table_cell-buffer slds-m-top_medium">\n\t  \t\t<thead>\n\t    \t\t<tr class="slds-text-heading_label">\n\t\t\t\t\t<th scope="col" data-title="{{column.label}}" ng-repeat="column in subModuleList[activeTab].metaDataList">\n\t\t\t\t\t\t<div class="slds-truncate">{{column.label}}</div>\n\t\t\t\t\t</th>\n\t\t\t\t\t<th scope="col">\n\t\t\t\t\t\t<div class="slds-p-horizontal_x-small">{{labels.ActionLabel}}</div>\n\t    \t\t\t</th>\n\t    \t\t</tr>\n\t  \t\t</thead>\n\t  \t\t<tbody>\n\t    \t\t<tr scope="row" ng-repeat="record in subModuleList[activeTab].records| filter:filterList track by $index">\n\t\t\t\t\t<td ng-repeat="column in subModuleList[activeTab].metaDataList" data-label="{{record[column.name]}}" title="{{record[column.name]}}" class="slds-cell-wrap">\n\n\t\t\t\t\t\t<div ng-if="!record.editMode" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t<div ng-if="getViewOption(column.name) === 0">{{record[column.name]}}</div>\n\t\t\t\t\t\t\t<div ng-if="getViewOption(column.name) === 1">\n\t\t\t\t\t\t\t\t{{getObjectLabel(record[column.name])}}\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="getViewOption(column.name) === 2">\n\t\t\t\t\t\t\t\t{{getFieldLabel(record)}}\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<div ng-if="record.editMode">\n\t\t\t\t\t\t\t<div ng-if="column.name === \'Name\' && subModuleList[activeTab].name !== \'configurations\'" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t\t{{record[column.name]}}\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === \'Name\' && subModuleList[activeTab].name === \'configurations\'">\n\t\t\t\t\t\t\t\t<input type="text" ng-required="true" ng-model="record[column.name]" ng-change="verifyDuplicate(column.name)" ng-class="{\'ng-invalid-required\':record.isDuplicate}" class="slds-input" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'IsEditable__c\'">\n\t\t\t\t\t\t\t\t<select ng-options="boolean.value as boolean.label for boolean in booleanSelectionOptions" ng-model="record[column.name]" ng-required="true" class="slds-select">\n\t\t\t\t\t\t\t\t\t<option value="" ng-disabled="true">{{labels.SelectLabel}}</option>\n\t\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'ObjectName__c\' || column.name === nsPrefix  + \'Object_Name__c\'" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t\t<select ng-options="object.name as object.label for object in allObjectList" ng-model="record[column.name]" ng-required="true" class="slds-select" ng-change="record[nsPrefix  + \'FieldName__c\'] = \'\' ">\n\t\t\t\t\t\t\t\t\t<option value="" ng-disabled="true">{{labels.SelectLabel}}</option>\n\t\t\t\t\t\t\t\t</select>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'FieldName__c\' ">\n\t\t\t\t\t\t\t\t<div class="slds-is-relative">\n\t\t\t\t\t\t\t\t\t<input type="text" ng-required="true" ng-disabled="true" class="slds-input" ng-model="record[column.name]">\n\t\t\t\t\t\t\t\t\t<button class="slds-button slds-button-icon-position" ng-click="openFieldSelection(record)" ng-disabled="!record[nsPrefix + \'ObjectName__c\'] && !record[nsPrefix + \'Object_Name__c\']">\n\t\t\t\t\t\t\t\t\t\t<slds-button-svg-icon sprite="\'utility\'" icon="\'edit\'" extra-classes="\'slds-input__icon slds-icon-text-default\'"></slds-button-svg-icon>\n\t\t\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'Sequence__c\'">\n\t\t\t\t\t\t\t\t<input type="text" ng-model="record[column.name]" ng-change="verifyDuplicate(column.name)" ng-class="{\'ng-invalid-required\':record.isDuplicate}" ng-required="true" class="slds-input" ng-pattern="/^\\d+$/"/>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'Feature__c\'" ng-init="record[column.name]=subModuleList[activeTab].feature">\n\t\t\t\t\t\t\t\t<input type="text" ng-model="record[column.name]" ng-readonly="true" ng-required="true" ng-disabled="true" class="slds-input" data-title="{{record[column.name]}}"/>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'Popup_Page_Id__c\'">\n\t\t\t\t\t\t\t\t<div class="slds-is-relative">\n\t\t\t\t\t\t\t\t\t<input type="text" ng-required="true" ng-disabled="true" class="slds-input" ng-model="record[column.name]" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t\t\t<button class="slds-button slds-button-icon-position" ng-click="openPageSelection(record)">\n\t\t\t\t\t\t\t\t\t\t<slds-button-svg-icon sprite="\'utility\'" icon="\'search\'" extra-classes="\'slds-input__icon slds-icon-text-default\'"></slds-button-svg-icon>\n\t\t\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'SetupValue__c\'">\n\t\t\t\t\t\t\t\t<input type="text" ng-required="true" ng-model="record[column.name]" class="slds-input" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if="column.name === nsPrefix + \'Value__c\'">\n\t\t\t\t\t\t\t\t<input type="text" ng-required="true" ng-model="record[column.name]" class="slds-input" data-title="{{record[column.name]}}">\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</td>\n\t\t\t\t\t<td data-label="Action" title="Action">\n\t\t\t\t\t\t<button class="slds-button" ng-disabled="record.editMode" ng-click="record.editMode = true">\n\t\t\t\t\t\t\t<slds-button-svg-icon sprite="\'utility\'" icon="\'edit\'" extra-classes="\'slds-input__icon slds-icon-text-default\'"></slds-button-svg-icon>\n\t\t\t\t\t\t</button>\n\t\t\t\t\t\t<button class="slds-button" ng-click="delete(record, $index)">\n\t\t\t\t\t\t  \t<slds-button-svg-icon sprite="\'utility\'" icon="\'delete\'" extra-classes="\'slds-input__icon slds-icon-text-default\'"></slds-button-svg-icon>\n\t\t\t\t\t  \t</button>\n\t\t\t\t\t</td>\n\t    \t\t</tr>\n\t  \t\t</tbody>\n\t\t</table>\n\t\t<div class="slds-grid slds-grid_align-center slds-button-group slds-m-top_medium" role="group">\n\t\t\t<button class="slds-button slds-button_neutral" ng-click="add(subModuleList[activeTab].records)">{{labels.AddLabel}}</button>\n\t\t\t<button class="slds-button slds-button_neutral" ng-click="save()" ng-disabled="isDuplicate || moduleForm.$invalid || checkSaveMode()">{{labels.SaveLabel}}</button>\n\t\t</div>\n\t</ng-form>\n</div>\n'),$templateCache.put("PowerUpdate.tpl.html",'<div ng-controller="CustomSettingsController" ng-init="initApp(\'powerupdate\')">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="slds-p-around_small" slds-active-pane="tab.index" slds-tabs-pane-class="slds-p-top_none" slds-tabs="true">\n\t\t<div ng-repeat="subModule in subModuleList" slds-pane="true" data-title="{{subModule.label}}" ng-include="\'Module.tpl.html\'"></div>\n\t</div>\n</div>'),$templateCache.put("fieldLookup.html",'<div class="slds-grid slds-grid_pull-padded">\n\t\t<div class="fieldsContainer-{{$index}} slds-size_1-of-2"  ng-repeat="fieldSet in fieldSets track by $index" ng-init="outerIndex = $index">\n\t\t\t<select class="slds-select" size="10" ng-change="populateNextTable($index, selectedFields[$index])" data-ng-options="field as field.label+\'<\'+field.name+\'>\' for field in fieldSet | orderBy:\'label\'" data-ng-model="selectedFields[$index]">\n\t\t\t\t<option value="" ng-if="false"></option>\n\t\t\t</select>\t\t\t\t\t\t\t\n\t\t</div>\n</div>'),$templateCache.put("CAJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'CAJob\', labels.CMTOptionCacheableAPIJobsLabel)">\n    <div ng-include="\'SubHeader.tpl.html\'"></div>\n    <div class="job-wrapper">\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="javascript:void(0)">{{labels.LoadAPIMetadataCAJob}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_x-small">{{labels.LoadAPIMetadataCAJobDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="loadAPIMetadataCAJob();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="javascript:void(0)" ng-click="isCacheJobCollapsed = !isCacheJobCollapsed">{{labels.PopulateCacheCAJob}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.PopulateCacheCAJobDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="isCacheJobCollapsed = true; showCAJobListPopup();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="cacheableAPIJobsList.length != 0" ng-show="isCacheJobCollapsed">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                        <tr>\n                            <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n                        </tr>\n                    </thead>\n                    <tbody>\n                        <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n                                        \'slds-theme_default\': job.Status == \'Holding\',\n                                        \'slds-theme_default\': job.Status == \'Preparing\',\n                                        \'slds-theme_success\': job.Status == \'Completed\',\n                                        \'slds-theme_info\': job.Status == \'Aborted\',\n                                        \'slds-theme_warning\': job.Status == \'Processing\',\n                                        \'slds-theme_error\': job.Status == \'Failed\'}"\n                            ng-repeat="job in cacheableAPIJobsList track by $index">\n                            <td class="slds-cell-wrap">\n                                <p>{{job.Name}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.Status}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.TotalJobItems}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.JobItemsProcessed}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{ job.CreatedDate | date : \'short\' }}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{ job.CompletedDate | date : \'short\' }}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.ExtendedStatus}}</p>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="javascript:void(0)" ng-click="isDeleteOldCacheResponseCollapsed = !isDeleteOldCacheResponseCollapsed">{{labels.DeleteExpiredAPICache}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.DeleteExpiredAPICacheDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="isDeleteOldCacheResponseCollapsed = true; deleteOldCacheResponse();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="deleteExpiredCacheJobsList.length != 0" ng-show="isDeleteOldCacheResponseCollapsed">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                    <tr>\n                        <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n                    </tr>\n                    </thead>\n                    <tbody>\n                    <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n                                        \'slds-theme_default\': job.Status == \'Holding\',\n                                        \'slds-theme_default\': job.Status == \'Preparing\',\n                                        \'slds-theme_success\': job.Status == \'Completed\',\n                                        \'slds-theme_info\': job.Status == \'Aborted\',\n                                        \'slds-theme_warning\': job.Status == \'Processing\',\n                                        \'slds-theme_error\': job.Status == \'Failed\'}"\n                        ng-repeat="job in deleteExpiredCacheJobsList track by $index">\n                        <td class="slds-cell-wrap">\n                            <p>{{labels.DeleteExpiredAPICache}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.Status}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.TotalJobItems}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.JobItemsProcessed}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{ job.CreatedDate | date : \'short\' }}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{ job.CompletedDate | date : \'short\' }}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.ExtendedStatus}}</p>\n                        </td>\n                    </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="javascript:void(0)" ng-click="isDeleteQuasiRecordsCollapsed = !isDeleteQuasiRecordsCollapsed">{{labels.DeleteQuasiRecords}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.DeleteQuasiRecordsDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="isDeleteQuasiRecordsCollapsed = true; deleteQuasiRecordsPopup();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="deleteQuasiRecordsJobsList.length != 0" ng-show="isDeleteQuasiRecordsCollapsed">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                    <tr>\n                        <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n                    </tr>\n                    </thead>\n                    <tbody>\n                    <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n                                        \'slds-theme_default\': job.Status == \'Holding\',\n                                        \'slds-theme_default\': job.Status == \'Preparing\',\n                                        \'slds-theme_success\': job.Status == \'Completed\',\n                                        \'slds-theme_info\': job.Status == \'Aborted\',\n                                        \'slds-theme_warning\': job.Status == \'Processing\',\n                                        \'slds-theme_error\': job.Status == \'Failed\'}"\n                        ng-repeat="job in deleteQuasiRecordsJobsList track by $index">\n                        <td class="slds-cell-wrap">\n                            <p>{{labels.DeleteQuasiRecords}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.Status}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.TotalJobItems}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.JobItemsProcessed}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{ job.CreatedDate | date : \'short\' }}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{ job.CompletedDate | date : \'short\' }}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.ExtendedStatus}}</p>\n                        </td>\n                    </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="javascript:void(0)" ng-click="isregenerateCachedAPIRecordsCollapsed = !isregenerateCachedAPIRecordsCollapsed">{{labels.RegenerateCachedAPIRecords}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.RegenerateCachedAPIRecordsDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="isregenerateCachedAPIRecordsCollapsed = true; regenerateCacheAPIRecordsJob();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="regenerateCacheAPIRecordsJobsList.length != 0" ng-show="isregenerateCachedAPIRecordsCollapsed" ng-repeat="(key,catagory) in regenerateCacheAPIRecordsJobsList">\n                <div class="job-section slds-p-around_small slds-has-divider_bottom" >\n                \x3c!-- <div class="slds-card__header slds-grid grid--flex-spread slds-hint-parent" >\n                    <div class="slds-float--left ng-binding">Regenerate Job Started at {{catagory[\'DeriveCMAggregateEntityBatch\'].CreatedDate |date : \'short\'}}</div>\n                    \n                </div> --\x3e\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                    <tr>\n                        \x3c!-- <th class="slds-cell-wrap">{{labels.JobName}}</th> --\x3e\n                        \x3c!-- <th class="slds-cell-wrap">Job Id</th>  --\x3e\n                        <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n                    </tr>\n                    </thead>\n                    <tbody>\n                    <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n                                        \'slds-theme_default\': job.Status == \'Holding\',\n                                        \'slds-theme_default\': job.Status == \'Preparing\',\n                                        \'slds-theme_success\': job.Status == \'Completed\',\n                                        \'slds-theme_info\': job.Status == \'Aborted\',\n                                        \'slds-theme_warning\': job.Status == \'Processing\',\n                                        \'slds-theme_error\': job.Status == \'Failed\'}"\n                        ng-repeat="job in catagory track by $index">\n                        \x3c!-- <td class="slds-cell-wrap">\n                            <p>{{labels.RegenerateCachedAPIRecords}}</p>\n                        </td> --\x3e\n\n                        \x3c!-- <td class="slds-cell-wrap">\n                            <p>{{job.Id}}</p>\n                        </td> --\x3e\n                        <td class="slds-cell-wrap">\n                            <p>{{job.ApexClass.Name}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.Status}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.TotalJobItems}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.JobItemsProcessed}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{ job.CreatedDate | date : \'short\' }}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{ job.CompletedDate | date : \'short\' }}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.ExtendedStatus}}</p>\n                        </td>\n                    </tr>\n                    </tbody>\n                </table>\n            </div>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="javascript:void(0)" ng-click="iscacheMigrationJobsCollapsed = !iscacheMigrationJobsCollapsed">{{labels.CacheMigrationJobs}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.CacheMigrationJobsDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="iscacheMigrationJobsCollapsed = true; cacheMigrationJobs();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="cacheMigrationJobsList.length != 0" ng-show="iscacheMigrationJobsCollapsed">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                    <tr>\n                        <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                        <th class="slds-cell-wrap">{{labels.JobId}}</th>\n                        <th class="slds-cell-wrap">{{labels.Status}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                        <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                    </tr>\n                    </thead>\n                    <tbody>\n                    <tr ng-class="{ \'slds-theme_default\': job.Status == \'queued\',\n                                        \'slds-theme_success\': job.Status == \'completed\',\n                                        \'slds-theme_success\': job.Status == \'success\',\n                                        \'slds-theme_warning\': job.Status == \'running\',\n                                        \'slds-theme_error\': job.Status == \'failed\'}"\n                        ng-repeat="job in cacheMigrationJobsList track by $index">\n                        <td class="slds-cell-wrap">\n                            <p>{{labels.CacheMigrationJobs}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.ExternalJobId}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.Status}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.CreatedDate}}</p>\n                        </td>\n                        <td class="slds-cell-wrap">\n                            <p>{{job.LastModifiedDate}}</p>\n                        </td>\n                    </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n   </div> \n</div>'),$templateCache.put("ProductManagementConfig.tpl.html",'<div ng-controller="CustomSettingsController" ng-init="initApp(\'prodMgmtCfg\')">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="slds-p-around_small" slds-active-pane="tab.index" slds-tabs-pane-class="slds-p-top_none" slds-tabs="true">\n\t\t<div ng-repeat="subModule in subModuleList" slds-pane="true" data-title="{{subModule.label}}" ng-include="\'Module.tpl.html\'"></div>\n\t</div>\n</div>'),$templateCache.put("WorkSetUpgradeJob.tpl.html",'<batch-job job-details="jobType.workSetUpgradeJob" input-template="\'worksetUpgradeAdditionalInput.html\'"></batch-job>\n\n<script type="text/ng-template" id="worksetUpgradeAdditionalInput.html">\n    <div ng-init="additionalInput = jobDetails.additionalInput;">\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-3">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminBatchSizeLimit100}}</label>\n                <div class="slds-form-element__control">\n                    <input class="slds-input"\n                        ng-class="{\'slds-has-error\': additionalInput.workSetItemUpgradeJobBatchSize && (additionalInput.workSetItemUpgradeJobBatchSize == 0 || additionalInput.workSetItemUpgradeJobBatchSize < 1 || additionalInput.workSetItemUpgradeJobBatchSize > 100)}"\n                        ng-model="additionalInput.workSetItemUpgradeJobBatchSize"\n                        min="1" max="100"\n                        type="number"\n                        ng-init="additionalInput.workSetItemUpgradeJobBatchSize = 100;">\n                </div>\n            </div>\n        </div>\n    </div>\n<\/script>\n'),$templateCache.put("Dashboard.tpl.html",'<div>\n    <div class="slds-p-around_small">\n    </div>\n    <div class="slds-grid slds-grid_pull-padded-small">\n    \t<div class="slds-p-horizontal_small slds-size_1-of-3 slds-medium-size_2-of-6 slds-large-size_4-of-12" ng-repeat="section in sectionList track by $index" ng-class="{\'slds-p-right_small\': $index % 1 === 0}">\n            <div class="slds-card">\n                <div class="slds-card__header slds-grid grid_flex-spread slds-p-horizontal_x-small">\n                    <h2 class="slds-text-heading_medium slds-truncate" title="{{section.name}}">{{section.label}}</h2>\n                </div>\n                <div class="slds-card__body">\n                    <ul class="slds-list_vertical slds-has-dividers_top-space slds-has-list-interactions slds-theme_default fix-border-bottom-radius">\n                        <li class="slds-list__item slds-p-horizontal_x-small" ng-repeat="menu in section.menuList">\n                            <div class="slds-clearfix">\n                                <div class="slds-float_left">\n                                    <a href ng-click="showClickedMenu(menu.name)" title="{{menu.label}}">{{menu.label}}\n                                    </a>\n                                </div>\n                            </div>\n                        </li>\n                    </ul>\n                </div>\n            </div>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("SubHeader.tpl.html",'<div class="slds-clearfix slds-p-around_small">\n\t<span class="slds-text-heading_medium slds-float_left">{{module.label}}</span>\n\t<span class="slds-float_right">\n\t\t<button class="slds-button slds-button_neutral" ng-click="showClickedMenu(\'Dashboard\')">{{labels.BackToDashboardLabel}}</button>\n\t</span>\n</div>\n'),$templateCache.put("CAJobListModal.tpl.html",'<section role="dialog" tabindex="-1" aria-labelledby="modal-heading-01" aria-modal="true" aria-describedby="modal-content-id-1" class="slds-modal slds-fade-in-open">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header" ng-class="confirmationClass">\n            <slds-button-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'large\'" extra-classes="\'slds-modal__close slds-button_icon-inverse\'" ng-click="$hide()"></slds-button-svg-icon>\n            <h2 class="slds-text-heading_medium slds-hyphenate">{{confirmationTitle}}</h2>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div class="slds-scrollable tbl-cache-handler">\n                <table class="slds-table slds-table_bordered">\n                    <th ng-repeat="columnTitle in columnTitles">\n                    <span ng-if="columnTitle === \'Name\'">\n                        <input id="caJob_{{job.JobId}}" type="checkbox" ng-model="allSelected" ng-change="selectAll(allSelected)" ng-true-value="1" ng-false-value="0"/>\n                        &nbsp;{{columnTitle}}    \n                    </span>\n                    <span ng-if="columnTitle !== \'Name\'">\n                        {{columnTitle}}    \n                    </span>\n                    <tr ng-repeat="job in caJobList">\n                        <td><label for="caJob_{{job.JobId}}">\n                        <input id="caJob_{{job.JobId}}" type="checkbox" ng-model="job.Selected" ng-change="validateCheck()" ng-true-value="1" ng-false-value="0"/>\n                        &nbsp;{{job.Name}}\n                        </label></td>\n                        <td>{{job.LastEffectiveStartTime}}</td>\n                        <td>{{job.LastExpirationTime}}</td>\n                        <td>{{job.LastCachedTime}}</td>\n                    </tr>\n                </table>\n            </div>\n            <div class="job-desc slds-m-top_xx-small">Filters</div>\n            <div ng-repeat="filter in filters">\n                <div class="slds-scrollable tbl-cache-handler">\n                    <table class="slds-table slds-table_bordered">\n                        <th>\n                        <span>\n                            \x3c!-- <input type="checkbox" ng-model="filter.SelectedAll"  ng-true-value="1" ng-false-value="0"/> --\x3e\n                            &nbsp;\n                            {{filter.Name}} \n                            &nbsp; &nbsp; &nbsp; &nbsp; \n                            Search <input type="text" ng-model="searchText" placeholder="Type to filter {{filter.Name}} ">\n                        </span>\n                        <tr>\n                            <td>\n                            <span>\n                                <input ng-model="filter.SelectedAll" type="checkbox"  ng-change="selectFilters(filter, null ,filter.SelectedAll, true)" ng-true-value="true" ng-false-value="false"/>\n                                All&nbsp;\n                            </span>\n                            <span ng-repeat="filterOption in filter.Options | filter:searchText">\n                                <input id="filterOption_{{filterOption.Value}}" ng-change="validateCheck()" ng-disabled="filter.SelectedAll" ng-model="filterOption.Selected" type="checkbox"  ng-true-value="true" ng-false-value="false"/>\n                                {{ filterOption.Name }}&nbsp;\n                                ({{ filterOption.Code }})&nbsp;\n                            </span>\n                            </td>\n                        </tr>\n                        <tr><td></td></tr>\n                    </table>\n                </div>\n            </div>\n            <div class="job-desc slds-m-top_xx-small">{{effectiveStartTimeLbl}}</div>\n            <div class="slds-m-left_small slds-form-element slds-m-top_small">\n                <div class="slds-form-element__control">\n                     <input type="text" class="slds-input slds-size--1-of-2 vloc-dt-date"\n                        id="text-input-01"\n                        ng-model="effectiveStartTime.value"\n                        slds-date-picker="true"\n                        data-date-format="M/d/yyyy"\n                        data-date-type="number" data-container=".via-slds" ng-change="validateCheck()"/>\n                    <input type="text" class="slds-input slds-size--1-of-2 vloc-dt-time"\n                        id="text-input-02"\n                        ng-model="effectiveStartTime.value"\n                        slds-time-picker="true"\n                        data-time-format="h:mm a"\n                        data-time-type="number" data-container=".via-slds" ng-change="validateCheck()"/>\n                </div>\n            </div>\n            <div class="job-desc slds-m-top_xx-small">{{expirationTimeLbl}}</div>\n            <div class="slds-m-left_small slds-form-element slds-m-top_small">\n                <div class="slds-form-element__control slds-input-has-icon slds-input-has-icon_right">\n                    <div class="slds-form-element__control">\n                        <input type="text" class="slds-input slds-size--1-of-2 vloc-dt-date"\n                            id="text-input-03"\n                            ng-model="expirationTime.value"\n                            slds-date-picker="true"\n                            data-date-format="M/d/yyyy"\n                            data-date-type="number" data-container=".via-slds" ng-change="validateCheck()"/>\n                        <input type="text" class="slds-input slds-size--1-of-2 vloc-dt-time"\n                            id="text-input-04"\n                            ng-model="expirationTime.value"\n                            slds-time-picker="true"\n                            data-time-format="h:mm a"\n                            data-time-type="number" data-container=".via-slds" ng-change="validateCheck()"/>\n                    </div>\n                </div>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral" ng-click="$hide()">{{cancelActionLbl}}</button>\n            <button type="button" class="slds-button slds-button_brand" ng-disabled="okBtnDisabled" ng-click="confirmAction()">{{confirmActionLbl}}</button>\n        </div>\n    </div>\n</section>\n<div class="slds-backdrop slds-backdrop_open"></div>'),$templateCache.put("CpqConfig.tpl.html",'<div ng-controller="CustomSettingsController" ng-init="initApp(\'genericcpq\')">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="slds-p-around_small" slds-active-pane="tab.index" slds-tabs-pane-class="slds-p-top_none" slds-tabs="true">\n\t\t<div ng-repeat="subModule in subModuleList" slds-pane="true" data-title="{{subModule.label}}" ng-include="\'Module.tpl.html\'"></div>\n\t</div>\n</div>'),$templateCache.put("FunctionalJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'FunctionalJobs\', labels.CMTOptionFunctionalJobsLabel)">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="job-wrapper">\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.BasicConfigLabel}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.BasicConfigDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button id="testConfigurationsJobButton" type="button" ng-click="showTestResults = true; testConfigurationsJob();" class="slds-button  slds-button_brand">{{labels.CheckLabel}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\n\t\t\t<div class="row">\n\t\t\t\t<div id="testConfigurationsJobStatus" class="col-md-12 col-sm-12 col-xs-12">\n\t\t\t\t\t<div ng-if="hasError" style="color : red" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\n\t\t\t<div ng-if="configResult.Cache != 0" ng-show="showTestResults">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<tr ng-class="slds-theme_shade" style="background-color : #cfeef8">\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Cache</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Current Status (Used Capacity)</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Expected Status</th>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr ng-class="{\'slds-theme_error\': configResult.Cache.SessionCache !== \'Available\' || configResult.Cache.SessionCacheSize> 95}">\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>Session Cache</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{configResult.Cache.SessionCache}} ({{configResult.Cache.SessionCacheSize}}%)</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>Available</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr ng-class="{\'slds-theme_error\': configResult.Cache.OrganizationCache !== \'Available\' || configResult.Cache.OrganizationCacheSize> 95}">\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>Organization Cache</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{configResult.Cache.OrganizationCache}} ({{configResult.Cache.OrganizationCacheSize}}%)</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>Available</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\n\t\t\t<div ng-if="result != 0" ng-show="showTestResults">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<tr ng-class="slds-theme_success" style="background-color : #cfeef8">\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Triggers</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Current Value</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Expected Value</th>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr ng-class="{ \'slds-theme_error\': configResult.AllTriggers != \'On\' }">\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>AllTriggers</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{configResult.AllTriggers}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>On</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\n\t\t\t<div ng-if="result != 0" ng-show="showTestResults">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<tr ng-class="slds-theme_success" style="background-color : #cfeef8">\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Custom Field Map</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Current Value</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Expected Value</th>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr ng-class="{\'slds-theme_warning\': configResult.CustomFieldMapCount < 300}">\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>CustomFieldMapCount</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{configResult.CustomFieldMapCount}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>> 300</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\n\t\t\t<div ng-if="result != 0" ng-show="showTestResults">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<tr ng-class="slds-theme_success" style="background-color : #cfeef8">\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Interface Implementation</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Current Value</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Expected Value</th>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr ng-class="{\'slds-theme_warning\': configResult.InterfaceImplementationCount < 50}">\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>InterfaceImplementationCount</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{configResult.InterfaceImplementationCount}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>>=50</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\n\t\t\t<div ng-if="result != 0" ng-show="showTestResults">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover">\n\t\t\t\t\t<tr ng-class="slds-theme_success" style="background-color : #cfeef8">\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Custom Settings</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Current Value</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Default Value</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Expected Value</th>\n\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Description</th>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr ng-repeat="(key, value) in configResult.CustomSettings" >\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{key}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{value.Current}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{value.Defaults}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{value.Expected}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t<p>{{value.Description}}</p>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t</div>\n\t</div>\n</div>\n'),$templateCache.put("VersioningUpgradeJob.tpl.html",'<div class="">\n    <div class="job-section slds-p-around_small">\n        <div class="job-content slds-clearfix ">\n            <div class="job-detail slds-float_left">\n                <div class="job-label">\n                    <a>{{labels.UpgradeEPCSchemaJob}}</a>\n                </div>\n                <div class="job-desc">{{labels.UpgradeEPCSchemaJobDesc}}</div>\n            </div>\n        </div>\n        <batch-job job-details="jobType.versionFieldsJob" input-template="\'versionUpgradeAdditionalInput.html\'">\n        </batch-job>\n        <batch-job job-details="jobType.globalGroupKeyPathJob"></batch-job>\n    </div>\n</div>\n<script type="text/ng-template" id="versionUpgradeAdditionalInput.html">\n    <div ng-init="additionalInput = jobDetails.additionalInput; additionalData = jobDetails.additionalData">\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-3">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminObjectToUpgrade}}</label>\n                <div class="slds-form-element__control">\n                        <select ng-required="true" class="slds-select" \n                            data-ng-model="additionalInput.objectString" \n                            ng-change="additionalData.resetVersionFilterList()" \n                            data-ng-options="key for (key , value) in additionalData.upgradableVersionObjectNamesMap"></select>\n                </div>\n            </div>\n\n            <div class="slds-form-element slds-size_1-of-3 slds-p-left_small">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminBatchSize}}</label>\n                <div class="slds-form-element__control">\n                    <input ng-disabled="!additionalInput.objectString"\n                    ng-class="{\'slds-has-error\': additionalInput.versionUpgradeJobBatchSize && (additionalInput.versionUpgradeJobBatchSize == 0 || additionalInput.versionUpgradeJobBatchSize < 1 || additionalInput.versionUpgradeJobBatchSize > 2000)}"\n                        class="slds-input"\n                        ng-model="additionalInput.versionUpgradeJobBatchSize"\n                        min="1" max="2000"\n                        type="number" ng-init="additionalInput.versionUpgradeJobBatchSize = 200">\n                </div>\n            </div>\n\n            <div class="slds-form-element slds-size_1-of-3 slds-p-left_small">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.VersionLabel}}</label>\n                <div class="slds-form-element__control">\n                        <input ng-disabled="!additionalInput.objectString" \n                            ng-class="{\'slds-has-error\': additionalInput.versionLabel && (additionalInput.versionLabel.length > 255)}"\n                            class="slds-input" data-ng-model="additionalInput.versionLabel"\n                            type="text" ng-init="additionalInput.versionLabel = \'V1\'"/>\n                    </div>\n                </div>\n            </div>\n        </div>\n\n        \x3c!-- <div class="slds-hidden"> DO NOT REMOVE THIS\n            <div class="slds-col slds-size_2-of-3">\n                <b>{{labels.CMTAdminFilterRecordsBy}}</b>\n                <div class="slds-grid slds-gutters" ng-repeat="objectFilter in upgradeTab.versionObjectFilterList track by $index">\n                    <div class="slds-col slds-size_2-of-6">\n                        <select ng-disabled="!upgradeTab.objectString" class="slds-select" \n                        data-ng-model="objectFilter.fieldName" ng-change="upgradeTab.objectFiltersListString = buildVersionQueryFilter(upgradeTab.versionObjectFilterList, true);" ng-Keyup="upgradeTab.objectFiltersListString = buildVersionQueryFilter(upgradeTab.versionObjectFilterList, true);" data-ng-options="fieldDesc.name as fieldDesc.label for fieldDesc in upgradeTab.upgradableVersionObjectsFieldsMap[upgradeTab.objectString]">\n                            <option value="">{{CMTAdminChooseAField}}</option>\n                        </select>\n                    </div>\n                    <div class="slds-col slds-size_1-of-6">\n                        <select ng-disabled="!upgradeTab.objectString || !objectFilter.fieldName" class="form-control" data-ng-model="objectFilter.operator" ng-change="upgradeTab.objectFiltersListString = buildVersionQueryFilter(upgradeTab.versionObjectFilterList, true);" ng-Keyup="upgradeTab.objectFiltersListString = buildVersionQueryFilter(upgradeTab.versionObjectFilterList, true);" data-ng-options="key for (key , value) in upgradeTab.queryFiltersOperatorsMap"></select>\n                    </div>\n                    <div class="slds-col slds-size_2-of-6">\n                        <input ng-disabled="!additionalInput.objectString || !objectFilter.fieldName || !objectFilter.operator" class="form-control" data-ng-model="objectFilter.value" ng-change="upgradeTab.objectFiltersListString = buildVersionQueryFilter(upgradeTab.versionObjectFilterList, true);" ng-Keyup="upgradeTab.objectFiltersListString = buildVersionQueryFilter(upgradeTab.versionObjectFilterList, true);" class="slds-input" type="text" />\n                    </div>\n                    <div class="slds-col slds-size_1-of-6" ng-if="$last">\n                        <span class="slds-icon_container action" ng-click="upgradeTab.versionObjectFilterList.push({});">\n                            <slds-svg-icon sprite="\'utility\'" size="\'x-small\'" icon="\'new\'" extra-classes="\'slds-icon-text-default\'"></slds-svg-icon>\n                        </span>\n                    </div>\n                </div>\n                <div class="slds-grid slds-gutters">\n                    <div class="slds-col">\n                        <b>{{labels.CMTAdminFiltersPreview}}</b>\n                    </div>\n                </div>\n                <div class="slds-grid slds-gutters">\n                    <div class="slds-col">\n                        <code>\n                            {{additionalInput.objectFiltersListString}}\n                        </code>\n                    </div>\n                </div>\n            </div>\n        </div> --\x3e\n        \x3c!-- <div class="slds-hidden">\n            <div class="slds-col slds-size_1-of-5">\n                <div class="slds-grid slds-gutters">\n                    <div class="slds-col">\n                        <b>{{labels.LifecycleStatus}}</b>\n                        <select class="slds-select" data-ng-model="additionalInput.lifecycleStatus" \n                            data-ng-options="key for (key , value) in upgradeTab.lifecycleStatusMap"></select>\n                    </div>\n                </div>\n            </div>\n        </div> --\x3e\n    </div>\n<\/script>'),$templateCache.put("RelationshipUpgradeJob.tpl.html",'<batch-job job-details="jobType.relationshipJob" input-template="\'relationshipUpgradeAdditionalInput.html\'"></batch-job>\n\n<script type="text/ng-template" id="relationshipUpgradeAdditionalInput.html">\n    <div ng-init="additionalInput = jobDetails.additionalInput; additionalData = jobDetails.additionalData">\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-3">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminBatchSizeLimit100}}</label>\n                <div class="slds-form-element__control">\n                    <input class="slds-input"\n                        ng-model="additionalInput.createRelationshipBatchSize"\n                        min="1" max="100"\n                        type="number">\n                </div>\n            </div>\n        </div>\n        <div class="slds-m-bottom_x-small">\n            <label class="">{{labels.CMTAdminFilterRecordsBy}}</label>\n        </div>\n        <div class="slds-grid slds-p-bottom_x-small"\n            ng-repeat="objectFilter in additionalData.createRelationshipHeaderFiltersList track by $index">\n            <div class="slds-form-element slds-size_1-of-3">\n                <div class="slds-form-element__control">\n                    <select class="slds-select" \n                        ng-model="objectFilter.fieldName" \n                        ng-change="additionalData.buildRelQuery();"\n                        ng-Keyup="additionalData.buildRelQuery();"\n                        data-ng-options="fieldDesc.name as fieldDesc.label for fieldDesc in additionalData.orderFieldsList">\n                            <option value="">{{CMTAdminChooseAField}}</option>\n                    </select>\n                </div>\n            </div>\n            <div class="slds-size_1-of-6 slds-p-left_x-small">\n                <select ng-disabled="!objectFilter.fieldName" \n                class="slds-select" \n                ng-model="objectFilter.operator" \n                ng-change="additionalData.buildRelQuery();"\n                ng-Keyup="additionalData.buildRelQuery();"\n                ng-options="key for (key , value) in additionalData.queryFiltersOperatorsMap"></select>\n            </div>\n            <div class="slds-size_2-of-6 slds-p-left_x-small">\n                <input ng-disabled="!objectFilter.fieldName || !objectFilter.operator"\n                class="slds-input"\n                ng-model="objectFilter.value"\n                ng-change="additionalData.buildRelQuery();"\n                ng-Keyup="additionalData.buildRelQuery();"\n                class="slds-input" type="text" />\n            </div>\n            <div class="slds-size_1-of-6 slds-p-left_x-small" ng-if="$last">\n                <span class="slds-icon_container action" ng-click="additionalData.createRelationshipHeaderFiltersList.push({});">\n                    <slds-svg-icon sprite="\'utility\'" size="\'x-small\'" icon="\'new\'" extra-classes="\'slds-icon-text-default\'"></slds-svg-icon>\n                </span>\n            </div>\n        </div>\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-1">\n                <label class="slds-form-element__label">{{labels.CMTAdminFiltersPreview}}</label>\n                <div class="slds-form-element__control">\n                    <code>\n                        {{additionalInput.createRelationshipHeaderFiltersListString}}\n                    </code>\n                </div>\n            </div>\n        </div>\n    </div>\n<\/script>\n'),$templateCache.put("MLSFieldConfig.tpl.html",'<div ng-controller="CustomSettingsController" ng-init="initApp(\'mlsfieldconfig\')">\n    <div ng-include="\'SubHeader.tpl.html\'"></div>\n    <div class="slds-p-around_small" slds-active-pane="tab.index" slds-tabs-pane-class="slds-p-top_none" slds-tabs="true">\n        <div ng-repeat="subModule in subModuleList" slds-pane="true" data-title="{{subModule.label}}" ng-include="\'Module.tpl.html\'"></div>\n    </div>\n</div>\n'),$templateCache.put("CustomSettings.tpl.html",'<div ng-controller="CustomSettingsController" class="grid-wrapper slds-grid slds-theme_shade" ng-init="initApp()">\n\t<div class="module-menu slds-grid_vertical slds-size_3-of-12 slds-p-left-medium">\n\t\t<ul role="menu" class="slds-has-block-links_space slds-has-dividers_bottom">\n\t\t\t<li ng-repeat="module in metadata track by $index" class="slds-item slds-clearfix" ng-class="activeIndex.module === $index ? \'slds-item-active\': \'\'" ng-click="makeActiveModule($index)">\n\t\t\t\t<a role="menuitem" href="#">\n\t                <p class="slds-truncate" ng-click="menuToggle = module">\n\t                  <span class="slds-icon_container slds-m-right_medium slds-float_right">\n\t                    <svg aria-hidden="true" class="slds-icon slds-icon-text-default slds-icon_x-small">\n\t                      <use xlink:href="{{SLDSICON.RIGHT_ARROW}}"></use>\n\t                    </svg>\n\t                  </span>\n\t                  <span>{{module.label}}</span>\n\t                </p>\n\t            </a>\n\t\t\t</li>\n\t\t</ul>\n\t</div>\n\t<div class="tab-wrapper slds-grid_vertical slds-size_9-of-12 slds-p-left_medium slds-p-right_x-small">\n\t\t<div slds-active-pane="activeIndex.subModule" slds-tabs-pane-class="slds-p-top_none" slds-tabs="true">\n\t\t\t<div ng-repeat="subModule in metadata[activeIndex.module].subModuleList" slds-pane="true" data-title="{{subModule.label}}" ng-include="\'Module.tpl.html\'"></div>\n\t\t</div>\n\t</div>\n</div>'),$templateCache.put("AttributeUpgradeJob.tpl.html",'<div class="job-wrapper">\n    <div class="job-section slds-p-around_small">\n        <div class="job-content slds-clearfix">\n            <div class="job-detail slds-float_left">\n                <div class="job-label">\n                    <a>{{labels.AttributeModelUpgrade}}</a>\n                </div>\n                <div class="job-desc">{{labels.AttributeModelUpgradeDesc}}</div>\n            </div>\n        </div>\n        <batch-job job-details="jobType.prodAttrJob" input-template="\'prodAttrUpgradeAdditionalInput.html\'">\n        </batch-job>\n        <batch-job job-details="jobType.lineAttrJob" input-template="\'lineAttrUpgradeAdditionalInput.html\'"></batch-job>\n    </div>\n</div>\n\n<script type="text/ng-template" id="lineAttrUpgradeAdditionalInput.html">\n    <div ng-init="additionalInput = jobDetails.additionalInput; additionalData = jobDetails.additionalData">\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-3">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminBatchSize}}</label>\n                <div class="slds-form-element__control">\n                    <input class="slds-input"\n                        ng-model="additionalInput.convertXliBatchSize"\n                        min="1" max="2000"\n                        type="number">\n                </div>\n            </div>\n            <div class="slds-form-element slds-size_1-of-3 slds-p-left_x-small">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminObjectToUpgrade}}</label>\n                <div class="slds-form-element__control">\n                    <select ng-required="true" class="slds-select"\n                        ng-model="additionalInput.convertXliInput"\n                        ng-change="additionalData.resetFilterList()"\n                        ng-options="key for (key , value) in additionalData.upgradableObjectNamesMap">\n                    </select>\n                </div>\n            </div>\n        </div>\n        <div class="slds-m-vertical_x-small">\n            <label class="">{{labels.CMTAdminFilterRecordsBy}}</label>\n        </div>\n        <div class="slds-grid slds-p-bottom_x-small"\n            ng-repeat="objectFilter in additionalData.upgradableObjectFilterList track by $index">\n            <div class="slds-form-element slds-size_1-of-3">\n                <div class="slds-form-element__control">\n                    <select class="slds-select"\n                        ng-disabled="!additionalInput.convertXliInput"\n                        ng-model="objectFilter.fieldName" \n                        ng-change="additionalData.buildRelQuery();"\n                        ng-Keyup="additionalData.buildRelQuery();"\n                        data-ng-options="fieldDesc.name as fieldDesc.label for fieldDesc in additionalData.upgradableObjectsFieldsMap[additionalInput.convertXliInput]">\n                            <option value="">{{labels.CMTAdminChooseAField}}</option>\n                    </select>\n                </div>\n            </div>\n            <div class="slds-size_1-of-6 slds-p-left_x-small">\n\n                <select ng-disabled="!additionalInput.convertXliInput || !objectFilter.fieldName" \n                    class="slds-select" \n                    ng-model="objectFilter.operator" \n                    ng-change="additionalData.buildRelQuery();"\n                    ng-Keyup="additionalData.buildRelQuery();"\n                    ng-options="key for (key , value) in additionalData.queryFiltersOperatorsMap"></select>\n            </div>\n            <div class="slds-size_2-of-6 slds-p-left_x-small">\n\n                <input ng-disabled="!additionalInput.convertXliInput || !objectFilter.fieldName || !objectFilter.operator"\n                    class="slds-input"\n                    ng-model="objectFilter.value"\n                    ng-change="additionalData.buildRelQuery();"\n                    ng-Keyup="additionalData.buildRelQuery();"\n                    class="slds-input" type="text" />\n            </div>\n            <div class="slds-size_1-of-6 slds-p-left_x-small" ng-if="$last">\n                <span class="slds-icon_container action" ng-click="additionalData.upgradableObjectFilterList.push({});">\n                    <slds-svg-icon sprite="\'utility\'" size="\'x-small\'" icon="\'new\'" extra-classes="\'slds-icon-text-default\'"></slds-svg-icon>\n                </span>\n            </div>\n        </div>\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-1">\n                <label class="slds-form-element__label">{{labels.CMTAdminFiltersPreview}}</label>\n                <div class="slds-form-element__control">\n                    <code>\n                        {{additionalInput.xliFiltersListString}}\n                    </code>\n                </div>\n            </div>\n        </div>\n    </div>\n<\/script>\n\n<script type="text/ng-template" id="prodAttrUpgradeAdditionalInput.html">\n    <div ng-init="additionalInput = jobDetails.additionalInput; additionalData = jobDetails.additionalData">\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-3">\n                <label class="slds-form-element__label" for="batch-size-input">{{labels.CMTAdminBatchSize}}</label>\n                <div class="slds-form-element__control">\n                    <input class="slds-input"\n                        ng-model="additionalInput.convertProductBatchSize"\n                        min="1" max="2000"\n                        type="number">\n                </div>\n            </div>\n        </div>\n        <div class="slds-m-vertical_x-small">\n            <label class="">{{labels.CMTAdminFilterRecordsBy}}</label>\n        </div>\n        <div class="slds-grid slds-p-bottom_x-small"\n            ng-repeat="objectFilter in additionalData.productFilterList track by $index">\n            <div class="slds-form-element slds-size_1-of-3">\n                <div class="slds-form-element__control">\n                    <select class="slds-select" \n                        ng-model="objectFilter.fieldName" \n                        ng-change="additionalData.buildRelQuery();"\n                        ng-Keyup="additionalData.buildRelQuery();"\n                        data-ng-options="fieldDesc.name as fieldDesc.label for fieldDesc in additionalData.productFieldsList">\n                            <option value="">{{labels.CMTAdminChooseAField}}</option>\n                    </select>\n                </div>\n            </div>\n            <div class="slds-size_1-of-6 slds-p-left_x-small">\n                <select ng-disabled="!objectFilter.fieldName" \n                    class="slds-select" \n                    ng-model="objectFilter.operator" \n                    ng-change="additionalData.buildRelQuery();"\n                    ng-Keyup="additionalData.buildRelQuery();"\n                    ng-options="key for (key , value) in additionalData.queryFiltersOperatorsMap"></select>\n            </div>\n            <div class="slds-size_2-of-6 slds-p-left_x-small">\n                <input ng-disabled="!objectFilter.fieldName || !objectFilter.operator"\n                    class="slds-input"\n                    ng-model="objectFilter.value"\n                    ng-change="additionalData.buildRelQuery();"\n                    ng-Keyup="additionalData.buildRelQuery();"\n                    class="slds-input" type="text" />\n            </div>\n            <div class="slds-size_1-of-6 slds-p-left_x-small" ng-if="$last">\n                <span class="slds-icon_container action" ng-click="additionalData.productFilterList.push({});">\n                    <slds-svg-icon sprite="\'utility\'" size="\'x-small\'" icon="\'new\'" extra-classes="\'slds-icon-text-default\'"></slds-svg-icon>\n                </span>\n            </div>\n        </div>\n        <div class="slds-grid">\n            <div class="slds-form-element slds-size_1-of-1">\n                <label class="slds-form-element__label">{{labels.CMTAdminFiltersPreview}}</label>\n                <div class="slds-form-element__control">\n                    <code>\n                        {{additionalInput.productFiltersListString}}\n                    </code>\n                </div>\n            </div>\n        </div>\n    </div>\n<\/script>\n'),$templateCache.put("EPCJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'epcJobs\', labels.CMTOptionEPCJobsLabel)">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="job-wrapper">\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.InstallDefaultLayouts}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.InstallDefaultLayoutsDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="importEpcObjectsLayouts();" class="slds-button  slds-button_brand">{{labels.InstallLabel}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="#">{{labels.InstallProductReport}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_x-small">{{labels.InstallProductReportDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="importProductReportIP();" class="slds-button  slds-button_brand">{{labels.InstallLabel}}</button>\n                </div>\n            </div>\n\t\t</div>\n\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.InstallDefaultPPD}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.InstallDefaultPPDDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="importPricingPlanData();" class="slds-button  slds-button_brand">{{labels.InstallLabel}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.DeleteDefaultObjectLayouts}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.DeleteLayoutsDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="deleteEpcDefaultLayouts();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.CreateDefaultPVB}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.CreateDefaultPVBDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="createDefaultPricingVariables();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">Create Default Contextual Adjustment Data</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">Creates default contextual adjustment data</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button id="createDefaultContextualAdjustmentDataButton" type="button" ng-click="createDefaultContextualAdjustmentData();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<div class="row">\n\t\t\t\t<div id="createDefaultContextualAdjustmentDataStatus" class="col-md-12 col-sm-12 col-xs-12">\n\t\t\t\t\t<div ng-if="hasErrors" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t\x3c!-- create default time policy --\x3e\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.CMTAdminCreateDefaultTPJob}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.CMTAdminCreateDefaultTPJobDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="createDefaultTimePolicy();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.GenerateGlobalKey}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.GenerateGlobalKeyDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="generateEPCGlobalKeys();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#"><span class="slds-text-color_error">[{{labels.DeprecatedLabel}}]</span> {{labels.CreateDefaultObjectClass}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.CreateDefaultObjectClassDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="createEpcObjectClasses();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#"><span class="slds-text-color_error">[{{labels.DeprecatedLabel}}]</span> {{labels.CreateDefaultLayout}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.CreateDefaultLayoutDesc}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="createEpcDefaultLayouts();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t</div>\n</div>\n'),$templateCache.put("ErrorModal.tpl.html",'<div>\n    <div aria-hidden="false" aria-labelledby="prompt-heading-id" aria-describedby="prompt-message-wrapper" role="alertdialog" class="slds-modal slds-modal_prompt slds-fade-in-open">\n        <div class="slds-modal__container slds-modal_prompt" role="document" id="prompt-message-wrapper" tabindex="0">\n            <div class="slds-modal__header slds-theme_alert-texture" ng-class="theme">\n                <h2 class="slds-text-heading_medium" id="prompt-heading-id">{{confirmationTitle}}</h2>\n            </div>\n            <div class="slds-modal__content slds-p-around_medium">\n                <div>\n                    <p>{{errorMessage}}</p>\n                </div>\n            </div>\n            <div class="slds-modal__footer slds-theme_default">\n                <button class="slds-button slds-button_neutral" ng-click="$hide()">{{cancelActionLbl}}</button>\n            </div>\n        </div>\n    </div>\n    <div class="slds-backdrop slds-backdrop_open"></div>\n</div>\n'),$templateCache.put("PerformanceJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'PerformanceJobs\', labels.CMTOptionPerformanceJobsLabel)">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="slds-theme_shade">\n\t\t<div class="job-wrapper slds-p-around_medium">\n\t\t\t<div class="job-section slds-m-top_x-small slds-has-divider_bottom">\n\t\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t\t<a href="#">{{labels.XLIAPILabel}}</a>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.XLIAPIDesc}}</div>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t\t<button id="addOrderLineItemJobButton" type="button" ng-click="showTestResults = true; addOrderLineItemJob();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="row">\n\t\t\t\t\t<div id="addOrderLineItemJobStatus" class="col-md-12 col-sm-12 col-xs-12">\n\t\t\t\t\t\t<div ng-if="hasErrors" style="color : red" class="alert alert-danger" role="alert">{{errorMessage}}</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div ng-if="result != 0" ng-show="showTestResults">\n\t\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t\t<tr ng-class="slds-theme_success" style="background-color : #cfeef8">\n\t\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">API</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap" style="font-weight:900">Time</th>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t  \t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t  \t\t<p>{{labels.AddXLILabel}}</p>\n\t\t\t\t\t  \t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{result.AddOLITime}} <span ng-bind="{{result.AddOLITime}}"></span><i ng-hide="result.AddOLITime"  class="icon icon-refresh icon-spin" >...</i></p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</div>\n\t\t\t</div>\n\n\t\t</div>\n\t</div>\n</div>\n'),$templateCache.put("BatchJob.tpl.html",'<ng-form name="batchJobForm">\n    <div class="job-wrapper slds-size_1-of-1">\n        <div class="job-section slds-size_1-of-1 slds-p-around_small slds-has-divider_bottom">\n            <div class="slds-grid slds-size_1-of-1 slds-clearfix">\n                <div class="slds-size_1-of-2">\n                    <div class="job-label">\n                        <a href="#" ng-click="showTable = !showTable"> {{::jobDetails.label}}</a>\n                    </div>\n                    <div class="job-desc">{{::jobDetails.desc}}</div>\n                    <div ng-include="inputTemplate" class="slds-m-top_small"></div>\n                </div>\n                <div class="slds-size_1-of-2">\n                    <button type="button" ng-click="showTable = true; startBatch();" \n                        class="slds-button  slds-button_brand slds-float_right"\n                        ng-disabled="batchJobForm.$invalid">{{::labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="jobList.length != 0" ng-show="showTable" class="slds-grid slds-size_1-of-1">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                    <tr>\n                        <th class="slds-cell-wrap">{{::labels.JobName}}</th>\n                        <th class="slds-cell-wrap">{{::asyncApexJobFieldsLabels.status}}</th>\n                        <th class="slds-cell-wrap">{{::asyncApexJobFieldsLabels.totalJobItems}}</th>\n                        <th class="slds-cell-wrap">{{::asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                        <th class="slds-cell-wrap">{{::asyncApexJobFieldsLabels.createdDate}}</th>\n                        <th class="slds-cell-wrap">{{::asyncApexJobFieldsLabels.completedDate}}</th>\n                        <th class="slds-cell-wrap">{{::asyncApexJobFieldsLabels.extendedStatus}}</th>\n                    </tr>\n                    </thead>\n                    <tbody>\n                    <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n'+"                                        'slds-theme_default': job.Status == 'Holding',\n                                        'slds-theme_default': job.Status == 'Preparing',\n                                        'slds-theme_success': job.Status == 'Completed',\n                                        'slds-theme_info': job.Status == 'Aborted',\n                                        'slds-theme_warning': job.Status == 'Processing',\n                                        'slds-theme_error': job.Status == 'Failed'}\"\n                        ng-repeat=\"job in jobDetails.records track by $index\">\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{::jobDetails.label}}</p>\n                        </td>\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{job.Status}}</p>\n                        </td>\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{job.TotalJobItems}}</p>\n                        </td>\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{job.JobItemsProcessed}}</p>\n                        </td>\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{ job.CreatedDate | date : 'short' }}</p>\n                        </td>\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{ job.CompletedDate | date : 'short' }}</p>\n                        </td>\n                        <td class=\"slds-cell-wrap\">\n                            <p>{{job.ExtendedStatus}}</p>\n                        </td>\n                    </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n    </div>\n</ng-form>"),$templateCache.put("MLSJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'MLSJob\', labels.CMTOptionMLSJobsLabel)">\n    <div ng-include="\'SubHeader.tpl.html\'"></div>\n    <div class="job-wrapper">\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="#" ng-click="isTranslationJobCollapsed = !isTranslationJobCollapsed">{{labels.CreateTranslationJobLabel}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.CreateTranslationJobDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="isTranslationJobCollapsed = true; startTranslationJob();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="translationJobsList.length != 0" ng-show="isTranslationJobCollapsed">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                        <tr>\n                            <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n                        </tr>\n                    </thead>\n                    <tbody>\n                        <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n                                        \'slds-theme_default\': job.Status == \'Holding\',\n                                        \'slds-theme_default\': job.Status == \'Preparing\',\n                                        \'slds-theme_success\': job.Status == \'Completed\',\n                                        \'slds-theme_info\': job.Status == \'Aborted\',\n                                        \'slds-theme_warning\': job.Status == \'Processing\',\n                                        \'slds-theme_error\': job.Status == \'Failed\'}"\n                            ng-repeat="job in translationJobsList track by $index">\n                            <td class="slds-cell-wrap">\n                                <p>{{labels.TranslationJobLabel}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.Status}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.TotalJobItems}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.JobItemsProcessed}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{ job.CreatedDate | date : \'short\' }}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{ job.CompletedDate | date : \'short\' }}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.ExtendedStatus}}</p>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="#" ng-click="isTranslationCacheJobCollapsed = !isTranslationCacheJobCollapsed">{{labels.CreateTranslationCacheJobLabel}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_xx-small">{{labels.CreateTranslationCacheJobDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="isTranslationCacheJobCollapsed = true; startTranslationCacheJob();" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n            <div ng-if="translationCacheJobsList.length != 0" ng-show="isTranslationCacheJobCollapsed">\n                <table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n                    <thead>\n                        <tr>\n                            <th class="slds-cell-wrap">{{labels.JobName}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n                            <th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n                        </tr>\n                    </thead>\n                    <tbody>\n                        <tr ng-class="{ \'slds-theme_default\': job.Status == \'Queued\',\n                                        \'slds-theme_default\': job.Status == \'Holding\',\n                                        \'slds-theme_default\': job.Status == \'Preparing\',\n                                        \'slds-theme_success\': job.Status == \'Completed\',\n                                        \'slds-theme_info\': job.Status == \'Aborted\',\n                                        \'slds-theme_warning\': job.Status == \'Processing\',\n                                        \'slds-theme_error\': job.Status == \'Failed\'}"\n                            ng-repeat="job in translationCacheJobsList track by $index">\n                            <td class="slds-cell-wrap">\n                                <p>{{labels.CachedTranslationJobLabel}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.Status}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.TotalJobItems}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.JobItemsProcessed}}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{ job.CreatedDate | date : \'short\' }}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{ job.CompletedDate | date : \'short\' }}</p>\n                            </td>\n                            <td class="slds-cell-wrap">\n                                <p>{{job.ExtendedStatus}}</p>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </div>\n        </div>\n        <div class="job-section slds-p-around_small slds-has-divider_bottom">\n            <div class="job-content slds-clearfix">\n                <div class="job-detail slds-float_left">\n                    <div class="job-label">\n                        <a href="#">{{labels.LoadDefaultObjectFieldMLS}}</a>\n                    </div>\n                    <div class="job-desc slds-m-top_x-small">{{labels.LoadDefaultObjectFieldMLSDesc}}</div>\n                </div>\n                <div class="job-start slds-float_right">\n                    <button type="button" ng-click="loadDefaultObjectFieldsConfigMLS();" class="slds-button  slds-button_brand">{{labels.StartDT}}</button>\n                </div>\n            </div>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("MaintenanceJob.tpl.html",'<div ng-controller="AdminConsoleController" ng-init="initApp(\'maintenanceJobs\', labels.CMTOptionMaintenanceJobsLabel)">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="job-wrapper">\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#" ng-click="jobWrapper.startRootAccountJob.jobListToggle = !jobWrapper.startRootAccountJob.jobListToggle">{{labels.AccountHierarchyMaintenance}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.JobRestoreAccountHierarchy}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.startRootAccountJob);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<div ng-if="rootAccountJobsList.length != 0" ng-show="jobWrapper.startRootAccountJob.jobListToggle">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<thead>\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{labels.JobName}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</thead>\n\t\t\t\t\t<tbody>\n\t\t\t\t\t\t<tr ng-class="{\t\'slds-theme_default\': job.Status == \'Queued\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_default\': job.Status == \'Holding\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_default\': job.Status == \'Preparing\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_success\': job.Status == \'Completed\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_info\': job.Status == \'Aborted\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_warning\': job.Status == \'Processing\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_error\': job.Status == \'Failed\'}"\n\t\t\t\t\t\t\tng-repeat="job in rootAccountJobsList track by $index">\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{labels.ResolveRootAccounts}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.Status}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.TotalJobItems}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.JobItemsProcessed}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{ job.CreatedDate | date : \'short\' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{ job.CompletedDate | date : \'short\' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.ExtendedStatus}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</tbody>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.InterfaceImplementationMaintenanceRestore}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.JobRestoreImplementations}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.resetInterfaceImplementations);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.InterfaceImplementationMaintenanceMerge}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.MergeInterfaceImplementations}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.mergeInterfaceImplementations);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.FieldMapsMaintenance}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.JobRestoreFieldMaps}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.resetFieldMaps);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.ObjectMapMaintenance}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.ObjectMapMaintenanceDescription}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.resetObjectMaps);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom" >\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#" ng-click="jobWrapper.startXLIBatchValidationJob.jobListToggle = !jobWrapper.startXLIBatchValidationJob.jobListToggle">{{labels.BatchValidation}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.StartBatchJobValidation}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.startXLIBatchValidationJob);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<div  ng-show="jobWrapper.startXLIBatchValidationJob.jobListToggle">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<thead>\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{labels.JobName}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</thead>\n\t\t\t\t\t<tbody>\n\t\t\t\t\t\t<tr ng-class="{\t\'slds-theme_default\': job.Status == \'Queued\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_default\': job.Status == \'Holding\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_default\': job.Status == \'Preparing\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_success\': job.Status == \'Completed\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_info\': job.Status == \'Aborted\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_warning\': job.Status == \'Processing\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_error\': job.Status == \'Failed\'}"\n\t\t\t\t\t\t\tng-repeat="job in XLIBatchJobValidationList track by $index">\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{labels.BatchValidation}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.Status}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.TotalJobItems}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.JobItemsProcessed}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{ job.CreatedDate | date : \'short\' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{ job.CompletedDate | date : \'short\' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.ExtendedStatus}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</tbody>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.ResetXLIValiatonData}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.ValidateOrdersReset}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.resetXLIBatchValidationData);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#" ng-click="jobWrapper.startProductHierarchyJob.jobListToggle = !jobWrapper.startProductHierarchyJob.jobListToggle">{{labels.ProductHierarchyMaintenanceTitle}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.ProductHierarchyMaintenanceDescription}}</div>\n\t\t\t\t\t<div class="slds-grid slds-gutters">\n\t\t\t\t\t\t<div class="slds-col slds-size_1-of-5">\n\t\t\t\t\t\t\t<div class="slds-grid slds-gutters">\n\t\t\t\t\t\t\t\t<div class="slds-col">\n\t\t\t\t\t\t\t\t\t<b>{{labels.DeleteOldProductHierarchyData}}</b>\n\t\t\t\t\t\t\t\t\t<input type="checkbox" data-ng-model="upgradeTab.deleteOldData" ng-true-value="\'true\'" ng-false-value="\'false\'" ng-checked="upgradeTab.deleteOldData == \'true\'" ng-init="upgradeTab.deleteOldData = \'false\'">\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.startProductHierarchyJob);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<div ng-if="productHierarchyJobsList.length != 0" ng-show="jobWrapper.startProductHierarchyJob.jobListToggle">\n\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t<thead>\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{labels.JobName}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</thead>\n\t\t\t\t\t<tbody>\n\t\t\t\t\t\t<tr ng-class="{\t\'slds-theme_default\': job.Status == \'Queued\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_default\': job.Status == \'Holding\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_default\': job.Status == \'Preparing\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_success\': job.Status == \'Completed\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_info\': job.Status == \'Aborted\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_warning\': job.Status == \'Processing\',\n\t\t\t\t\t\t\t\t\t\t\'slds-theme_error\': job.Status == \'Failed\'}"\n\t\t\t\t\t\t\tng-repeat="job in productHierarchyJobsList track by $index">\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{labels.ProductHierarchyMaintenanceJobName}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.Status}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.TotalJobItems}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.JobItemsProcessed}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{ job.CreatedDate | date : \'short\' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{ job.CompletedDate | date : \'short\' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class="slds-cell-wrap">\n\t\t\t\t\t\t\t\t<p>{{job.ExtendedStatus}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</tbody>\n\t\t\t\t</table>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#">{{labels.ClearManagedPlatformCache}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_xx-small">{{labels.ClearManagedPlatformCacheDescription}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button type="button" ng-click="confirmationPopup(jobWrapper.clearPlatformCache);" class="slds-button slds-button_brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\n\t\t<div class="job-section slds-p-around_small slds-has-divider_bottom">\n\n\t\t\t<div class="job-content slds-clearfix">\n\t\t\t\t<div class="job-detail slds-float_left">\n\t\t\t\t\t<div class="job-label">\n\t\t\t\t\t\t<a href="#" ng-click="jobWrapper.refreshPriceBook.jobListToggle = !jobWrapper.refreshPriceBook.jobListToggle">{{labels.RefreshPricebook}}</a>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class="job-desc slds-m-top_x-small">{{labels.RefreshPricebookDescription}}</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="job-start slds-float_right">\n\t\t\t\t\t<button id="idRefreshPriceBookStartButton" type="button" ng-click="confirmationPopup(jobWrapper.refreshPriceBook);" class="slds-button  slds-button--brand">{{labels.StartDT}}</button>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<div ng-if="refreshPriceBookJobList.length != 0" ng-show="jobWrapper.refreshPriceBook.jobListToggle">\n\t\t\t\t\t<table class="slds-table slds-m-top_small slds-no-row-hover slds-table_fixed-layout">\n\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{labels.JobName}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.status}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.totalJobItems}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.jobItemsProcessed}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.createdDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.completedDate}}</th>\n\t\t\t\t\t\t\t<th class="slds-cell-wrap">{{asyncApexJobFieldsLabels.extendedStatus}}</th>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t<tr ng-class="{\t\'slds-theme_default\': job.Status == \'Queued\',\n'+"\t\t\t\t\t\t\t\t\t\t'slds-theme_default': job.Status == 'Holding',\n\t\t\t\t\t\t\t\t\t\t'slds-theme_default': job.Status == 'Preparing',\n\t\t\t\t\t\t\t\t\t\t'slds-theme_success': job.Status == 'Completed',\n\t\t\t\t\t\t\t\t\t\t'slds-theme_info': job.Status == 'Aborted',\n\t\t\t\t\t\t\t\t\t\t'slds-theme_warning': job.Status == 'Processing',\n\t\t\t\t\t\t\t\t\t\t'slds-theme_error': job.Status == 'Failed'}\"\n\t\t\t\t\t\t\tng-repeat=\"job in refreshPriceBookJobList track by $index\">\n\t\t\t\t\t\t  \t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t  \t<p>{{labels.RefreshPricebook}}</p>\n\t\t\t\t\t\t  \t</td>\n\t\t\t\t\t\t\t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t\t<p>{{job.Status}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t\t<p>{{job.TotalJobItems}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t\t<p>{{job.JobItemsProcessed}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t\t<p>{{ job.CreatedDate | date : 'short' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t\t<p>{{ job.CompletedDate | date : 'short' }}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t\t<td class=\"slds-cell-wrap\">\n\t\t\t\t\t\t\t\t<p>{{job.ExtendedStatus}}</p>\n\t\t\t\t\t\t\t</td>\n\t\t\t\t\t\t</tr>\n\t\t\t\t\t</table>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t</div>\n</div>\n"),$templateCache.put("ReviewCart.tpl.html",'<div ng-controller="CustomSettingsController" ng-init="initApp(\'reviewcart\')">\n\t<div ng-include="\'SubHeader.tpl.html\'"></div>\n\t<div class="slds-p-around_small" slds-active-pane="tab.index" slds-tabs-pane-class="slds-p-top_none" slds-tabs="true">\n\t\t<div ng-repeat="subModule in subModuleList" slds-pane="true" data-title="{{subModule.label}}" ng-include="\'Module.tpl.html\'"></div>\n\t</div>\n</div>'),$templateCache.put("FieldSelectionModal.tpl.html",'<div class="slds-modal slds-fade-in-open" aria-hidden="false" role="dialog">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header">\n            <button class="slds-button slds-button_icon-inverse slds-modal__close" ng-click="$hide()">\n                <svg aria-hidden="true" class="slds-button__icon slds-button__icon_large">\n                    <use xlink:href="{{SLDSICON.CLOSE}}"></use>\n                </svg>\n                <span class="slds-assistive-text">{{labels.CloseLabel}}</span>\n            </button>\n            <h2 class="slds-text-heading_medium">{{confirmationTitle}}</h2>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <field-Lookup object-name="objectName" field-name="fieldName" selected-fields="selectedFields"> </field-Lookup>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral" ng-click="$hide()">{{cancelActionLbl}}</button>\n            <button type="button" class="slds-button slds-button_neutral slds-button_brand" ng-click="confirmAction()">{{confirmActionLbl}}</button>\n        </div>\n    </div>\n</div>\n<div class="slds-backdrop slds-backdrop_open"></div>\n'),$templateCache.put("ConfirmationModal.tpl.html",'<section role="dialog" tabindex="-1" aria-labelledby="modal-heading-01" aria-modal="true" aria-describedby="modal-content-id-1" class="slds-modal slds-fade-in-open">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header" ng-class="confirmationClass">\n            <slds-button-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'large\'" extra-classes="\'slds-modal__close slds-button_icon-inverse\'" ng-click="isCancelActionRequried ? cancelAction() : $hide()"></slds-button-svg-icon>\n            <h2 class="slds-text-heading_medium slds-hyphenate">{{confirmationTitle}}</h2>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div>\n                <p ng-bind-html="confirmationMsg"></p>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral" ng-click="isCancelActionRequried ? cancelAction() : $hide()">{{cancelActionLbl}}</button>\n            <button type="button" class="slds-button slds-button_brand" ng-click="confirmAction()">{{confirmActionLbl}}</button>\n        </div>\n    </div>\n</section>\n<div class="slds-backdrop slds-backdrop_open"></div>\n')}]);

},{}]},{},[1]);
})();
