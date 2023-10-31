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
angular.module('drhome', ['DRHome.core', 'sldsangular', 'drvcomp', 'ngTable', 'vlocity', 'infinite-scroll'])
	.config(['$localizableProvider', function($localizableProvider) {
      'use strict';
      $localizableProvider.setLocalizedMap(window.i18n);
      $localizableProvider.setDebugMode(window.ns === '');
  	}]);

require('./modules/drhome/config/config.js');

require('./modules/drhome/controller/DRHome.js');

},{"./modules/drhome/config/config.js":2,"./modules/drhome/controller/DRHome.js":3}],2:[function(require,module,exports){
angular.module('drhome')
    .config(['remoteActionsProvider', 'fileNsPrefixDot', function(remoteActionsProvider, fileNsPrefixDot) {
        'use strict';
        var remoteActions = {
            getAllBundles: {
                action: fileNsPrefixDot() + 'DRMapperControllerFoundation.getAllBundles',
                config: {escape: false}
            },
            deleteBundle: {
                action: fileNsPrefixDot() + 'DRMapperControllerFoundation.deleteBundle'
            }
        };
        remoteActionsProvider.setRemoteActions(remoteActions);
    }]);

},{}],3:[function(require,module,exports){
angular.module('drhome')
    .controller('drhome', ['$sanitize', '$scope', 'remoteActions', '$filter', '$localizable', 'DRBundleFieldMappingsNamespace', 'IsFoundation',
                                function($sanitize, $scope, remoteActions, $filter, $localizable, DRBundleFieldMappingsNamespace, IsFoundation) {
        'use strict';
        
        $scope.isFoundation = IsFoundation;

        if(IsFoundation !== false) {
            $scope.groupBy = function (datatransform) {
                return  datatransform['Name'];
            };
        } else {
            $scope.groupBy = false;
        }
        
        $scope.defaultColumns = [{
            field: 'Name',
            additionalFields: window.isFoundationPackage ? [DRBundleFieldMappingsNamespace.VersionNumber] : undefined,
            getValue: function ($scope, row) {
                var url;
                if(row?.IsFileBased){
                    url = window.DRNewUrl + '?uniqueName=' + row.UniqueName;
                } else {
                    url = window.DRNewUrl + '?id=' + row.Id;
                }
                var versionString = '';
                if (window.isFoundationPackage) {
                    versionString = ' (Version ' + row[DRBundleFieldMappingsNamespace.VersionNumber] + ')';
                }
                return '<a href="' + url + '" ng-mouseup="$root.vlocityOpenUrl(\'' + url + '\', $event);">' +
                    _.escape(row.Name) + versionString + '</a>';
            },
            getGroupValue: function ($scope, $group) {
                var Name = _.escape($group.data[0]['Name']);
                if (!Name) {
                    return '<span>&nbsp;</span>';
                }
                return '<span>' + Name + '</span>';
            },
            resizable: true
        }, {
            field: DRBundleFieldMappingsNamespace.Type__c,
            resizable: true,
            width: 180,
            additionalFields: [DRBundleFieldMappingsNamespace.InputType__c, DRBundleFieldMappingsNamespace.OutputType__c],
            sortable: DRBundleFieldMappingsNamespace.Type__c + ', ' + DRBundleFieldMappingsNamespace.InputType__c + ', ' + DRBundleFieldMappingsNamespace.OutputType__c,
            getValue: function($scope, row) {
                var output = row[DRBundleFieldMappingsNamespace.Type__c]
                if (!/\(/.test(output)) {
                    if (row[DRBundleFieldMappingsNamespace.InputType__c] && row[DRBundleFieldMappingsNamespace.OutputType__c]) {
                        output += ' (' + row[DRBundleFieldMappingsNamespace.InputType__c] + ' → ' + row[DRBundleFieldMappingsNamespace.OutputType__c] + ')';
                    } else if (row[DRBundleFieldMappingsNamespace.OutputType__c]) {
                        output += ' (' + row[DRBundleFieldMappingsNamespace.OutputType__c] + ')';
                    }
                }
                return _.escape(output);
            }
        }, {
            field: DRBundleFieldMappingsNamespace.Description__c,
            getValue: function($scope, row) {
                if (!row[DRBundleFieldMappingsNamespace.Description__c]) {
                    return '';
                }
                return '<span title="' + _.escape(row[DRBundleFieldMappingsNamespace.Description__c]) + '">' +
                _.escape(row[DRBundleFieldMappingsNamespace.Description__c]) + '</span>';
            },
            resizable: true
        }, {
            resizable: true,
            width: 140,
            field: 'LastModifiedDate',
            getGroupValue: function($scope, $group) {
                return $filter('date')($group.data[0].LastModifiedDate, 'short');
            },
            getValue: function($scope, row) {
                return $filter('date')(row.LastModifiedDate, 'short');
            }
        }, {
            resizable: true,
            width: 140,
            field: 'LastModifiedById',
            getGroupValue: function($scope, $group) {
                return $group.data[0].LastModifiedBy ? _.escape($group.data[0].LastModifiedBy.Name) : '';
            },
            getValue: function($scope, row) {
                return row.LastModifiedBy ? _.escape(row.LastModifiedBy.Name) : '';
            }
        }];

        if (window.isFoundationPackage) {
            $scope.defaultColumns.push(
                {
                    title: window.i18n['DRHomeStandard'],
                    field: 'IsActive',
                    resizable: false,
                    width: 180,
                    dynamic: true,
                    getValue: function ($scope, row) {
                        if (row?.IsFileBased) {
                            return '<span class="slds-icon_container" title="Is Standard">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    },
                    getGroupValue: function ($scope, $group) {
                        var hasAnActiveEntry = false;
                        _.forEach($group.data, function (row) {
                            if (row?.IsFileBased) {
                                hasAnActiveEntry = true;
                                return false;
                            }
                        });
                        if (hasAnActiveEntry) {
                            return '<span class="slds-icon_container" title="Is Standard">' +
                                '<slds-svg-icon sprite="\'utility\'"' +
                                ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                        }
                    }
                });
                $scope.defaultColumns.push(
                    {
                        title: window.i18n['DRHomeActive'],
                        resizable: false,
                        width: 180,
                        dynamic: true,
                        getValue: function ($scope, row) {
                            if (row[DRBundleFieldMappingsNamespace.IsActive]) {
                                return '<span class="slds-icon_container" title="Is Active">' +
                                    '<slds-svg-icon sprite="\'utility\'"' +
                                    ' icon="\'success\'" size="\'x-small\'"  extra-classes=\"\'slds-icon-text-default\'\"></slds-svg-icon></span>';
                            }
                        }
                    });
        }

        $localizable('DeleteDataRaptor', 'Delete DataRaptor')
            .then(function(label) {
                $scope.rowActions = [{
                    type: 'export',
                    drvType: 'DataRaptor'
                }, {
                    type: 'delete',
                    promptTitle: label,
                    promptContent: function(row, group) {
                        return $localizable('DeleteDataraptorConfirmation2', 'Are you sure you want to delete this DataRaptor interface?<br/> <br/> {1}', _.escape(row.Name));
                    },
                    deleteAction: function(row, group) {
                        return remoteActions.deleteBundle(row.Id);
                    },
                    hide: function (row, group) {
                        return row[DRBundleFieldMappingsNamespace.IsActive];
                    }
                }];
            });

        $scope.extraFilters = [{
            name: {
                Name: DRBundleFieldMappingsNamespace.Type__c
            },
            operator: '!=',
            value: 'Migration'
        }, {
            name: {
                Name: DRBundleFieldMappingsNamespace.Type__c
            },
            operator: '!=',
            value: 'Export (Component)'
        }];

    }]);

},{}]},{},[1]);
})();
