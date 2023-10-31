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
var contractDocumentCreationApp = angular.module('contractDocumentCreationApp', ['vlocity', 'mgcrea.ngStrap', 'ngSanitize',
'ngAnimate', 'sldsangular'
]).config(['remoteActionsProvider', function(remoteActionsProvider) {
    'use strict';
    remoteActionsProvider.setRemoteActions(window.remoteActions || {});
}]);

// Factories
require('./modules/contractDocumentCreationApp/factory/ValidationErrorHandler.js');
require('./modules/contractDocumentCreationApp/factory/ReconcileChanges.js');

// Services
require('./modules/contractDocumentCreationApp/services/BrowserDetection.js');

// Controllers
require('./modules/contractDocumentCreationApp/controller/ContractDocumentCreationController.js');

// Directives
require('./modules/contractDocumentCreationApp/directive/FilePreviewPdfTron.js');
require('./modules/contractDocumentCreationApp/directive/VlcLoader.js');

// Components
require('./modules/contractDocumentCreationApp/component/docxTemplateComponent.js');

// Templates
require('./modules/contractDocumentCreationApp/templates/templates.js');

},{"./modules/contractDocumentCreationApp/component/docxTemplateComponent.js":2,"./modules/contractDocumentCreationApp/controller/ContractDocumentCreationController.js":3,"./modules/contractDocumentCreationApp/directive/FilePreviewPdfTron.js":4,"./modules/contractDocumentCreationApp/directive/VlcLoader.js":5,"./modules/contractDocumentCreationApp/factory/ReconcileChanges.js":6,"./modules/contractDocumentCreationApp/factory/ValidationErrorHandler.js":7,"./modules/contractDocumentCreationApp/services/BrowserDetection.js":8,"./modules/contractDocumentCreationApp/templates/templates.js":9}],2:[function(require,module,exports){
angular.module('contractDocumentCreationApp').component('docxTemplateComponent', {
    templateUrl: 'component/docxTemplateComponent.tpl.html',
    bindings: {
        contentVersion: '<',
        labels: '<',
        ispdfDownloadReady: '<',
        pdfSinglePageViewer: '<'
    },
    controller: function($scope) {
        var ctrl = this;
    
        ctrl.$onChanges = function(changes) {
            if (changes.contentVersion) {
                $scope.contentVersion = changes.contentVersion.currentValue;
            }
            if (changes.labels) {
                $scope.labels = changes.labels.currentValue;
            }
            if(changes.ispdfDownloadReady){
                $scope.ispdfDownloadReady = changes.ispdfDownloadReady.currentValue;
            }
            if(changes.pdfSinglePageViewer){
                $scope.pdfSinglePageViewer = changes.pdfSinglePageViewer.currentValue;
            }
        };
    }
});

},{}],3:[function(require,module,exports){
angular.module('contractDocumentCreationApp').controller('contractDocumentCreationCtrl', function ($scope, $sce, $rootScope,
    remoteActions, ValidationErrorHandler, ReconcileChanges, browserDetection, $sldsModal, $timeout, $q) {
    'use strict';
    $scope.nameSpacePrefix = '';
    $scope.editPageUrl = '';
    $scope.parentId = '';
    $scope.sourceId = '';
    $scope.versionName = '';
    $scope.docName = '';
    $scope.containsRedlines = '';
    $scope.baseRequestUrl = '';
    $scope.inLightningExperience = false;
    $scope.labels = {};
    $scope.PdfGenerationSource;
    $scope.docGenerationMechanism;
    $scope.isPdftronInitialized = false;
    $scope.isCheckIn = false;
    $scope.VlocityClientSide = 'vlocityclientside';
    $scope.VlocityCloud = 'vlocitycloud';
    $scope.Salesforce = 'salesforce';
    $scope.docTypeOptions = new Set(['pdf', 'word,pdf','pdf,word']);
    $scope.pdfViewer='none'; //default viewer
    $scope.documentAttachmentType = {};
    $scope.autoAttachDocType = {};
    $scope.showDownloadWord = false;
    $scope.showDownloadPdf = false;
    $scope.showDownloadNone = false;
    $scope.autoAttachDoc = false;
    $scope.isReconcileDoc = false;
    $scope.isAutoAttachTypePDF = false;
    $scope.documentTemplateId;
	$scope.preview = false;
	$scope.sitePrefix = '';

    $scope.pdfLoading = false;
    $scope.pdfSinglePageViewer = {};
    $scope.recordDeletionLimit = 8000;
    $scope.templateType = '';

    if (window.nameSpacePrefix !== undefined) {
        $scope.nameSpacePrefix = window.nameSpacePrefix;
    }
    if (window.editSectionPage !== undefined) {
        $scope.editPageUrl = window.editSectionPage;
    }
    if (window.parentId !== undefined) {
        $scope.parentId = window.parentId;
    }
    if (window.sourceId !== undefined) {
        $scope.sourceId = window.sourceId;
    }
    if (window.versionName !== undefined) {
        $scope.versionName = window.versionName;
    }
    if (window.docName !== undefined) {
        $scope.docName = window.docName;
    }
    if (window.containsRedlines !== undefined) {
        $scope.containsRedlines = window.containsRedlines;
    }
    if (window.baseRequestUrl !== undefined) {
        $scope.baseRequestUrl = window.baseRequestUrl;
    }
    if (window.inLightningExperience !== undefined) {
        $scope.inLightningExperience = window.inLightningExperience;
    }
    if (window.labels !== undefined) {
        $scope.labels = window.labels;
    }
    if (window.pdfGenerationSource !== undefined) {
        $scope.pdfGenerationSource = window.pdfGenerationSource;
    }
    if (window.pdfViewer !== undefined) {
        $scope.pdfViewer = window.pdfViewer.toLowerCase();
    }
    if (window.recordDeletionLimit !== undefined) {
        $scope.recordDeletionLimit = window.recordDeletionLimit;
    }
    if (window.autoAttachDoc !== undefined) {
        $scope.autoAttachDoc = window.autoAttachDoc;
    }
    if (window.documentTemplateId !== undefined) {
        $scope.documentTemplateId = window.documentTemplateId;
    }
    if (window.templateType !== undefined) {
        $scope.templateType = window.templateType;
    }
    if (window.autoAttachDocType !== undefined) {
        $scope.autoAttachDocType = window.autoAttachDocType;
    }
	if (window.preview !== undefined) {
		$scope.preview = window.preview;
	}
	if (window.sitePrefix !== undefined) {
		$scope.sitePrefix = window.sitePrefix;
		sforce.connection.serverUrl = $scope.sitePrefix + sforce.connection.serverUrl;
    }
    if (window.isReconcileDoc !== undefined) {
        $scope.isReconcileDoc = window.isReconcileDoc;
    }
    

    console.log('recordDeletionLimit=' + $scope.recordDeletionLimit);
    console.log('pdfGenerationSource=' + $scope.pdfGenerationSource);
    console.log('templateType=' + $scope.templateType);


    $scope.vlcLoading = true;
    $scope.isPdfDownloadReady = false;
    $scope.isDocxDownloadReady = false;
    $scope.isBatchableTemplate = false;
    $scope.activeTemplates = true;
    $scope.showSuccessMessage = false;
    $scope.showRemovedMessage = false;
    $scope.validationMessage = {
        'type': 'alert-success',
        'content': '',
        'error': false
    };
    // warning message shows if sections length is 0, so we add a dummy index:
    $scope.versionData = {
        'sections': ['dataOnLoad'],
        'template': {}
    };
    $scope.originalSections = {};
    $scope.initialTemplateOption = {
        templateLabel: 'Select a Template'
    };
    $scope.versionLoadedData = {};
    $scope.latestVersionData = {};
    $scope.contractTemplates = [];
    $scope.templateAttached = false;
    $scope.availableTemplatesLabel = 'Available Templates';
    $scope.versionUrl = document.referrer.split('?')[0];
    $scope.newVersionId = '';
    $scope.isConsole = sforce.console.isInConsole();
    $scope.isSforce = (typeof sforce !== 'undefined' && typeof sforce.one !== 'undefined') ? (true) : (false);
    $scope.browser = browserDetection.detectBrowser();
    $scope.isSafari = ($scope.browser === 'safari') ? true : false;
    $scope.isInternetExplorer = ($scope.browser === 'msielte10' || $scope.browser === 'msiegt10') ? true : false;
    $scope.browserVersion = browserDetection.getBrowserVersion();
    $scope.tabs = {};
    $scope.isReconciledView = false;
    $scope.validationErrorHandler = new ValidationErrorHandler(); // Instantiating ValidationErrorHandler Factory
    $scope.clientSidePdfGenerationConfig={};
    $scope.generatedContentVersion = {};
    $scope.generatedPDFContentVersion={};
    $scope.pdfIntegrationConfig={};
    $scope.isBatchCheckinReady = false;
    $scope.isWordCheckinReady = false;
    $scope.isNewDocWithSectionsNeeded = false;
    $scope.showViewTrackSections = false;
    $scope.showReconcileView = false;
    $scope.showDocumentView = false;
    $scope.docxSectionList =[];
    $scope.contentVersionMap = {};

    var templateTypeCodeMap = {
        'Vlocity Web Template': 'Web',
        'Microsoft Word .DOCX Template': 'DocX'
    };

    function refreshCurrentPrimaryTab() {
        sforce.console.getFocusedPrimaryTabId(showTabId);
    }

    function showTabId(result) {
        var primaryTabId = result.id;
        console.log('primaryTabId::', primaryTabId );
        sforce.console.refreshPrimaryTabById(primaryTabId, true, refreshSuccess); //To update/refresh the contractVersion on checkin in lightning.
        //sforce.console.refreshSubtabByNameAndPrimaryTabId($scope.versionLoadedData.documentObj.ContractNumber , primaryTabId, true, refreshSuccess);
    }

    function refreshSuccess(result) {
        //Report whether action was successful
        if (result.success === true) {
            if ($scope.showSuccessMessage) {
                alert('Successfully Attached Template to Contract Version.');
                $scope.showSuccessMessage = false;
            } else if ($scope.showRemovedMessage) {
                alert('Successfully Removed Template from Contract Version.');
                $scope.showRemovedMessage = false;
            }
        } else {
            //alert('Primary did not refresh');
        }
    }

    function getRelsFile(zip) {
        var file = zip.file('word/_rels/document.xml.rels');
        if (file != null) {
            return file.asText();
        }
        return '';
    }

    function generateDocx(result, type, zip) {
        var i, doc, out;
        var contractData = result.contractData;
        var imageCount = result.imageData.numImages;
        for (i = 0; i < imageCount; i++) {
            if (typeof result.imageData['imageData' + i] !== 'undefined' && result.imageData['imageData' + i] !== null) {
                zip.file('word/media/imageData' + i + '.png', result.imageData['imageData' + i], {base64: true});
            }
        }
        if (result.contractData.numberingXML !== null && result.contractData.numberingXML !== '') {
            zip.remove('word/numbering.xml');
            zip.file('word/numbering.xml',result.contractData.numberingXML,{});
        }
        if (typeof result.contractData.DocxRels !== 'undefined' && result.contractData.DocxRels !== null) {
            zip.remove('word/_rels/document.xml.rels');
            zip.file('word/_rels/document.xml.rels', result.contractData.DocxRels, {});
        }

        doc = new Docxtemplater();
        doc.loadZip(zip);
        doc.setData(contractData);
        doc.render();

        if (type === 'blob') {
            out = doc.getZip().generate({
                type: 'blob',
                mimeType:'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            });
        } else {
            out = doc.getZip().generate({
                type: 'base64',
                mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            });
        }

        return out;
    }

    function base64ToArrayBuffer(base64) {
        var binary_string = window.atob(base64);
        var len = binary_string.length;
        var bytes = new Uint8Array(len);
        for (var i = 0; i < len; i++) {
            bytes[i] = binary_string.charCodeAt(i);
        }
        return bytes.buffer;
    }

    $scope.showSelectedView = function(showView) {
        $scope.showViewTrackSections = (showView === 'viewTrackSections') ? true :false;
        $scope.showReconcileView = (showView === 'reconcileView') ? true : false;
        $scope.showDocumentView = (showView === 'viewDocument') ? true : false;
    }

    $scope.initContractVersion = function() {
     //Get the Attach Option for document
     if($scope.autoAttachDoc == "false"){
         remoteActions.getDocumentType($scope.sourceId).then(function(result){
                 console.log('### document settings: ', result);
                 $scope.documentAttachmentType =  result.ContractDocumentAttachOption;
                 $scope.isAttachmentTypePdf = $scope.documentAttachmentType.search(/PDF/i) > -1;
                 $scope.isAttachmentTypeWord = $scope.documentAttachmentType.search(/WORD/i) > -1;
                 $scope.showDownloadPdf = result.ContractDocumentDownloadOption.search(/PDF/i) > -1;
                 $scope.showDownloadWord = result.ContractDocumentDownloadOption.search(/WORD/i) > -1;
                 $scope.showDownloadNone = result.ContractDocumentDownloadOption.search(/None/i) > -1;
                 $scope.isNewDocWithSectionsNeeded = result.CreateDocumentSectionsforDocxTemplates;
          });
      }

        remoteActions.getContractSectionsForVersion($scope.parentId).then(function(result) {
            $scope.versionLoadedData = result;
            console.log('INIT data: ', result);

            if ($scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateId__c']) {
                $scope.documentTemplateId = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateId__c'];
                // There is an attached template
                $scope.templateAttached = true;
                var cvTemplateType = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateFormatType__c'];
                if (cvTemplateType === 'Vlocity Web Template') {
                    // Web template
                    if ($scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'IsTemplateBatchable__c']) {
                        // Template is batchable
                        $scope.isBatchableTemplate = true;
                        $scope.batchJobId = $scope.versionLoadedData.batchJobId;
                        $scope.batchJobStatus = $scope.versionLoadedData.batchJobStatus;
                        if ($scope.batchJobStatus === 'Finished') {
                            $scope.documentSectionSize = $scope.versionLoadedData.documentSectionSize;
                            $scope.documentTemplateResource = $scope.versionLoadedData.documentTemplateResource;
                            $scope.documentMetadata = $scope.versionLoadedData.documentMetadata;
                            $scope.contentVersionMap = result.contentVersionMap;
                        }
                        $scope.showBatchableTemplate = true;
                        $scope.showWebTemplate = false;
                    } else {
                        // Template is not batchable
                        $scope.showWebTemplate = true;
                        $scope.showBatchableTemplate = false;

                        console.log('### getGeneratedContentVersionDetailsCompleted one');
                        $scope.$on('getGeneratedContentVersionDetailsCompleted', function () {
                            console.log('### getGeneratedContentVersionDetailsCompleted one');
                            if ($scope.generatedContentVersion.Id) {
                                $scope.isDocxDownloadReady = true;
                                if (!$scope.generatedPDFContentVersion.Id && ($scope.isAttachmentTypePdf || $scope.showDownloadPdf)) {
                                    //override the pdfGeneration source using template level settings -- webTemplates.
                                    $scope.resolveDocumentGenerationMethods().then(function() {
                                        $scope.generatePDFDocument();
                                    }).catch(function (error) {
                                        console.error('### resolveDocumentGenerationMethods() error: ', error);
                                        reject(error);
                                    });
                                } else {
                                    $scope.isPdfDownloadReady = true;
                                }
                            } else {
                                $scope.generateDocumentsForWebTemplate().then(function () {
                                    $scope.isDocxDownloadReady = true;
                                    if (!$scope.generatedPDFContentVersion.Id && ($scope.isAttachmentTypePdf || $scope.showDownloadPdf)) {
                                        //override the pdfGeneration source using template level settings -- webTemplates.
                                        $scope.resolveDocumentGenerationMethods().then(function () {
                                            $scope.generatePDFDocument();
                                        }).catch(function (error) {
                                            console.error('### resolveDocumentGenerationMethods() error: ', error);
                                            reject(error);
                                        });
                                    } else {
                                        $scope.isPdfDownloadReady = true;
                                    }
                                });
                            }

                            // Instatiate ReconcileChanges Factory
                            $scope.reconcileChanges = new ReconcileChanges($scope);
                            if (window.location.search.indexOf('reconcile=true') > -1) {
                                $scope.tabs.activeTab = 'Reconcile Changes';
                                $scope.reconcileChanges.toggleView.label = $scope.labels.clmReconcileDocViewDoc;
                                $scope.reconcileChanges.toggleView.icon = 'icon-v-view';
                            } else {
                                $scope.tabs.activeTab = 'Document View';
                            }
                            $scope.showDocXTemplate = false;
                        });

                        // Template sections
                        $scope.versionData.sections = $scope.versionLoadedData.documentSectionObjs;
                        // Check if ContentVersion is associated with template
                        if (result.contentVersionMap && result.contentVersionMap.contentVersionId) {
                            $scope.getGeneratedContentVersionDetails(result.contentVersionMap);
                        } else {
                            console.log('### getGeneratedContentVersionDetailsCompleted emit');
                            $scope.$emit('getGeneratedContentVersionDetailsCompleted');
                        }
                    }
                    
                } else if (cvTemplateType === 'Microsoft Word .DOCX Template' && $scope.isReconcileDoc === 'false') {
                    // DocX template
                    $scope.showDocXTemplate = true;
                    $scope.showDocumentView = true;
                    $scope.showWebTemplate = false;
                    $scope.showBatchableTemplate = false;
                    $scope.vlcLoading = false;
                    // Document sections
                    let isSectionInfoStoredOnDoc = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'IsSectionInfoStoredOnDoc__c'];
                    let versionHasSections = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'SectionCount__c'];
                    //Check if Both Contract Type setting is true and the version doesnot have sections.
                    $scope.isNewDocWithSectionsNeeded = $scope.isNewDocWithSectionsNeeded && !isSectionInfoStoredOnDoc && versionHasSections ? true : false;
                    if ($scope.versionLoadedData.documentSectionObjs.length >0) {
                        $scope.documentSectionData = $scope.normalizeSectionData($scope.versionLoadedData.documentSectionObjs);
                        if ($scope.documentSectionData && $scope.documentSectionData.length > 0) {
                            for (var i in $scope.documentSectionData) {
                                if($scope.documentSectionData[i][$scope.nameSpacePrefix + 'SectionContent__c'])
                                    $scope.docxSectionList += $scope.documentSectionData[i][$scope.nameSpacePrefix + 'SectionContent__c'];
                            }
                        }
                    }

                    $scope.$on('getGeneratedContentVersionDetailsCompleted', function () {
                        console.log('### getGeneratedContentVersionDetailsCompleted 2')

                        if ($scope.generatedContentVersion.Id) {
                            console.log('## if')
                            $scope.isDocxDownloadReady = true;
                            if (!$scope.generatedPDFContentVersion.Id && $scope.autoAttachDoc == "false") {
                                onsole.log('## generate pdf')
                                $scope.generatePDFDocument();
                            } else {
                                console.log('## isPdfDownloadReady true')
                                $scope.isPdfDownloadReady = true;
                                $scope.$apply();
                            }
                        } else {
                            console.log('## else')
                            $scope.generateContractDocumentDocXTemplate($scope.versionLoadedData.documentObj.Id, $scope.documentTemplateId);
                        }
                        // Instatiate ReconcileChanges Factory
                        $scope.reconcileChanges = new ReconcileChanges($scope);
                        if (window.location.search.indexOf('reconcile=true') > -1) {
                            $scope.isReconciledView = true;
                            $scope.showReconcileView = true;
                            $scope.showViewTrackSections = false;
                            $scope.showDocumentView = false;
                        } 
                    });

                    // Check if ContentVersion is associated with template
                    if (result.contentVersionMap && result.contentVersionMap.contentVersionId) {
                        $scope.getGeneratedContentVersionDetails(result.contentVersionMap);
                        $scope.generatedContentCheckedIn = result.contentVersionMap.contentCheckedIn || result.contentVersionMap.contentPDFCheckedIn;
                    } else {
                        $scope.$emit('getGeneratedContentVersionDetailsCompleted');
                    }

                } 
                //On docx reconcilation, generate pdf document, if documentAttachmentType = 'pdf'.
                else if (cvTemplateType === 'Microsoft Word .DOCX Template' && $scope.isReconcileDoc === 'true') {
                    if ($scope.isAttachmentTypePdf || $scope.showDownloadPdf) {
                            $scope.generatedContentVersion = {
                                'Id': result.contentVersionMap && result.contentVersionMap.contentVersionId,
                                'Title': result.contentVersionMap && result.contentVersionMap.contentDocumentTitle,
                            };
                            $scope.contractDocumentCollectionId = result.contentVersionMap.contractDocumentCollectionId;
                            $scope.generatePDFDocument().then(function (result) {
                                var checkinMap = {
                                    'contractVersionId': $scope.parentId,
                                    'contentVersionId': $scope.generatedPDFContentVersion.Id,
                                    'contractDocumentCollectionId': $scope.generatedPDFContentVersion.collectionId,
                                }
                                if ($scope.isAttachmentTypePdf) {
                                    remoteActions.checkInContentVersionForContractVersion(checkinMap).then(function () {
                                        $scope.dispatchEvent('ContractDocumentAttachDone');
                                    });
                                } else {
                                    console.log('pdf document attachment is not needed');
                                     $scope.dispatchEvent('ContractDocumentAttachDone');
                                }
                            });
                    } else {
                        console.log('pdf document generation is not needed');
                        $scope.dispatchEvent('ContractDocumentAttachDone');
                    }
                }
            } else {
                // There is no attached template
                $scope.templateAttached = false;
                $scope.showWebTemplate = false;
                $scope.showBatchableTemplate = false;
                $scope.showDocXTemplate = false;
                $scope.contractTemplates.push($scope.initialTemplateOption);
            }

            if ($scope.versionLoadedData.documentVersionObj) {
                $scope.contractVersionId = $scope.versionLoadedData.documentVersionObj.Id;
            }

            // Check if reconciled view
            if (window.location.search.indexOf('preview=true') > -1 &&
                $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentCreationSource__c'] === 'Reconcile Word') {
                $scope.isReconciledView = true;
            }
            //Auto Attach DoX Template
            if($scope.autoAttachDoc == "true" && $scope.documentTemplateId != null){
                if($scope.documentTemplateId != null){
                    remoteActions.getDocumentType($scope.sourceId).then(function(result){
                        console.log('### document settings: ', result);
                        $scope.isNewDocWithSectionsNeeded = result.CreateDocumentSectionsforDocxTemplates;

                        remoteActions.getAutoAttachTemplateDetails($scope.documentTemplateId).then(function(result){
                            $scope.initiateAutoDocGeneration(result);
                          },function(error){
                            $scope.validationErrorHandler.throwError(error);
                          });
                    });
                }
            }

			if ( $scope.autoAttachDoc == "false" && $scope.documentAttachmentType.toUpperCase() == 'NONE' && $scope.preview == 'true' ) {
				$scope.generatedContentCheckedIn = true;	
			}
        }, function(error) {
            $scope.validationErrorHandler.throwError(error);
        }).then(function() {
            if($scope.autoAttachDoc == "false" && $scope.isReconcileDoc === 'false'){
                var selectedTemplateLabel, selectedTemplate, i, j, temporaryObj, temporaryVersion;
                remoteActions.getTemplateList($scope.parentId).then(function(result) {
                    var isTemplatePresentInList = false;
                    var attachedTemplateId = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateId__c'];
                    if (attachedTemplateId) {
                        var templateName = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateName__c'];
                        var templateVersion = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateVersion__c'];
                        var templateType = $scope.versionLoadedData.documentVersionObj[$scope.nameSpacePrefix + 'DocumentTemplateFormatType__c'];
                        selectedTemplateLabel = templateName + ' (version ' + templateVersion + ') ' + '[' + templateTypeCodeMap[templateType] + ']';
                        selectedTemplate = {
                            templateGroup: 'Attached Template',
                            templateId: attachedTemplateId,
                            templateVersion: templateVersion,
                            templateType: templateType,
                            templateName: templateName,
                            templateLabel: selectedTemplateLabel
                        };
                    }
                    $scope.versionData.template = selectedTemplate;
                    $scope.selectedTemplate = selectedTemplate;

                    if (result !== null) {
                        for (i = 0; i < result.length; i++) {
                            var templateType = result[i][$scope.nameSpacePrefix + 'TemplateContentFormat__c'];
                            temporaryVersion = result[i][$scope.nameSpacePrefix + 'VersionNumber__c'];
                            temporaryObj = {
                                templateName: result[i].Name,
                                templateLabel: result[i].Name + ' (version ' + temporaryVersion + ') [' + templateTypeCodeMap[templateType] + ']',
                                templateVersion: temporaryVersion,
                                templateId: result[i].Id,
                                templateType: templateType,
                                templateGroup: $scope.availableTemplatesLabel,
                                isBatchable: result[i][$scope.nameSpacePrefix + 'HasBatchableSections__c']
                            };
                            $scope.contractTemplates.push(temporaryObj);

                            if (result[i].Id === attachedTemplateId) {
                                selectedTemplate.templateType = result[i][$scope.nameSpacePrefix + 'TemplateContentFormat__c'];
                                selectedTemplate.isBatchable = result[i][$scope.nameSpacePrefix + 'HasBatchableSections__c'];
                            }
                        }
                    } else {
                        $scope.activeTemplates = false;
                    }

                    // Check which template to select and sections to show on page load:
                    if (attachedTemplateId) {
                        if (isTemplatePresentInList) {
                            for (j = 0; j < $scope.contractTemplates.length; j++) {
                                if ($scope.contractTemplates[j].templateId === attachedTemplateId) {
                                    isTemplatePresentInList = true;
                                    $scope.versionData.template = $scope.contractTemplates[j];
                                    $scope.selectedTemplate = $scope.contractTemplates[j];
                                    $scope.contractTemplates[j].templateGroup = 'Attached Template';
                                }
                            }
                        }
                    } else {
                        // If there is no template ID, then we just show the default "Select a Template" in the dropdown:
                        $scope.versionData.template = $scope.contractTemplates[0];
                        $scope.selectedTemplate = $scope.contractTemplates[0];
                        $scope.vlcLoading = false;
                    }
                    if (!isTemplatePresentInList && attachedTemplateId) {
                        $scope.contractTemplates.push(selectedTemplate);
                        $scope.selectedTemplate = selectedTemplate;
                    }
                    console.log('Template attached: ' + $scope.templateAttached);
                    console.log($scope.versionData.template);
                    console.log($scope.contractTemplates);
                    console.log('Selected Template: ', $scope.selectedTemplate);
                    $scope.vlcLoading = false;
                    if($scope.showWebTemplate) {
                        $scope.vlcLoading = false;

                    }
                }, function(error) {
                    $scope.validationErrorHandler.throwError(error);
                });
            }
        }).then(function() {
            console.log('### ', $scope.isBatchableTemplate);
            console.log('### ', $scope.batchJobStatus);

            if ($scope.isBatchableTemplate && $scope.batchJobStatus !== undefined && $scope.batchJobStatus === 'Finished') {

                $scope.$on('getGeneratedContentVersionDetailsCompleted', function () {
                    console.log('### getGeneratedContentVersionDetailsCompleted one');
                    var isPdfGenerationNeeded = $scope.isAttachmentTypePdf || $scope.showDownloadPdf;

                    if ($scope.generatedContentVersion && $scope.generatedContentVersion.Id) {
                        console.log("### skipping document generation");
                        $scope.isDocxDownloadReady = true;
                        if (isPdfGenerationNeeded && !($scope.generatedPDFContentVersion && $scope.generatedPDFContentVersion.Id)) {
                            console.log("### pdf generation not required");
    
                            //override the pdfGeneration source using template level settings -- webTemplates.
                            $scope.resolveDocumentGenerationMethods().then(function() {
                                $scope.generatePDFDocument();
                            }).catch(function (error) {
                                console.error('### resolveDocumentGenerationMethods() error: ', error);
                                reject(error);
                            });
                        } else {
                            console.log("### skipping pdf generation");
                            $scope.isBatchCheckinReady = true;
                            $scope.isPdfDownloadReady = true;
                        }
        
                    }  else {
                        $scope.vlcLoading = true;
                        //unlink if there is a pdf attached
                        if ($scope.generatedPDFContentVersion && $scope.generatedPDFContentVersion.Id) {
                            console.log("### unlinking pdf")
                            $scope.unlinkContentVersionFromContractVersion($scope.contractVersionId, $scope.generatedPDFContentVersion.Id, $scope.generatedPDFContentVersion.collectionId, false);
                        }
                
                        $scope.generateFileForBatchableTemplate().then(function(wordContents, event) {
                            console.log('done generating docx');
        
                            // save docx to memory
                            $scope.generatedContentVersion = {
                                'Title': $scope.docName,
                                'VersionData': wordContents
                            }
                            if ($scope.documentAttachmentType === 'Word') {
                                $scope.isBatchCheckinReady = true;
                            }
                            $scope.isDocxDownloadReady = true;
                            $scope.vlcLoading = false;
                            return ($scope.generatedContentVersion);
        
                        }).then(function(contentVersion) {
                            console.log("### saving docx as contentVersion");
                            return new Promise(function(resolve, reject) {
                                $scope.saveContent(contentVersion.Title + '.docx', contentVersion.VersionData).then(function(savedContentVersion) {
                                    $scope.generatedContentVersion.Id = savedContentVersion.Id;
                                    $scope.linkContentVersionToContractVersion(savedContentVersion.Id, 'Docx', null).then(function() {
                                        resolve();
                                    });
                                });
                            })
                        }).then(function() {
        
                            if ($scope.isAttachmentTypePdf || $scope.showDownloadPdf) {
                                //override the pdfGeneration source using template level settings -- webTemplates.
                                $scope.resolveDocumentGenerationMethods().then(function() {
                                    console.log('$scope.pdfGenerationSource:', $scope.pdfGenerationSource);
                                    $scope.generatePDFDocument();
                                }).catch(function (error) {
                                    console.error('### resolveDocumentGenerationMethods() error: ', error);
                                    reject(error);
                                });
                            }
                            else {
                                console.log("### pdf generation not required");
                                $scope.isBatchCheckinReady = true;
                            }
                        }).finally(function() {
                            console.log('completed processing batchable template...');
                        });
                    }
                });
                // Check if ContentVersion is associated with template
                if ($scope.contentVersionMap && $scope.contentVersionMap.contentVersionId) {
                    $scope.getGeneratedContentVersionDetails($scope.contentVersionMap);
                } else {
                    console.log('### getGeneratedContentVersionDetailsCompleted emit');
                    $scope.$emit('getGeneratedContentVersionDetailsCompleted');
                }  
     
            }
        });
    };

    $scope.initiateAutoDocGeneration = function(result){
         var templateDetails = result.templateDetails;
         var templateType = templateDetails[0][$scope.nameSpacePrefix + 'TemplateContentFormat__c'];
         var temporaryVersion = templateDetails[0][$scope.nameSpacePrefix + 'VersionNumber__c'];
         var selectedTemplate = {
                                 templateName: templateDetails[0].Name,
                                 templateLabel: templateDetails[0].Name + ' (version ' + temporaryVersion + ') [' + templateTypeCodeMap[templateType] + ']',
                                 templateVersion: temporaryVersion,
                                 templateId: templateDetails[0].Id,
                                 templateType: templateType,
                                 templateGroup: $scope.availableTemplatesLabel,
                                 isBatchable: templateDetails[0][$scope.nameSpacePrefix + 'HasBatchableSections__c']
                             };
         $scope.selectedTemplate = selectedTemplate;
         $scope.versionData.template = $scope.selectedTemplate;
         $scope.isAutoAttachTypePDF = $scope.docTypeOptions.has($scope.autoAttachDocType.toLowerCase());
         $scope.isAttachmentTypePdf =  $scope.isAutoAttachTypePDF;
         //Assign the autoAttachDocType to documentAttachmentType for checkin
         $scope.documentAttachmentType = $scope.autoAttachDocType;
         // Method to attach a docx template and generate Word/PDF Document
         $scope.changeDocumentTemplate($scope.selectedTemplate);

         //CheckIn Logic
         //Triggered once the DOCX content version is linked to Document Collection
         $scope.$on('linkContentVersionfForDOCXComplete', function () {
            $scope.isNewDocWithSectionsNeeded = false;
            if($scope.isAutoAttachTypePDF){
               //Triggered Only when the PDF is generated and Linked to Document Collection
                $scope.$on('generatePDFDocumentComplete', function () {
                     console.log('### PDFGeneration Completed event triggered');
                     $scope.checkInContentVersionForContractVersion($scope.contractVersionId, $scope.generatedContentVersion.Id, $scope.contractDocumentCollectionId);
                });
            }else{
                console.log('### Document Genration Completed event triggered');
                $scope.checkInContentVersionForContractVersion($scope.contractVersionId, $scope.generatedContentVersion.Id, $scope.contractDocumentCollectionId);
             }
         });
    }

    $scope.normalizeSectionData= function (sectionData){
        var filteredSectionContent = sectionData.map(item => {
                                        const container = {};
                                        var sectionId = $scope.nameSpacePrefix+'DocumentTemplateSectionId__c';
                                        var sectionContent = $scope.nameSpacePrefix + 'SectionContent__c'
                                        container[sectionId] = item[sectionId];
                                        container['Id'] = item['Id'];
                                        container[sectionContent] = item[sectionContent];
                                       return container;
                                    });
        return filteredSectionContent;
    }

    this.$onInit = function() {
        // Set resource path in coreControls
    if (($scope.pdfGenerationSource && $scope.pdfGenerationSource.toLowerCase() == $scope.VlocityClientSide) || $scope.pdfViewer.match(/VlocityClientsideViewer/i)) {
        pdfTronSetResourcePath(remoteActions, $scope.clientSidePdfGenerationConfig).then(function(result){
              if( $scope.labels.VlocityPDFTronNoSystemUserMsg === result){
                  $scope.validationErrorHandler.throwError($scope.labels.VlocityPDFTronNoSystemUserMsg);
              }
              else{
                $scope.clientSidePdfGenerationConfig = result.clientSidePdfGenerationConfig;
                $scope.pdfIntegrationConfig= JSON.parse(result.license);
                $scope.workerTransport = result.workerTransport;
              }
              $scope.initContractVersion();
          });
      }
       else {
        $scope.initContractVersion();
       } 
    };

    $scope.dispatchEvent = function(eventName) {
        var event = new CustomEvent(eventName, {
            detail: true
        });
        window.parent.dispatchEvent(event);
        window.close();
    }

    $scope.trustAsHtml = function (string) {
        return $sce.trustAsHtml(string);
    };
    // Check to see if we should allow Template selection
    $scope.showTemplateSelection = function() {
        if (window.location.search.indexOf('preview=true') > -1) {
            return false;
        }
        return true;
    };

    $scope.getGeneratedContentVersionDetails = function (contentDetails) {
        console.log('### getGeneratedContentVersionDetails');
        var promise = new Promise(function(resolve, reject) {
            if (!contentDetails.contractDocumentVersionData) {
                console.log('### sforce');
                sforce.connection.sessionId = window.sessionId;
                var queryString = 'Select Id, Title, VersionData FROM ContentVersion where Id = \'' + contentDetails.contentVersionId + '\'';
                sforce.connection.query(queryString, {
                    onSuccess: function(result) {
                        contentDetails.contractDocumentVersionData = result.records.VersionData;
                        resolve();
                    },
                    onFailure: function(result) {
                        var errorMsg = result.faultstring;
                        reject(errorMsg);
                    }
                });
            } else {
                console.log('### resolve');
                resolve();
            }
        })

        promise.then(function() {
            $scope.generatedContentVersion = {
                'Id': contentDetails.contentVersionId,
                'Title': contentDetails.contentDocumentTitle,
                'VersionData': contentDetails.contractDocumentVersionData
            };
            $scope.isWordCheckinReady = true;
            $scope.contractDocumentCollectionId = contentDetails.contractDocumentCollectionId;
            if (contentDetails && contentDetails.generatedPDFContentVersionId) {
                console.log('### pdf contentVersion already available')
                $scope.generatedPDFContentVersion = {
                    'Id': contentDetails.generatedPDFContentVersionId,
                    'collectionId': contentDetails.contractPDFDocumentCollectionId,
                    'contentPDFCheckedIn': contentDetails.contentPDFCheckedIn,
                    'Title': contentDetails.contentPDFDocumentTitle,
                    'parentDocumentId': contentDetails.parentDocumentId
                }
            }
            console.log('### $scope.generatedContentVersion', $scope.generatedContentVersion);
            console.log('### $scope.generatedPDFContentVersion', $scope.generatedPDFContentVersion);
            console.log('### emit');
            $scope.$emit('getGeneratedContentVersionDetailsCompleted');
        }).catch(function(error) {
            console.error(error);
        });
    }

    $scope.removeTemplate = function() {
        $scope.documentTemplateId = null;
        if ($scope.versionData.template.templateType === 'Vlocity Web Template') {
            $scope.removeContractSections();
        } else if ($scope.versionData.template.templateType === 'Microsoft Word .DOCX Template') {
            //Remove Contract Sections. 
            $scope.removeContractSections();
            //Remove Document Links and Content Versions
            /*$scope.unlinkContentVersionFromContractVersion($scope.contractVersionId, $scope.generatedContentVersion.Id, $scope.contractDocumentCollectionId, true);
            if($scope.generatedPDFContentVersion.Id) {
                $scope.unlinkContentVersionFromContractVersion($scope.contractVersionId, $scope.generatedPDFContentVersion.Id, $scope.generatedPDFContentVersion.collectionId, true);
            }*/
        }
    };

    $scope.changeDocumentTemplate = function(currentTemplate) {
        $scope.vlcLoading = true;
        if($scope.autoAttachDoc == "false"){
            remoteActions.getDocumentType($scope.sourceId).then(function(result){
                    $scope.documentAttachmentType =  result.ContractDocumentAttachOption;
                    $scope.isAttachmentTypePdf = $scope.documentAttachmentType.search(/PDF/i) > -1;
                    $scope.isAttachmentTypeWord = $scope.documentAttachmentType.search(/WORD/i) > -1;
                    $scope.showDownloadPdf = result.ContractDocumentDownloadOption.search(/PDF/i) > -1;
                    $scope.showDownloadWord = result.ContractDocumentDownloadOption.search(/WORD/i) > -1;
                    $scope.showDownloadNone = result.ContractDocumentDownloadOption.search(/None/i) > -1;
            });
        }

        $scope.documentTemplateId = currentTemplate.templateId;

        if (currentTemplate.templateType === 'Vlocity Web Template') {
            // changing to a Web template
            if (currentTemplate.isBatchable) {
                // template is batchable
                $scope.batchJobStatus = 'Not Started';
                $scope.showWebTemplate = false;
                $scope.showBatchableTemplate = true;
                $scope.vlcLoading = false;
            } else {
                // template is not batchable
                $scope.createContractSectionsforVersion(currentTemplate);
                $scope.showWebTemplate = true;
                $scope.showBatchableTemplate = false;
                $scope.templateAttached = true;
            }
            $scope.showDocXTemplate = false;
        } else if (currentTemplate.templateType === 'Microsoft Word .DOCX Template') {
            // changing to a DocX template
            $scope.showWebTemplate = false;
            $scope.showBatchableTemplate = false;
            $scope.showDocXTemplate = true;
            $scope.showDocumentView = true;
            $scope.templateAttached = true;
            $scope.isPdfDownloadReady = false;
            $scope.generateContractDocumentDocXTemplate($scope.versionLoadedData.documentObj.Id, currentTemplate.templateId);
        }

        $scope.templateType = currentTemplate.templateType;
        $scope.versionData.template = currentTemplate;
        $scope.$on('generatePDFDocumentComplete', function () {
            console.log('### PDFGeneration Completed event triggered');
        });
    };

    // Generate a Contract Document based on a DocX Template
    $scope.generateContractDocumentDocXTemplate = function(contextId, templateId) {
        // (1): get the token data from the document template
        $scope.getDocXTokenData(contextId, templateId).then(function() {
            // (2): get the attached document template file content
            $scope.getTemplateFileContent($scope.templateContentVersionId).then(function() {
                // (3): generate a new contract document based on the template file content and the token data
                $scope.generateDocXFromTokenData($scope.templateContentVersion.VersionData, $scope.docXTokenData);
            }, function(error) {
                console.error('error: ', error);
                $scope.vlcLoading = false;
            });
        }, function(error) {
            console.error('error: ', error);
            $scope.vlcLoading = false;
        });
    };


    $scope.generatePDFDocument = function () {
        return new Promise(function(resolve, reject) {
            let pdfGenerationMethod = $scope.getResolvedPdfGenerationMethod();
            pdfGenerationMethod()
                .then(function(response) {
                    console.log('### response: ', response);
                    $scope.generatedPDFContentVersion = {
                        'Id': response['Id'],               //Id is the only property of response if PdfGenerationSource == Salesforce
                        'Title': response['Title'],
                        'VersionData': response['VersionData']
                    };
                return $scope.linkContentVersionToContractVersion($scope.generatedPDFContentVersion.Id,'PDF',$scope.contractDocumentCollectionId);
            })
            .then(function() {
                console.log('### setting flags');
                $scope.setFlags();
                resolve();
            })
            .catch(function(error) {
                console.log('### error: ', error);
                $scope.validationErrorHandler.throwError(error);
                reject(error);
            })
            .finally(function() {
                $scope.vlcLoading = false;
                $scope.$apply();
            });
        });
    }

    $scope.setFlags = function () {
        if ($scope.templateType === 'Vlocity Web Template' && !$scope.isBatchableTemplate) {
            $scope.showDocXTemplate = false;
            $scope.showWebTemplate = true;
            $scope.showBatchableTemplate = false;
        } else if($scope.templateType === 'Vlocity Web Template' && $scope.isBatchableTemplate) {
            $scope.showDocXTemplate = false;
            $scope.showWebTemplate = false;
            $scope.showBatchableTemplate = true;
            $scope.isBatchCheckinReady = true;
        } else {
            $scope.showDocXTemplate = true;
            $scope.showWebTemplate = false;
            $scope.showBatchableTemplate = false;
        }
        $scope.vlcLoading = false;
        $scope.isPdfDownloadReady = true;
    }

    $scope.invokeBatchJob = function() {
        $scope.vlcLoading = true;
        var inputData = {
            'contractId': $scope.versionLoadedData.documentObj.Id,
            'templateId': $scope.versionData.template.templateId
        };
        remoteActions.invokeBatchJob(inputData).then(function(result) {
            $scope.batchJobId = result;
            $scope.batchJobStatus = 'Running';
            $scope.templateAttached = true;
            $scope.vlcLoading = false;
        }, function(error) {
            $scope.vlcLoading = false;
        });
    };

    // Assign sections of the selected template into a scope variable to loop through and create table
    $scope.createContractSectionsforVersion = function(currentTemplate) {
        var i, temporaryContentAttached, htmlTagRegexAttached, temporaryObjAttached, noTemplateError;
        $scope.vlcLoading = true;
        // warning message shows if sections length is 0, so we add a dummy index:
        $scope.versionData.sections = ['dataOnLoad'];
        // Load the data from the cached $scope.versionLoadedData if we are showing the attached template
        // because this data reflects any edits made to the sections and not the stored section data in
        // the template:
        if (currentTemplate.templateGroup === 'Attached Template') {
            htmlTagRegexAttached = /(<([^>]+)>)/ig;
            for (i = 0; i < $scope.versionLoadedData.documentSectionObjs.length; i++) {
                temporaryContentAttached = $scope.versionLoadedData.documentSectionObjs[i][$scope.nameSpacePrefix + 'SectionContent__c'];
                if (temporaryContentAttached) {
                    temporaryContentAttached = temporaryContentAttached.replace(htmlTagRegexAttached, '');
                }
                temporaryObjAttached = {
                    sectionName: $scope.versionLoadedData.documentSectionObjs[i].Name,
                    sectionType: $scope.versionLoadedData.documentSectionObjs[i][$scope.nameSpacePrefix + 'Type__c'],
                    sectionContent: temporaryContentAttached
                };
                $scope.versionData.sections.push(temporaryObjAttached);
                if ($scope.showSuccessMessage) {
                    $scope.validationMessage.type = 'alert-success';
                    $scope.validationMessage.content = 'Successfully Attached Template to Contract Version.';
                    $scope.showSuccessMessage = false;
                }
            }
            $scope.vlcLoading = false;
        } else if (currentTemplate.templateLabel === $scope.initialTemplateOption.templateLabel) {
            $scope.vlcLoading = false;
        } else {
            remoteActions.createContractSectionsforVersion(currentTemplate.templateId, $scope.parentId).then(function(result) {
                $scope.processSectionContent(result);
                $scope.vlcLoading = false;
                noTemplateError = true;
            }, function(error) {
                noTemplateError = false;
                $scope.vlcLoading = false;
                $scope.validationErrorHandler.throwError(error);
            }).then(function() {
                if (noTemplateError) {
                    // Only call if there were no errors in the previous promise:
                    $scope.saveNewDocumentSections();
                }
            });
        }
    };

    //Method to create Document Sections for DocxTemplates
    $scope.createDocxContractSections = function(fileContentData){
        return new Promise(function (resolve, reject){
            let inputMap = {
                fileContentData: fileContentData,
                contractId: $scope.sourceId,
                versionId:$scope.parentId
            }
            generateDocxContractSections(remoteActions, inputMap)
            .then(function(result){
                if (result === 'DocHasNoSections' || result.length === 0) {
                    $scope.isWordCheckinReady = true;
                    $scope.isNewDocWithSectionsNeeded = false;
                }
                else{
                    $scope.documentSectionData = result;
                    $scope.isWordCheckinReady = true;
                    if ($scope.documentSectionData && $scope.documentSectionData.length > 0) {
                        for (var i in $scope.documentSectionData) {
                            if($scope.documentSectionData[i][$scope.nameSpacePrefix + 'SectionContent__c'])
                                $scope.docxSectionList += $scope.documentSectionData[i][$scope.nameSpacePrefix + 'SectionContent__c'];
                        }
                    }
                    console.log('###isWordCheckinReady###',$scope.isWordCheckinReady);
                }
                resolve();
            })
            .catch(function(error){
                console.log('createDocxContractSections error');
                reject(error);
            });
        });
    };


    //Method to create Document Sections for DocxTemplates
    $scope.createAutoDocxContractSections = function(fileContentData){
        return new Promise(function (resolve, reject){
            let inputMap = {
                fileContentData: fileContentData,
                contractId: $scope.sourceId,
                versionId:$scope.parentId
            }
            generateDocxContractSections(remoteActions, inputMap)
            .then(function(result){
                if (result === 'DocHasNoSections' || result.length === 0) {
                    $scope.isNewDocWithSectionsNeeded = false;
                    return resolve({'fileContent': fileContentData});
                }
                $scope.documentSectionData = result;
                if ($scope.documentSectionData && $scope.documentSectionData.length > 0) {
                    for (var i in $scope.documentSectionData) {
                        if($scope.documentSectionData[i][$scope.nameSpacePrefix + 'SectionContent__c'])
                            $scope.docxSectionList += $scope.documentSectionData[i][$scope.nameSpacePrefix + 'SectionContent__c'];
                    }
                }
                if(fileContentData !== undefined){
                    inputMap.docName = $scope.docName + '.docx';
                    inputMap.ns = $scope.nameSpacePrefix;
                    inputMap.documentSectionData = $scope.documentSectionData;

                    //Add SectionId to the Document
                    addSectionIdtoWordDoc(fileContentData, inputMap)
                    .then(function(result){
                        console.log('####SectionId Added to the Doc::' );
                        $scope.isWordCheckinReady = true;
                        resolve(result);
                    })
                    .catch(function (error) {
                        console.log('### generateDocxFromWebTemplate() error: ', error);
                        reject(error);
                    });
                }
                else {
                    reject('No ConversionData Found');
                }
            });
        });
    };

    $scope.processSectionContent = function (result){
        var i, temporaryObj, temporaryContent;
        var htmlTagRegex = /(<([^>]+)>)/ig;
        $scope.originalSections = result;
        console.log($scope.originalSections);
        console.log($scope.versionData);
        for (i = 0; i < result.documentSectionObjs.length; i++) {
            temporaryContent = result.documentSectionObjs[i][$scope.nameSpacePrefix + 'SectionContent__c'];
            if (temporaryContent) {
                temporaryContent = temporaryContent.replace(htmlTagRegex, '');
            }
            temporaryObj = {
                sectionName: result.documentSectionObjs[i].Name,
                sectionType: result.documentSectionObjs[i][$scope.nameSpacePrefix + 'Type__c'],
                sectionContent: temporaryContent
            };
            $scope.versionData.sections.push(temporaryObj);
        }
    };

    // Attach template sections to contract version
    $scope.getSectionContentData = function(fileContentData) {
        var zip = new JSZip(fileContentData, {base64: true});
        var docXmlContent = zip.files["word/document.xml"].asText();
        var Docxml = $.parseXML(docXmlContent);
        var wordParagraph = $(Docxml).find('w\\:p');
    };
    

    // Attach template sections to contract version
    $scope.saveNewDocumentSections = function() {
        $scope.validationMessage.content = '';
        $scope.validationMessage.error = false;
        $scope.vlcLoading = true;
        if ($scope.templateAttached) {
            console.log($scope.contractTemplates);
            remoteActions.saveNewDocumentSections($scope.originalSections).then(function() {
                    $scope.generateDocumentsForWebTemplate().then(function () {
                        window.location.reload();
                    })
            }, function(error) {
                $scope.vlcLoading = false;
                $scope.validationErrorHandler.throwError(error);
            });
        }
    };

    $scope.generateDocumentsForWebTemplate = function () {
        //$scope.vlcLoading = true;
        return new Promise(function (resolve, reject) {
        $scope.generateDocxFromWebTemplate($scope.parentId).then(function (response) {
            $scope.saveContent($scope.docName + '.docx', response).then(function (response) {
                $scope.generatedContentVersion = {
                    'Id': response['Id'],
                    'Title': response['Title'],
                    'VersionData': response['VersionData']
                };
                $scope.linkContentVersionToContractVersion(response['Id'], 'Docx', null).then(function () {
                    resolve();
                });
            });
        }).catch(function (error) {
            console.log('### generateDocxFromWebTemplate() error: ', error);
            reject(error);
        });
    });
    }

    // Remove template and sections from version
    $scope.removeContractSections = function() {
        $scope.vlcLoading = true;
        if ($scope.generatedContentVersion && $scope.generatedContentVersion.Id) {
            console.log("### unlinking docx")
            $scope.unlinkContentVersionFromContractVersion($scope.contractVersionId, $scope.generatedContentVersion.Id, $scope.contractDocumentCollectionId, false);
        }
        if ($scope.generatedPDFContentVersion && $scope.generatedPDFContentVersion.Id) {
            console.log("### unlinking pdf")
            $scope.unlinkContentVersionFromContractVersion($scope.contractVersionId, $scope.generatedPDFContentVersion.Id, $scope.generatedPDFContentVersion.collectionId, false);
        }

       console.log('### removeContractSections() start');
       $scope.removeContractSectionsByBatch($scope.parentId).then(function() {
                console.log('### removeContractSections() end');
               // $scope.vlcLoading = false;
                window.location.reload();
            }, function(error) {
                console.error('error: ', error);
                $scope.vlcLoading = false;
            }
        );
    };

    /**
     * 
     */
    $scope.removeContractSectionsByBatch = function(parentId) {
        var deferred = $q.defer();

        $scope.vlcLoading = true;
        $scope.deleteContractSections(parentId);
        $scope.$on('removeContractSectionsByBatchComplete', function () {
            console.log('### removeContractSectionsByBatchComplete event triggered');
            deferred.resolve(true);
        });

        return deferred.promise;
    };

     /**
     * 
     */
    $scope.deleteContractSections = function(parentId) {
        var inputData = {
            'limit': $scope.recordDeletionLimit
        };

        remoteActions.removeContractSectionsByBatch(parentId, inputData).then(function(result) {
            if (result.hasMoreContractSections) {
                // there is more contract sections to delete
                $scope.deleteContractSections(parentId);
            } else {
                // all contract sections deleted
                console.log('### removeContractSectionsByBatch() complete');
                $scope.$emit('removeContractSectionsByBatchComplete');
            }
        }, function(error) {
            console.error('error: ', error);
            $scope.vlcLoading = false;
            $scope.validationErrorHandler.throwError(error);
        });
    };

    $scope.getDocXTokenData = function(contextId, templateId) {
        var deferred = $q.defer();

        $scope.vlcLoading = true;

        $scope.docXTokenData = {};

        $scope.getTokenData(contextId, templateId);

        $scope.$on('tokenDataFetchComplete', function () {
            // all token data has been retrieved; resolve the promise
            deferred.resolve(true);
        });

        return deferred.promise;
    };

    $scope.getTokenData = function(contextId, templateId, tokenDataQueryInfo) {
        var inputData = {
            'contextId': contextId,
            'templateId': templateId
        };
        if (tokenDataQueryInfo !== undefined) {
            inputData['tokenDataQueryInfo'] = JSON.stringify(tokenDataQueryInfo);
        }
        remoteActions.getTokenData(inputData).then(function(result) {
            if (tokenDataQueryInfo === undefined) {
                $scope.templateContentVersionId = result.contentVersionId;
            }

            // merge the existing token data with the incoming token data
            if(result.tokenMap) { 
                $scope.docXTokenData = deepmerge($scope.docXTokenData, result.tokenMap);
            }

            if (result.hasMoreTokenData) {
                // there is more token data that needs to be retreived
                $scope.getTokenData(contextId, templateId, result.tokenDataQueryInfo);
            } else {
                // all token data has been retrieved
                $scope.$emit('tokenDataFetchComplete');
            }
        }, function(error) {
            console.error('error: ', error);
            $scope.vlcLoading = false;
            $scope.validationErrorHandler.throwError(error);
        });
    };

    $scope.getTemplateFileContent = function(contentVersionId) {
        var deferred = $q.defer();

        sforce.connection.sessionId = window.sessionId;
        var queryString = 'Select Id, Title, VersionData FROM ContentVersion where Id = \'' + contentVersionId + '\'';
        sforce.connection.query(queryString, {
            onSuccess: function(result) {
                $scope.templateContentVersion = {
                    'Id': result.records.Id,
                    'Title': result.records.Title,
                    'VersionData': base64ToArrayBuffer(result.records.VersionData),
                    'Base64VersionData': result.records.VersionData
                }
                deferred.resolve(true);
            },
            onFailure: function(result) {
                var errorMsg = result.faultstring;
                deferred.reject(errorMsg);
            }
        });

        return deferred.promise;
    };

    /**
     * 
     */
    $scope.generateDocXFromTokenData = function(fileContentData, docXTokenData) {
        return new Promise(function(resolve, reject) {
            $scope.resolveDocumentGenerationMethods()
                .then(function() {
                    $scope.generateDocViaClientSide(fileContentData, docXTokenData)
                        .then(function(data) {
                            if($scope.autoAttachDoc != "true" && $scope.isNewDocWithSectionsNeeded){
                                $scope.isWordCheckinReady = false;
                                return $scope.createDocxContractSections(data.fileContent)
                                .then(function(){
                                    return $scope.saveGeneratedDocXFile(data.fileName, data.fileContent);
                                });
                            }
                            else if($scope.autoAttachDoc == "true" && $scope.isNewDocWithSectionsNeeded){
                                return $scope.createAutoDocxContractSections(data.fileContent)
                                .then(function(result){
                                    $scope.isWordCheckinReady = true;
                                    return $scope.saveGeneratedDocXFile(data.fileName, result.fileContent);
                                });
                            }
                            else{
                                $scope.isWordCheckinReady = true;
                                return $scope.saveGeneratedDocXFile(data.fileName, data.fileContent);
                            }
                        }).then(function(generatedContentVersionId) {
                            return $scope.linkContentVersionToContractVersion(generatedContentVersionId,'Docx',null);
                        }).then(function() {
                            resolve();
                        }).catch(function(error) {
                            console.error('error: ', error);
                            $scope.vlcLoading = false;
                            reject(error);
                        });
                })
                .catch(function(error) {
                    console.error('### generateDocXFromTokenData() error: ', error);
                    reject(error);
                });
        });
    }

    $scope.generateDocViaClientSide = function(fileContentData, docXTokenData) {
        var deferred = $q.defer();

        var zip = new JSZip(fileContentData);
        var doc = new Docxtemplater();
        doc.setOptions({
            delimiters: {
                start: '{{',
                end: '}}'
            },
            nullGetter: function(part) {
                if (!part.module) {
                    return "";
                }
                if (part.module === "rawxml") {
                    return "";
                }
                return "";
            }
        });
        doc.loadZip(zip);

        /* Update table of contents */

        //@TODO: Lots of workarounds or patchs done for updating table of contents; needs to be optimized before using
        var settings = zip.files["word/settings.xml"].asText();
        var settingsXMLDoc = $.parseXML(settings);

        var updateFieldsElement = '<w:updateFields></w:updateFields>';
        var $updateFieldsElement = $(updateFieldsElement).attr("w:val","true");
        $(settingsXMLDoc).children().append($updateFieldsElement);

        // https://github.com/open-xml-templating/docxtemplater/issues/240
        var settingsRaw = (new XMLSerializer()).serializeToString(settingsXMLDoc);
        settingsRaw = settingsRaw.replace(' xmlns="http://www.w3.org/1999/xhtml"', '');
        zip.file("word/settings.xml", settingsRaw);

        // https://blogs.msdn.microsoft.com/pfedev/2010/08/08/openxml-how-to-refresh-a-field-when-the-document-is-opened/
        var documentXML = zip.files["word/document.xml"].asText();
        // @Todo: Update only table of content fields. Code below updates all fields.
        documentXML = documentXML.replace(/<w:fldChar /g, '<w:fldChar w:dirty="true" ');
        zip.file("word/document.xml", documentXML);

        /* End of table of contents changes */

        // replace the tokens with real data in the document
        doc.setData(docXTokenData);

        try {
            // render the document
            doc.render();
        } catch (error) {
            var e = {
                message: error.message,
                name: error.name,
                stack: error.stack,
                properties: error.properties,
            };
            console.log(JSON.stringify({ error: e }));
            // The error thrown here contains additional information when logged with JSON.stringify (it contains a property object).
            throw error;
        }

        var outputFileName = $scope.docName + '.docx';
        var outputFileConfig = {
            'type': 'blob',
            'mimeType': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            'compression': 'DEFLATE',
            'compressionOptions': {
                'level': 9
            }
        };
        var outputContentBlob = doc.getZip().generate(outputFileConfig);

        var dataReader = new FileReader();
        dataReader.addEventListener('load', function() {
            var outputContentBase64 = dataReader.result;
            var base64Mark = 'base64,';
            var dataStart = outputContentBase64.indexOf(base64Mark) + base64Mark.length;
            outputContentBase64 = outputContentBase64.substring(dataStart);

            deferred.resolve({'fileName': outputFileName, 'fileContent': outputContentBase64});
        });
        dataReader.readAsDataURL(outputContentBlob);

        return deferred.promise;
    };

    /** 
     * 
     */
    $scope.saveContent = function(fileName, fileContent) {
        var deferred = $q.defer();

        var contentVersionSObj = new sforce.SObject('ContentVersion');
        contentVersionSObj.Title = fileName;
        contentVersionSObj.PathOnClient = fileName;
        contentVersionSObj.VersionData = fileContent;

        sforce.connection.sessionId = window.sessionId;
        sforce.connection.create([contentVersionSObj], {
            onSuccess: function(result) {
                //$scope.vlcLoading = false;
                var status = result[0].getBoolean('success');
                var generatedContentVersionId = result[0].id;
                console.log('generatedContentVersionId: ', generatedContentVersionId);
                var generatedContentVersion = {
                    'Id': generatedContentVersionId,
                    'Title': fileName,
                    'VersionData': fileContent
                }
                deferred.resolve(generatedContentVersion);
            },
            onFailure: function(result) {
                deferred.reject(result.faultstring);
            }
        });

        return deferred.promise;
    };

    $scope.saveGeneratedDocXFile = function(fileName, fileContent) {
        var deferred = $q.defer();

        var contentVersionSObj = new sforce.SObject('ContentVersion');
        contentVersionSObj.Title = fileName;
        contentVersionSObj.PathOnClient = fileName;
        contentVersionSObj.VersionData = fileContent;

        sforce.connection.sessionId = window.sessionId;
        sforce.connection.create([contentVersionSObj], {
            onSuccess: function(result) {
                $scope.vlcLoading = false;
                var status = result[0].getBoolean('success');
                var generatedContentVersionId = result[0].id;
                console.log('generatedContentVersionId: ', generatedContentVersionId);
                $scope.generatedContentVersion = {
                    'Id': generatedContentVersionId,
                    'Title': fileName,
                    'VersionData': fileContent
                }
                // Logic for PDFTron PDF Attachment on loads
                if($scope.autoAttachDoc == "false" && $scope.pdfGenerationSource.toLowerCase() == $scope.VlocityClientSide){
                    $scope.generatePDFDocument().then(function(result){
                         $scope.$emit('generatePDFDocumentComplete');
                    });
                }
                else if($scope.autoAttachDoc == "true" && $scope.isAutoAttachTypePDF){
                     $scope.generatePDFDocument().then(function(result){
                         $scope.$emit('generatePDFDocumentComplete');
                    });
                }
                else if($scope.autoAttachDoc == "false") {
                    //checkPdfDownloadReady($scope.generatedContentVersion.Id);
                    $scope.generatePDFDocument().then(function(result){
                        $scope.$emit('generatePDFDocumentComplete');
                   });
                }
                deferred.resolve(generatedContentVersionId);
            },
            onFailure: function(result) {
                deferred.reject(result.faultstring);
            }
        });

        return deferred.promise;
    };

    $scope.linkContentVersionToContractVersion = function(contentVersionId,fileFormat,parentDocumentId) {
        var deferred = $q.defer();
        var inputData = {
            'contractVersionId': $scope.contractVersionId,
            'contentVersionId': contentVersionId,
            'templateId': $scope.versionData.template.templateId,
            'fileFormat':fileFormat,
            'parentDocumentId':parentDocumentId,
            'isAutoAttachFlow': $scope.autoAttachDoc,
            'isNewDocWithSectionsNeeded': $scope.isNewDocWithSectionsNeeded
        };
        remoteActions.linkContentVersionToContractVersionNew(inputData).then(function(result) {
            console.log('contractDocumentCollectionId:', result);
            // if the template is of type DocX, then reload the page
                 // window.location.reload();
                    var fileTitle = result.Title && result.Title.split('.');
                    var fileExtention = fileTitle && fileTitle[fileTitle.length -1];
                      if(fileFormat == 'Docx' || (fileFormat == null && fileExtention === 'docx')){
                            console.log("### Linking docx...")
                            $scope.generatedContentVersion = {
                                                        'Id': contentVersionId,
                                                        'Title': result.Title,
                                                        'contractDocumentCollectionId': result.docCollectionId,
                                                        'contentDocxCheckedIn':result.isCheckedIn,
                                                        'fileFormat': fileFormat,
                                                        'VersionData': $scope.generatedContentVersion.VersionData
                                                    };
                            console.log("### result.docCollectionId: " + result.docCollectionId);
                            $scope.contractDocumentCollectionId = result.docCollectionId;
                            $scope.$emit('linkContentVersionfForDOCXComplete');
                      }
                      else if(fileFormat == 'PDF'){
                            console.log("### Linking pdf...")
                            $scope.generatedPDFContentVersion = {
                                                        'Id': contentVersionId,
                                                        'Title': result.Title,
                                                        'collectionId':result.docCollectionId,
                                                        'contentPDFCheckedIn': result.isCheckedIn,
                                                        'fileFormat': fileFormat,
                                                        'parentDocumentId':parentDocumentId,
                                                        'VersionData': $scope.generatedPDFContentVersion.VersionData
                                                    }
                      }
                      $scope.generatedContentCheckedIn = $scope.generatedContentCheckedIn || result.isCheckedIn;
                 deferred.resolve();
        }, function(error) {
            $scope.vlcLoading = false;
        });
        return deferred.promise;

    };

    $scope.updateDocxContentVersionLink = function(inputMap, newContentVersionId) {
        var deferred = $q.defer();
        inputMap.newContentVersionId = newContentVersionId.Id;

        remoteActions.updateDocxContentVersionLink(inputMap).then(function(result) {
            if (result == true){
                 deferred.resolve(newContentVersionId);
            }
            else{
                var e = {
                            message: 'Update New Docx Content Failed.',
                            name: 'Update Failed',
                        };
                console.error(JSON.stringify({ error: e }));
                deferred.reject(error);
            }
        }, function(error) {
            $scope.vlcLoading = false;
            deferred.reject(error);
        });
        return deferred.promise;
    };


    $scope.unlinkContentVersionFromContractVersion = function(contractVersionId, contentVersionId, contractDocumentCollectionId, reload) {
        $scope.vlcLoading = true;
        var inputData = {
            'contractVersionId': contractVersionId,
            'contentVersionId': contentVersionId,
            'contractDocumentCollectionId': contractDocumentCollectionId
        };
        remoteActions.unlinkContentVersionFromContractVersion(inputData).then(function(result) {
            console.log('Unlink content version result:', result);

            var deleteMap = {
                'contractVersionId' : contractVersionId,
                'contentVersionId': contentVersionId
            };

            remoteActions.deleteNotRequiredDocs(deleteMap).then(function(result) {
                console.log('deleteNotRequiredDocs result:', result);
                if (reload) {
                    window.location.reload();
                }
            }, function(error) {
                $scope.vlcLoading = false;
            });

        }, function(error) {
            $scope.vlcLoading = false;
        });
    };

    $scope.customizeDocument = function() {
        $sldsModal({
            title: $scope.labels.clmContractCustomizeDoc,
            templateUrl: 'check-status-modal.tpl.html',
            html: true,
            scope: $scope,
            container: 'div.vlocity',
            placement: 'center'
        });
    };

    $scope.navigateBackAndCheckin = function() {
        if ($scope.templateAttached) {
            if ($scope.versionData.template.templateType === 'Vlocity Web Template' &&
                $scope.versionData.template.isBatchable &&
                $scope.batchJobStatus !== 'Finished') {
                // if it is a batchable web template and the batch job hasn't finished,
                // do not prompt the user to check-in
                $scope.navigateBack();
            } else {
                $sldsModal({
                    title: $scope.labels.clmContractDocCheckInDoc,
                    templateUrl: 'checkin-modal.tpl.html',
                    html: true,
                    scope: $scope,
                    container: 'div.vlocity',
                    placement: 'center',
                    prefixEvent: 'checkinModal'
                });
            }
        } else {
            $scope.navigateBack();
        }
    };

    $scope.navigateBackNoCheckin = function() {
        if($scope.versionData.template.templateType === 'Microsoft Word .DOCX Template' && $scope.isNewDocWithSectionsNeeded ){
            $scope.createNewDocWithSectionId($scope.contractVersionId, $scope.generatedContentVersion.Id,  $scope.contractDocumentCollectionId).then( function(newContentVersionId){
                $scope.isNewDocWithSectionsNeeded = false;
                $scope.navigateBack();
            });
        }else{
            $scope.navigateBack()
        }
    };

    $scope.navigateBack = function(){
     //navigate back to page that issue send
        if ($scope.isConsole) {
            //close the preview tab
            sforce.console.getEnclosingTabId(function(result) {
                var tabId = result.id;
                sforce.console.closeTab(tabId);
            });
            refreshCurrentPrimaryTab();
        } else {
            if (!$scope.isSforce) {
                window.top.location.href = $scope.baseRequestUrl + '/' + $scope.versionLoadedData.documentObj.Id;
                return false;
            } else if ($scope.isSforce) {
                if ( $scope.baseRequestUrl != '' ) {
                    $scope.baseRequestUrl = $scope.baseRequestUrl + '/s/detail';
                }
                sforce.one.navigateToURL($scope.baseRequestUrl + '/' + $scope.versionLoadedData.documentObj.Id);
            }
        }
    };

    $scope.checkInDocument = function() {
        $scope.vlcLoading = true;
        $scope.isCheckIn = true;
        if ($scope.versionData.template.templateType === 'Vlocity Web Template') {
            if ($scope.versionData.template.isBatchable) {
                // create an attachment and associate it with the contract version
                // document will be checked in after the attachment is created
                $scope.createAttachmentForBatchableTemplate();
            } else {
                // check in the document
                $scope.checkInDocForWebTemplate();

                // create an attachment and associate it with the contract version
                $scope.createAttachmentForWebTemplate();
            }
        } else if ($scope.versionData.template.templateType === 'Microsoft Word .DOCX Template') {
            // check in the document
            $scope.checkInContentVersionForContractVersion($scope.contractVersionId, $scope.generatedContentVersion.Id, $scope.contractDocumentCollectionId);

        }
    };

    $scope.checkInDocForWebTemplate = function(goBack) {
        remoteActions.checkIn($scope.parentId).then(function(result) {
            console.log('check in document complete', result);
            if (goBack) {
                $scope.navigateBack();
            }
        }, function(error) {
            $scope.validationErrorHandler.throwError(error);
        });
    };

    $scope.checkInContentVersionForContractVersion = function(contractVersionId, contentVersionId, contractDocumentCollectionId) {
        $scope.vlcLoading = true;
        if($scope.isNewDocWithSectionsNeeded ){
            $scope.createNewDocWithSectionId(contractVersionId, contentVersionId, contractDocumentCollectionId).then( function(newContentVersion){
                contentVersionId = newContentVersion.Id;
                $scope.isNewDocWithSectionsNeeded = false;
                $scope.initiateCheckin(contractVersionId, contentVersionId, contractDocumentCollectionId);
            });
        }
        else{
            $scope.initiateCheckin(contractVersionId, contentVersionId, contractDocumentCollectionId);
        }
    };

    $scope.initiateCheckin = function (contractVersionId, contentVersionId, contractDocumentCollectionId) {
        
        var inputData = {
            'contractVersionId': contractVersionId,
            'contentVersionId': contentVersionId,
            'contractDocumentCollectionId': contractDocumentCollectionId
            };
        // check value of ContractDocumentAttachOption, do not attach document collection if NONE
		if ( $scope.documentAttachmentType.toUpperCase() == 'NONE' ) {
			remoteActions.checkinWithoutAttachment($scope.sourceId).then(function(){
				$scope.navigateBack();
			});
		} else {
			// attach docx file, if a ttachment type is not PDF.
			if(!$scope.isAttachmentTypePdf) { 
				$scope.checkInDocumentGeneric(inputData);
			}
			//CheckIn Logic for PDFTron PDF Attachment
			else if($scope.autoAttachDoc == "false" && $scope.isAttachmentTypePdf && !$scope.generatedPDFContentVersion.Id) {
				if($scope.pdfGenerationSource.toLowerCase() == $scope.VlocityClientSide){
					// Logic for PDFTron PDF Attachment on attach
					$scope.generatePDFDocument().then(function(result){
						if($scope.generatedPDFContentVersion.Id != undefined){
							$scope.selectiveDocumentCheckin(contractVersionId, contentVersionId, contractDocumentCollectionId);
						}
						else{
							$scope.checkInDocumentGeneric(inputData);
						}
					});
				} else {
					$scope.checkInDocumentGeneric(inputData);
				}
			} else if($scope.generatedPDFContentVersion.Id){
				$scope.selectiveDocumentCheckin(contractVersionId, contentVersionId, contractDocumentCollectionId);
			}
        }
    }

    $scope.selectiveDocumentCheckin = function(contractVersionId, contentVersionId, contractDocumentCollectionId) {
        $scope.vlcLoading = true;
        if($scope.documentAttachmentType.toLowerCase() === 'pdf'){
             var checkinMap = {
                                'contractVersionId': contractVersionId,
                                'contentVersionId': $scope.generatedPDFContentVersion.Id,
                                'contractDocumentCollectionId': $scope.generatedPDFContentVersion.collectionId,
                             }
              $scope.checkInDocumentGeneric(checkinMap);
        }
        else if($scope.documentAttachmentType.toLowerCase() === 'word'){
              var checkinMap = {
                                 'contractVersionId': contractVersionId,
                                 'contentVersionId': contentVersionId,
                                 'contractDocumentCollectionId': contractDocumentCollectionId,
                              }
              $scope.checkInDocumentGeneric(checkinMap);
         }
        else if($scope.documentAttachmentType.toLowerCase() === 'word,pdf' || $scope.documentAttachmentType.toLowerCase() === 'pdf,word'){
              var checkinMap = {
                                 'contractVersionId': contractVersionId,
                                 'contentVersionId': $scope.generatedPDFContentVersion.Id,
                                 'contractDocumentCollectionId': $scope.generatedPDFContentVersion.collectionId,
                                 'parentDocumentId': $scope.generatedPDFContentVersion.parentDocumentId
                              }
              $scope.checkInDocumentGeneric(checkinMap);
        }
        else if ($scope.documentAttachmentType.toLowerCase() === 'none' || $scope.documentAttachmentType == '') {
               $scope.navigateBack();
        }
    }

    $scope.createNewDocWithSectionId = function(contractVersionId, contentVersionId, contractDocumentCollectionId){
        return new Promise(function(resolve, reject) {
            if($scope.generatedContentVersion.VersionData !== undefined){
                let inputMap ={
                    docName: $scope.docName + '.docx',
                    ns: $scope.nameSpacePrefix,
                    documentSectionData: $scope.documentSectionData,
                    contractVersionId: contractVersionId,
                    oldContentVersionId: contentVersionId,
                    contractDocumentCollectionId: contractDocumentCollectionId
                }

                //Add SectionId to the Document
                addSectionIdtoWordDoc($scope.generatedContentVersion.VersionData, inputMap)
                .then(function(result){
                    console.log('####Document Updated::' + result);
                    return $scope.createNewDocxContentVersion(inputMap, result.fileContent);
                }).then(function(tempRes){
                    resolve(tempRes);
                })
                .catch(error => {
                    console.error('###Document update error' + error);
                    $scope.vlcLoading = false;
                    $scope.validationErrorHandler.throwError(error);
                    reject(error);
                });
            }
            else {
                error = {
                    message: 'No Content Data',
                    name: 'FailedDocxSections::'
                }
                console.error('###Document update error' + error);
                $scope.vlcLoading = false;
                $scope.validationErrorHandler.throwError(error);
                reject(error);
            }
        });
    }

    $scope.createNewDocxContentVersion=function(inputMap, fileContent){
       return new Promise(function(resolve, reject) {
            $scope.saveContent(inputMap.docName, fileContent)
            .then(function(generatedContentVersionId) {
                return $scope.updateDocxContentVersionLink(inputMap, generatedContentVersionId);
            }).then(function(newContentVersionId) {
                resolve(newContentVersionId);
            }).catch(function(error) {
                console.error('error: ', error);
                $scope.vlcLoading = false;
                reject(error);
            });
        });
    }

    $scope.createAttachmentForWebTemplate = function() {
        if ($scope.isAttachmentTypePdf && $scope.isAttachmentTypeWord) {
            $scope.attachWebTemplatePDF(false);
            $scope.attachWebTemplateDocX();
        } else if ($scope.isAttachmentTypePdf) {
            $scope.attachWebTemplatePDF(true);
        } else if ($scope.isAttachmentTypeWord) {
            $scope.attachWebTemplateDocX();
        } else if ($scope.documentAttachmentType.toLowerCase() === 'none') {
            $scope.navigateBack();
        }
    };

    $scope.deleteNotRequiredDocsAndCheckin = function(deleteMap,checkinMap) {
        remoteActions.deleteNotRequiredDocs(deleteMap).then(function(result) {
            if(result == true){
                $scope.checkInDocumentGeneric(checkinMap);
            }
            else if(result == false){
                console.log('Failed to Delete the files...');
            }
        }, function(error) {
            $scope.vlcLoading = false;
        });
    };

    $scope.checkInDocumentGeneric = function(inputData){
         remoteActions.checkInContentVersionForContractVersion(inputData).then(function(result) {
                console.log('Check in Document results:', result);
                var event = new CustomEvent('ContractDocXDocumentAttachDone', {
                                detail: true
                            });
                $scope.generatedContentCheckedIn = result;
                //$scope.vlcLoading = true;
                if($scope.autoAttachDoc == 'true'){
                      window.parent.dispatchEvent(event);
                      window.close();
                }else{
                    $scope.navigateBack();
                }
        },function(error) {
            $scope.vlcLoading = false;
        });
    }

    /**
     * 
     */
    $scope.createAttachmentForBatchableTemplate = function() {

        var savePdf = function() {
            return new Promise(function(resolve, reject) {
                if (!$scope.generatedPDFContentVersion.VersionData) {
                    sforce.connection.sessionId = window.sessionId;
                    var queryString = 'Select VersionData FROM ContentVersion where Id = \'' + $scope.generatedPDFContentVersion.Id + '\'';
                    sforce.connection.query(queryString, {
                        onSuccess: function(result) {
                            $scope.generatedPDFContentVersion.VersionData = result.records.VersionData;
                            resolve(doSavePdf());
                        },
                        onFailure: function(result) {
                            var errorMsg = result.faultstring;
                            reject(errorMsg);
                        }
                    });
                } else {
                    resolve(doSavePdf());
                }
            });
        };

        var doSavePdf = function() {
            return $scope.saveAttachment(
                $scope.generatedPDFContentVersion.Title,
                $scope.generatedPDFContentVersion.VersionData,
                'application/pdf', 
                $scope.parentId
            );
        }

        var saveDocx = function() {
            return $scope.saveAttachment(
                    $scope.generatedContentVersion.Title, 
                    $scope.generatedContentVersion.VersionData,
                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                    $scope.parentId
            );
        };

        if ($scope.documentAttachmentType.toLowerCase() != 'none') {
                var documentAttachmentType = $scope.documentAttachmentType.toLowerCase();
                if (documentAttachmentType === 'word,pdf' || documentAttachmentType === 'pdf,word') {
                    saveDocx().then(function() {
                        console.log('done saving docx attachment...');
                        savePdf().then(function(response) {
                            console.log('done saving pdf attachment...');
                            $scope.checkInDocForWebTemplate(true);
                        });
                    });
                } else if (documentAttachmentType === 'pdf') {
                    savePdf().then(function(response) {
                        console.log('done saving pdf attachment...');
                        $scope.checkInDocForWebTemplate(true);
                    });
                } else if (documentAttachmentType === 'word') {
                    saveDocx().then(function(response) {
                        console.log('done saving docx attachment...');
                        $scope.checkInDocForWebTemplate(true);
                    });
                } else {
                    $scope.checkInDocForWebTemplate(true);
                }
        } else {
            $scope.checkInDocForWebTemplate(true);
        }
    };

    /**
     * 
     */
    $scope.saveAttachment = function(filename, fileContents, fileType, contractVersionId) {
        
        return new Promise(function(resolve, reject) {
            var attachmentSObj = new sforce.SObject('Attachment');
            attachmentSObj.Body = fileContents;
            attachmentSObj.IsPrivate = false;
            attachmentSObj.Name = filename;
            attachmentSObj.ParentId = contractVersionId;
            attachmentSObj.ContentType = fileType;

            sforce.connection.sessionId = window.sessionId;
            sforce.connection.create([attachmentSObj], {
                onSuccess: function(result) {
                    console.log('Attachment created:', result);
                    resolve(result);
                },
                onFailure: function(error) {
                    console.error('error: ', error);
                    reject(error.faultstring);
                }
            });
        });
    };

    /**
     *
     */
    $scope.generateFileForBatchableTemplate = function() {
        var deferred = $q.defer();

        if ($scope.documentTemplateResource.errorString !== undefined) {
            console.error('Error in the document template resource: ', $scope.documentTemplateResource.errorString);
        } else {
            var zip = new JSZip($scope.documentTemplateResource, {base64: true});
            parseContentTypes(zip); // parse the document content to convert all jpeg/jpg images to png
            var contentDataMap = $scope.documentMetadata.contentDataMap;
            var imageDataMap = $scope.documentMetadata.imageDataMap;
            for (var i = 0; i < imageDataMap.numImages; i++) {
                if (typeof imageDataMap['imageData' + i] !== 'undefined' && imageDataMap['imageData' + i] !== null) {
                    zip.file('word/media/imageData' + i + '.png', imageDataMap['imageData' + i], {base64: true});
                }
            }
            if (contentDataMap.numberingXML !== null && contentDataMap.numberingXML !== '') {
                zip.remove('word/numbering.xml');
                zip.file('word/numbering.xml', contentDataMap.numberingXML,{});
            }
            if (typeof contentDataMap.DocxRels !== 'undefined' && contentDataMap.DocxRels !== null) {
                zip.remove('word/_rels/document.xml.rels');
                zip.file('word/_rels/document.xml.rels', contentDataMap.DocxRels, {});
            }

            var doc = new Docxtemplater();
            doc.loadZip(zip);
            $scope.startIndex = 0;
            $scope.wmlContents = '';
            // if (isAttachCall) {
                $scope.fetchWML(doc, contentDataMap, true, 'base64');
                $scope.$on('wordFileContents', function (event, data) {
                    deferred.resolve(data);
                });
            // } else {
            //     $scope.fetchWML(doc, contentDataMap, false, 'blob');
            // }
        }

        return deferred.promise;
    };

    $scope.fetchWML = function (doc, contentDataMap, isAttachCall, docType) {
        var recordCount = 100;
        remoteActions.getWMLData($scope.contractVersionId, $scope.startIndex, recordCount).then(function(result, event) {
            $scope.wmlContents += result;
            $scope.startIndex += recordCount;
            if ($scope.startIndex < $scope.documentSectionSize) {
                $scope.fetchWML(doc, contentDataMap, isAttachCall, docType);
            } else {
                contentDataMap.ContractData = $scope.wmlContents;
                doc.setData(contentDataMap);
                doc.render();

                var outputFileConfig = {
                    'type': docType,
                    'mimeType': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                    'compression': 'DEFLATE',
                    'compressionOptions': {
                        'level': 9
                    }
                };
                var out = doc.getZip().generate(outputFileConfig);

                if (isAttachCall) {
                    $scope.$emit('wordFileContents', out);
                } else {
                    if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0 || $scope.isSafari) {
                        let url = window.URL.createObjectURL(out);
                        window.open(url, "_top");
                        setTimeout(function () {
                            window.URL.revokeObjectURL(url);
                        }, 2000);
                       
                    } else {
                        saveAs(out, $scope.docName + '.docx');
                    }
                    $scope.vlcLoading = false;
                }
            }
        }, function(error) {
            console.log(error);
        });
    };

    $scope.preDownloadPdf = function() {
        if ($scope.containsRedlines) {
            $sldsModal({
                title: $scope.labels.clmContractDocDownloadPDFDoc,
                templateUrl: 'pdf-contains-redlines-modal.tpl.html',
                html: true,
                scope: $scope,
                container: 'div.vlocity',
                placement: 'center'
            });
        } else {
            $scope.downloadGeneratedFile(true);
        }
    };

    /**
     * 
     */
    $scope.generateWebTemplatePDF = function() {
        $scope.vlcLoading = true;
        remoteActions.downloadPdf($scope.parentId, $scope.docName).then(function(result) {
            var data = result;
            var blob = b64toBlob(data, 'application/pdf');
            $scope.vlcLoading = false;
            if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0 || $scope.isSafari) {
                let url = window.URL.createObjectURL(blob);
                window.open(url, "_blank");
                setTimeout(function () {
                    window.URL.revokeObjectURL(url);
                }, 2000);
            } else {
                saveAs(blob, $scope.docName + '.pdf');
            }
        }, function(error) {
            $scope.vlcLoading = false;
            $scope.validationErrorHandler.throwError(error);
        });
    };

    $scope.preDownloadDocx = function() {
        if (!$scope.inLightningExperience && $scope.isSafari) {
            $sldsModal({
                title: $scope.labels.safariNoSupportLabel,
                template: '<div class="slds-notify_container">' +
                            '<div class="slds-notify slds-notify--alert slds-theme--error slds-theme--alert-texture" role="alert">' +
                                '<span class="slds-assistive-text">Error</span>' +
                                '<span class="slds-icon_container slds-icon-utility-ban slds-m-right_x-small" title="Error">' +
                                '<slds-svg-icon sprite="\'utility\'" icon="\'ban\'" size="\'x-small\'"></slds-svg-icon>' +
                                '</span>' +
                                '<h2>This operation is currently not supported in the Safari browser. Please use another browser like&nbsp;' +
                                '<a href="https://www.google.com/chrome/browser" target="_blank">Chrome</a>&nbsp;or&nbsp;' +
                                '<a href="https://www.mozilla.org/firefox" target="_blank">Firefox</a>.</h2>' +
                                '<button class="slds-button slds-button_icon slds-notify__close slds-button_icon-inverse" title="Close" ng-click="$hide()">' +
                                '<slds-button-svg-icon sprite="\'utility\'" icon="\'close\'" size="\'small\'"></slds-button-svg-icon>' +
                                '<span class="slds-assistive-text">Close</span>' +
                                '</button>' +
                            '</div>' +
                        '</div>',
                html: true,
                container: 'div.vlocity',
                placement: 'center'
            });
        } else {
            if ($scope.containsRedlines) {
                $sldsModal({
                    title: $scope.labels.clmContractDocDownloadWordDoc,
                    templateUrl: 'docx-contains-redlines-modal.tpl.html',
                    html: true,
                    scope: $scope,
                    container: 'div.vlocity',
                    placement: 'center'
                });
            } else {
                $scope.downloadGeneratedFile(false);
            }
        }
    };

    $scope.generateWebTemplateDocX = function() {
        $scope.vlcLoading = true;
        remoteActions.getDocxTemplate($scope.parentId).then(function(result) {
            var zip = new JSZip(result.templateEncoded, {base64: true});
            parseContentTypes(zip); // parse the document content to convert all jpeg/jpg images to png

            remoteActions.downloadDocx($scope.parentId, getRelsFile(zip)).then(function(resultTwo) {
                $scope.vlcLoading = false;
                if (resultTwo.errorString !== undefined) {
                    alert(resultTwo.errorString);
                    console.log('### error: ', resultTwo.errorString);
                } else {
                    var blob = generateDocx(resultTwo, 'blob', zip);
                    if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0 || $scope.isSafari) {
                        let url = window.URL.createObjectURL(blob);
                        window.open(url, "_top");
                        setTimeout(function () {
                            window.URL.revokeObjectURL(url);
                        }, 2000);
                    } else {
                        saveAs(blob, $scope.docName + '.docx');
                    }
                }
            }, function(error) {
                $scope.vlcLoading = false;
                $scope.validationErrorHandler.throwError(error);
            });
        }, function(error) {
            $scope.vlcLoading = false;
            $scope.validationErrorHandler.throwError(error);
        });
    };

    $scope.attachWebTemplatePDF = function(goBack) {
        $scope.vlcLoading = true;
        if (isPdfGenerationViaClientSide()){
            if(!$scope.generatedPDFContentVersion.VersionData) {
                //query for contentVersion when the versionData is not available
                getTemplateFileContent($scope.generatedPDFContentVersion.Id).then(function (templateContentVersion) {
                   // var blobData = b64toBlob(templateContentVersion.Base64VersionData, 'application/pdf');
                    $scope.generatedPDFContentVersion.VersionData = templateContentVersion.Base64VersionData;
                    $scope.attachWebPdfDocument(goBack);
                });
            } else {
                $scope.attachWebPdfDocument(goBack);
            }
        }else{
            remoteActions.savePdf($scope.parentId).then(function() {
                if (goBack) {
                    $scope.navigateBack();
                }
            }, function(error) {
                $scope.validationErrorHandler.throwError(error);
            });
        }
    };
    $scope.attachWebPdfDocument = function (goBack) {
        var savePdf = function () {

            var title = $scope.generatedPDFContentVersion.Title;
            if (!title.toLowerCase().endsWith('.pdf')) {
                title = title + '.pdf';
            }

            return $scope.saveAttachment(
                title,
                $scope.generatedPDFContentVersion.VersionData,
                'application/pdf',
                $scope.parentId
            );
        }
        savePdf().then(function (response) {
            console.log('done saving pdf attachment...');
            if (goBack) {
                $scope.navigateBack();
            }
        });
    }

    $scope.attachWebTemplateDocX = function() {
        $scope.vlcLoading = true;
        remoteActions.getDocxTemplate($scope.parentId).then(function(result) {
            var zip;
            if (result.errorString !== undefined) {
                alert(result.errorString);
            } else {
                zip = new JSZip(result.templateEncoded, {base64: true});
                parseContentTypes(zip); // parse the document content to convert all jpeg/jpg images to png

                remoteActions.downloadDocx($scope.parentId, getRelsFile(zip)).then(function(docXresult) {
                    if (docXresult.errorString !== undefined) {
                        alert(docXresult.errorString);
                        $scope.vlcLoading = false;
                    } else {
                        remoteActions.attachDocx($scope.parentId, generateDocx(docXresult, 'base64', zip)).then(function(result) {
                            $scope.navigateBack();
                        }, function(error) {
                            $scope.vlcLoading = false;
                            $scope.validationErrorHandler.throwError(error);
                        });
                    }
                }, function(error) {
                    $scope.vlcLoading = false;
                    $scope.validationErrorHandler.throwError(error);
                });
            }
        }, function(error) {
            $scope.vlcLoading = false;
            $scope.validationErrorHandler.throwError(error);
        });
    };
    $scope.downloadGeneratedFile = function(downloadPdf) {
        if (downloadPdf) {
            // pdf
            console.log('### downloadGeneratedFile() generatedPDFContentVersion: ', $scope.generatedPDFContentVersion);
            location.href = $scope.sitePrefix + '/sfc/servlet.shepherd/version/download/' + $scope.generatedPDFContentVersion.Id;
            
        } else {
            // docx
            console.log('### downloadGeneratedFile() generatedContentVersion: ', $scope.generatedContentVersion);
            location.href = $scope.sitePrefix + '/sfc/servlet.shepherd/version/download/' + $scope.generatedContentVersion.Id;
        }
    };

    $scope.downloadWordDoc = function(){
        if ($scope.generatedContentVersion.Id) {
            location.href = $scope.sitePrefix + '/sfc/servlet.shepherd/version/download/' + $scope.generatedContentVersion.Id;
        } else {
            $scope.vlcLoading = true;
            var blob = base64ToBlob($scope.generatedContentVersion.VersionData, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
            saveAs(blob, $scope.generatedContentVersion.Title);
            $scope.vlcLoading = false;
        }
    }

    $scope.test = function() {
        console.log(' in test func');
    };

    /**
     *
     */
    $scope.downloadBatchGeneratedWordFile = function() {

        $scope.vlcLoading = true;
        var blob = b64toBlob($scope.generatedContentVersion.VersionData, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
        var title = $scope.generatedContentVersion.Title;

        if (!title.toLowerCase().endsWith('.docx')) {
            title = title + '.docx';
        }

        console.log('Downloading batch generated file: ' + title);

        if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0 || $scope.isSafari) {
            let url = window.URL.createObjectURL(blob);
            window.open(url, "_top");
            setTimeout(function () {
                window.URL.revokeObjectURL(url);
            }, 2000);
        } else {
            saveAs(blob, title);
        }
        $scope.vlcLoading = false;
    };

    /**
     *
     */
    $scope.downloadBatchGeneratedPdfFile = function() {

        if ($scope.generatedPDFContentVersion && $scope.generatedPDFContentVersion.Id && !$scope.generatedPDFContentVersion.VersionData) {
            $scope.downloadGeneratedFile(true);
            return;
        }

        $scope.vlcLoading = true;
        var blob = b64toBlob($scope.generatedPDFContentVersion.VersionData, 'application/pdf');

        var title = $scope.generatedPDFContentVersion.Title;
        if (!title.toLowerCase().endsWith('.pdf')) {
            title = title + '.pdf';
        }

        console.log('Downloading batch generated file: ' + title);

        if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0 || $scope.isSafari) {
            let url = window.URL.createObjectURL(blob);
            window.open(url, "_blank");
            setTimeout(function () {
                window.URL.revokeObjectURL(url);
            }, 2000);
           
        } else {
            saveAs(blob, title);
        }
        $scope.vlcLoading = false;
     };

    //generate and save generated Pdf document using salesforce
    $scope.generatePdf = function() {
        var input = {
            'contractId': $scope.sourceId,
            'sourceContentVersionId': $scope.generatedContentVersion.Id,
            'sourceFileName': $scope.docName
        };
        remoteActions.generatePdf(input).then(function(generatedPDFContentVersionId) {
            console.log('### generatePdf() generatedPDFContentVersionId response: ', generatedPDFContentVersionId);
            $scope.$emit('SalesforcePdfGenerationCompelete', { 
                'Id': generatedPDFContentVersionId
            });
        }, function(error) {
            $scope.vlcLoading = false;
            $scope.validationErrorHandler.throwError(error);
        })
    }
    /**
     * 
     * @param {*} contenVersionId
     */
    function checkPdfDownloadReady(contenVersionId) {
        var imgSource = '/sfc/servlet.shepherd/version/renditionDownload?rendition=SVGZ&versionId=' + contenVersionId + '&operationContext=CHATTER&page=0';
        var img = document.createElement("img");
        var retries = 0;

        console.log('imgSource=', imgSource);
        console.log('loading thumbnail');
        
        img.setAttribute('src', imgSource);
           
        img.addEventListener("load", function() {
            console.log('successfully verified thumbnail');
            $scope.isPdfDownloadReady = true;
            $scope.$apply();
            if(!$scope.generatedPDFContentVersion.Id) {
                console.log('attach pdf -------')
                $scope.generatePdf();
            }
        }, false); 
        
        
        img.addEventListener("error", function(e) {
            ++retries;
            $timeout(function () {
                img.setAttribute('src', imgSource);
                console.log('reloading thumbnail');
            }, 2000 * retries);
                        
        }, false); 

    }

    /**
     * 
     */
    $scope.resolveDocumentGenerationMethods = function() {
        return new Promise(function(resolve, reject) {
            let inputMap = {
                'templateId' : $scope.documentTemplateId,
                'parentId': $scope.parentId,
                'sourceId': $scope.sourceId
            };
            console.log('### resolveDocumentGenerationMethods() inputMap: ', inputMap)
            remoteActions.resolveDocumentGenerationMethods(inputMap)
                .then(function(result) {
                    console.log('### resolveDocumentGenerationMethods() result: ', result);
                    $scope.docGenerationMechanism = result.docGenerationMechanism;
                    $scope.pdfGenerationSource = result.pdfGenerationSource;

                    if (!$scope.isPdftronInitialized && (isPdfGenerationViaClientSide() || isPdfViewerClientSide())) {
                        $scope.initializePdftron()
                            .then(function() {      
                                $scope.isPdftronInitialized = true;                          
                                resolve();
                            });
                    } else {
                        resolve();
                    }
                })
                .catch(function(error) {
                    console.log('error: ', error);  
                    reject(error);              
                });
        });
    };

    /**
     * 
     */
    $scope.getResolvedPdfGenerationMethod = function() {
        if (isPdfGenerationViaClientSide()) {
            return $scope.generatePdfViaClientSide;            
        } else if (isPdfGenerationViaCloud() && $scope.templateType === 'Microsoft Word .DOCX Template') {
            return $scope.generatePdfViaCloud;         
        } else {
            return $scope.generatePdfViaSalesforce;
        }
    };

    /**
     * 
     */
    $scope.getResolvedDocGenerationMethod = function() {
        return $scope.generateDocViaClientSide;
    };

    /**
     * 
     */
    $scope.initializePdftron = function() {
        return new Promise(function(resolve, reject) {
            pdfTronSetResourcePath(remoteActions, $scope.clientSidePdfGenerationConfig)
                .then(function(result){
                    if ($scope.labels.VlocityPDFTronNoSystemUserMsg === result) {
                        $scope.validationErrorHandler.throwError($scope.labels.VlocityPDFTronNoSystemUserMsg);
                        reject(result);
                    } else {
                        $scope.clientSidePdfGenerationConfig = result.clientSidePdfGenerationConfig
                        $scope.pdfIntegrationConfig = JSON.parse(result.license);
                        resolve(true);
                    }
                });
        });
    };

    /**
     * 
     */
    $scope.generatePdfViaSalesforce = function() {
        var inputMap = {
            'contractId': $scope.sourceId,
            'docName': $scope.docName,
            'sourceContentVersion': $scope.generatedContentVersion,
            'templateType': $scope.templateType,
            'withSave': false
        };
        return new Promise(function(resolve, reject) {
            console.log('### generatePdfViaSalesforce() inputMap: ', inputMap);

            if (inputMap['templateType'] === 'Vlocity Web Template') {
                remoteActions.downloadPdf($scope.parentId, inputMap['docName'])
                    .then(function(response) {
                        console.log('### salesforce pdf generation completed...');
                        resolve($scope.saveContent(inputMap['docName'] + '.pdf', response));
                })
                .catch(function(error) {
                    $scope.vlcLoading = false;
                    $scope.validationErrorHandler.throwError(error);
                    reject(error);
                });
            } else {
                // generatePdf
                console.log('### inputMap: ', inputMap);

                checkPdfDownloadReady(inputMap['sourceContentVersion'].Id);

                $scope.$on('SalesforcePdfGenerationCompelete', function(event, response) {
                    console.log('### response: ', response);
                    resolve(response);
                })

            }
        });
    }

    /**
     *  inputMap
     *      parentId => contentVersionId
     *      documentName
     */
    $scope.generatePdfViaCloud = function() {
        var inputMap = {
            'objectId': $scope.sourceId,
            'contentVersionId': $scope.generatedContentVersion.Id,
            'docName': $scope.docName,
            'templateType': $scope.templateType,
            'base64Content': $scope.generatedContentVersion.VersionData
        };
        return new Promise(function(resolve, reject) {
            let promise = null;
            if (inputMap['templateType'] === 'Microsoft Word .DOCX Template') {
                promise = new Promise(function(resolve, reject) {
                    resolve(inputMap);
                });
            }
            promise.then(function() {
                remoteActions.remoteGeneratePdf(inputMap)
                    .then(function(response) {
                        if (response['success']) {
                            console.log('### server side pdf generation completed...');
                            var generatedContentVersion = {
                                'Id': response['contentVersionId'],
                                'Title': response['Title'],
                                'VersionData': response['base64Content']
                            };
                            resolve(generatedContentVersion);
                        } else {
                            throw response;
                        }
                })
                .catch(function(error) {
                    console.error('### remoteGeneratePdf() error: ', error);
                    error = error.error ? error.error : error;          //TODO check error structure returned by service
                    reject(error);
                });
            });
        })                
    }

    /**
     * 
     */
    $scope.generatePdfViaClientSide = function() {
        var inputMap = {
            'pdfIntegrationConfig': $scope.pdfIntegrationConfig,
            'generatedContentVersion': $scope.generatedContentVersion,
            'docName': $scope.docName,
            'templateType': $scope.templateType,
            'isDownload': false
        };
        return new Promise(function(resolve, reject) {
            generatePDFTronDocument(inputMap)
                .then(function(response) {
                    console.log('### client side pdf generation completed...');
                    resolve($scope.saveContent(inputMap['docName'] + '.pdf', response));
            }).catch(function(error) {
                console.log('### generatePdfViaClientSide() error: ', error);
                reject(error);
            });
        });
    }

    /**
     * 
     */
    $scope.generateDocxFromWebTemplate = function(contractVersionId) {
        return new Promise(function(resolve, reject) {
            remoteActions.getDocxTemplate(contractVersionId)
                .then(function(result) {
                    var zip = new JSZip(result.templateEncoded, {base64: true});
                    parseContentTypes(zip);
                    return zip;
                })
                .then(function(zip) {
                    remoteActions.downloadDocx(contractVersionId, getRelsFile(zip))
                        .then(function(result) {
                            if (result.errorString !== undefined) {
                                console.log('### error: ', error);
                                alert(result.errorString);
                                $scope.vlcLoading = false;
                            } else {
                                let blob = generateDocx(result, 'blob', zip);

                                var dataReader = new FileReader();
                                dataReader.addEventListener('load', function() {
                                    var outputContentBase64 = dataReader.result;
                                    var base64Mark = 'base64,';
                                    var dataStart = outputContentBase64.indexOf(base64Mark) + base64Mark.length;
                                    outputContentBase64 = outputContentBase64.substring(dataStart);

                                    resolve(outputContentBase64);
                                });
                                dataReader.readAsDataURL(blob);
                            }
                    })
                })
                .catch(function(error) {
                    console.log('### error: ', error);
                    reject(error);
                });
        });
    }

    /**
     * 
     */
    function isDocGenerationViaClientSide() {
        return  ($scope.docGenerationMechanism.toLowerCase() === $scope.VlocityClientSide)
    }

    /**
     * 
     */
    function isPdfGenerationViaSalesforce() {
        return  ($scope.pdfGenerationSource.toLowerCase() === $scope.Salesforce)
    }

    /**
     * 
     */
    function isPdfGenerationViaClientSide() {
        return  ($scope.pdfGenerationSource.toLowerCase() === $scope.VlocityClientSide)
    }

    /**
     * 
     */
    function isPdfGenerationViaCloud() {
        return  ($scope.pdfGenerationSource.toLowerCase() === $scope.VlocityCloud)
    }

    /**
     * 
     */
    function isPdfViewerClientSide() {
        return $scope.pdfViewer.match(/VlocityClientsideViewer/i);
    }
});

},{}],4:[function(require,module,exports){
angular.module('contractDocumentCreationApp').directive('filePreviewPdfTron', ['$timeout', function($timeout, remoteActions) {
    'use strict';
    return {
        restrict: 'E',
        scope: {
            width: '=',
            height: '='
        },
        link: function(scope, elem, attrs) { 

            var webViewerCustomOptions = {
                 'clientSidePdfGenerationConfig':scope.$parent.$parent.$parent.clientSidePdfGenerationConfig
            };
            var wvElement = document.getElementById('viewer');

            var  wv = new PDFTron.WebViewer({
                // get path from pdf config
                path: scope.$parent.$parent.$parent.clientSidePdfGenerationConfig['cs_pdftron_lib'],
                //List the elements that need to hide/disable.
                disabledElements: [
                    'toolsButton',
                    'textPopup',
                    'toolsHeader'
                ],
                custom: JSON.stringify(webViewerCustomOptions),
                l: atob(scope.$parent.$parent.$parent.pdfIntegrationConfig),
               // config: scope.$parent.$parent.$parent.sitePrefix + '/resource/' + scope.$parent.$parent.$parent.nameSpacePrefix + 'cs_pdftron_config'
            }, wvElement);
            
            
            window.addEventListener('ready', function(event) {
                console.log('document loaded', wv.getInstance());
                var coreContrls = wv.iframe.contentWindow.CoreControls;
                //Set WorkerPath before loading the document
                setWorkerPath(coreContrls,scope.$parent.$parent.$parent.clientSidePdfGenerationConfig);
                //Load document for previewer
                var instance =wv.getInstance();
                instance.disableDownload(); // disable download feature
                instance.disablePrint(); // disable print feature
                instance.disableTools(); //disable the tools that are used for editing the document.
				instance.disableElements(['searchButton','toolbarGroup-View','toolbarGroup-Annotate','toolbarGroup-Shapes','toolbarGroup-Insert','toolbarGroup-Edit','toggleNotesButton']);
                var versionData = scope.$parent.contentVersion.VersionData;
                if(versionData) {
                    wv.loadDocument(base64ToBlob(versionData),{ filename: 'myfile.docx' , officeOptions: { disableBrowserFontSubstitution: true } });
                } else {
                    getContentVersionData(scope.$parent.$parent.contentVersion.Id);
                }
            });

            //Method to set the CoreControls Worker Path
            function setWorkerPath(coreContrls, clientSidePdfGenerationConfig){
                coreContrls.forceBackendType('ems');
                //window.CoreControls.setPDFWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_full']);
                coreContrls.setPDFWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_lean']);
                coreContrls.setOfficeWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_office']);
                coreContrls.setPDFResourcePath(clientSidePdfGenerationConfig['cs_pdftron_resource']);
                coreContrls.setPDFAsmPath(clientSidePdfGenerationConfig['cs_pdftron_asm']);
                coreContrls.setExternalPath(clientSidePdfGenerationConfig['cs_pdftron_external']);
                //Set the path for Fonts
                coreContrls.setCustomFontURL(clientSidePdfGenerationConfig['cs_vlocity_webfonts_main'] + '/');
                //Set the path for office workers
                coreContrls.setOfficeAsmPath(clientSidePdfGenerationConfig['cs_pdftron_officeasm']); //cs_pdftron_officeresource
                coreContrls.setOfficeResourcePath(clientSidePdfGenerationConfig['cs_pdftron_officeresource']);
            }

            //Method to query for content version when the Version Data is not available
            function getContentVersionData(ContentVersionId) {
                sforce.connection.sessionId = window.sessionId;
                var queryString = 'Select Id, Title, FileType, VersionData FROM ContentVersion where Id  = \'' + ContentVersionId + '\'';
                sforce.connection.query(queryString, {
                    onSuccess: function(result) {
                        scope.$parent.$parent.$parent.vlcLoading = false;
                        var templateContentVersion = {
                        'Id': result.records.Id,
                        'Title': result.records.Title,
                        'VersionData': base64ToBlob(result.records.VersionData)
                        }
                        wv.loadDocument(templateContentVersion.VersionData,{ filename: 'myfile.docx' , officeOptions: { disableBrowserFontSubstitution: true } });
                    },
                    onFailure: function(result) {
                        var errorMsg = result.faultstring;
                        console.error('errorMsg: ', errorMsg);
                        scope.$parent.$parent.$parent.vlcLoading = false;
                        scope.$apply();
                    }
                });
            };

            var base64ToBlob = function(base64) {
                var binaryString = window.atob(base64);
                var len = binaryString.length;
                var bytes = new Uint8Array(len);
                for (var i = 0; i < len; ++i) {
                  bytes[i] = binaryString.charCodeAt(i);
                }

                return new Blob([bytes], { type: 'application/pdf' });
            };
        } 
    };
}]);

},{}],5:[function(require,module,exports){
angular.module('contractDocumentCreationApp').directive('vlcLoader', function() {
    'use strict';
    return {
        restrict: 'E',
        templateNamespace: 'svg',
        replace: true,
        template:
        '<svg x="0px" y="0px" width="28" height="28" viewBox="0 0 48 48">' +
            '<g width="48" height="48">' +
                '<animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 24 24" to="360 24 24" dur="0.75s" repeatCount="indefinite"/>' +
                '<path fill="#dedede" d="M24,45C12.4,45,3,35.6,3,24S12.4,3,24,3V0l0,0C10.7,0,0,10.7,0,24c0,13.3,10.7,24,24,24V45z"/>' +
                '<path fill="#05a6df" d="M24,3c11.6,0,21,9.4,21,21s-9.4,21-21,21v3l0,0c13.3,0,24-10.7,24-24C48,10.7,37.3,0,24,0V3z"/>' +
            '</g>' +
        '</svg>',
        scope: {
            stroke: '@'
        }
    };
});

},{}],6:[function(require,module,exports){
angular.module('contractDocumentCreationApp').factory('ReconcileChanges', function($sce) {
    'use strict';
    var ReconcileChanges = function(scp) {
        var self = this;
        if (window.nameSpacePrefix !== undefined) {
            this.nameSpacePrefix = window.nameSpacePrefix;
        }

        this.initialize = function() {
            // anything that immediately should fire upon instantiation
        };

        // Concatenate all regular view section content HTML
        this.getRegularView = function() {
            var i, regularView;
            regularView = '';
            for (i = 0; i < scp.versionLoadedData.reconciledDocumentSectionList.length; i++) {
                regularView += scp.versionLoadedData.reconciledDocumentSectionList[i];
            }
            var regularViewContent = DOMPurify.sanitize(regularView);
            return $sce.trustAsHtml(regularViewContent);
        };

        // Concatenate all reconciled section HTML
        this.getReconciledView = function() {
            var i, reconciledView;
            reconciledView = '';
            if (scp.versionLoadedData.documentVersionObj[this.nameSpacePrefix + 'DocumentCreationSource__c'] !== 'Reconcile Word') {
                return;
            }
            for (i = 0; i < scp.versionLoadedData.documentSectionObjs.length; i++) {
                reconciledView += scp.versionLoadedData.documentSectionObjs[i][this.nameSpacePrefix + 'ReconciledSectionContent__c'];
            }
            var reconciledViewContent = DOMPurify.sanitize(reconciledView);
            return $sce.trustAsHtml(reconciledViewContent);
        };

        // Set up the two tabs
        this.tabs = [{
            title: 'Document View',
            html: self.getRegularView()
        }, {
            title: 'Reconcile Changes',
            html: self.getReconciledView()
        }];

        // Toggle button label
        this.toggleView = {
            label: 'View Reconciliation Details',
            icon: 'icon-v-reconcile-word-doc'
        };

        // Toggle between views
        this.toggleContractView = function() {
            if (scp.tabs.activeTab === 'Document View') {
                scp.tabs.activeTab = 'Reconcile Changes';
                this.toggleView.label = scp.labels.clmReconcileDocViewDoc;
                this.toggleView.icon = 'icon-v-view';
            } else {
                scp.tabs.activeTab = 'Document View';
                this.toggleView.label = scp.labels.clmReconcileDocViewReconcileDetail;
                this.toggleView.icon = 'icon-v-reconcile-word-doc';
            }
        };

        // Initialize
        this.initialize();
    };
    return (ReconcileChanges);
});

},{}],7:[function(require,module,exports){
angular.module('contractDocumentCreationApp').factory('ValidationErrorHandler', function(remoteActions, $sldsModal, $rootScope) {
    'use strict';
    var ValidationErrorHandler = function() {
        this.initialize = function() {
            // anything that immediately should fire upon instantiation
        };

        // Error handling helper
        this.throwError = function(error) {
            var statusCode;
            if (!error.message) {
                error.message = 'No error message.';
            }
            if (error.statusCode) {
                statusCode = '(' + error.statusCode + '): ';
            }
            if (typeof error.type === 'string') {
                error.type = error.type.capitalizeFirstLetter() + ' ';
            }
            if (error.message.indexOf('Logged in?') > -1) {
                error.message = 'You have been logged out of Salesforce. Please back up any changes to your document and refresh your browser window to login again.';
                error.type = '';
                statusCode = '';
            }
            $sldsModal({
                title: 'There Has Been An Error',
                templateUrl: 'error-handler-modal.tpl.html',
                content: error.type + statusCode + error.message,
                html: true,
                container: 'div.vlocity',
                placement: 'center'
            });
            $rootScope.vlcLoading = false;
        };

        // Adding to String prototype:
        String.prototype.capitalizeFirstLetter = function() {
            return this.charAt(0).toUpperCase() + this.slice(1);
        };

        // Initialize
        this.initialize();
    };
    return (ValidationErrorHandler);
});

},{}],8:[function(require,module,exports){
(function() {
    'use strict';
    window.angular.module('contractDocumentCreationApp').service('browserDetection', ['$window', function($window) {
        this.userAgent = $window.navigator.userAgent;
        this.browsers = {
            chrome: /chrome/i,
            safari: /safari/i,
            firefox: /firefox/i,
            msielte10: /msie/i,
            msiegt10: /rv:/i,
            edge: /edge/i
        };

        this.detectBrowser = function() {
            var key;
            var userAgent = this.userAgent;
            var browsers = this.browsers;
            for (key in browsers) {
                if (browsers[key].test(userAgent)) {
                    if(key === 'safari' && userAgent.match('CriOS')) {
                        return 'chrome';
                    }
                    return key;
                }
            }
            return 'unknown';
        };

        this.getBrowserVersion = function() {
            var version, i;
            var browser = this.detectBrowser();
            var userAgent = this.userAgent;
            var versionSearch = [{
                browser: 'chrome',
                before: ' ',
                after: 'Chrome/'
            }, {
                browser: 'safari',
                before: ' ',
                after: 'Version/'
            }, {
                browser: 'firefox',
                before: '',
                after: 'Firefox/'
            }, {
                browser: 'msielte10',
                before: ';',
                after: 'MSIE '
            }, {
                browser: 'msiegt10',
                before: ')',
                after: 'rv:'
            }, {
                browser: 'edge',
                before: '',
                after: 'Edge/'
            }];

            for (i = 0; i < versionSearch.length; i++) {
                if (browser === versionSearch[i].browser) {
                    version = userAgent.split(versionSearch[i].after)[1];
                    if (version && versionSearch[i].before) {
                        version = parseFloat(version.substr(0, version.indexOf(versionSearch[i].before)));
                    }
                }
            }

            return version;
        };
    }]);
}());

},{}],9:[function(require,module,exports){
angular.module("contractDocumentCreationApp").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("error-handler-modal.tpl.html",'<div class="slds-modal slds-fade-in-open" tabindex="-1" role="dialog">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header">\n            <button class="slds-button slds-button_icon-inverse slds-modal__close" ng-click="$hide();">\n                <slds-svg-icon id="clause-page-header_icon" sprite="\'action\'" icon="\'close\'" size="\'medium\'"></slds-svg-icon>\n            </button>\n            <h4 class="slds-text-heading_medium" ng-bind-html="title">{{modalLabels.CLMTemplateDeleteSection}}</h4>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div class="slds-notify slds-notify_alert slds-theme_error slds-theme_alert-texture" role="alert">\n                <span class="slds-assistive-text">Error</span>\n                <h2>\n                    <slds-svg-icon sprite="\'utility\'" icon="\'ban\'" size="\'small\'" extra-classes="\'slds-m-right_x-small\'"></slds-svg-icon>\n                    {{content}}\n                </h2>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral modal-close-btn" ng-click="$hide()">Close</button>\n        </div>\n    </div>\n</div>\n<div class="slds-backdrop slds-backdrop_open"></div>\n'),$templateCache.put("pdf-contains-redlines-modal.tpl.html",'<div class="slds-modal slds-fade-in-open" tabindex="-1" role="dialog">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header">\n           <button class="slds-button slds-button_icon-inverse slds-modal__close" ng-click="$hide();">\n                <slds-svg-icon id="clause-page-header_icon" sprite="\'action\'" icon="\'close\'" size="\'medium\'"></slds-svg-icon>\n            </button>\n            <h4 class="slds-text-heading_medium slds-m-bottom_none" ng-bind-html="title">Warning</h4>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div>\n                <p>{{labels.clmContractDocPdfRedlines}}</p>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral modal-cancel-btn" ng-click="$hide()">{{labels.cancelLabel}}</button>\n            <button type="button" class="slds-button slds-button_brand modal-download-btn" ng-click="downloadGeneratedFile(true); $hide();">{{labels.clmContractDocDownloadYes}}</button>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("docx-contains-redlines-modal.tpl.html",'<div class="slds-modal slds-fade-in-open" tabindex="-1" role="dialog">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header">\n           <button class="slds-button slds-button_icon-inverse slds-modal__close" ng-click="$hide();">\n                <slds-svg-icon id="clause-page-header_icon" sprite="\'action\'" icon="\'close\'" size="\'medium\'"></slds-svg-icon>\n            </button>\n            <h4 class="slds-text-heading_medium slds-m-bottom_none" ng-bind-html="title">Warning</h4>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div>\n                <p>{{labels.clmContractDocWordDocRedlines}}</p>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral modal-cancel-btn" ng-click="$hide()">{{labels.cancelLabel}}</button>\n            <button type="button" class="slds-button slds-button_brand modal-download-btn" ng-click="generateWebTemplateDocX(); $hide()">{{labels.clmContractDocDownloadWord}}</button>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("checkin-modal.tpl.html",'<div class="slds-modal slds-fade-in-open" tabindex="-1" role="dialog">\n    <div class="slds-modal__container">\n        <div class="slds-modal__header">\n           <button class="slds-button slds-button_icon-inverse slds-modal__close" ng-click="$hide();">\n                <slds-svg-icon id="clause-page-header_icon" sprite="\'action\'" icon="\'close\'" size="\'medium\'"></slds-svg-icon>\n            </button>\n            <h4 class="slds-text-heading_medium slds-m-bottom_none" ng-bind-html="title">Warning</h4>\n        </div>\n        <div class="slds-modal__content slds-p-around_medium">\n            <div>\n                <p>{{labels.customizeReadyCheckInLabel}}</p>\n            </div>\n        </div>\n        <div class="slds-modal__footer">\n            <button type="button" class="slds-button slds-button_neutral modal-back-btn" ng-click="navigateBackNoCheckin(); $hide()">{{labels.noCheckInLabel}}</button>\n            <button type="button" class="slds-button slds-button_neutral modal-cancel-btn" ng-click="$hide()">{{labels.cancelLabel}}</button>\n            <button type="button" class="slds-button slds-button_brand modal-check-in-btn" ng-click="checkInDocument(); $hide()">{{labels.yesCheckInLabel}}</button>\n        </div>\n    </div>\n</div>\n'),$templateCache.put("component/docxTemplateComponent.tpl.html",'<div class="document-wrapper">\n    <div class="document-container">\n        <h3 class="slds-text-heading_small slds-m-bottom_small documentTitle">{{::contentVersion.Title}}</h3>\n        <div class="document-buttons" ng-if="$parent.pdfViewer === \'none\'" style="text-align: center;">\n            <div ng-show="$parent.$parent.showDownloadNone" class="slds-grid slds-wrap slds-size_1-of-1 download-buttons buttons-group slds-m-around_medium">\n                    <div  class="slds-size_1-of-2">\n                            <div class="dz-preview dz-file-preview icon-v-file-word border-right"></div>\n                    </div>\n                    <div  class="slds-size_1-of-2">\n                            <div class="dz-preview dz-file-preview icon-v-file-psd" style=\'color:#fc897a\'></div>\n                    </div>\n            </div>\n            <div class="slds-grid slds-wrap slds-size_1-of-1 download-buttons buttons-group slds-m-around_medium">\n                    <div ng-show="$parent.$parent.showDownloadWord"  ng-class="{\'slds-size_1-of-2 border-right\': $parent.$parent.showDownloadWord && $parent.$parent.showDownloadPdf, \'slds-size_1-of-1\': $parent.$parent.showDownloadWord}">\n                            <div class="dz-preview dz-file-preview icon-v-file-word"></div>\n                            <button type="button" class="slds-button slds-button--neutral download-word" ng-click="$parent.$parent.downloadGeneratedFile(false)">{{labels.CLMDocGenDownloadWord}}</button>\n                        \n                    </div>\n                    <div ng-show="$parent.$parent.showDownloadPdf" ng-class="{\'slds-size_1-of-2\':$parent.$parent.showDownloadWord && $parent.$parent.showDownloadPdf, \'slds-size_1-of-1\':$parent.$parent.showDownloadPdf}">\n                        <div class="dz-preview dz-file-preview icon-v-file-psd"  ng-style="{ \'color\' : (ispdfDownloadReady) ? \'#fc897a\' : \'#EBEBE4\' }"> </div>\n                        <button type="button" class="slds-button slds-button--neutral slds-m-bottom_x-small download-pdf" style="min-width: 18%;"\n                                ng-disabled="!ispdfDownloadReady" ng-click="$parent.$parent.downloadGeneratedFile(true)">{{ ispdfDownloadReady ? labels.CLMDocGenDownloadPDF : labels.CLMDocGeneratingPDF}}</button>\n                    </div>\n            </div>\n        </div>\n        <div class="slds-m-around_large" ng-if ="$parent.pdfViewer !== \'none\' && !contentVersion.Id" >\n                <h2 class="slds-text-heading_small slds-m-around_medium"> {{labels.PdfGenerationWaitingMessage}} </h2>\n        </div>\n        \x3c!-- PdfTron previewer --\x3e\n        <div class="file-details" ng-if="$parent.pdfViewer === \'vlocityclientsideviewer\' && contentVersion.Id">\n                <div id="viewer" class="pdfViewer"  style=\'width: 800px; height: 600px;\'></div>\n                <file-preview-pdf-tron width="\'100%\'" height="\'100%\'"></file-preview-pdf-tron>\n        </div>\n    </div>\n</div>')}]);

},{}]},{},[1]);
})();
