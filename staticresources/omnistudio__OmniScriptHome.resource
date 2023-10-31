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
require('./polyfills/Array.find.js');
require('./polyfills/Array.findIndex.js');

angular.module('ouihome', ['vlocity', 'ouihome.core', 'sldsangular', 'drvcomp', 'ngTable', 'infinite-scroll', 'omniscriptLwcCompiler']);

require('./modules/ouihome/config/config.js');
require('./modules/ouihome/factory/BackcompatExport.js');
require('./modules/ouihome/factory/BackcompatImport.js');
require('./modules/ouihome/controller/OuiHomeSlds.js');
require('./modules/ouihome/templates/templates.js');
require('./modules/ouihome/directive/osWarning.js');

},{"./modules/ouihome/config/config.js":2,"./modules/ouihome/controller/OuiHomeSlds.js":3,"./modules/ouihome/directive/osWarning.js":4,"./modules/ouihome/factory/BackcompatExport.js":5,"./modules/ouihome/factory/BackcompatImport.js":6,"./modules/ouihome/templates/templates.js":7,"./polyfills/Array.find.js":8,"./polyfills/Array.findIndex.js":9}],2:[function(require,module,exports){
angular.module('ouihome')
    .config(['remoteActionsProvider', 'fileNsPrefixDot', function(remoteActionsProvider, fileNsPrefixDot) {
        'use strict';
        var remoteActions = {
            exportOmniScript: {
                action: fileNsPrefixDot() + 'OmniScriptHomeController.exportScripts',
                config: {buffer: true,escape: false}
            },
            BuildJSONV2: {
                action: fileNsPrefixDot() + 'OmniScriptHomeController.BuildJSONV2',
                config: {escape: false, buffer: false}
            },
            toggleElementTrigger: fileNsPrefixDot() + 'OmniScriptHomeController.toggleElementTrigger',
            createElement: {
                action: fileNsPrefixDot() + 'OmniScriptHomeController.createElement',
                config: {escape: false, buffer: true}
            },
            createScript: fileNsPrefixDot() + 'OmniScriptHomeController.createScript',
            getOmniScriptsWarnings: {
                action: fileNsPrefixDot() + "OmniScriptDesignerController.getOmniScriptsWarningsByJsonString",
                config: {
                    escape: false,
                    buffer: false
                }
            },
        };
        remoteActionsProvider.setRemoteActions(remoteActions);
    }])
    .config(['$localizableProvider', function ($localizableProvider) {
        $localizableProvider.setLocalizedMap(window.i18n);
        $localizableProvider.setDebugMode(window.ns === '');
    }])
    .config(['$compileProvider', function ($compileProvider) {
        $compileProvider.debugInfoEnabled(false);
    }]).value('isIntegrationProcedure', true);

},{}],3:[function(require,module,exports){
angular.module('ouihome')
    .controller('ouihome', ['$scope', '$rootScope', '$injector',
        '$filter', 'backcompatExport', 'backcompatImport', '$modal', '$q', 'OmniScriptFieldMappingsNamespace', 'remoteActions',
        function ($scope, $rootScope, $injector, $filter, backcompatExport, backcompatImport, $modal, $q, OmniScriptFieldMappingsNamespace, remoteActions) {

            'use strict';
            $scope.groupBy = function (script) {
                var type = script[OmniScriptFieldMappingsNamespace.Type__c],
                    subType = script[OmniScriptFieldMappingsNamespace.SubType__c],
                    language = script[OmniScriptFieldMappingsNamespace.Language__c]
                return (type ? type : '') + '/' + (subType ? subType : '') + '/' +
                    (language ? language : '');
            };

            window.OmniInvalidConfigForFoundation = '';
            window.OmniScriptWarningDialogHeaderMessage = '';
            $rootScope.omniScriptIds = [];
            $rootScope.omniScriptsWarnings = {};
            $rootScope.omniScriptsWarningsRequest = {};
            $rootScope.vlocity.getCustomLabels('OmniInvalidConfigForFoundation', 'OmniScriptWarningDialogHeaderMessage')
                .then(result => {
                    window.OmniInvalidConfigForFoundation = result[0];
                    window.OmniScriptWarningDialogHeaderMessage = result[1];
                })
                .catch(reason => { });


            $scope.backcompatImport = backcompatImport;
            $scope.searchColumns = [OmniScriptFieldMappingsNamespace.Type__c, OmniScriptFieldMappingsNamespace.SubType__c, 'Name'];
            $scope.defaultColumns = [
                {
                    resizable: true,
                    field: OmniScriptFieldMappingsNamespace.Type__c,
                    additionalFields: [OmniScriptFieldMappingsNamespace.SubType__c, OmniScriptFieldMappingsNamespace.Version__c],
                    getValue: function ($scope, row) {
                        var url;
                        if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                            if(row?.IsFileBased){
                                if(!row.uniqueName) {
                                    let type = row[OmniScriptFieldMappingsNamespace.Type__c];
                                    let subType = row[OmniScriptFieldMappingsNamespace.SubType__c];
                                    let lang = row[OmniScriptFieldMappingsNamespace.Language__c];
                                    let version = row[OmniScriptFieldMappingsNamespace.Version__c];
                                    row.uniqueName =   `${type}_${subType}_${lang}_${version}`;
                                }
                                url = window.omniLwcMetadataUrl + row.uniqueName;
                            } else {
                            url = window.omniLwcNewUrl + row.Id;
                            }
                        } else {
                            url = window.omniNewUrl + '?id=' + row.Id;
                        }

                        if (window.showLegacyOmniStudioUi === false && !row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                            return '<span slds-popover container=".via-slds"  title="' + window.OmniInvalidConfigForFoundation + '" class="slds-grid"><span class="slds-icon_container">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'warning\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-warning\'\"></slds-svg-icon></span>&nbsp;' +
                                '<span title="' + _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')" class="slds-m-top_xxx-small">' +
                                _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')</span><span>'
                        }
                        if ($rootScope.omniScriptsWarnings && $rootScope.omniScriptsWarnings[row.Id]) {
                            return '<span style="display:flex;" ><a title="' + _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')" href="' + url + '" ng-mouseup="$root.vlocityOpenUrl(\'' + url + '\', $event, false, null, true)">' +
                            _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')</a><os-warning warning-label="' + window.OmniScriptWarningDialogHeaderMessage + '" warning-message="' + $rootScope.omniScriptsWarnings[row.Id] + '"></os-warning></span>';
                        }
                        return '<a title="' + _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')" href="' + url + '" ng-mouseup="$root.vlocityOpenUrl(\'' + url + '\', $event, false, null, true)">' +
                        _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')</a>';
            },
                    getGroupValue: function ($scope, $group) {
                        var type = $group.data[0][OmniScriptFieldMappingsNamespace.Type__c],
                            subType = $group.data[0][OmniScriptFieldMappingsNamespace.SubType__c],
                            omniscriptWarningIds = [];
                        if (!type) {
                            return '<span>&nbsp;</span>';
                        }
                        _.forEach($group.data, function (row) {
                            if (OmniScriptFieldMappingsNamespace && OmniScriptFieldMappingsNamespace.DesignerCustomizationType) {
                                if (row[OmniScriptFieldMappingsNamespace.DesignerCustomizationType]) {
                                    if (!$rootScope.omniScriptsWarningsRequest[row[OmniScriptFieldMappingsNamespace.DesignerCustomizationType]]) {
                                        $rootScope.omniScriptsWarningsRequest[row[OmniScriptFieldMappingsNamespace.DesignerCustomizationType]] = [];
                                    }
                                    if ($rootScope.omniScriptsWarningsRequest[row[OmniScriptFieldMappingsNamespace.DesignerCustomizationType]] && $rootScope.omniScriptsWarningsRequest[row[OmniScriptFieldMappingsNamespace.DesignerCustomizationType]].indexOf(row.Id) === -1) {
                                        $rootScope.omniScriptsWarningsRequest[row[OmniScriptFieldMappingsNamespace.DesignerCustomizationType]].push(row.Id);
                                    }
                                }
                            }
                            if ($rootScope.omniScriptIds.indexOf(row.Id) === -1) {
                                $rootScope.omniScriptIds.push(row.Id);
                            }
                            if ($rootScope.omniScriptsWarnings && $rootScope.omniScriptsWarnings[row.Id]) {
                                omniscriptWarningIds.push(row.Id);
                            }
                        });
                        var groupExpanded = _.filter($scope.$$watchers, {exp: 'groupStatus[group.value]', last: true});
                        if (omniscriptWarningIds.length && !groupExpanded.length) {
                            return '<span style="display:flex;"><span class="slds-truncate">' + _.escape(type + (subType ? '/' + subType : '')) + '</span><os-warning hide-warning-dialog="true"></os-warning></span>';
                        }
                        return '<span style="display:flex;"><span class="slds-truncate">' + _.escape(type + (subType ? '/' + subType : '')) + '</span></span>';
                    },
                    dynamic: true,
                    sortable: false
                }, {
                    resizable: true,
                    width: 115,
                    field: OmniScriptFieldMappingsNamespace.Language__c,
                    sortable: false
                }, {
                    title: 'Description',
                    resizable: true,
                    field: OmniScriptFieldMappingsNamespace.AdditionalInformation__c
                }, {
                    title: 'Last Modified Date',
                    resizable: true,
                    width: 140,
                    field: 'LastModifiedDate',
                    getGroupValue: function ($scope, $group) {
                        return $filter('date')($group.data[0].LastModifiedDate, 'short');
                    },
                    getValue: function ($scope, row) {
                        return $filter('date')(row.LastModifiedDate, 'short');
                    }
                }, {
                    title: 'Last Modified By',
                    resizable: true,
                    width: 140,
                    field: 'LastModifiedById',
                    getGroupValue: function ($scope, $group) {
                        if ($group.data[0] && $group.data[0].LastModifiedBy) {
                            return _.escape($group.data[0].LastModifiedBy.Name);
                        }
                        return null;
                    },
                    getValue: function ($scope, row) {
                        if (row.LastModifiedBy) {
                            return _.escape(row.LastModifiedBy.Name);
                        }
                        return null;
                    }
                }, {
                    field: OmniScriptFieldMappingsNamespace.IsReusable__c,
                    resizable: false,
                    dynamic: true,
                    width: 110,
                    getValue: function ($scope, row) {
                        if (row[OmniScriptFieldMappingsNamespace.IsReusable__c]) {
                            return '<span class="slds-icon_container" title="Is Reusable"' +
                                '><slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'" extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    },
                    getGroupSortValue: function ($scope, $group) {
                        var hasAnActiveEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row[OmniScriptFieldMappingsNamespace.IsReusable__c]) {
                                hasAnActiveEntry = true;
                                return false;
                            }
                        });
                        return hasAnActiveEntry;
                    },
                    getGroupValue: function ($scope, $group) {
                        var hasAResusableEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row[OmniScriptFieldMappingsNamespace.IsReusable__c]) {
                                hasAResusableEntry = true;
                                return false;
                            }
                        });
                        if (hasAResusableEntry) {
                            return '<span class="slds-icon_container" title="Is Reusable">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    }
                }, {
                    field: OmniScriptFieldMappingsNamespace.IsActive__c,
                    resizable: false,
                    width: 90,
                    dynamic: true,
                    getValue: function ($scope, row) {
                        if (row[OmniScriptFieldMappingsNamespace.IsActive__c]) {
                            return '<span class="slds-icon_container" title="Is Active">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    },
                    getGroupSortValue: function ($scope, $group) {
                        var hasAnActiveEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row[OmniScriptFieldMappingsNamespace.IsActive__c]) {
                                hasAnActiveEntry = true;
                                return false;
                            }
                        });
                        return hasAnActiveEntry;
                    },
                    getGroupValue: function ($scope, $group) {
                        var hasAnActiveEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row[OmniScriptFieldMappingsNamespace.IsActive__c]) {
                                hasAnActiveEntry = true;
                                return false;
                            }
                        });
                        if (hasAnActiveEntry) {
                            return '<span class="slds-icon_container" title="Is Active">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    }
                }, {
                    field: OmniScriptFieldMappingsNamespace.IsLwcEnabled__c,
                    resizable: false,
                    width: 110,
                    dynamic: true,
                    title: 'LWC Enabled',
                    getValue: function ($scope, row) {
                        if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                            return '<span class="slds-icon_container" title="Is Lightning Web Component Enabled">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    },
                    getGroupSortValue: function ($scope, $group) {
                        var hasAnActiveEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                                hasAnActiveEntry = true;
                                return false;
                            }
                        });
                        return hasAnActiveEntry;
                    },
                    getGroupValue: function ($scope, $group) {
                        var hasAnActiveEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                                hasAnActiveEntry = true;
                                return false;
                            }
                        });
                        if (hasAnActiveEntry) {
                            return '<span class="slds-icon_container" title="Is Lightning Web Component Enabled">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    }
                }
            ];

            if (window.isFoundationPkg) {
                $rootScope.vlocity.getCustomLabels('ODCFileBasedOmniscriptFieldLabel')
                    .then(function (results) {
                        $scope.defaultColumns.push(
                            {
                                resizable: false,
                                width: 110,
                                dynamic: true,
                                title: results[0],
                                getValue: function ($scope, row) {
                                    if (row.IsFileBased) {
                                        return '<span class="slds-icon_container" title="' + results[0] + '">' +
                                            '<slds-svg-icon sprite="\'utility\'"' +
                                            ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                                    }
                                },
                                getGroupValue: function ($scope, $group) {
                                    var hasAnActiveEntry = false;
                                    _.forEach($group.data, function (row) {
                                        if (row.IsFileBased) {
                                            hasAnActiveEntry = true;
                                            return false;
                                        }
                                    });
                                    if (hasAnActiveEntry) {
                                        return '<span class="slds-icon_container" title="' + results[0] + '">' +
                                            '<slds-svg-icon sprite="\'utility\'"' +
                                            ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                                    }
                                }
                            });
                    });
            }

            function changeActivation(row, group, isActivate) {

                // We need to validate if LWC is enabled
                if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c] && isActivate) {
                    const compilerService = $injector.get('compilerService'),
                        type = row[OmniScriptFieldMappingsNamespace.Type__c],
                        subType = row[OmniScriptFieldMappingsNamespace.SubType__c],
                        language = row[OmniScriptFieldMappingsNamespace.Language__c];

                    $q.all([compilerService.validate(type, subType, language),
                    $rootScope.vlocity.getCustomLabels('OmniDesActivation', 'OmniDesConfirmActivationWithLwc')])
                        .then((results) => {
                            var modalScope = $scope.$new();
                            modalScope.ok = () => preActivation(row, group, isActivate);
                            $modal({
                                title: results[1][0],
                                templateUrl: 'confirmationModal.tpl.html',
                                content: results[1][1],
                                scope: modalScope,
                                show: true
                            });
                        })
                        .catch(() => { });  // Empty as we don't need to update the UI yet.
                } else {
                    preActivation(row, group, isActivate);
                }
            }

            function preActivation(row, group, isActivate) {
                row.deleting = true;
                executeActivation(row, isActivate)
                    .then(responseObj => {
                        if (!(/redirectTo/.test(responseObj.url))) {
                            if (isActivate) {
                                // Process the LWC
                                processLwc(row, isActivate)
                                    .then(success => postActivation(row, group, isActivate, success));
                            } else {
                                postActivation(row, group, isActivate, true);
                            }
                        } else {
                            window.vlocityOpenUrl(responseObj.url);
                        }
                    });
            }

            function executeActivation(row, isActivate) {
                return new Promise((resolve, reject) => {
                    var input = angular.toJson({
                        Id: row.Id
                    });
                    var options = angular.toJson({
                        url: 'omniscripthome'
                    })
                    var className = fileNsPrefixDot() + 'BusinessProcessController.BusinessProcessControllerOpen';

                    vlocityVFActionFunctionControllerHandlers.runServerMethod(className, isActivate ? 'ActivateVersion' : 'DeactivateVersion', input, options, false)
                        .then(response => resolve(JSON.parse(response)))
                        .catch(reject);
                });
            }

            function postActivation(row, group, isActivate, success) {

                if (!isActivate && !success) {
                    isActivate = true;
                }

                $scope.$evalAsync(function () {
                    row.deleting = false;
                    if (isActivate) {
                        group.data.forEach(function (row) {
                            row[OmniScriptFieldMappingsNamespace.IsActive__c] = false;
                        });
                    }
                    row[OmniScriptFieldMappingsNamespace.IsActive__c] = isActivate && success;
                });
            }

            function processLwc(row, isActivate) {
                return new Promise((resolve, reject) => {

                    // if LWC is disabled, return
                    if (!row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                        resolve();
                        return;
                    }

                    // Use the injector to load dependencies
                    const compilerService = $injector.get('compilerService'),
                        toolingService = $injector.get('toolingService'),
                        bpService = $injector.get('bpService'),
                        type = row[OmniScriptFieldMappingsNamespace.Type__c],
                        subType = row[OmniScriptFieldMappingsNamespace.SubType__c],
                        language = row[OmniScriptFieldMappingsNamespace.Language__c],
                        sId = row['Id'],
                        lwcName = compilerService.getLwcName(type, subType, language),
                        addRuntimeNamespace = window.omniLwcCompilerConfig.isInsidePckg,
                        namespace = fileNsPrefix().replace('__', '');

                    if (isActivate) {
                        bpService.loadActiveLwc(type, subType, language)
                            .then(jsonObj => compilerService.compileActivated(lwcName, jsonObj, addRuntimeNamespace, namespace))
                            .then(resources => toolingService.deployResources(lwcName, resources, sId, compilerService.getPackageMetaXmlAsJson(type, subType, language, sId, lwcName, addRuntimeNamespace, namespace)))
                            .then(() => resolve(true))
                            .catch(error =>
                                $rootScope.vlocity.getCustomLabels('OmniDesLwcDeployError')
                                    .then(function (results) {
                                        executeActivation(row, false)
                                            .then(_ => {
                                                compilerService.showDeploymentError(error, results[0]).then(() => resolve(false));
                                            });
                                    }));

                    } else {
                        compilerService.deactivateLwc(type, subType, language, sId, addRuntimeNamespace, namespace)
                            .then(() => resolve(true))
                            .catch(error => {
                                // Re-activate the OS, we were not able to deploy. Notify the user that needs to verify the LWC manually.
                                executeActivation(row, true)
                                    .finally(() => {
                                        $rootScope.vlocity.getCustomLabels('OmniDesLwcDeactivateDeployError')
                                            .then(function (results) {
                                                compilerService.showDeploymentError(error, results[0]);
                                                resolve(false);
                                            });
                                    });
                            });
                    }
                });
            }

            $scope.rowActions = [
                {
                    text: 'Activate',
                    icon: {
                        sprite: 'utility',
                        icon: 'success'
                    },
                    click: function (row, group) {
                        changeActivation(row, group, true);
                    },
                    hide: function (row, group) {
                        return row[OmniScriptFieldMappingsNamespace.IsActive__c] || (!window.showLegacyOmniStudioUi && !row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]);
                    }
                },
                {
                    text: 'Deactivate',
                    icon: {
                        sprite: 'utility',
                        icon: 'clear'
                    },
                    click: function (row, group) {
                        changeActivation(row, group, false);
                    },
                    hide: function (row, group) {
                        return !row[OmniScriptFieldMappingsNamespace.IsActive__c];
                    }
                },
                {
                    type: 'export',
                    drvType: 'OmniScript',
                    backcompatExport: backcompatExport
                }, {
                    type: 'delete',
                    promptTitle: 'Delete OmniScript?',
                    promptContent: function (row) {
                        return 'Are you sure you want to delete this OmniScript?<br/> <br/>"' +
                            _.escape(row.Name) + ' (Version ' + row[OmniScriptFieldMappingsNamespace.Version__c] + ')" ';
                    },
                    hide: function (row, group) {
                        return row[OmniScriptFieldMappingsNamespace.IsActive__c];
                    }
                }, {
                    text: 'Preview (Newport)',
                    icon: {
                        sprite: 'utility',
                        icon: 'preview'
                    },
                    click: function (row, group, $event) {
                        let url;
                        const isInsidePkg = window.omniLwcCompilerConfig.isInsidePckg === true || window.omniLwcCompilerConfig.isInsidePckg === 'true';

                        if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                            const urlParams = [
                                'ns=' + (row.IsActive && isInsidePkg ? 'c' : fileNsPrefix().replace('__', '')),
                                'lwc=' + (row.IsActive ? row.Type + row.SubType + row.Language : 'omniscriptPreview'),
                                'layout=' + 'newport',
                                'isdtp=p1',
                                'sfdcIFrameOrigin=' + encodeURIComponent(window.location.protocol + '//' + window.location.hostname),
                                'sfdcIFrameHost=web',
                            ];

                            if (!row.IsActive) {
                                urlParams.push(`id=${row.Id}`);
                            }
                            url = `/apex/${fileNsPrefix()}OmniscriptLwcPreviewPage?${urlParams.join('&')}`;
                        } else {
                            url = window.previewUrl + '?layout=newport&id=' + row.Id;
                        }
                        window.vlocityOpenUrl(url, $event);
                    },
                    hide: function (row, group) {
                        return (!window.showLegacyOmniStudioUi && !row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]);
                    }
                }, {
                    text: 'Preview (Lightning)',
                    icon: {
                        sprite: 'utility',
                        icon: 'preview'
                    },
                    click: function (row, group, $event) {
                        let url;
                        const isInsidePkg = window.omniLwcCompilerConfig.isInsidePckg === true || window.omniLwcCompilerConfig.isInsidePckg === 'true';

                        if (row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]) {
                            const urlParams = [
                                'ns=' + (row.IsActive && isInsidePkg ? 'c' : fileNsPrefix().replace('__', '')),
                                'lwc=' + (row.IsActive ? row.Type + row.SubType + row.Language : 'omniscriptPreview'),
                                'layout=' + 'lightning',
                                'isdtp=p1',
                                'sfdcIFrameOrigin=' + encodeURIComponent(window.location.protocol + '//' + window.location.hostname),
                                'sfdcIFrameHost=web',
                            ];

                            if (!row.IsActive) {
                                urlParams.push(`id=${row.Id}`);
                            }
                            url = `/apex/${fileNsPrefix()}OmniscriptLwcPreviewPage?${urlParams.join('&')}`;
                        } else {
                            url = window.previewUrl + '?layout=lightning&id=' + row.Id;
                        }
                        window.vlocityOpenUrl(url, $event);
                    },
                    hide: function (row, group) {
                        return (!window.showLegacyOmniStudioUi && !row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]);
                    }
                },
                {
                    text: 'Publish',
                    icon: {
                        sprite: 'utility',
                        icon: 'upload'
                    },
                    click: function (row, group) {
                        backcompatExport(row, false, true);
                    },
                    hide: function (row, group) {
                        return !row[OmniScriptFieldMappingsNamespace.IsActive__c] || (!window.showLegacyOmniStudioUi && !row[OmniScriptFieldMappingsNamespace.IsLwcEnabled__c]);
                    }
                }
            ];

            $scope.sorting = { [OmniScriptFieldMappingsNamespace.Type__c]: 'asc' };

            $scope.extraFilters = [{
                name: {
                    Name: OmniScriptFieldMappingsNamespace.IsProcedure__c,
                    Type: 'BOOLEAN'
                },
                operator: '=',
                value: false
            }];

            function getOmniScriptsWarnings() {
                $q(function(resolve, reject) {
                    remoteActions.getOmniScriptsWarnings(JSON.stringify($rootScope.omniScriptsWarningsRequest))
                    .then(function (resp) {
                        $rootScope.omniScriptsWarnings = resp;
                        resolve(resp)
                    })
                    .catch(function(err) {
                        reject(err);
                    });
                });
            }

            $scope.newDesignerCustomizationButtons = [];
            if(window.isFoundationPkg){
                $rootScope.vlocity.getCustomLabels('OmniAuraServerError').then(function (results) {
                    if (OmniScriptFieldMappingsNamespace && OmniScriptFieldMappingsNamespace.DesignerCustomizationType && OmniScriptFieldMappingsNamespace.Type__c) {
                        var osTypeFieldIndex = $scope.defaultColumns.findIndex((column => column.field === OmniScriptFieldMappingsNamespace.Type__c));
                        if (osTypeFieldIndex !== -1) {
                            $scope.defaultColumns[osTypeFieldIndex].additionalFields.push(OmniScriptFieldMappingsNamespace.DesignerCustomizationType);
                        }
                    }
                    window.omniDesignerCustomizationTypes.forEach(function (data) {
                        var button;
                        if(data){
                            button = {
                                id :   data.customDesignerTypeLabel,
                                text : data.newButtonLabel,
                                click : function(scope, event) {
                                    window.vlocityOpenUrl(window.newOutSideFeatureUrl+data.newFormAuraComponentNamespaceAndName+'&c__customLabel='+results[0],event);
                                }
                            };
                            $scope.newDesignerCustomizationButtons.push(button);
                        }
                    });
                });

                $scope.$watch(function() {
                    return $rootScope.omniScriptsWarningsRequest;
                  }, function() {
                    getOmniScriptsWarnings();
                }, true);
            }
        }]);

},{}],4:[function(require,module,exports){
(function(){
    'use strict';
    var dModule = angular.module('ouihome');
    dModule.directive('osWarning', function(){
        return {
            restrict: 'E',
            transclude: true,
            templateUrl: 'osWarning.tpl.html',
            scope: {
                'warningMessage': '@',
                'hideWarningDialog': '@',
                'warningLabel': '@',
            },
            controller: function($scope) {
                $scope.showWarningDialog = false;
                $scope.handleShowWarningDialog = function() {
                    $scope.showWarningDialog = true;
                };
                $scope.handleCloseWarningDialog = function() {
                    $scope.showWarningDialog = false;
                };
            },
          };
    }); 
}());

},{}],5:[function(require,module,exports){
angular.module('ouihome')
       .factory('backcompatExport', function(remoteActions, $localizable, OmniScriptFieldMappingsNamespace) {
           var $scope = {};

           return function backcompatExport(script, dontRetryCompile, useJSONV2)  {
                var exportResult,
                    initialPromise;
                if (useJSONV2) {
                    initialPromise = remoteActions.BuildJSONV2(script.Id)
                } else {
                    initialPromise = remoteActions.exportOmniScript(script.Id);
                }
                initialPromise
                    .then(function(result) {
                        var pom = document.createElement('a');
                        if (!angular.isString(result)) {
                            // OMNI-421 - always make into array for backcompat
                            if (!angular.isArray(result) && useJSONV2 !== true) {
                                result = [result];
                            }
                            result = JSON.stringify(result);
                            result = result.replace('&quot;', '&amp;quot;');
                        }
                        try {
                            pom.setAttribute('href', 'data:application/zip;charset=utf-8,' + encodeURIComponent(result));
                            var name = (script[OmniScriptFieldMappingsNamespace.Type__c] || '') + '_' + (script[OmniScriptFieldMappingsNamespace.SubType__c] || '') + '_' + (script[OmniScriptFieldMappingsNamespace.Language__c] || '');
                            name = name.replace(/ /g, '');
                            pom.setAttribute('download', name + '.json');
                            pom.style.display = 'none';
                            document.body.appendChild(pom);
                            pom.click();
                        } catch (e) {
                            window.alert($localizable('OmniHomeFailExport', 'Unable to export {1}', script.Name));
                        }
                        document.body.removeChild(pom);
                    }, function(error) {
                        if (dontRetryCompile) {
                            window.alert($localizable('OmniHomeFailExport', 'Unable to export {1}', script.Name));
                        } else {
                            // if false then try compile it
                            var iframe = document.createElement('iframe');
                            iframe.src = window.previewUrl + '?id=' + script.Id;
                            iframe.style.display = 'none';
                            $(iframe).load(function() {
                                setTimeout(function() {
                                    document.body.removeChild(iframe);
                                    backcompatExport(script, true, useJSONV2);
                                }, 5000);
                            });
                            document.body.appendChild(iframe);
                        }
                    });
           };
       });

},{}],6:[function(require,module,exports){
angular.module('ouihome')
       .factory('backcompatImport', function($localizable, remoteActions, $q) {
           var $scope = {};

           return function backcompatImport(json, done) {
               if (!angular.isArray(json)) {
                   json = [json];
               }
               $scope.importScripts = json;
               $scope.importScripts = $scope.importScripts.filter(function(script) {
                   return script.Name && script.jsonScript && script.jsonScript.propSetMap;
               });
               if ($scope.importScripts.length === 0) {
                   return false;
               }
               $scope.importedScriptNames = [];
               $scope.importMessage = $localizable('OmniScriptImport', 'Importing Script...');
               remoteActions.toggleElementTrigger(false)
                .then(function() {
                    if ($scope.importScripts) {
                        var promises = $scope.importScripts.reduce(function(array, script) {
                          return array.concat(angular.isArray(script) ? script : [script]);
                      }, []).map(function(script) {
                          return importScripts(script)
                            .then(function(result) {
                                $scope.importedScriptNames.push(result.Name);
                                $scope.importMessage = $localizable('OmniHomeImportMessage', 'Importing \'{1}\'...',
                                                                      result.Name);
                                return createElements(result.sfdcId, result.sfdcId, result.jsonScript.children);
                            });
                      });

                        return $q.all(promises);
                    } else {
                        return remoteActions.toggleElementTrigger(true);
                    }
                })
                  .then(flattenOrLoad)
                  .then(function() {
                      done();
                  }, function() {
                      done();
                  });
               return true;
           };

           function recursivelyFlatten(result, intoArray) {
              if (angular.isArray(result)) {
                  intoArray = intoArray.concat(result.reduce(function(array, value) {
                      return array.concat(recursivelyFlatten(value, []));
                  }, []));
              } else {
                  intoArray.push(result);
              }
              return intoArray;
          }

           function flattenOrLoad(result) {
              var promises = [];
              if (!angular.isArray(result)) {
                  result = [result];
              }
              promises = recursivelyFlatten(result, []).filter(function(value) {
                  return value && value.then;
              }).map(function(value) {
                  return $q.when(value);
              });
              if (promises.some(function(value) {
                  return !!value.then;
              })) {
                  return $q.all(promises).then(flattenOrLoad);
              }
          }

           function importScripts(script) {
                var propSetMap = '';
                if (script.jsonScript.propSetMap) {
                    propSetMap = JSON.stringify(script.jsonScript.propSetMap);
                }
                return remoteActions.createScript(script.Name, script.jsonScript, propSetMap)
                        .then(function(result) {
                            script.sfdcId = result;
                            return script;
                        });
            }

           function createElements(omniscriptId, parentId, elements) {
                var ind = 0;
                return elements.map(function(element) {
                    if (element.bEmbed === true)
                    {
                        ind++;
                        return $q.when(true);
                    }
                    $scope.importedElements++;
                    return createElement(omniscriptId, parentId, element, ind++)
                      .then(function(result) {
                          $scope.importedElements--;
                          $scope.totalImportedElements++;
                          var promises = [];
                          if (result.children && result.children.length > 0) {
                              promises.push(createElements(result.omniId, result.sfdcId, result.children));
                          }
                          if ($scope.importedElements === 0) {
                              $scope.importMessage = $localizable('OmniHomeImportMessage2',
                                  'Completed: Imported {1} scripts and {2} elements', $scope.importScripts.length,
                                  $scope.totalImportedElements);
                              promises.push(remoteActions.toggleElementTrigger(true));
                          }
                          return $q.all(promises);
                      }, function(reason) {
                          $scope.importMessage = $localizable('OmniHomeImportMessage3',
                              'Completed with Errors: Imported {1} scripts and {2} elements',
                                $scope.importScripts.length, $scope.totalImportedElements);
                          return remoteActions.toggleElementTrigger(true);
                      });
                });
            }

           function createElement(omniscriptId, parentId, jsonData, eleOrder) {
               if (jsonData.eleArray) {
                   jsonData = jsonData.eleArray[0];
               }
               var propSetMap = JSON.stringify(jsonData.propSetMap);
               return remoteActions.createElement(omniscriptId, parentId, jsonData, propSetMap, eleOrder)
                  .then(function(result) {
                      jsonData.sfdcId = result;
                      jsonData.omniId = omniscriptId;
                      return jsonData;
                  });
           }

       });

},{}],7:[function(require,module,exports){
angular.module("ouihome").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("osWarning.tpl.html",'<span>\n    <div style="margin-left: 5px;">\n        <slds-svg-icon sprite="\'utility\'" icon="\'warning\'" size="\'x-small\'"  extra-classes="\'slds-icon-text-warning\'" ng-click="handleShowWarningDialog()"></slds-svg-icon>\n    </div>\n    <div ng-if="!hideWarningDialog">\n      <div style="margin-top: 10px;margin-left: -12px;position: fixed;z-index: 10000;" ng-if="showWarningDialog">\n        <section class="slds-popover slds-popover_warning slds-nubbin_top-left" role="dialog">\n            <button class="slds-button slds-button_icon slds-button_icon-small slds-float_right slds-popover__close" ng-click="handleCloseWarningDialog()">\n              <slds-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'x-small\'"\n                class="slds-icon slds-icon_x-small slds-icon-text-default"\n              ></slds-svg-icon>\n            </button>              \n            <header class="slds-popover__header">\n              <div class="slds-media slds-media_center slds-has-flexi-truncate">\n                <div class="slds-media__figure">\n                  <span class="slds-icon_container slds-icon-utility-warning">\n                    <slds-svg-icon sprite="\'utility\'" icon="\'warning\'" size="\'small\'"\n                        class="slds-icon slds-icon_x-small slds-icon-text-default"\n                    ></slds-svg-icon>\n                  </span>\n                </div>\n                <div class="slds-media__body">\n                  <h2 class="slds-truncate slds-text-heading_medium">{{warningLabel}}</h2>\n                </div>\n              </div>\n            </header>\n            <div class="slds-popover__body slds-popover__body_small slds-popover_warning__body">\n              <p class="slds-cell-wrap">{{warningMessage}}</p>\n            </div>\n        </section>\n    </div>\n    </div>\n</span>\n'),$templateCache.put("alertModal.tpl.html",'<div class="modal vlocity" tabindex="-1" role="dialog" aria-hidden="true">\n  <div class="modal-dialog">\n    <div class="modal-content">\n      <div class="modal-header" ng-show="title">\n        <button type="button" class="close" aria-label="Close" ng-click="$hide()"><span aria-hidden="true">&times;</span></button>\n        <h4 class="modal-title" ng-bind="title"></h4>\n      </div>\n      <div class="modal-body">\n        <div class="content" ng-bind="content" ng-if="content">\n        </div>\n        <ul ng-if="errors">\n          <li ng-repeat="error in errors">\n            {{ error }}\n          </li>\n        </ul>\n      </div>\n      <div class="modal-footer">\n        <button type="button" class="btn btn-primary" ng-click="ok();$hide()">{{ ::\'OmniDesOk\' | localize }}</button>\n      </div>\n    </div>\n  </div>\n</div>'),$templateCache.put("confirmationModal.tpl.html",'<div class="modal vlocity" tabindex="-1" role="dialog" aria-hidden="true">\n  <div class="modal-dialog">\n    <div class="modal-content">\n      <div class="modal-header" ng-show="title">\n        <button type="button" class="close" aria-label="Close" ng-click="$hide()"><span aria-hidden="true">&times;</span></button>\n        <h4 class="modal-title" ng-bind="title"></h4>\n      </div>\n      <div class="modal-body">\n        <div class="content" ng-bind="content">\n        </div>\n      </div>\n      <div class="modal-footer">\n        <button type="button" class="btn btn-primary" ng-click="ok();$hide()">{{ ::\'OmniDesOk\' | localize }}</button>\n        <button type="button" class="btn btn-default" ng-click="$hide()">{{ ::\'OmniDesCancel\' | localize }}</button>\n      </div>\n    </div>\n  </div>\n</div>')}]);

},{}],8:[function(require,module,exports){
//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find
if (!Array.prototype.find) {
  Array.prototype.find = function(predicate) {
    /* jshint eqnull:true */
    if (this == null) {
      throw new TypeError('Array.prototype.find called on null or undefined');
    }
    if (typeof predicate !== 'function') {
      throw new TypeError('predicate must be a function');
    }
    var list = Object(this);
    var length = list.length >>> 0;
    var thisArg = arguments[1];
    var value;

    for (var i = 0; i < length; i++) {
      value = list[i];
      if (predicate.call(thisArg, value, i, list)) {
        return value;
      }
    }
    return undefined;
  };
}
},{}],9:[function(require,module,exports){
//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/findIndex
if (!Array.prototype.findIndex) {
  Array.prototype.findIndex = function(predicate) {
    /* jshint eqnull:true */
    if (this == null) {
      throw new TypeError('Array.prototype.findIndex called on null or undefined');
    }
    if (typeof predicate !== 'function') {
      throw new TypeError('predicate must be a function');
    }
    var list = Object(this);
    var length = list.length >>> 0;
    var thisArg = arguments[1];
    var value;

    for (var i = 0; i < length; i++) {
      value = list[i];
      if (predicate.call(thisArg, value, i, list)) {
        return i;
      }
    }
    return -1;
  };
}
},{}]},{},[1]);
})();
