{
    "dataPackId": "",
    "dataPacks": [
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ApplyToGroup",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"elementValueMap\":{\"ApplyToGroupIPName\":\"MultiService_ApplyToGroup\",\"BatchSize\":10},\"label\":\"SetApplyToGroupIPName\",\"message\":{},\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Set Values",
                                "Name": "SetApplyToGroupIPName",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__Element__c/SetApplyToGroupIPName"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ApplyToGroup",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"enableDefaultAbort\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"extraPayload\":{},\"failureAbortLabel\":\"Abort\",\"failureAbortMessage\":\"Are you sure?\",\"failureGoBackLabel\":\"Go Back\",\"failureNextLabel\":\"Continue\",\"inProgressMessage\":\"In Progress\",\"label\":\"ApplyToGroup\",\"message\":{},\"postMessage\":\"Done\",\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"redirectNextLabel\":\"Next\",\"redirectNextWidth\":3,\"redirectPageName\":\"\",\"redirectPreviousLabel\":\"Previous\",\"redirectPreviousWidth\":3,\"redirectTemplateUrl\":\"vlcAcknowledge.html\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"applyToGroup\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"svgIcon\":\"\",\"svgSprite\":\"\",\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "ApplyToGroup",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__Element__c/ApplyToGroup"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ApplyToGroup",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 3,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"Outcome\":\"\",\"consoleTabLabel\":\"New\",\"controlWidth\":12,\"disOnTplt\":false,\"label\":null,\"message\":{},\"redirectPageName\":\"mobileDone\",\"redirectTemplateUrl\":\"vlcMobileConfirmation.html\",\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"data\":\"true\",\"field\":\"isJobStarted\"}]}},\"source\":\"apex/MultiServiceCPQRedirect?id=%groupCartId%&contextId=%contextId%&parentId=%parentId%&groupCart=true&applyToGroup=true&groupPageSize=%groupPageSize%&groupedServicePageSize=%groupedServicePageSize%\",\"ssm\":false,\"type\":\"URL\",\"validationRequired\":\"Submit\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Done Action",
                                "Name": "RedirectToMultiServiceCPQ",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__Element__c/RedirectToMultiServiceCPQ"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ApplyToGroup",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 4,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"multi-service-batch-error\",\"allowSaveForLater\":false,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"chartLabel\":null,\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"conditionType\":\"Hide if False\",\"disOnTplt\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"instruction\":\"\",\"instructionKey\":\"\",\"knowledgeOptions\":{\"dataCategoryCriteria\":\"\",\"keyword\":\"\",\"language\":\"English\",\"publishStatus\":\"Online\",\"remoteTimeout\":30000,\"typeFilter\":\"\"},\"label\":null,\"nextLabel\":\"Next\",\"nextWidth\":3,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{},\"remoteTimeout\":30000,\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"data\":\"false\",\"field\":\"isJobStarted\"}]}},\"showPersistentComponent\":[false,false],\"validationRequired\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Step",
                                "Name": "Error",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__Element__c/Error"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": false,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "English",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"allowCancel\":false,\"allowSaveForLater\":false,\"autoFocus\":false,\"autoSaveOnStepNext\":false,\"bLK\":false,\"cancelRedirectPageName\":\"OmniScriptCancelled\",\"cancelRedirectTemplateUrl\":\"vlcCancelled.html\",\"cancelSource\":\"%ContextId%\",\"cancelType\":\"SObject\",\"consoleTabIcon\":\"custom:custom18\",\"consoleTabLabel\":\"New\",\"consoleTabTitle\":null,\"currencyCode\":\"\",\"disableUnloadWarn\":true,\"elementTypeToHTMLTemplateMapping\":{},\"enableKnowledge\":false,\"errorMessage\":{\"custom\":[]},\"hideStepChart\":true,\"knowledgeArticleTypeQueryFieldsMap\":{},\"lkObjName\":null,\"message\":{},\"persistentComponent\":[{\"id\":\"vlcCart\",\"itemsKey\":\"cartItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"ModalProductCtrl\",\"modalHTMLTemplateId\":\"vlcProductConfig.html\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\"},{\"id\":\"vlcKnowledge\",\"itemsKey\":\"knowledgeItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"\",\"modalHTMLTemplateId\":\"\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false}],\"rtpSeed\":false,\"saveContentEncoded\":false,\"saveExpireInDays\":null,\"saveForLaterRedirectPageName\":\"sflRedirect\",\"saveForLaterRedirectTemplateUrl\":\"vlcSaveForLaterAcknowledge.html\",\"saveNameTemplate\":null,\"saveObjectId\":\"%ContextId%\",\"saveURLPatterns\":{},\"seedDataJSON\":{},\"showInputWidth\":false,\"ssm\":false,\"timeTracking\":false,\"trackingCustomData\":{},\"visualforcePagesAvailableInPreview\":{},\"wpm\":false}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "ApplyToGroup",
                        "%vlocity_namespace%__TestHTMLTemplates__c": "<style>\n.via-slds section.slds-page-header {\npadding: .75rem;\nborder: none;\nbox-shadow: none;\nbackground: #F4F6F9;\npadding-bottom: 2.5rem; }\n\n.via-slds .vlc-slds-right--panel {\n\ndisplay: none;\n}\n\n.via-slds .slds-progress-bar {\ndisplay: block;\nwidth: 100%;\nheight: 0.5rem;\nbackground: #dddbda;\nborder: 0;\n-webkit-appearance: none;\n-moz-appearance: none;\nappearance: none;\nposition: relative;\n}\n\n.via-slds .slds-progress-bar_x-small, .via-slds .slds-progress-bar--x-small {\nheight: 0.125rem; }\n\n.via-slds .slds-progress-bar_small, .via-slds .slds-progress-bar--small {\nheight: 0.25rem; }\n\n.via-slds .slds-progress-bar_medium, .via-slds .slds-progress-bar--medium {\nheight: 0.5rem; }\n\n.via-slds .slds-progress-bar_large, .via-slds .slds-progress-bar--large {\nheight: 0.75rem; }\n\n.via-slds .slds-progress-bar_circular, .via-slds .slds-progress-bar--circular {\nborder-radius: 0.5rem; }\n\n.via-slds .slds-progress-bar_circular .slds-progress-bar__value, .via-slds .slds-progress-bar--circular .slds-progress-bar__value {\nborder-radius: 0.5rem; }\n\n.via-slds .slds-progress-bar__value {\ndisplay: block;\nbackground: #ff6d00;\nheight: 100%; }\n\n.via-slds .slds-progress-bar__value_success {\nbackground: #4bca81; }\n\n.via-slds .slds-progress {\nposition: relative;\nmax-width: 70%;\n-ms-flex: 1 1 auto;\nflex: 1 1 auto;\nmargin: auto;\n}\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker {\nbackground: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker--icon, .via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker--icon {\nborder-color: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker {\nbox-shadow: #fafaf9 0 0 0 4px; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker:focus, .via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nbox-shadow: #fafaf9 0 0 0 4px, 0 0 3px 4px #0070d2; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker:focus, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker:focus {\nbackground: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item .slds-progress__marker {\nborder-color: #fafaf9; }\n\n.via-slds .slds-progress .slds-progress-bar {\nposition: absolute;\ntop: 50%;\nmargin-top: -0.0625rem;\nwidth: 98%;\nleft: 0.05rem; }\n\n.via-slds .slds-progress__list {\ndisplay: -ms-flexbox;\ndisplay: flex;\n-ms-flex-pack: justify;\njustify-content: space-between;\n-ms-flex-align: center;\nalign-items: center;\nmargin: auto;\nposition: relative;\nz-index: 1; }\n\n.via-slds .slds-progress__item {\ndisplay: -ms-inline-flexbox;\ndisplay: inline-flex;\n-ms-flex-item-align: center;\nalign-self: center;\n}\n\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker {\nbackground: white;\nborder-color: #1589ee; }\n\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker--icon {\nborder-color: white;\ncolor: #ff6d00; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker {\nbox-shadow: white 0 0 0 4px; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker:hover, .via-slds .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nborder-color: #0070d2; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nbox-shadow: white 0 0 0 4px, 0 0 3px 4px #0070d2; }\n\n.via-slds .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress__item.slds-has-error .slds-progress__marker:focus {\ncolor: #c23934;\nbackground: white;\nborder-color: transparent;\nbox-shadow: none; }\n\n.via-slds .slds-progress__item.slds-has-error .slds-progress__marker:focus {\nbox-shadow: 0 0 3px 0 #c23934; }\n\n.via-slds .slds-progress__marker {\nwidth: 1rem;\nheight: 1rem;\nposition: relative;\nborder-radius: 50%;\nbackground: #dddbda;\nborder: 4px solid white;\nvertical-align: middle;\n}\n\n.via-slds .slds-progress__marker_icon, .via-slds .slds-progress__marker--icon {\nwidth: auto;\nheight: auto; }\n\n.via-slds .slds-progress-ring {\nposition: relative;\ndisplay: inline-block;\nheight: 1.5rem;\nwidth: 1.5rem;\nborder-radius: 1.5rem;\nbackground: #dddbda; }\n\n.via-slds .slds-progress-ring .slds-icon_container {\nline-height: 0; }\n\n.via-slds .slds-progress-ring__progress {\ntransform: scale(-1, 1) rotate(-90deg); }\n\n.via-slds .slds-progress-ring__progress svg {\nwidth: 100%; }\n\n.via-slds .slds-progress-ring__path {\nfill: #ff6d00; }\n\n.via-slds .slds-progress-ring__content {\nposition: absolute;\ntop: 0.1875rem;\nright: 0.1875rem;\nbottom: 0.1875rem;\nleft: 0.1875rem;\ndisplay: -ms-flexbox;\ndisplay: flex;\n-ms-flex-align: center;\nalign-items: center;\n-ms-flex-pack: center;\njustify-content: center;\nborder-radius: 1.5rem;\nbackground: white; }\n\n.via-slds .slds-progress-ring__content .slds-icon {\nwidth: 0.75rem; }\n\n.via-slds .slds-progress-ring_warning .slds-progress-ring__content {\nbackground: white; }\n\n.via-slds .slds-progress-ring_warning .slds-icon,\n.via-slds .slds-progress-ring_warning .slds-progress-ring__path {\nfill: #ffb75d; }\n\n.via-slds .slds-progress-ring_expired .slds-progress-ring__content {\nbackground: white; }\n\n.via-slds .slds-progress-ring_expired .slds-icon,\n.via-slds .slds-progress-ring_expired .slds-progress-ring__path {\nfill: #d4504c; }\n\n.via-slds .slds-progress-ring_complete .slds-icon {\nfill: white; }\n\n.via-slds .slds-progress-ring_complete .slds-progress-ring__path {\nfill: #ff6d00; }\n\n.via-slds .slds-progress-ring_complete .slds-progress-ring__content {\nbackground: #ff6d00; }\n\n\n\n.via-slds section.slds-page-header {\nborder: none;\nbox-shadow: none;\nbackground: white; }\n\n.via-slds section.slds-page-header .slds-progress .slds-progress__list {\ntop: -1px; }\n\n.via-slds section.slds-page-header ol li button .slds-button__icon {\nwidth: .875rem;\nheight: .875rem;\nfill: #0070d2;\nposition: relative;\ntop: -.35rem; }\n\n.via-slds section.slds-page-header ol li.slds-has-error button .slds-button__icon {\ntop: -0.15rem;\nfill: currentColor;\nleft: -0.2rem;\nposition: absolute;\nbackground: white; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item {\ncursor: pointer;\noutline: none; }\n\n.via-slds section.slds-page-header ol li.slds-has-error .slds-button {\ntop: 0px !important; }\n\n.via-slds section.slds-page-header ol li.slds-has-error .slds-progress__item_label {\ntop: 1.5rem; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item .slds-progress__marker {\ntop: 1px;\nbox-shadow: unset; }\n\n.via-slds section.slds-page-header ol li.slds-is-completed .slds-button {\nborder: 0;\npadding: 0;\nmargin: 0px;\nposition: relative;\ntop: -2px; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item .slds-popover--tooltip {\ndisplay: none;\nleft: calc(-50% + 8px);\nmax-width: 30rem;\nwhite-space: nowrap;\ntop: 1.7rem; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item:hover .slds-popover--tooltip {\ndisplay: block; }\n\n.via-slds section.slds-page-header .slds-progress__step-label {\nleft: calc(-50% + 8px);\nmax-width: 30rem;\nwhite-space: nowrap; \nfont-size: .8125rem;\nfont-weight: 600;\nposition: relative;\ntop: 1rem;}\n\n</style>\n\n<script type=\"text/ng-template\" id=\"vlcSideBar.html\">\n\t<div class=\"vlc-slds-cart\" ng-if=\"bpTree.showPC\">\n\t<ng-include ng-repeat=\"vlcPC in ::bpTree.propSetMap.persistentComponent\"\n\tng-if='bpTree.showPCNew[vlcPC.pcIndex] && ($index === 0 )'\n\tid='{{::vlcPC.id}}'\n\tclass=\"slds-box\"\n\tsrc=\"::bpTree.dfHPSTmpl[vlcPC.pcIndex]\"/>\n\t</div>\n\t<div ng-include=\"'vlcStepChart.html'\" style=\"width: 100%;\"></div>\n</script>\n\n<script type=\"text/ng-template\" id=\"vlcStepChart.html\">\n\t<section class=\"slds-page-header slds-m-top_x-small\" ng-if=\"::!bpTree.propSetMap.hideStepChart\">\n\t\t<div class='slds-size_1-of-1'>\n\t\t\t<div class=\"slds-size_6-of-12 slds-align_absolute-center slds-grid\" >\n\t\t\t\t<div class=\"slds-size_1-of-1 slds-col_bump-right\" style=\"width: 100%;\">\n\t\t\t\t\t<div class=\"slds-progress slds-size_1-of-1\" ng-init=\"stepsCnt=[]\">\n\t\t\t\t\t\t<ol class=\"slds-progress__list\">\n\t\t\t\t\t\t<li class=\"slds-progress__item slds-is-relative\"\n\t\t\t\t\t\tng-class=\"{'slds-is-active': step.bAccordionActive, 'slds-is-completed' : (!step.bAccordionActive && step.completed), 'slds-has-error' : (!step.bAccordionActive && step.tInvalid && step.visited)}\"\n\t\t\t\t\t\tng-repeat=\"step in ::children\"\n\t\t\t\t\t\tng-if=\"step.type === 'Step' && step.show\"\n\t\t\t\t\t\tstate=\"{{step.bAccordionActive}}\"\n\t\t\t\t\t\tng-click=\"sidebarNav(step)\"\n\t\t\t\t\t\tng-init=\"stepsCnt.push(0)\"\n\t\t\t\t\t\tvlc-slds-step-styler>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"step.completed && !step.bAccordionActive\">\n\t\t\t\t\t\t\t\t<slds-svg-icon aria-hidden=\"true\"\n\t\t\t\t\t\t\t\tsprite=\"'utility'\"\n\t\t\t\t\t\t\t\ticon=\"'success'\"\n\t\t\t\t\t\t\t\tsize=\"'small'\"\n\t\t\t\t\t\t\t\textra-classes=\"'slds-button__icon'\">\n\t\t\t\t\t\t\t\t</slds-svg-icon>\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"!step.bAccordionActive && step.tInvalid && step.visited\">\n\t\t\t\t\t\t\t\t<slds-svg-icon aria-hidden=\"true\"\n\t\t\t\t\t\t\t\tsprite=\"'utility'\"\n\t\t\t\t\t\t\t\ticon=\"'warning'\"\n\t\t\t\t\t\t\t\tsize=\"'small'\"\n\t\t\t\t\t\t\t\textra-classes=\"'slds-button__icon'\">\n\t\t\t\t\t\t\t\t</slds-svg-icon>\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"step.bAccordionActive || (!step.bAccordionActive && !step.completed)\"\n\t\t\t\t\t\t\tng-hide=\"!step.bAccordionActive && step.tInvalid && step.visited\">\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<div ng-if=\"step.bAccordionActive\" class=\"slds-is-absolute\">\n\t\t\t\t\t\t\t\t<div class=\"slds-m-top_medium slds-is-relative slds-progress__step-label\">\n\t\t\t\t\t\t\t\t\t<div>{{step.propSetMap.label}}</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if=\"!step.bAccordionActive\" class=\"slds-is-absolute\" >\n\t\t\t\t\t\t\t\t<div class=\"slds-popover slds-popover--tooltip slds-nubbin--top\" role=\"tooltip\">\n\t\t\t\t\t\t\t\t\t<div class=\"slds-popover__body\">{{step.propSetMap.label}}</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</li>\n\t\t\t\t\t</ol>\n\t\t\t\t\t\t<div class=\"slds-progress-bar slds-progress-bar_x-small\" aria-valuemin=\"0\" aria-valuemax=\"100\" aria-valuenow=\"0\" role=\"progressbar\" ng-if=\"stepsCnt.length > 1\">\n\t\t\t\t\t\t\t<span class=\"slds-progress-bar__value\" ng-style=\"{'width':calculateProgressWidth(), 'background': '#5eb4ff'}\">\n\t\t\t\t\t\t\t<span class=\"slds-assistive-text\">Progress: 0%</span>\n\t\t\t\t\t\t\t</span>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t</section>\n</script>\n\n<script type=\"text/ng-template\" id=\"vlcSldsRightPanel.html\">\n\t<div class=\"vlc-slds-right--panel\" ng-if=\"::!bpTree.propSetMap.hideStepChart\">\n\t\t<div vlc-slds-step-chart map=\"StepChart\" ></div>\n\t\t<!-- knowledge component will go here -->\n\t\t<ng-include ng-repeat=\"vlcPC in ::bpTree.propSetMap.persistentComponent\"\n\t\tng-if='bpTree.showPCNew[vlcPC.pcIndex] && ($index === 1 )'\n\t\tid='{{::vlcPC.id}}'\n\t\tknowledge=\"true\"\n\t\tsrc=\"::bpTree.dfHPSTmpl[vlcPC.pcIndex]\"/>\n\t</div>\n</script>",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "ApplyToGroup",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_English/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/English"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_ApplyToGroup_English",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_ApplyToGroup_English",
            "VlocityDataPackName": "MultiService_ApplyToGroup_English",
            "VlocityDataPackParents": [
                "VlocityUITemplate/multi-service-batch-error"
            ],
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__CustomJavaScript__c": "{}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ApplyToGroup",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{\"contextId\":\"%contextId%\",\"groupCartId\":\"%groupCartId%\",\"grouptId\":\"%groupId%\",\"parentId\":\"%parentId%\"},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction1\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"applyToGroupChunk\",\"remoteOptions\":{},\"responseJSONNode\":\"response\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "ApplyToGroup",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_Procedure/%vlocity_namespace%__Element__c/ApplyToGroup"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_ApplyToGroup",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{}}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "ApplyToGroup",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "ApplyToGroup",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_ApplyToGroup_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ApplyToGroup/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_ApplyToGroup_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_ApplyToGroup_Procedure",
            "VlocityDataPackName": "MultiService_ApplyToGroup_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"elementValueMap\":{\"groupPageSize\":20,\"groupedServicePageSize\":20,\"unGroupedServicePageSize\":30},\"label\":\"SetPageSizeForServicePoints\",\"message\":{},\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Set Values",
                                "Name": "SetPageSizeForServicePoints",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/SetPageSizeForServicePoints"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"allowSaveForLater\":false,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"chartLabel\":\"Master Quote\",\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"conditionType\":\"Hide if False\",\"disOnTplt\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"instruction\":\"\",\"instructionKey\":\"\",\"knowledgeOptions\":{\"dataCategoryCriteria\":\"\",\"keyword\":\"\",\"language\":\"English\",\"publishStatus\":\"Online\",\"remoteTimeout\":30000,\"typeFilter\":\"\"},\"label\":\"Master Quote\",\"nextLabel\":\"Next\",\"nextWidth\":3,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{},\"remoteTimeout\":30000,\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"show\":null,\"showPersistentComponent\":[false,false],\"validationRequired\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Step",
                                "Name": "SelectMasterQuote",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/SelectMasterQuote"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 3,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"allowSaveForLater\":true,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"chartLabel\":\"Manage Group\",\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"conditionType\":\"Hide if False\",\"disOnTplt\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"instruction\":\"\",\"instructionKey\":\"\",\"knowledgeOptions\":{\"dataCategoryCriteria\":\"\",\"keyword\":\"\",\"language\":\"English\",\"publishStatus\":\"Online\",\"remoteTimeout\":30000,\"typeFilter\":\"\"},\"label\":\"Manage Group\",\"nextLabel\":\"Next\",\"nextWidth\":3,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{},\"remoteTimeout\":30000,\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"show\":null,\"showPersistentComponent\":[false,false],\"validationRequired\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Step",
                                "Name": "ManageGroup",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/ManageGroup"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 4,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"allowSaveForLater\":true,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"chartLabel\":\"CPQ\",\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"conditionType\":\"Hide if False\",\"disOnTplt\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"instruction\":\"\",\"instructionKey\":\"\",\"knowledgeOptions\":{\"dataCategoryCriteria\":\"\",\"keyword\":\"\",\"language\":\"English\",\"publishStatus\":\"Online\",\"remoteTimeout\":30000,\"typeFilter\":\"\"},\"label\":\"CPQ\",\"nextLabel\":\"Next\",\"nextWidth\":3,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{},\"remoteTimeout\":30000,\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"show\":null,\"showPersistentComponent\":[false,false],\"validationRequired\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Step",
                                "Name": "CPQ",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/CPQ"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 1,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": {
                                    "%vlocity_namespace%__OmniScriptId__c": {
                                        "Name": "MultiServiceCPQConfiguration",
                                        "VlocityDataPackType": "VlocityMatchingKeyObject",
                                        "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                    },
                                    "Name": "CPQ",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/CPQ",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c"
                                },
                                "%vlocity_namespace%__ParentElementName__c": "CPQ",
                                "%vlocity_namespace%__ParentElementType__c": "Step",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"dataJSON\":false,\"disOnTplt\":false,\"label\":\"MultiServiceCPQ\",\"show\":null,\"text\":\"<p><iframe id=\\\"multi-service\\\" style=\\\"margin-top: 0px; height: 83vh;\\\" src=\\\"apex/MultiServiceCPQRedirect?contextId=%masterQuoteId%&amp;parentId=%ContextId%&amp;redirectToFirstGroup=true&amp;groupPageSize=%groupPageSize%&amp;groupedServicePageSize=%groupedServicePageSize%\\\" name=\\\"multi-service-cpq\\\" width=\\\"100%\\\" height=\\\"150\\\" frameborder=\\\"0\\\" marginwidth=\\\"0\\\" marginheight=\\\"0\\\" align=\\\"top\\\"></iframe></p>\",\"textKey\":\"\"}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Text Block",
                                "Name": "MultiServiceCPQ",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/MultiServiceCPQ"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 1,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": {
                                    "%vlocity_namespace%__OmniScriptId__c": {
                                        "Name": "MultiServiceCPQConfiguration",
                                        "VlocityDataPackType": "VlocityMatchingKeyObject",
                                        "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                    },
                                    "Name": "ManageGroup",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/ManageGroup",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c"
                                },
                                "%vlocity_namespace%__ParentElementName__c": "ManageGroup",
                                "%vlocity_namespace%__ParentElementType__c": "Step",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"multiservice-manage-group\",\"accessibleInFutureSteps\":false,\"collapse\":false,\"conditionType\":\"Hide if False\",\"controlWidth\":12,\"disOnTplt\":false,\"hide\":false,\"label\":\"Manage Group\",\"repeat\":false,\"repeatClone\":false,\"repeatLimit\":null,\"show\":null}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Block",
                                "Name": "ManageGroupUI",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/ManageGroupUI"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 1,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "MultiServiceCPQConfiguration",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": {
                                    "%vlocity_namespace%__OmniScriptId__c": {
                                        "Name": "MultiServiceCPQConfiguration",
                                        "VlocityDataPackType": "VlocityMatchingKeyObject",
                                        "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English",
                                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                    },
                                    "Name": "SelectMasterQuote",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/SelectMasterQuote",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c"
                                },
                                "%vlocity_namespace%__ParentElementName__c": "SelectMasterQuote",
                                "%vlocity_namespace%__ParentElementType__c": "Step",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"multiservice-select-master-quote\",\"accessibleInFutureSteps\":false,\"disOnTplt\":false,\"label\":null,\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"show\":null}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Input Block",
                                "Name": "SelectMasterQuoteUI",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__Element__c/SelectMasterQuoteUI"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": false,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "English",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"allowCancel\":true,\"allowSaveForLater\":false,\"autoFocus\":false,\"autoSaveOnStepNext\":false,\"bLK\":false,\"cancelRedirectPageName\":\"OmniScriptCancelled\",\"cancelRedirectTemplateUrl\":\"vlcCancelled.html\",\"cancelSource\":\"%ContextId%\",\"cancelType\":\"SObject\",\"consoleTabIcon\":\"custom:custom18\",\"consoleTabLabel\":\"New\",\"consoleTabTitle\":null,\"currencyCode\":\"\",\"disableUnloadWarn\":true,\"elementTypeToHTMLTemplateMapping\":{},\"enableKnowledge\":false,\"errorMessage\":{\"custom\":[]},\"hideStepChart\":false,\"knowledgeArticleTypeQueryFieldsMap\":{},\"lkObjName\":null,\"message\":{},\"persistentComponent\":[{\"id\":\"vlcCart\",\"itemsKey\":\"cartItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"ModalProductCtrl\",\"modalHTMLTemplateId\":\"vlcProductConfig.html\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\"},{\"id\":\"vlcKnowledge\",\"itemsKey\":\"knowledgeItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"\",\"modalHTMLTemplateId\":\"\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false}],\"rtpSeed\":false,\"saveContentEncoded\":false,\"saveExpireInDays\":null,\"saveForLaterRedirectPageName\":\"sflRedirect\",\"saveForLaterRedirectTemplateUrl\":\"vlcSaveForLaterAcknowledge.html\",\"saveNameTemplate\":null,\"saveObjectId\":\"%ContextId%\",\"saveURLPatterns\":{},\"seedDataJSON\":{},\"showInputWidth\":false,\"ssm\":false,\"timeTracking\":false,\"trackingCustomData\":{},\"visualforcePagesAvailableInPreview\":{},\"wpm\":false}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "CPQConfiguration",
                        "%vlocity_namespace%__TestHTMLTemplates__c": "<style>\n.via-slds.via-omni  form[stepForm]{\n    margin: 0px;\n    padding: 0px;\n    border: none;\n }\n.via-slds.via-omni section#CPQ{\n    margin: 0px;\n    padding: 0px;\n    min-height: 90vh;\n    border: none;\n }\n.via-slds.via-omni form[stepForm] div.slds-m-top--medium.slds-m-bottom--medium{\n  margin-top: 0.5rem;\n margin-bottom: 0.5rem;\n}\n.via-slds.via-omni .vlc-slds-button--tertiary {\n  margin-bottom: 0px;\n}\n.via-slds.via-omni ng-form{\n   padding-right: 0px;\n}\n.via-slds.via-omni sidebar {\n    border-bottom: none;\n}\n.via-slds.via-omni #MultiServiceCPQ > label{\n   display: none;\n}\n.via-slds section.slds-page-header {\npadding: .75rem;\nborder: none;\nbox-shadow: none;\nbackground: #F4F6F9;\npadding-bottom: 2.5rem; }\n\n.via-slds .vlc-slds-right--panel {\n    display: none;\n}\n.via-slds.via-omni .vlc-slds-bpTree-step-chart__container {\n     margin-bottom: 0px;\n}\n\n.via-slds .slds-progress-bar {\ndisplay: block;\nwidth: 100%;\nheight: 0.5rem;\nbackground: #dddbda;\nborder: 0;\n-webkit-appearance: none;\n-moz-appearance: none;\nappearance: none;\nposition: relative;\n}\n\n.via-slds .slds-progress-bar_x-small, .via-slds .slds-progress-bar--x-small {\nheight: 0.125rem; }\n\n.via-slds .slds-progress-bar_small, .via-slds .slds-progress-bar--small {\nheight: 0.25rem; }\n\n.via-slds .slds-progress-bar_medium, .via-slds .slds-progress-bar--medium {\nheight: 0.5rem; }\n\n.via-slds .slds-progress-bar_large, .via-slds .slds-progress-bar--large {\nheight: 0.75rem; }\n\n.via-slds .slds-progress-bar_circular, .via-slds .slds-progress-bar--circular {\nborder-radius: 0.5rem; }\n\n.via-slds .slds-progress-bar_circular .slds-progress-bar__value, .via-slds .slds-progress-bar--circular .slds-progress-bar__value {\nborder-radius: 0.5rem; }\n\n.via-slds .slds-progress-bar__value {\ndisplay: block;\nbackground: #ff6d00;\nheight: 100%; }\n\n.via-slds .slds-progress-bar__value_success {\nbackground: #4bca81; }\n\n.via-slds .slds-progress {\nposition: relative;\nmax-width: 70%;\n-ms-flex: 1 1 auto;\nflex: 1 1 auto;\nmargin: auto;\n}\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker {\nbackground: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker--icon, .via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker--icon {\nborder-color: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker {\nbox-shadow: #fafaf9 0 0 0 4px; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker:focus, .via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nbox-shadow: #fafaf9 0 0 0 4px, 0 0 3px 4px #0070d2; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker:focus, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker:focus {\nbackground: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item .slds-progress__marker {\nborder-color: #fafaf9; }\n\n.via-slds .slds-progress .slds-progress-bar {\nposition: absolute;\ntop: 50%;\nmargin-top: -0.0625rem;\nwidth: 98%;\nleft: 0.05rem; }\n\n.via-slds .slds-progress__list {\ndisplay: -ms-flexbox;\ndisplay: flex;\n-ms-flex-pack: justify;\njustify-content: space-between;\n-ms-flex-align: center;\nalign-items: center;\nmargin: auto;\nposition: relative;\nz-index: 1; }\n\n.via-slds .slds-progress__item {\ndisplay: -ms-inline-flexbox;\ndisplay: inline-flex;\n-ms-flex-item-align: center;\nalign-self: center;\n}\n\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker {\nbackground: white;\nborder-color: #1589ee; }\n\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker--icon {\nborder-color: white;\ncolor: #ff6d00; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker {\nbox-shadow: white 0 0 0 4px; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker:hover, .via-slds .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nborder-color: #0070d2; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nbox-shadow: white 0 0 0 4px, 0 0 3px 4px #0070d2; }\n\n.via-slds .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress__item.slds-has-error .slds-progress__marker:focus {\ncolor: #c23934;\nbackground: white;\nborder-color: transparent;\nbox-shadow: none; }\n\n.via-slds .slds-progress__item.slds-has-error .slds-progress__marker:focus {\nbox-shadow: 0 0 3px 0 #c23934; }\n\n.via-slds .slds-progress__marker {\nwidth: 1rem;\nheight: 1rem;\nposition: relative;\nborder-radius: 50%;\nbackground: #dddbda;\nborder: 4px solid white;\nvertical-align: middle;\n}\n\n.via-slds .slds-progress__marker_icon, .via-slds .slds-progress__marker--icon {\nwidth: auto;\nheight: auto; }\n\n.via-slds .slds-progress-ring {\nposition: relative;\ndisplay: inline-block;\nheight: 1.5rem;\nwidth: 1.5rem;\nborder-radius: 1.5rem;\nbackground: #dddbda; }\n\n.via-slds .slds-progress-ring .slds-icon_container {\nline-height: 0; }\n\n.via-slds .slds-progress-ring__progress {\ntransform: scale(-1, 1) rotate(-90deg); }\n\n.via-slds .slds-progress-ring__progress svg {\nwidth: 100%; }\n\n.via-slds .slds-progress-ring__path {\nfill: #ff6d00; }\n\n.via-slds .slds-progress-ring__content {\nposition: absolute;\ntop: 0.1875rem;\nright: 0.1875rem;\nbottom: 0.1875rem;\nleft: 0.1875rem;\ndisplay: -ms-flexbox;\ndisplay: flex;\n-ms-flex-align: center;\nalign-items: center;\n-ms-flex-pack: center;\njustify-content: center;\nborder-radius: 1.5rem;\nbackground: white; }\n\n.via-slds .slds-progress-ring__content .slds-icon {\nwidth: 0.75rem; }\n\n.via-slds .slds-progress-ring_warning .slds-progress-ring__content {\nbackground: white; }\n\n.via-slds .slds-progress-ring_warning .slds-icon,\n.via-slds .slds-progress-ring_warning .slds-progress-ring__path {\nfill: #ffb75d; }\n\n.via-slds .slds-progress-ring_expired .slds-progress-ring__content {\nbackground: white; }\n\n.via-slds .slds-progress-ring_expired .slds-icon,\n.via-slds .slds-progress-ring_expired .slds-progress-ring__path {\nfill: #d4504c; }\n\n.via-slds .slds-progress-ring_complete .slds-icon {\nfill: white; }\n\n.via-slds .slds-progress-ring_complete .slds-progress-ring__path {\nfill: #ff6d00; }\n\n.via-slds .slds-progress-ring_complete .slds-progress-ring__content {\nbackground: #ff6d00; }\n\n\n\n.via-slds section.slds-page-header {\nborder: none;\nbox-shadow: none;\nbackground: white; }\n\n.via-slds section.slds-page-header .slds-progress .slds-progress__list {\ntop: -1px; }\n\n.via-slds section.slds-page-header ol li button .slds-button__icon {\nwidth: .875rem;\nheight: .875rem;\nfill: #0070d2;\nposition: relative;\ntop: -.35rem; }\n\n.via-slds section.slds-page-header ol li.slds-has-error button .slds-button__icon {\ntop: -0.15rem;\nfill: currentColor;\nleft: -0.2rem;\nposition: absolute;\nbackground: white; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item {\ncursor: pointer;\noutline: none; }\n\n.via-slds section.slds-page-header ol li.slds-has-error .slds-button {\ntop: 0px !important; }\n\n.via-slds section.slds-page-header ol li.slds-has-error .slds-progress__item_label {\ntop: 1.5rem; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item .slds-progress__marker {\ntop: 1px;\nbox-shadow: unset; }\n\n.via-slds section.slds-page-header ol li.slds-is-completed .slds-button {\nborder: 0;\npadding: 0;\nmargin: 0px;\nposition: relative;\ntop: -2px; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item .slds-popover--tooltip {\ndisplay: none;\nleft: calc(-50% + 8px);\nmax-width: 30rem;\nwhite-space: nowrap;\ntop: 1.7rem; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item:hover .slds-popover--tooltip {\ndisplay: block; }\n\n.via-slds section.slds-page-header .slds-progress__step-label {\nleft: calc(-50% + 8px);\nmax-width: 30rem;\nwhite-space: nowrap; \nfont-size: .8125rem;\nfont-weight: 600;\nposition: relative;\ntop: 1rem;}\n\n</style>\n\n<script type=\"text/ng-template\" id=\"vlcSideBar.html\">\n\t<div class=\"vlc-slds-cart\" ng-if=\"bpTree.showPC\">\n\t<ng-include ng-repeat=\"vlcPC in ::bpTree.propSetMap.persistentComponent\"\n\tng-if='bpTree.showPCNew[vlcPC.pcIndex] && ($index === 0 )'\n\tid='{{::vlcPC.id}}'\n\tclass=\"slds-box\"\n\tsrc=\"::bpTree.dfHPSTmpl[vlcPC.pcIndex]\"/>\n\t</div>\n\t<div ng-include=\"'vlcStepChart.html'\" style=\"width: 100%;\"></div>\n</script>\n\n<script type=\"text/ng-template\" id=\"vlcStepChart.html\">\n\t<section class=\"slds-page-header slds-m-top_x-small\" ng-if=\"::!bpTree.propSetMap.hideStepChart\">\n\t\t<div class='slds-size_1-of-1'>\n\t\t\t<div class=\"slds-size_6-of-12 slds-align_absolute-center slds-grid\" >\n\t\t\t\t<div class=\"slds-size_1-of-1 slds-col_bump-right\" style=\"width: 100%;\">\n\t\t\t\t\t<div class=\"slds-progress slds-size_1-of-1\" ng-init=\"stepsCnt=[]\">\n\t\t\t\t\t\t<ol class=\"slds-progress__list\">\n\t\t\t\t\t\t<li class=\"slds-progress__item slds-is-relative\"\n\t\t\t\t\t\tng-class=\"{'slds-is-active': step.bAccordionActive, 'slds-is-completed' : (!step.bAccordionActive && step.completed), 'slds-has-error' : (!step.bAccordionActive && step.tInvalid && step.visited)}\"\n\t\t\t\t\t\tng-repeat=\"step in ::children\"\n\t\t\t\t\t\tng-if=\"step.type === 'Step' && step.show\"\n\t\t\t\t\t\tstate=\"{{step.bAccordionActive}}\"\n\t\t\t\t\t\tng-click=\"sidebarNav(step)\"\n\t\t\t\t\t\tng-init=\"stepsCnt.push(0)\"\n\t\t\t\t\t\tvlc-slds-step-styler>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"step.completed && !step.bAccordionActive\">\n\t\t\t\t\t\t\t\t<slds-svg-icon aria-hidden=\"true\"\n\t\t\t\t\t\t\t\tsprite=\"'utility'\"\n\t\t\t\t\t\t\t\ticon=\"'success'\"\n\t\t\t\t\t\t\t\tsize=\"'small'\"\n\t\t\t\t\t\t\t\textra-classes=\"'slds-button__icon'\">\n\t\t\t\t\t\t\t\t</slds-svg-icon>\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"!step.bAccordionActive && step.tInvalid && step.visited\">\n\t\t\t\t\t\t\t\t<slds-svg-icon aria-hidden=\"true\"\n\t\t\t\t\t\t\t\tsprite=\"'utility'\"\n\t\t\t\t\t\t\t\ticon=\"'warning'\"\n\t\t\t\t\t\t\t\tsize=\"'small'\"\n\t\t\t\t\t\t\t\textra-classes=\"'slds-button__icon'\">\n\t\t\t\t\t\t\t\t</slds-svg-icon>\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"step.bAccordionActive || (!step.bAccordionActive && !step.completed)\"\n\t\t\t\t\t\t\tng-hide=\"!step.bAccordionActive && step.tInvalid && step.visited\">\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<div ng-if=\"step.bAccordionActive\" class=\"slds-is-absolute\">\n\t\t\t\t\t\t\t\t<div class=\"slds-m-top_medium slds-is-relative slds-progress__step-label\">\n\t\t\t\t\t\t\t\t\t<div>{{step.propSetMap.label}}</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if=\"!step.bAccordionActive\" class=\"slds-is-absolute\" >\n\t\t\t\t\t\t\t\t<div class=\"slds-popover slds-popover--tooltip slds-nubbin--top\" role=\"tooltip\">\n\t\t\t\t\t\t\t\t\t<div class=\"slds-popover__body\">{{step.propSetMap.label}}</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</li>\n\t\t\t\t\t</ol>\n\t\t\t\t\t\t<div class=\"slds-progress-bar slds-progress-bar_x-small\" aria-valuemin=\"0\" aria-valuemax=\"100\" aria-valuenow=\"0\" role=\"progressbar\" ng-if=\"stepsCnt.length > 1\">\n\t\t\t\t\t\t\t<span class=\"slds-progress-bar__value\" ng-style=\"{'width':calculateProgressWidth(), 'background': '#5eb4ff'}\">\n\t\t\t\t\t\t\t<span class=\"slds-assistive-text\">Progress: 0%</span>\n\t\t\t\t\t\t\t</span>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t</section>\n</script>\n\n<script type=\"text/ng-template\" id=\"vlcSldsRightPanel.html\">\n\t<div class=\"vlc-slds-right--panel\" ng-if=\"::!bpTree.propSetMap.hideStepChart\">\n\t\t<div vlc-slds-step-chart map=\"StepChart\" ></div>\n\t\t<!-- knowledge component will go here -->\n\t\t<ng-include ng-repeat=\"vlcPC in ::bpTree.propSetMap.persistentComponent\"\n\t\tng-if='bpTree.showPCNew[vlcPC.pcIndex] && ($index === 1 )'\n\t\tid='{{::vlcPC.id}}'\n\t\tknowledge=\"true\"\n\t\tsrc=\"::bpTree.dfHPSTmpl[vlcPC.pcIndex]\"/>\n\t</div>\n</script>",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "MultiServiceCPQConfiguration",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_CPQConfiguration_English/%vlocity_namespace%__OmniScript__c/MultiService/CPQConfiguration/English"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_CPQConfiguration_English",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_CPQConfiguration_English",
            "VlocityDataPackName": "MultiService_CPQConfiguration_English",
            "VlocityDataPackParents": [
                "VlocityUITemplate/multiservice-manage-group",
                "VlocityUITemplate/multiservice-select-master-quote"
            ],
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Checkout",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"elementValueMap\":{\"BatchSize\":1,\"CheckoutIPName\":\"MultiService_Checkout\"},\"label\":\"SetCheckoutIPName\",\"message\":{},\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Set Values",
                                "Name": "SetCheckoutIPName",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__Element__c/SetCheckoutIPName"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Checkout",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"enableDefaultAbort\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"extraPayload\":{},\"failureAbortLabel\":\"Abort\",\"failureAbortMessage\":\"Are you sure?\",\"failureGoBackLabel\":\"Go Back\",\"failureNextLabel\":\"Continue\",\"inProgressMessage\":\"In Progress\",\"label\":\"CreateOrderAndSubmit\",\"message\":{},\"postMessage\":\"Done\",\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"redirectNextLabel\":\"Next\",\"redirectNextWidth\":3,\"redirectPageName\":\"\",\"redirectPreviousLabel\":\"Previous\",\"redirectPreviousWidth\":3,\"redirectTemplateUrl\":\"vlcAcknowledge.html\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"createOrderAndSubmit\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"svgIcon\":\"\",\"svgSprite\":\"\",\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "CreateOrderAndSubmit",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__Element__c/CreateOrderAndSubmit"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Checkout",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 3,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"multiservice-account-redirect\",\"allowSaveForLater\":true,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"chartLabel\":null,\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"conditionType\":\"Hide if False\",\"disOnTplt\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"instruction\":\"\",\"instructionKey\":\"\",\"knowledgeOptions\":{\"dataCategoryCriteria\":\"\",\"keyword\":\"\",\"language\":\"English\",\"publishStatus\":\"Online\",\"remoteTimeout\":30000,\"typeFilter\":\"\"},\"label\":\"Redirect\",\"nextLabel\":\"Next\",\"nextWidth\":3,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{},\"remoteTimeout\":30000,\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"show\":null,\"showPersistentComponent\":[false,false],\"validationRequired\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Step",
                                "Name": "Redirect",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__Element__c/Redirect"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": false,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "English",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"allowCancel\":true,\"allowSaveForLater\":true,\"autoFocus\":false,\"autoSaveOnStepNext\":false,\"bLK\":false,\"cancelRedirectPageName\":\"OmniScriptCancelled\",\"cancelRedirectTemplateUrl\":\"vlcCancelled.html\",\"cancelSource\":\"%ContextId%\",\"cancelType\":\"SObject\",\"consoleTabIcon\":\"custom:custom18\",\"consoleTabLabel\":\"New\",\"consoleTabTitle\":null,\"currencyCode\":\"\",\"disableUnloadWarn\":true,\"elementTypeToHTMLTemplateMapping\":{},\"enableKnowledge\":false,\"errorMessage\":{\"custom\":[]},\"hideStepChart\":true,\"knowledgeArticleTypeQueryFieldsMap\":{},\"lkObjName\":null,\"message\":{},\"persistentComponent\":[{\"id\":\"vlcCart\",\"itemsKey\":\"cartItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"ModalProductCtrl\",\"modalHTMLTemplateId\":\"vlcProductConfig.html\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\"},{\"id\":\"vlcKnowledge\",\"itemsKey\":\"knowledgeItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"\",\"modalHTMLTemplateId\":\"\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false}],\"rtpSeed\":false,\"saveContentEncoded\":false,\"saveExpireInDays\":null,\"saveForLaterRedirectPageName\":\"sflRedirect\",\"saveForLaterRedirectTemplateUrl\":\"vlcSaveForLaterAcknowledge.html\",\"saveNameTemplate\":null,\"saveObjectId\":\"%ContextId%\",\"saveURLPatterns\":{},\"seedDataJSON\":{},\"showInputWidth\":false,\"ssm\":false,\"timeTracking\":false,\"trackingCustomData\":{},\"visualforcePagesAvailableInPreview\":{},\"wpm\":false}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "Checkout",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "Checkout",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_English/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/English"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_Checkout_English",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_Checkout_English",
            "VlocityDataPackName": "MultiService_Checkout_English",
            "VlocityDataPackParents": [
                "VlocityUITemplate/multiservice-account-redirect"
            ],
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__CustomJavaScript__c": "{}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Checkout",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_Checkout_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{\"ContextId\":\"%Id%\",\"cartId\":\"%Id%\"},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction1\",\"remoteClass\":\"CpqAppHandler\",\"remoteMethod\":\"checkout\",\"remoteOptions\":{},\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "CreateOrder",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_Procedure/%vlocity_namespace%__Element__c/CreateOrder"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Checkout",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_Checkout_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{\"ContextId\":\"%CreateOrder:records|1:id%\",\"cartId\":\"%CreateOrder:records|1:id%\"},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction2\",\"remoteClass\":\"CpqAppHandler\",\"remoteMethod\":\"checkout\",\"remoteOptions\":{},\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "SubmitOrder",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_Procedure/%vlocity_namespace%__Element__c/SubmitOrder"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_Checkout",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{}}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "Checkout",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "Checkout",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_Checkout_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/Checkout/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_Checkout_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_Checkout_Procedure",
            "VlocityDataPackName": "MultiService_Checkout_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "This VIP is responsible for getting external pricing and updating into system.",
                        "%vlocity_namespace%__CustomJavaScript__c": "{}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__LwcId__c": "552d610c-87d9-1d25-8e9f-30c4f32017e4",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_GetExternalPricing",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableActualTimeLimit\":null,\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"queueableChainableCpuLimit\":40000,\"queueableChainableHeapSizeLimit\":6,\"queueableChainableQueriesLimit\":120,\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{},\"ttlMinutes\":5}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "GetExternalPricing",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "Get External Pricing",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_GetExternalPricing_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/GetExternalPricing/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_GetExternalPricing_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_GetExternalPricing_Procedure",
            "VlocityDataPackName": "MultiService_GetExternalPricing_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__CustomJavaScript__c": "{}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "GroupRollups",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_GroupRollups_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/GroupRollups/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction1\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"groupRollup\",\"remoteOptions\":{},\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "GroupRollup",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_GroupRollups_Procedure/%vlocity_namespace%__Element__c/GroupRollup"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_GroupRollups",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{}}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "GroupRollups",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "GroupRollups",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_GroupRollups_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/GroupRollups/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_GroupRollups_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_GroupRollups_Procedure",
            "VlocityDataPackName": "MultiService_GroupRollups_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "PriceAndValidate",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__OmniScript__c/MultiService/PriceAndValidate/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"elementValueMap\":{\"BatchSize\":1,\"GroupRollupIPName\":\"MultiService_GroupRollups\",\"ValidateAndPriceIPName\":\"MultiService_ValidateAndPrice\",\"ValidateAndUpdateExternalPricingStatusIPName\":\"MultiService_ValidateAndUpdateExternalPricingStatus\"},\"label\":\"Set Integration Procedure Name\",\"message\":{},\"pubsub\":false,\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Set Values",
                                "Name": "SetIPName",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__Element__c/SetIPName"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "PriceAndValidate",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__OmniScript__c/MultiService/PriceAndValidate/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"controlWidth\":12,\"disOnTplt\":false,\"enableDefaultAbort\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"extraPayload\":{},\"failureAbortLabel\":\"Abort\",\"failureAbortMessage\":\"Are you sure?\",\"failureGoBackLabel\":\"Go Back\",\"failureNextLabel\":\"Continue\",\"inProgressMessage\":\"In Progress\",\"label\":\"PriceAndValidate\",\"message\":{},\"postMessage\":\"Done\",\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"redirectNextLabel\":\"Next\",\"redirectNextWidth\":3,\"redirectPageName\":\"\",\"redirectPreviousLabel\":\"Previous\",\"redirectPreviousWidth\":3,\"redirectTemplateUrl\":\"vlcAcknowledge.html\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"priceAndValidate\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"show\":null,\"showPersistentComponent\":[false,false],\"ssm\":false,\"svgIcon\":\"\",\"svgSprite\":\"\",\"validationRequired\":\"Step\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "PriceAndValidate",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__Element__c/PriceAndValidate"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "PriceAndValidate",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__OmniScript__c/MultiService/PriceAndValidate/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 3,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"\",\"Outcome\":\"\",\"consoleTabLabel\":\"New\",\"controlWidth\":12,\"disOnTplt\":false,\"label\":null,\"message\":{},\"redirectPageName\":\"mobileDone\",\"redirectTemplateUrl\":\"vlcMobileConfirmation.html\",\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"data\":\"true\",\"field\":\"isJobStarted\"}]}},\"source\":\"apex/MultiServiceCPQRedirect?id=%ContextId%&contextId=%contextId%&parentId=%parentId%&groupCart=true&priceValidate=true&groupPageSize=%groupPageSize%&groupedServicePageSize=%groupedServicePageSize%\",\"ssm\":false,\"type\":\"URL\",\"validationRequired\":\"Submit\",\"wpm\":false}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Done Action",
                                "Name": "RedirectToMultiServiceCPQ",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__Element__c/RedirectToMultiServiceCPQ"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "PriceAndValidate",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__OmniScript__c/MultiService/PriceAndValidate/English",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 4,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"HTMLTemplateId\":\"multi-service-batch-error\",\"allowSaveForLater\":false,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"chartLabel\":null,\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"conditionType\":\"Hide if False\",\"disOnTplt\":false,\"errorMessage\":{\"custom\":[],\"default\":null},\"instruction\":\"\",\"instructionKey\":\"\",\"knowledgeOptions\":{\"dataCategoryCriteria\":\"\",\"keyword\":\"\",\"language\":\"English\",\"publishStatus\":\"Online\",\"remoteTimeout\":30000,\"typeFilter\":\"\"},\"label\":null,\"nextLabel\":\"Next\",\"nextWidth\":3,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{},\"remoteTimeout\":30000,\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"data\":\"false\",\"field\":\"isJobStarted\"}]}},\"showPersistentComponent\":[false,false],\"validationRequired\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Step",
                                "Name": "Error",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__Element__c/Error"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": false,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "English",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"allowCancel\":true,\"allowSaveForLater\":true,\"autoFocus\":false,\"autoSaveOnStepNext\":false,\"bLK\":false,\"cancelRedirectPageName\":\"OmniScriptCancelled\",\"cancelRedirectTemplateUrl\":\"vlcCancelled.html\",\"cancelSource\":\"%ContextId%\",\"cancelType\":\"SObject\",\"consoleTabIcon\":\"custom:custom18\",\"consoleTabLabel\":\"New\",\"consoleTabTitle\":null,\"currencyCode\":\"\",\"disableUnloadWarn\":true,\"elementTypeToHTMLTemplateMapping\":{},\"enableKnowledge\":false,\"errorMessage\":{\"custom\":[]},\"hideStepChart\":false,\"knowledgeArticleTypeQueryFieldsMap\":{},\"lkObjName\":null,\"message\":{},\"persistentComponent\":[{\"id\":\"vlcCart\",\"itemsKey\":\"cartItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"ModalProductCtrl\",\"modalHTMLTemplateId\":\"vlcProductConfig.html\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false,\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"sendJSONNode\":\"\",\"sendJSONPath\":\"\"},{\"id\":\"vlcKnowledge\",\"itemsKey\":\"knowledgeItems\",\"label\":\"\",\"modalConfigurationSetting\":{\"modalController\":\"\",\"modalHTMLTemplateId\":\"\",\"modalSize\":\"lg\"},\"postTransformBundle\":\"\",\"preTransformBundle\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"postTransformBundle\":\"\",\"preTransformBundle\":\"\"},\"remoteTimeout\":30000,\"render\":false}],\"rtpSeed\":false,\"saveContentEncoded\":false,\"saveExpireInDays\":null,\"saveForLaterRedirectPageName\":\"sflRedirect\",\"saveForLaterRedirectTemplateUrl\":\"vlcSaveForLaterAcknowledge.html\",\"saveNameTemplate\":null,\"saveObjectId\":\"%ContextId%\",\"saveURLPatterns\":{},\"seedDataJSON\":{},\"showInputWidth\":false,\"ssm\":false,\"timeTracking\":false,\"trackingCustomData\":{},\"visualforcePagesAvailableInPreview\":{},\"wpm\":false}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "PriceAndValidate",
                        "%vlocity_namespace%__TestHTMLTemplates__c": "<style>\n.via-slds section.slds-page-header {\npadding: .75rem;\nborder: none;\nbox-shadow: none;\nbackground: #F4F6F9;\npadding-bottom: 2.5rem; }\n\n.via-slds .vlc-slds-right--panel {\n\ndisplay: none;\n}\n\n.via-slds .slds-progress-bar {\ndisplay: block;\nwidth: 100%;\nheight: 0.5rem;\nbackground: #dddbda;\nborder: 0;\n-webkit-appearance: none;\n-moz-appearance: none;\nappearance: none;\nposition: relative;\n}\n\n.via-slds .slds-progress-bar_x-small, .via-slds .slds-progress-bar--x-small {\nheight: 0.125rem; }\n\n.via-slds .slds-progress-bar_small, .via-slds .slds-progress-bar--small {\nheight: 0.25rem; }\n\n.via-slds .slds-progress-bar_medium, .via-slds .slds-progress-bar--medium {\nheight: 0.5rem; }\n\n.via-slds .slds-progress-bar_large, .via-slds .slds-progress-bar--large {\nheight: 0.75rem; }\n\n.via-slds .slds-progress-bar_circular, .via-slds .slds-progress-bar--circular {\nborder-radius: 0.5rem; }\n\n.via-slds .slds-progress-bar_circular .slds-progress-bar__value, .via-slds .slds-progress-bar--circular .slds-progress-bar__value {\nborder-radius: 0.5rem; }\n\n.via-slds .slds-progress-bar__value {\ndisplay: block;\nbackground: #ff6d00;\nheight: 100%; }\n\n.via-slds .slds-progress-bar__value_success {\nbackground: #4bca81; }\n\n.via-slds .slds-progress {\nposition: relative;\nmax-width: 70%;\n-ms-flex: 1 1 auto;\nflex: 1 1 auto;\nmargin: auto;\n}\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker {\nbackground: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-completed .slds-progress__marker--icon, .via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress--shade .slds-progress__item.slds-is-completed .slds-progress__marker--icon {\nborder-color: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker {\nbox-shadow: #fafaf9 0 0 0 4px; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-is-active .slds-progress__marker:focus, .via-slds .slds-progress--shade .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nbox-shadow: #fafaf9 0 0 0 4px, 0 0 3px 4px #0070d2; }\n\n.via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress_shade .slds-progress__item.slds-has-error .slds-progress__marker:focus, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress--shade .slds-progress__item.slds-has-error .slds-progress__marker:focus {\nbackground: #fafaf9; }\n\n.via-slds .slds-progress_shade .slds-progress__item .slds-progress__marker, .via-slds .slds-progress--shade .slds-progress__item .slds-progress__marker {\nborder-color: #fafaf9; }\n\n.via-slds .slds-progress .slds-progress-bar {\nposition: absolute;\ntop: 50%;\nmargin-top: -0.0625rem;\nwidth: 98%;\nleft: 0.05rem; }\n\n.via-slds .slds-progress__list {\ndisplay: -ms-flexbox;\ndisplay: flex;\n-ms-flex-pack: justify;\njustify-content: space-between;\n-ms-flex-align: center;\nalign-items: center;\nmargin: auto;\nposition: relative;\nz-index: 1; }\n\n.via-slds .slds-progress__item {\ndisplay: -ms-inline-flexbox;\ndisplay: inline-flex;\n-ms-flex-item-align: center;\nalign-self: center;\n}\n\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker,\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker {\nbackground: white;\nborder-color: #1589ee; }\n\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker_icon,\n.via-slds .slds-progress__item.slds-is-completed .slds-progress__marker--icon {\nborder-color: white;\ncolor: #ff6d00; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker {\nbox-shadow: white 0 0 0 4px; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker:hover, .via-slds .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nborder-color: #0070d2; }\n\n.via-slds .slds-progress__item.slds-is-active .slds-progress__marker:focus {\nbox-shadow: white 0 0 0 4px, 0 0 3px 4px #0070d2; }\n\n.via-slds .slds-progress__item.slds-has-error .slds-progress__marker, .via-slds .slds-progress__item.slds-has-error .slds-progress__marker:hover, .via-slds .slds-progress__item.slds-has-error .slds-progress__marker:focus {\ncolor: #c23934;\nbackground: white;\nborder-color: transparent;\nbox-shadow: none; }\n\n.via-slds .slds-progress__item.slds-has-error .slds-progress__marker:focus {\nbox-shadow: 0 0 3px 0 #c23934; }\n\n.via-slds .slds-progress__marker {\nwidth: 1rem;\nheight: 1rem;\nposition: relative;\nborder-radius: 50%;\nbackground: #dddbda;\nborder: 4px solid white;\nvertical-align: middle;\n}\n\n.via-slds .slds-progress__marker_icon, .via-slds .slds-progress__marker--icon {\nwidth: auto;\nheight: auto; }\n\n.via-slds .slds-progress-ring {\nposition: relative;\ndisplay: inline-block;\nheight: 1.5rem;\nwidth: 1.5rem;\nborder-radius: 1.5rem;\nbackground: #dddbda; }\n\n.via-slds .slds-progress-ring .slds-icon_container {\nline-height: 0; }\n\n.via-slds .slds-progress-ring__progress {\ntransform: scale(-1, 1) rotate(-90deg); }\n\n.via-slds .slds-progress-ring__progress svg {\nwidth: 100%; }\n\n.via-slds .slds-progress-ring__path {\nfill: #ff6d00; }\n\n.via-slds .slds-progress-ring__content {\nposition: absolute;\ntop: 0.1875rem;\nright: 0.1875rem;\nbottom: 0.1875rem;\nleft: 0.1875rem;\ndisplay: -ms-flexbox;\ndisplay: flex;\n-ms-flex-align: center;\nalign-items: center;\n-ms-flex-pack: center;\njustify-content: center;\nborder-radius: 1.5rem;\nbackground: white; }\n\n.via-slds .slds-progress-ring__content .slds-icon {\nwidth: 0.75rem; }\n\n.via-slds .slds-progress-ring_warning .slds-progress-ring__content {\nbackground: white; }\n\n.via-slds .slds-progress-ring_warning .slds-icon,\n.via-slds .slds-progress-ring_warning .slds-progress-ring__path {\nfill: #ffb75d; }\n\n.via-slds .slds-progress-ring_expired .slds-progress-ring__content {\nbackground: white; }\n\n.via-slds .slds-progress-ring_expired .slds-icon,\n.via-slds .slds-progress-ring_expired .slds-progress-ring__path {\nfill: #d4504c; }\n\n.via-slds .slds-progress-ring_complete .slds-icon {\nfill: white; }\n\n.via-slds .slds-progress-ring_complete .slds-progress-ring__path {\nfill: #ff6d00; }\n\n.via-slds .slds-progress-ring_complete .slds-progress-ring__content {\nbackground: #ff6d00; }\n\n\n\n.via-slds section.slds-page-header {\nborder: none;\nbox-shadow: none;\nbackground: white; }\n\n.via-slds section.slds-page-header .slds-progress .slds-progress__list {\ntop: -1px; }\n\n.via-slds section.slds-page-header ol li button .slds-button__icon {\nwidth: .875rem;\nheight: .875rem;\nfill: #0070d2;\nposition: relative;\ntop: -.35rem; }\n\n.via-slds section.slds-page-header ol li.slds-has-error button .slds-button__icon {\ntop: -0.15rem;\nfill: currentColor;\nleft: -0.2rem;\nposition: absolute;\nbackground: white; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item {\ncursor: pointer;\noutline: none; }\n\n.via-slds section.slds-page-header ol li.slds-has-error .slds-button {\ntop: 0px !important; }\n\n.via-slds section.slds-page-header ol li.slds-has-error .slds-progress__item_label {\ntop: 1.5rem; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item .slds-progress__marker {\ntop: 1px;\nbox-shadow: unset; }\n\n.via-slds section.slds-page-header ol li.slds-is-completed .slds-button {\nborder: 0;\npadding: 0;\nmargin: 0px;\nposition: relative;\ntop: -2px; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item .slds-popover--tooltip {\ndisplay: none;\nleft: calc(-50% + 8px);\nmax-width: 30rem;\nwhite-space: nowrap;\ntop: 1.7rem; }\n\n.via-slds section.slds-page-header ol li.slds-progress__item:hover .slds-popover--tooltip {\ndisplay: block; }\n\n.via-slds section.slds-page-header .slds-progress__step-label {\nleft: calc(-50% + 8px);\nmax-width: 30rem;\nwhite-space: nowrap; \nfont-size: .8125rem;\nfont-weight: 600;\nposition: relative;\ntop: 1rem;}\n\n</style>\n\n<script type=\"text/ng-template\" id=\"vlcSideBar.html\">\n\t<div class=\"vlc-slds-cart\" ng-if=\"bpTree.showPC\">\n\t<ng-include ng-repeat=\"vlcPC in ::bpTree.propSetMap.persistentComponent\"\n\tng-if='bpTree.showPCNew[vlcPC.pcIndex] && ($index === 0 )'\n\tid='{{::vlcPC.id}}'\n\tclass=\"slds-box\"\n\tsrc=\"::bpTree.dfHPSTmpl[vlcPC.pcIndex]\"/>\n\t</div>\n\t<div ng-include=\"'vlcStepChart.html'\" style=\"width: 100%;\"></div>\n</script>\n\n<script type=\"text/ng-template\" id=\"vlcStepChart.html\">\n\t<section class=\"slds-page-header slds-m-top_x-small\" ng-if=\"::!bpTree.propSetMap.hideStepChart\">\n\t\t<div class='slds-size_1-of-1'>\n\t\t\t<div class=\"slds-size_6-of-12 slds-align_absolute-center slds-grid\" >\n\t\t\t\t<div class=\"slds-size_1-of-1 slds-col_bump-right\" style=\"width: 100%;\">\n\t\t\t\t\t<div class=\"slds-progress slds-size_1-of-1\" ng-init=\"stepsCnt=[]\">\n\t\t\t\t\t\t<ol class=\"slds-progress__list\">\n\t\t\t\t\t\t<li class=\"slds-progress__item slds-is-relative\"\n\t\t\t\t\t\tng-class=\"{'slds-is-active': step.bAccordionActive, 'slds-is-completed' : (!step.bAccordionActive && step.completed), 'slds-has-error' : (!step.bAccordionActive && step.tInvalid && step.visited)}\"\n\t\t\t\t\t\tng-repeat=\"step in ::children\"\n\t\t\t\t\t\tng-if=\"step.type === 'Step' && step.show\"\n\t\t\t\t\t\tstate=\"{{step.bAccordionActive}}\"\n\t\t\t\t\t\tng-click=\"sidebarNav(step)\"\n\t\t\t\t\t\tng-init=\"stepsCnt.push(0)\"\n\t\t\t\t\t\tvlc-slds-step-styler>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"step.completed && !step.bAccordionActive\">\n\t\t\t\t\t\t\t\t<slds-svg-icon aria-hidden=\"true\"\n\t\t\t\t\t\t\t\tsprite=\"'utility'\"\n\t\t\t\t\t\t\t\ticon=\"'success'\"\n\t\t\t\t\t\t\t\tsize=\"'small'\"\n\t\t\t\t\t\t\t\textra-classes=\"'slds-button__icon'\">\n\t\t\t\t\t\t\t\t</slds-svg-icon>\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"!step.bAccordionActive && step.tInvalid && step.visited\">\n\t\t\t\t\t\t\t\t<slds-svg-icon aria-hidden=\"true\"\n\t\t\t\t\t\t\t\tsprite=\"'utility'\"\n\t\t\t\t\t\t\t\ticon=\"'warning'\"\n\t\t\t\t\t\t\t\tsize=\"'small'\"\n\t\t\t\t\t\t\t\textra-classes=\"'slds-button__icon'\">\n\t\t\t\t\t\t\t\t</slds-svg-icon>\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<button class=\"slds-button slds-progress__marker\" ng-if=\"step.bAccordionActive || (!step.bAccordionActive && !step.completed)\"\n\t\t\t\t\t\t\tng-hide=\"!step.bAccordionActive && step.tInvalid && step.visited\">\n\t\t\t\t\t\t\t</button>\n\t\t\t\t\t\t\t<div ng-if=\"step.bAccordionActive\" class=\"slds-is-absolute\">\n\t\t\t\t\t\t\t\t<div class=\"slds-m-top_medium slds-is-relative slds-progress__step-label\">\n\t\t\t\t\t\t\t\t\t<div>{{step.propSetMap.label}}</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div ng-if=\"!step.bAccordionActive\" class=\"slds-is-absolute\" >\n\t\t\t\t\t\t\t\t<div class=\"slds-popover slds-popover--tooltip slds-nubbin--top\" role=\"tooltip\">\n\t\t\t\t\t\t\t\t\t<div class=\"slds-popover__body\">{{step.propSetMap.label}}</div>\n\t\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</li>\n\t\t\t\t\t</ol>\n\t\t\t\t\t\t<div class=\"slds-progress-bar slds-progress-bar_x-small\" aria-valuemin=\"0\" aria-valuemax=\"100\" aria-valuenow=\"0\" role=\"progressbar\" ng-if=\"stepsCnt.length > 1\">\n\t\t\t\t\t\t\t<span class=\"slds-progress-bar__value\" ng-style=\"{'width':calculateProgressWidth(), 'background': '#5eb4ff'}\">\n\t\t\t\t\t\t\t<span class=\"slds-assistive-text\">Progress: 0%</span>\n\t\t\t\t\t\t\t</span>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t</section>\n</script>\n\n<script type=\"text/ng-template\" id=\"vlcSldsRightPanel.html\">\n\t<div class=\"vlc-slds-right--panel\" ng-if=\"::!bpTree.propSetMap.hideStepChart\">\n\t\t<div vlc-slds-step-chart map=\"StepChart\" ></div>\n\t\t<!-- knowledge component will go here -->\n\t\t<ng-include ng-repeat=\"vlcPC in ::bpTree.propSetMap.persistentComponent\"\n\t\tng-if='bpTree.showPCNew[vlcPC.pcIndex] && ($index === 1 )'\n\t\tid='{{::vlcPC.id}}'\n\t\tknowledge=\"true\"\n\t\tsrc=\"::bpTree.dfHPSTmpl[vlcPC.pcIndex]\"/>\n\t</div>\n</script>",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "PriceAndValidate",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_PriceAndValidate_English/%vlocity_namespace%__OmniScript__c/MultiService/PriceAndValidate/English"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_PriceAndValidate_English",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_PriceAndValidate_English",
            "VlocityDataPackName": "MultiService_PriceAndValidate_English",
            "VlocityDataPackParents": [
                "VlocityUITemplate/multi-service-batch-error"
            ],
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "This VIP is responsible to configure required data for external pricing.",
                        "%vlocity_namespace%__CustomJavaScript__c": "{}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__LwcId__c": "6390e619-5df9-f25b-eb28-dfe5ec7d121e",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_RequestExternalPricing",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableActualTimeLimit\":null,\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"queueableChainableCpuLimit\":40000,\"queueableChainableHeapSizeLimit\":6,\"queueableChainableQueriesLimit\":120,\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{},\"ttlMinutes\":5}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "RequestExternalPricing",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "Request External Pricing",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_RequestExternalPricing_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/RequestExternalPricing/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_RequestExternalPricing_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_RequestExternalPricing_Procedure",
            "VlocityDataPackName": "MultiService_RequestExternalPricing_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__CustomJavaScript__c": "{}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ValidateAndPrice",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndPrice/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction1\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"runCartValidation\",\"remoteOptions\":{},\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "Validate",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__Element__c/Validate"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ValidateAndPrice",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndPrice/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction2\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"priceCart\",\"remoteOptions\":{},\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "Price",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__Element__c/Price"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "ValidateAndPrice",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndPrice/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 3,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"additionalOutput\":{\"priceResult\":\"%Price:pricingResult%\",\"validationResult\":\"%Validate:validationResult%\"},\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"label\":\"ResponseAction1\",\"responseDefaultData\":{},\"responseFormat\":\"JSON\",\"responseJSONNode\":\"\",\"responseJSONPath\":\"\",\"returnFullDataJSON\":false,\"returnOnlyAdditionalOutput\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"show\":null,\"useFormulas\":true,\"vlcResponseHeaders\":{}}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Response Action",
                                "Name": "ValidationPricingResult",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__Element__c/ValidationPricingResult"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_ValidateAndPrice",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{}}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "ValidateAndPrice",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "ValidateAndPrice",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndPrice_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndPrice/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_ValidateAndPrice_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_ValidateAndPrice_Procedure",
            "VlocityDataPackName": "MultiService_ValidateAndPrice_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__OmniScript__c": [
                    {
                        "%vlocity_namespace%__AdditionalInformation__c": "",
                        "%vlocity_namespace%__CustomJavaScript__c": "{\"\":\"\",\"masterQuoteId\":\"0Q06g000000YHpk\"}",
                        "%vlocity_namespace%__DataRaptorBundleId__c": "",
                        "%vlocity_namespace%__DisableMetadataCache__c": false,
                        "%vlocity_namespace%__ElementTypeToHTMLTemplateList__c": "{\"ElementTypeToHTMLTemplateList\":[]}",
                        "%vlocity_namespace%__Element__c": [
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Validate And Update External Pricing Status",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndUpdateExternalPricingStatus/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 1,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction1\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"isAllGroupsValidatedAndPriced\",\"remoteOptions\":{},\"responseJSONNode\":\"isAllGroupsValidatedAndPriced\",\"responseJSONPath\":\"isAllGroupsValidatedAndPriced\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "IsAllGroupsValidatedAndPriced",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure/%vlocity_namespace%__Element__c/IsAllGroupsValidatedAndPriced"
                            },
                            {
                                "%vlocity_namespace%__Active__c": true,
                                "%vlocity_namespace%__InternalNotes__c": "",
                                "%vlocity_namespace%__Level__c": 0,
                                "%vlocity_namespace%__OmniScriptId__c": {
                                    "Name": "Validate And Update External Pricing Status",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndUpdateExternalPricingStatus/Procedure",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c"
                                },
                                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                                "%vlocity_namespace%__Order__c": 2,
                                "%vlocity_namespace%__ParentElementId__c": "",
                                "%vlocity_namespace%__PropertySet__c": "{\"actionMessage\":\"\",\"additionalChainableResponse\":{},\"additionalInput\":{},\"additionalOutput\":{},\"chainOnStep\":false,\"disOnTplt\":false,\"executionConditionalFormula\":\"\",\"failOnStepError\":true,\"failureConditionalFormula\":\"\",\"failureResponse\":{},\"label\":\"RemoteAction2\",\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"updateExternalPricingStatus\",\"remoteOptions\":{},\"responseJSONNode\":\"response\",\"responseJSONPath\":\"\",\"returnOnlyAdditionalOutput\":false,\"returnOnlyFailureResponse\":false,\"sendJSONNode\":\"\",\"sendJSONPath\":\"\",\"sendOnlyAdditionalInput\":false,\"show\":null,\"useFormulas\":true}",
                                "%vlocity_namespace%__ReusableOmniScript__c": false,
                                "%vlocity_namespace%__SearchKey__c": "",
                                "%vlocity_namespace%__Type__c": "Remote Action",
                                "Name": "UpdateExternalPricingStatus",
                                "VlocityDataPackIsIncluded": true,
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                                "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure/%vlocity_namespace%__Element__c/UpdateExternalPricingStatus"
                            }
                        ],
                        "%vlocity_namespace%__IsActive__c": true,
                        "%vlocity_namespace%__IsLwcEnabled__c": false,
                        "%vlocity_namespace%__IsProcedure__c": true,
                        "%vlocity_namespace%__IsReusable__c": false,
                        "%vlocity_namespace%__Language__c": "Procedure",
                        "%vlocity_namespace%__LastPreviewPage__c": "",
                        "%vlocity_namespace%__LwcId__c": "2b064b2f-f333-3c36-1d0d-722bbeafbe2f",
                        "%vlocity_namespace%__ProcedureKey__c": "MultiService_ValidateAndUpdateExternalPricingStatus",
                        "%vlocity_namespace%__ProcedureResponseCacheType__c": "",
                        "%vlocity_namespace%__PropertySet__c": "{\"additionalChainableResponse\":{},\"chainableActualTimeLimit\":null,\"chainableCpuLimit\":2000,\"chainableDMLRowsLimit\":null,\"chainableDMLStatementsLimit\":null,\"chainableHeapSizeLimit\":null,\"chainableQueriesLimit\":50,\"chainableQueryRowsLimit\":null,\"chainableSoslQueriesLimit\":null,\"columnsPropertyMap\":[],\"description\":\"\",\"includeAllActionsInResponse\":false,\"labelPlural\":\"\",\"labelSingular\":\"\",\"linkToExternalObject\":\"\",\"nameColumn\":\"\",\"queueableChainableCpuLimit\":40000,\"queueableChainableHeapSizeLimit\":6,\"queueableChainableQueriesLimit\":120,\"relationshipFieldsMap\":[],\"rollbackOnError\":false,\"trackingCustomData\":{},\"ttlMinutes\":5}",
                        "%vlocity_namespace%__RequiredPermission__c": "",
                        "%vlocity_namespace%__SubType__c": "ValidateAndUpdateExternalPricingStatus",
                        "%vlocity_namespace%__Type__c": "MultiService",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "Validate And Update External Pricing Status",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                        "VlocityRecordSourceKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure/%vlocity_namespace%__OmniScript__c/MultiService/ValidateAndUpdateExternalPricingStatus/Procedure"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure",
                "VlocityDataPackType": "OmniScript"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "OmniScript/MultiService_ValidateAndUpdateExternalPricingStatus_Procedure",
            "VlocityDataPackName": "MultiService_ValidateAndUpdateExternalPricingStatus_Procedure",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "OmniScript"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityAction__c": [
                    {
                        "%vlocity_namespace%__AdditionalFilter__c": "",
                        "%vlocity_namespace%__ApplicablePermissionName__c": "",
                        "%vlocity_namespace%__ApplicableTypes__c": "Quote",
                        "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
                        "%vlocity_namespace%__CustomLabelName__c": "CPQApplyToGroup",
                        "%vlocity_namespace%__DisplayLabel__c": "Apply To Group",
                        "%vlocity_namespace%__DisplayOn__c": "All",
                        "%vlocity_namespace%__DisplaySequence__c": 1,
                        "%vlocity_namespace%__Filter__c": "",
                        "%vlocity_namespace%__InvokeClassName__c": "",
                        "%vlocity_namespace%__InvokeMethodName__c": "",
                        "%vlocity_namespace%__IsSeedAction__c": false,
                        "%vlocity_namespace%__LinkType__c": "OmniScript",
                        "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
                        "%vlocity_namespace%__StateId__c": "",
                        "%vlocity_namespace%__StateModelId__c": "",
                        "%vlocity_namespace%__UrlParameters__c": "Id,OpportunityId,%vlocity_namespace%__QuoteGroupId__c",
                        "%vlocity_namespace%__Url__c": "/apex/%vlocity_namespace%__OmniScriptUniversalPage?groupCartId={0}&parentId={1}&groupId={2}&layout=lightning#/OmniScriptType/MultiService/OmniScriptSubType/ApplyToGroup/OmniScriptLang/English/ContextId/{0}/PrefillDataRaptorBundle//true",
                        "%vlocity_namespace%__ValidationClassName__c": "",
                        "%vlocity_namespace%__ValidationMethodName__c": "",
                        "%vlocity_namespace%__VlocityIcon__c": "icon-v-document1-line",
                        "Name": "Apply To Group",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
                        "VlocityRecordSourceKey": "VlocityAction/Apply To Group/%vlocity_namespace%__VlocityAction__c/Apply To Group"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityAction/Apply To Group",
                "VlocityDataPackType": "VlocityAction"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityAction/Apply To Group",
            "VlocityDataPackName": "Apply To Group",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityAction"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityAction__c": [
                    {
                        "%vlocity_namespace%__AdditionalFilter__c": "",
                        "%vlocity_namespace%__ApplicablePermissionName__c": "",
                        "%vlocity_namespace%__ApplicableTypes__c": "Quote",
                        "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
                        "%vlocity_namespace%__CustomLabelName__c": "CPQMultiServiceCheckout",
                        "%vlocity_namespace%__DisplayLabel__c": "Checkout",
                        "%vlocity_namespace%__DisplayOn__c": "All",
                        "%vlocity_namespace%__DisplaySequence__c": 2,
                        "%vlocity_namespace%__Filter__c": "",
                        "%vlocity_namespace%__InvokeClassName__c": "",
                        "%vlocity_namespace%__InvokeMethodName__c": "",
                        "%vlocity_namespace%__IsSeedAction__c": false,
                        "%vlocity_namespace%__LinkType__c": "OmniScript",
                        "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
                        "%vlocity_namespace%__StateId__c": "",
                        "%vlocity_namespace%__StateModelId__c": "",
                        "%vlocity_namespace%__UrlParameters__c": "Id,OpportunityId,%vlocity_namespace%__QuoteGroupId__c,AccountId",
                        "%vlocity_namespace%__Url__c": "/apex/%vlocity_namespace%__OmniScriptUniversalPage?Id={0}&OpportunityId={1}&GroupId={2}&AccountId={3}&layout=lightning#/OmniScriptType/MultiService/OmniScriptSubType/Checkout/OmniScriptLang/English/ContextId/{0}/PrefillDataRaptorBundle//true",
                        "%vlocity_namespace%__ValidationClassName__c": "",
                        "%vlocity_namespace%__ValidationMethodName__c": "",
                        "%vlocity_namespace%__VlocityIcon__c": "icon-v-document1-line",
                        "Name": "MultiServiceCheckout",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
                        "VlocityRecordSourceKey": "VlocityAction/MultiServiceCheckout/%vlocity_namespace%__VlocityAction__c/MultiServiceCheckout"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityAction/MultiServiceCheckout",
                "VlocityDataPackType": "VlocityAction"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityAction/MultiServiceCheckout",
            "VlocityDataPackName": "MultiServiceCheckout",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityAction"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityAction__c": [
                    {
                        "%vlocity_namespace%__AdditionalFilter__c": "",
                        "%vlocity_namespace%__ApplicablePermissionName__c": "",
                        "%vlocity_namespace%__ApplicableTypes__c": "Quote",
                        "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
                        "%vlocity_namespace%__CustomLabelName__c": "CPQPriceValidateLabel",
                        "%vlocity_namespace%__DisplayLabel__c": "Price And Validate",
                        "%vlocity_namespace%__DisplayOn__c": "All",
                        "%vlocity_namespace%__DisplaySequence__c": 1,
                        "%vlocity_namespace%__Filter__c": "",
                        "%vlocity_namespace%__InvokeClassName__c": "",
                        "%vlocity_namespace%__InvokeMethodName__c": "",
                        "%vlocity_namespace%__IsSeedAction__c": false,
                        "%vlocity_namespace%__LinkType__c": "OmniScript",
                        "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
                        "%vlocity_namespace%__StateId__c": "",
                        "%vlocity_namespace%__StateModelId__c": "",
                        "%vlocity_namespace%__UrlParameters__c": "Id, OpportunityId",
                        "%vlocity_namespace%__Url__c": "/apex/%vlocity_namespace%__OmniScriptUniversalPage?groupCartId={0}&parentId={1}&layout=lightning#/OmniScriptType/MultiService/OmniScriptSubType/PriceAndValidate/OmniScriptLang/English/ContextId/{0}/PrefillDataRaptorBundle//true",
                        "%vlocity_namespace%__ValidationClassName__c": "",
                        "%vlocity_namespace%__ValidationMethodName__c": "",
                        "%vlocity_namespace%__VlocityIcon__c": "icon-v-document1-line",
                        "Name": "Price And Validate",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
                        "VlocityRecordSourceKey": "VlocityAction/Price And Validate/%vlocity_namespace%__VlocityAction__c/Price And Validate"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityAction/Price And Validate",
                "VlocityDataPackType": "VlocityAction"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityAction/Price And Validate",
            "VlocityDataPackName": "Price And Validate",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityAction"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityCard__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"dataSource\":{\"type\":null,\"value\":{}},\"filter\":{},\"sessionVars\":[{\"name\":\"groupedServicePageSize\",\"val\":\"importedScope.groupedServicePageSize\"},{\"name\":\"groupPageSize\",\"val\":\"importedScope.groupPageSize\"},{\"name\":\"contextId\",\"val\":\"importedScope.contextId\"},{\"name\":\"enableUsage\",\"val\":\"$root.enableUsage\"},{\"name\":\"enableCostAndMargin\",\"val\":\"$root.enableCostAndMargin\"}],\"states\":[{\"actionCtxId\":\"['Id']\",\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"$scope.data.status\",\"operator\":\"===\",\"type\":\"system\",\"value\":\"'active'\"},{\"field\":\"['ObjectType']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'Quote'\"},{\"field\":\"$scope.session.enableCostAndMargin\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'false'\"},{\"field\":\"$scope.session.enableUsage\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'false'\"}]},\"definedActions\":{\"actions\":[{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == true\",\"hasExtraParams\":true,\"id\":\"Apply To Group\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"||\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == false || $scope.obj['%vlocity_namespace%__IsValidated__c'] == false\",\"hasExtraParams\":true,\"id\":\"Price And Validate\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == true && $scope.obj['%vlocity_namespace%__IsValidated__c'] == true\",\"hasExtraParams\":true,\"id\":\"MultiServiceCheckout\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"}]},\"disableAddCondition\":false,\"fields\":[{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Recurring Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__RecurringTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group One Time Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__OneTimeTotal__c']\",\"type\":\"currency\"}],\"filter\":\"$scope.data.status === 'active' && $scope.obj['ObjectType'] == 'Quote' && $scope.session.enableCostAndMargin == 'false' && $scope.session.enableUsage == 'false'\",\"isSmartAction\":false,\"name\":\"Advance Pricing (Quote)\",\"sObjectType\":\"Quote\",\"smartAction\":{},\"templateUrl\":\"multiservice-cpq-total-card\"},{\"actionCtxId\":\"['Id']\",\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"$scope.data.status\",\"operator\":\"===\",\"type\":\"system\",\"value\":\"'active'\"},{\"field\":\"['ObjectType']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'Quote'\"},{\"field\":\"$scope.session.enableCostAndMargin\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'true'\"},{\"field\":\"$scope.session.enableUsage\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'false'\"}]},\"definedActions\":{\"actions\":[{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == true\",\"hasExtraParams\":true,\"id\":\"Apply To Group\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"||\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == false || $scope.obj['%vlocity_namespace%__IsValidated__c'] == false\",\"hasExtraParams\":true,\"id\":\"Price And Validate\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == true && $scope.obj['%vlocity_namespace%__IsValidated__c'] == true\",\"hasExtraParams\":true,\"id\":\"MultiServiceCheckout\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"}]},\"disableAddCondition\":false,\"fields\":[{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Recurring Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__RecurringTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group One Time Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__OneTimeTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group One Time Margin Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__OneTimeMarginTotal__c']\",\"type\":\"percentage\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Recurring Margin Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__RecurringMarginTotal__c']\",\"type\":\"percentage\"}],\"filter\":\"$scope.data.status === 'active' && $scope.obj['ObjectType'] == 'Quote' && $scope.session.enableCostAndMargin == 'true' && $scope.session.enableUsage == 'false'\",\"isSmartAction\":false,\"name\":\"Advance Pricing  + CostAndMargin (Quote)\",\"sObjectType\":\"Quote\",\"smartAction\":{},\"templateUrl\":\"multiservice-cpq-total-card\"},{\"actionCtxId\":\"['Id']\",\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"$scope.data.status\",\"operator\":\"===\",\"type\":\"system\",\"value\":\"'active'\"},{\"field\":\"['ObjectType']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'Quote'\"},{\"field\":\"$scope.session.enableUsage\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'true'\"},{\"field\":\"$scope.session.enableCostAndMargin\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'false'\"}]},\"definedActions\":{\"actions\":[{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == true\",\"hasExtraParams\":true,\"id\":\"Apply To Group\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"||\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == false || $scope.obj['%vlocity_namespace%__IsValidated__c'] == false\",\"hasExtraParams\":true,\"id\":\"Price And Validate\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == true && $scope.obj['%vlocity_namespace%__IsValidated__c'] == true\",\"hasExtraParams\":true,\"id\":\"MultiServiceCheckout\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"}]},\"disableAddCondition\":false,\"fields\":[{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Usage Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__UsagePriceTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Recurring Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__RecurringTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group One Time Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__OneTimeTotal__c']\",\"type\":\"currency\"}],\"filter\":\"$scope.data.status === 'active' && $scope.obj['ObjectType'] == 'Quote' && $scope.session.enableUsage == 'true' && $scope.session.enableCostAndMargin == 'false'\",\"isSmartAction\":false,\"name\":\"Usage Pricing (Quote)\",\"sObjectType\":\"Quote\",\"smartAction\":{},\"templateUrl\":\"multiservice-cpq-total-card\"},{\"actionCtxId\":\"['Id']\",\"collapse\":false,\"conditions\":{\"group\":[{\"field\":\"$scope.data.status\",\"operator\":\"===\",\"type\":\"system\",\"value\":\"'active'\"},{\"field\":\"['ObjectType']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'Quote'\"},{\"field\":\"$scope.session.enableUsage\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'true'\"},{\"field\":\"$scope.session.enableCostAndMargin\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'true'\"}]},\"definedActions\":{\"actions\":[{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == true\",\"hasExtraParams\":true,\"id\":\"Apply To Group\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"||\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\",\"groupPageSize\":\"$scope.session.groupPageSize\",\"groupedServicePageSize\":\"$scope.session.groupedServicePageSize\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == false || $scope.obj['%vlocity_namespace%__IsValidated__c'] == false\",\"hasExtraParams\":true,\"id\":\"Price And Validate\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"},{\"collapse\":true,\"conditions\":{\"group\":[{\"field\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c']\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"false\"},{\"field\":\"['%vlocity_namespace%__IsPriced__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"},{\"field\":\"['%vlocity_namespace%__IsValidated__c']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"true\"}]},\"disableAddCondition\":false,\"extraParams\":{\"contextId\":\"$scope.session.contextId\"},\"filter\":\"$scope.obj['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__HasUnappliedGroupItems__c'] == false && $scope.obj['%vlocity_namespace%__IsPriced__c'] == true && $scope.obj['%vlocity_namespace%__IsValidated__c'] == true\",\"hasExtraParams\":true,\"id\":\"MultiServiceCheckout\",\"isCustomAction\":false,\"type\":\"Vlocity Action\"}]},\"disableAddCondition\":false,\"fields\":[{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Usage Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__UsagePriceTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Usage Margin Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__UsageMarginTotal__c']\",\"type\":\"percentage\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Recurring Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__RecurringTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Recurring Margin Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__RecurringMarginTotal__c']\",\"type\":\"percentage\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group One Time Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__OneTimeTotal__c']\",\"type\":\"currency\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"One Time Margin Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__OneTimeMarginTotal__c']\",\"type\":\"percentage\"},{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"Group Margin Total\",\"name\":\"['%vlocity_namespace%__QuoteGroupId__r.%vlocity_namespace%__QuoteGroupMarginTotal__c']\",\"type\":\"percentage\"}],\"filter\":\"$scope.data.status === 'active' && $scope.obj['ObjectType'] == 'Quote' && $scope.session.enableUsage == 'true' && $scope.session.enableCostAndMargin == 'true'\",\"isSmartAction\":false,\"name\":\"Usage Pricing + CostAndMargin (Quote)\",\"sObjectType\":\"Quote\",\"smartAction\":{},\"templateUrl\":\"multiservice-cpq-total-card\"}],\"title\":\"Multiservice Group Total Card\"}",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-group-total-bar/Vlocity/1/1562155724480",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-group-total-bar",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityCard__c",
                        "VlocityRecordSourceKey": "VlocityCard/multiservice-cpq-group-total-bar/%vlocity_namespace%__VlocityCard__c/multiservice-cpq-group-total-bar"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityCard/multiservice-cpq-group-total-bar",
                "VlocityDataPackType": "VlocityCard"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityCard/multiservice-cpq-group-total-bar",
            "VlocityDataPackName": "multiservice-cpq-group-total-bar",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityCard"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityCard__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"dataSource\":{\"contextVariables\":[],\"type\":\"ApexRemote\",\"value\":{\"inputMap\":{\"cartId\":\"{{params.id}}\",\"price\":\"false\",\"validate\":\"false\"},\"optionsMap\":{\"vlcClass\":\"%vlocity_namespace%.CpqAppHandler\"},\"remoteClass\":\"CpqAppHandler\",\"remoteMethod\":\"getCarts\",\"remoteNSPrefix\":\"%vlocity_namespace%\",\"resultVar\":\"records[0].details.records\"}},\"filter\":{},\"states\":[{\"collapse\":false,\"conditions\":{\"group\":[{\"field\":\"$scope.data.status\",\"operator\":\"===\",\"type\":\"system\",\"value\":\"'active'\"},{\"field\":\"['ObjectType']\",\"logicalOperator\":\"&&\",\"operator\":\"==\",\"type\":\"custom\",\"value\":\"'Quote'\"}]},\"definedActions\":{\"actions\":[]},\"disableAddCondition\":false,\"fields\":[{\"collapse\":true,\"displayLabel\":\"<<Custom Field>>\",\"editing\":false,\"fieldType\":\"custom\",\"label\":\"['QuoteNumber']['label']\",\"name\":\"['QuoteNumber']['value']\",\"type\":\"string\"}],\"filter\":\"$scope.data.status === 'active' && $scope.obj['ObjectType'] == 'Quote'\",\"name\":\"Active Quote\",\"templateUrl\":\"multiservice-cpq-base-header-card\"}],\"title\":\"Multiservice CPQ Header\"}",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-header/Vlocity/1/1562152092684",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-header",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityCard__c",
                        "VlocityRecordSourceKey": "VlocityCard/multiservice-cpq-header/%vlocity_namespace%__VlocityCard__c/multiservice-cpq-header"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityCard/multiservice-cpq-header",
                "VlocityDataPackType": "VlocityCard"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityCard/multiservice-cpq-header",
            "VlocityDataPackName": "multiservice-cpq-header",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityCard"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"Cards\":[],\"previewType\":\"runTime\",\"templates\":{\"0\":{\"templateUrl\":\"multiservice-cpq-base-grid\"}}}",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-base-grid/1/Vlocity/1562153009163",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-base-grid",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/multiservice-cpq-base-grid/%vlocity_namespace%__VlocityUILayout__c/multiservice-cpq-base-grid"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-base-grid",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-base-grid",
            "VlocityDataPackName": "multiservice-cpq-base-grid",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"Cards\":[],\"dataSource\":{\"contextVariables\":[{\"name\":\"params.parentId\",\"val\":\"0062E00001FHgE6QAL\"}],\"type\":\"ApexRemote\",\"value\":{\"inputMap\":{\"contextId\":\"{{params.contextId}}\",\"fields\":\"Name,%vlocity_namespace%__PremisesId__r.Name\",\"offset\":\"0\",\"pageSize\":\"{{params.groupPageSize}}\",\"parentId\":\"{{params.parentId}}\"},\"optionsMap\":{\"vlcClass\":\"%vlocity_namespace%.MultiServicePointsService\"},\"remoteClass\":\"MultiServiceAppHandler\",\"remoteMethod\":\"getGroups\",\"remoteNSPrefix\":\"%vlocity_namespace%\",\"resultVar\":\"\"}},\"previewType\":\"runTime\",\"templates\":{\"0\":{\"templateUrl\":\"multiservice-cpq-group-list\"}}}",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-group-list/1/Vlocity/1562154123283",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-group-list",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/multiservice-cpq-group-list/%vlocity_namespace%__VlocityUILayout__c/multiservice-cpq-group-list"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-group-list",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-group-list",
            "VlocityDataPackName": "multiservice-cpq-group-list",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"Cards\":[\"multiservice-cpq-group-total-bar\"],\"dataSource\":{\"contextVariables\":[{\"name\":\"params.id\",\"val\":\"0Q02E000004kkBFSAY\"},{\"name\":\"\",\"val\":\"\"}],\"type\":\"ApexRemote\",\"value\":{\"inputMap\":{\"cartId\":\"{{params.id}}\",\"groupCart\":\"true\",\"price\":\"false\",\"validate\":\"false\"},\"optionsMap\":{\"vlcClass\":\"%vlocity_namespace%.CpqAppHandler\"},\"remoteClass\":\"CpqAppHandler\",\"remoteMethod\":\"getCarts\",\"remoteNSPrefix\":\"%vlocity_namespace%\",\"resultVar\":\"records[0].details.records[0]\"}},\"previewType\":\"runTime\",\"templates\":{\"0\":{\"templateUrl\":\"cpq-total-bar\"}},\"workspace\":[\"multiservice-cpq-group-total-bar/Vlocity/1/1562155724480\"]}",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-group-total-bar/1/Vlocity/1562155465295",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-group-total-bar",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/multiservice-cpq-group-total-bar/%vlocity_namespace%__VlocityUILayout__c/multiservice-cpq-group-total-bar"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-group-total-bar",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-group-total-bar",
            "VlocityDataPackName": "multiservice-cpq-group-total-bar",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"Cards\":[],\"previewType\":\"runTime\",\"templates\":{\"0\":{\"templateUrl\":\"multiservice-cpq-grouplist-sidebar\"}}}",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-grouplist-sidebar/1/Vlocity/1562155203025",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-grouplist-sidebar",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/multiservice-cpq-grouplist-sidebar/%vlocity_namespace%__VlocityUILayout__c/multiservice-cpq-grouplist-sidebar"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-grouplist-sidebar",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-grouplist-sidebar",
            "VlocityDataPackName": "multiservice-cpq-grouplist-sidebar",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUILayout__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Datasource__c": "",
                        "%vlocity_namespace%__Definition__c": "{\"Cards\":[\"multiservice-cpq-header\"],\"previewType\":\"runTime\",\"templates\":{\"0\":{\"templateUrl\":\"cpq-base-header\"}},\"workspace\":[\"multiservice-cpq-header/Vlocity/1/1562152092684\"]}",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "multiservice-cpq-header/1/Vlocity/1562151802525",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Layout",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-header",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUILayout__c",
                        "VlocityRecordSourceKey": "VlocityUILayout/multiservice-cpq-header/%vlocity_namespace%__VlocityUILayout__c/multiservice-cpq-header"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-header",
                "VlocityDataPackType": "VlocityUILayout"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUILayout/multiservice-cpq-header",
            "VlocityDataPackName": "multiservice-cpq-header",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUILayout"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** CPQ BASE THEME VARIABLES ***/\n/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "cpq-base-theme-variables/4/Vlocity/1510409685180",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** CPQ BASE THEME VARIABLES ***/\n\n@import \"cpq-base-variables\";\n\n// Common padding\n$cpq-padding-base-vertical: 6px !default;\n$cpq-padding-base-horizontal: 12px !default;\n\n$cpq-padding-large-vertical: 10px !default;\n$cpq-padding-large-horizontal: 16px !default;\n\n$cpq-padding-small-vertical: 5px !default;\n$cpq-padding-small-horizontal: 10px !default;\n\n$cpq-padding-xs-vertical: 1px !default;\n$cpq-padding-xs-horizontal: 5px !default;\n\n$cpq-headings-font-weight: 600;\n$cpq-discount-headings-font-weight: 500;\n$cpq-cart-item-product-group-font-weight: 300;\n\n$cpq-page-bg-color: #f4f6f9;\n\n$cpq-product-container-bg-color: $white;\n$cpq-product-container-border-color: $mid-gray;\n\n$cpq-product-padding: 10px;\n$cpq-product-item-padding: 3px;\n$cpq-cart-action-button-margin: 0px 10px 0px 10px;\n$cpq-cart-container-tabs-height: 40px;\n$cpq-cart-container-tabs-top-margin: -10px;\n$cpq-cart-container-bg-color: $white;\n$cpq-cart-container-border-color: $mid-gray;\n$cpq-cart-total-bar-bg-color: #14315D;\n\n$cpq-product-cart-items-bg-color: $white;\n$cpq-product-cart-items-attr-value-color: $dark-gray;\n$cpq-product-cart-item-selected-border-color: #FDB734;\n$cpq-product-cart-order-bg-color: $mid-gray;\n$cpq-product-cart-config-error-font-size: .75rem;\n$cpq-product-cart-config-error-margin-top: .5rem;\n$cpq-product-cart-discount-price: #97C077;\n$cpq-cart-item-attr-label-font-size: 11px;\n$cpq-cart-item-product-group-label-color: $black;\n$cpq-cart-section-title-font-size: 15px;\n$cpq-cart-item-product-messages-padding: 28px;\n$cpq-cart-item-product-details-padding: 20px;\n$cpq-cart-item-product-cfg-attr-font-size: 13px;\n$cpq-cart-promo-item-bg-color: #F9FCF3;\n$cpq-cart-promo-button-bg-color: #9ECC3B;\n$cpq-cart-promo-item-border-color: #CCE29C;\n$cpq-cart-promo-item-border-width: 2px;\n$cpq-cart-promo-item-border-radius: 5px;\n$cpq-loyalty-points-color: #061C3F;\n$cpq-product-link-color: #0070d2;\n$cpq-offers-count-bg-color: #FDB734;\n$cpq-discount-info-color : #3e3e3c;\n$cpq-discount-charge-color: #7D7E7F;\n\n$cpq-product-cart-item-popover-top: -3.5rem;\n$cpq-product-cart-item-popover-left: -0.5rem;\n\n$product-item-bookmark-red: #f65327;\n$product-item-bookmark-blue: #0058C6;\n$product-item-bookmark-green: #13834D;\n$product-item-bookmark-yellow: #FFB75D;\n$discount-type-label-background:#9b9b9b;\n$cpq-discount-font-size:12px;\n$cpq-discount-border-color:#D8DDE6;\n$cpq-action-label-color:#005FB2;\n$cpq-discount-status-color:#13834D;\n$cpq-discount-title-color:#4A4A4A;\n$cpq-custom-discount-title-border-color:#DDDBDA;\n$product-item-bookmark-grayish-blue:#54698D;",
                        "%vlocity_namespace%__Type__c": "mixin",
                        "%vlocity_namespace%__Version__c": 4,
                        "Name": "cpq-base-theme-variables",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/cpq-base-theme-variables/%vlocity_namespace%__VlocityUITemplate__c/cpq-base-theme-variables"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/cpq-base-theme-variables",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/cpq-base-theme-variables",
            "VlocityDataPackName": "cpq-base-theme-variables",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "cpq-base-variables/4/Vlocity/1510409691759",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** CPQ BASE VARIABLES ***/\n\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n\n$black: #000000;\n$white: #FFFFFF;\n\n$mid-black: #16325c;\n$dark-gray: #7c7c7c;\n$text-gray: #9999a7;\n$middle-dark-gray: #c7c7c7;\n$mid-gray: #d8d8d8;\n$middle-light-gray: #dedede;\n$light-gray: #f2f2f2;\n$lightest-gray: #f8f8f8;\n\n$dark-blue: #008ab3;\n$light-blue: #05a6df;\n\n\n$warning: #eac438;\n$success: #58a300;\n$error: #f65327;\n\n$font-family: \"Salesforce Sans\", Arial, sans-serif;\n$font-size: 14px;\n$line-height: 20px;\n$font-title-size: 28px;\n$font-heading-size: 22px;\n$font-thin: normal 100 14px/18px $font-family;\n$font-light: normal 300 14px/18px $font-family;\n$font-regular: normal 400 14px/18px $font-family;\n$font-semibold: normal 600 14px/18px $font-family;\n\n/*** SLDS VARIABLES ***/\n//*** RESPONSIVE BREAKPOINTS ***//\n$bp-xsmall: 20em;\n$bp-small: 30em;\n$bp-xmedium: 44em;\n$bp-medium: 48em;\n$bp-large: 64em;\n$bp-xlarge: 80em;\n\n//*** COLORS ***//\n// Grays\n$header-gray: #f7f9fb;\n$cards-gray: #f4f6f9;\n$cards-border-gray: #d8dde6;\n$mobile-icons-gray: #9faab5;\n\n// Notifications\n$notify-danger: #c23934;\n$notify-warning: #ffb75d;\n$notify-success: #04844b;\n$notify-default: #54698d;\n\n// Neutrals\n$neutral-lightest: #EEF1F6;\n$neutral-light: #CFD7E6;\n$neutral-medium: #A7B8D1;\n$neutral-dark: #4F6A92;\n\n// Modals\n$modal-overlay: #7e8c99;\n\n// Primary Colors\n$primary-alternative: #4A90E2;\n$primary-lightest: #0C8EFF;\n$primary-light: #0070D2;\n$primary-medium: #005FB2;\n$primary-dark: #00396B;\n\n// Secondary Colors\n$secondary-pink: #EF7EAD;\n$secondary-green: #4BC076;\n$secondary-aqua: #50E3C2;\n$secondary-purple: #7F8DE1;\n$secondary-orange: #F88962;\n\n// Other Colors\n$slds-red: #ef6e64;\n\n// Fonts\n$slds-font: \"Salesforce Sans\", Arial, sans-serif;\n\n// Namespace\n$cpq-namespace: 'cpq';\n$assets-namespace: 'assets'\n",
                        "%vlocity_namespace%__Type__c": "mixin",
                        "%vlocity_namespace%__Version__c": 4,
                        "Name": "cpq-base-variables",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/cpq-base-variables/%vlocity_namespace%__VlocityUITemplate__c/cpq-base-variables"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/cpq-base-variables",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/cpq-base-variables",
            "VlocityDataPackName": "cpq-base-variables",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** CPQ Theme VARIABLES ***/\n/*** \n   ***** CPQ THEME VARIABLES ****\n   Add only the theme file here. Don't add any code here.\n   It's easier to swap the theme here rather than swapping in every other template.\n   If you swap the theme here, all templates will automatically get the latest.\n   Note: You need to re save all the templates once you change the theme. Also, if you change theme files, refresh the browser and then save the templates.\n***/\n/*** CPQ BASE THEME VARIABLES ***/\n/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n/*** MIXINS ***/\n/*** MIXINS ***/\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "cpq-card-mixin/5/Vlocity/cpq-card-mixin.scss",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** CPQ Theme VARIABLES ***/\n@import \"cpq-theme-variables\";\n\n/*** MIXINS ***/\n@import \"cpq-mixin\";\n\n@mixin cardMixin($namespace: 'cpq') {\n\n    /*** STYLES ***/\n\n    .#{$namespace}-product-cart-item-child, .#{$namespace}-product-item, .#{$namespace}-product-cart-item, .#{$namespace}-replace-item,\n    .comp-#{$namespace}-product-item-child, .comp-#{$namespace}-product-item {\n        .#{$namespace}-large-name-text-wrap {\n            max-width: 7vw;\n            white-space: nowrap;\n            overflow: hidden;\n            text-overflow: ellipsis;\n        }\n        .#{$namespace}-text-name-wrap {\n            display: inline-flex;\n        }\n        .#{$namespace}-product-item-selling-period-past {\n            color:$notify-warning;\n            width: 1.5rem;\n            height: 1.5rem;\n            margin: 4px;\n        }\n        .#{$namespace}-product-item-selling-period-future {\n            color:$notify-success;\n            width: 1.5rem;\n            height: 1.5rem;\n            margin: 4px;\n        }\n        .#{$namespace}-product-item-selling-period-endoflife {\n            color:$notify-danger;\n            width: 1.5rem;\n            height: 1.5rem;\n            margin: 4px;\n        }\n        position:relative; /* needed for selected border */\n        padding-top: 20px;\n\n        input.ng-invalid {\n            color: $error;\n        }\n\n        .extend-slds-close-switch {\n            .slds-button__icon {\n                margin: 0.3rem 0.5rem 0 0;\n\n                &.#{$namespace}-fix-slds-close-switch {\n                    transform: rotate(-90deg) !important;\n                }\n            }\n        }\n\n        .#{$namespace}-item-product, .#{$namespace}-item-base-product {\n            &.#{$namespace}-item-selected {\n                &::after {\n                    content: '';\n                    display: block;\n                    position: absolute;\n                    top: 0;\n                    right: 0;\n                    bottom: 0;\n                    /* don't use left:0, as it will take full width rather than creating just the border to the right */\n                    border-right: 8px solid $cpq-product-cart-item-selected-border-color;\n                }\n            }\n        }\n        .#{$namespace}-product-cart-item-child, .comp-#{$namespace}-product-item-child {\n            .#{$namespace}-item-base-product {\n                padding: 0.1rem 0;\n                &.#{$namespace}-item-selected {\n                    &::after {\n                        right: -$cpq-padding-large-horizontal;\n                    }\n                }\n            }\n        }\n        .#{$namespace}-item-product {\n            padding: $cpq-padding-large-vertical 0px;\n            margin: 0px $cpq-padding-large-horizontal;\n            border-bottom: 1px solid $middle-light-gray;\n        }\n        .#{$namespace}-item-base-product {\n            display: flex;\n            flex-flow: row nowrap;\n            justify-content: flex-end;\n            \n            .#{$namespace}-loyalty-points {\n                color: $cpq-loyalty-points-color;\n            }\n\n            .#{$namespace}-promo-text-wrap {\n                max-width: 7vw;\n                white-space: nowrap;\n                overflow: hidden;\n                text-overflow: ellipsis;\n            }\n\n            .#{$namespace}-item-base-product-input,\n            .#{$namespace}-item-base-product-text,\n            .#{$namespace}-item-base-product-lookup,\n            .#{$namespace}-item-base-product-string {\n                flex: 2;\n                padding-right: $cpq-padding-base-horizontal/2;\n            }\n\n            .#{$namespace}-item-base-product-text,\n            .#{$namespace}-item-base-product-lookup,\n            .#{$namespace}-item-base-product-string {\n                padding-top: $cpq-padding-base-vertical;\n                overflow-wrap: break-word;\n                min-width: 0;\n            }\n\n            .#{$namespace}-item-base-product-loyalty, \n            .#{$namespace}-item-base-product-currency,\n            .#{$namespace}-item-base-product-currency5, \n            .#{$namespace}-item-base-product-promo-field {\n                .slds-popover.#{$namespace}-price-actions-popover {\n                    position: absolute;\n                    z-index: 999;\n                    width: auto;\n                    top: $cpq-product-cart-item-popover-top;\n                    left: $cpq-product-cart-item-popover-left;\n\n                    .slds-popover__body.#{$namespace}-price-actions-popover__body {\n                        &:after {\n                            content: \"\";\n                            display: block;\n                            width: 100%;\n                            height: 2rem;\n                            position: absolute;\n                            left: 0;\n                            bottom: -2rem;\n                        }\n                    }\n                }\n            }\n            .#{$namespace}-item-base-product-loyalty,\n            .#{$namespace}-item-base-product-percentage,\n            .#{$namespace}-item-base-product-currency5,\n            .#{$namespace}-item-base-product-currency {\n                flex: 2;\n                position: relative;\n                transition: color 250ms ease-in;\n                padding: $cpq-padding-base-vertical $cpq-padding-base-horizontal/2 0 0;\n\n                .#{$namespace}-item-discount-price {\n                    color: $cpq-product-cart-discount-price;\n                }\n            }\n            .#{$namespace}-item-percentage-value {\n                color: $cpq-product-cart-items-attr-value-color;\n                padding-top: $cpq-padding-large-vertical/2;\n            }\n            .#{$namespace}-item-base-product-actions {\n                flex: 3;\n                padding-right: $cpq-padding-base-horizontal/2;\n\n                &.compacted {\n                    flex: 1;\n                }\n                .#{$namespace}-actions-dropdown-menu-dropdown {\n                    position: relative;\n\n                    .#{$namespace}-item-actions-dropdown-button {\n                        height: 1.6875rem;\n                        margin-top: 0.125rem;\n\n                        .slds-button__icon {\n                            fill: $primary-medium;\n                        }\n                    }\n\n                    .#{$namespace}-action-item-label {\n                        font-size: 11px;\n                        color: $primary-medium;\n                    }\n                    .slds-icon {\n                        fill: $primary-medium;\n                        position: relative;\n                        top: -1px;\n                        margin-right: 0.25rem;\n                    }\n                }\n            }\n\n            .#{$namespace}-item-base-product-name-field {\n                flex: 5;\n                padding: 0 $cpq-padding-base-horizontal/2 0 0;\n                \n                .#{$namespace}-product-item-bookmark-change, .#{$namespace}-product-item-bookmark-existing, {\n                    color: $product-item-bookmark-red;\n                }\n                .#{$namespace}-product-item-bookmark-add, .#{$namespace}-product-item-bookmark-null {\n                    color: $product-item-bookmark-blue;\n                }    \n                .#{$namespace}-product-item-bookmark-disconnect {\n                    color: $product-item-bookmark-grayish-blue;\n                }\n                .#{$namespace}-item-has-children {\n                    font-size: 13px;\n                    color: $mid-black;\n\n                    &:focus{\n                        box-shadow: none;\n                    }\n                    \n                    @extend .extend-slds-close-switch;\n\n                    .#{$namespace}-product-name {\n                        line-height: 1.6;\n                        text-align: left;\n                        max-width: 82%;\n                        float: left;\n                        display: inline-block;\n                        margin-top: 0.125rem;\n                        margin-left: 0;\n                    }\n                    .#{$namespace}-large-name-text-wrap {\n                        max-width: 7vw;\n                        white-space: nowrap;\n                        overflow: hidden;\n                        text-overflow: ellipsis;\n                    }\n                    \n                }\n                .#{$namespace}-item-no-children {\n                    margin-top: 6px;\n                    padding-left: 0;\n                }\n                .#{$namespace}-product-name-block {\n                    display: inline-flex;\n                    .#{$namespace}-product-icon-block {\n                        display: inherit;\n                        div {\n                            margin: auto\n                        }\n                    }\n                }  \n            }\n\n            .#{$namespace}-item-base-product-promo-field {\n                flex: 4;\n                position: relative;\n                transition: color 250ms ease-in;\n                padding: $cpq-padding-base-vertical $cpq-padding-base-horizontal/2 0 0;\n\n                .#{$namespace}-promo-name-strike {\n                    text-decoration: line-through;\n                }\n            }\n\n            .#{$namespace}-item-base-product-itemname-field {\n                flex: 3;\n                input {\n                    width: 90%;\n                    text-align: left;\n                }\n            }\n\n            .#{$namespace}-item-product-group {\n                @extend .extend-slds-close-switch;\n            }\n        }\n\n        .#{$namespace}-item-currency-value, \n        .#{$namespace}-item-currency5-value,{\n            color: $cpq-product-cart-items-attr-value-color;\n            padding-top: $cpq-padding-large-vertical/2;\n        }\n        .#{$namespace}-item-input {\n            padding: 0px 3px;\n            margin-top: $cpq-padding-large-vertical/5;\n            text-align: center;\n            width: 50px; /* width can fit 3 digits */\n            height: 25px;\n            min-height: calc(25px + 2px); /* override slds input styles */\n        }\n        .#{$namespace}-item-product-messages {\n            font-size: 95%;\n        }\n        .#{$namespace}-item-base-product-details {\n\n        }\n        .#{$namespace}-item-base-product-cfg-attr {\n            .slds-section__title {\n                a {\n                    font-size: $cpq-cart-item-product-cfg-attr-font-size;\n                }\n\n                button {\n                    padding-bottom: 4px;\n                }\n            }\n            .#{$namespace}-item-attributes-form {\n                .slds-section:first-child {\n                    .slds-section__title {\n                        margin-top: 8px;\n                    }\n                }\n            }\n        }\n\n        .#{$namespace}-error-msg {\n            color: $error;\n        }\n        .#{$namespace}-warning-msg {\n            color: $warning;\n        }\n        .#{$namespace}-underline {\n            border-bottom: dashed 1px;\n            &:hover, &.hovered {\n                color: #0070d2;\n                cursor: pointer;\n            }\n        }\n    }\n\n    /* 64rem */\n    @media screen and (max-width: $bp-large) {\n        .#{$namespace}-item-product {\n            .#{$namespace}-item-base-product {\n                .#{$namespace}-item-base-product-actions {\n                    .slds-button {\n                        .slds-button__icon {\n                            fill: $primary-medium;\n                        }\n                    }\n                }\n            }\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "mixin",
                        "%vlocity_namespace%__Version__c": 5,
                        "Name": "cpq-card-mixin",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/cpq-card-mixin/%vlocity_namespace%__VlocityUITemplate__c/cpq-card-mixin"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/cpq-card-mixin",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/cpq-card-mixin",
            "VlocityDataPackName": "cpq-card-mixin",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** MIXINS ***/\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "cpq-mixin/3/Vlocity/1510409728777",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** MIXINS ***/\n@mixin clearfix {\n    &:before, &:after {\n        content: \" \"; \n        display: table;\n    }\n    &:after {\n        clear: both;\n    }\n}\n\n//generate padding styles for product-name wrapper in tree\n$padding-offset: 20;\n$final-level: 10;\n\n@mixin productChildLevelStyling($namespace: 'cpq', $direction: 'left', $padding: $padding-offset, $level: 1) {\n    .#{$namespace}-item-product-child-level-#{$level} {\n        .#{$namespace}-item-child-product-name-wrapper {\n            @if $direction == 'left' {\n                padding-left : $padding + px;\n                padding-right: 0;\n            } \n            @if $direction == 'right' {\n                padding-right: $padding + px; \n                padding-left: 0;\n            }\n        }\n        @if ($level < $final-level) {\n            @include productChildLevelStyling($namespace, $direction, $padding + $padding-offset, $level + 1);\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "mixin",
                        "%vlocity_namespace%__Version__c": 3,
                        "Name": "cpq-mixin",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/cpq-mixin/%vlocity_namespace%__VlocityUITemplate__c/cpq-mixin"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/cpq-mixin",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/cpq-mixin",
            "VlocityDataPackName": "cpq-mixin",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** \n   ***** CPQ THEME VARIABLES ****\n   Add only the theme file here. Don't add any code here.\n   It's easier to swap the theme here rather than swapping in every other template.\n   If you swap the theme here, all templates will automatically get the latest.\n   Note: You need to re save all the templates once you change the theme. Also, if you change theme files, refresh the browser and then save the templates.\n***/\n/*** CPQ BASE THEME VARIABLES ***/\n/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "cpq-theme-variables/2/Vlocity/1510410420849",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** \n   ***** CPQ THEME VARIABLES ****\n   Add only the theme file here. Don't add any code here.\n   It's easier to swap the theme here rather than swapping in every other template.\n   If you swap the theme here, all templates will automatically get the latest.\n   Note: You need to re save all the templates once you change the theme. Also, if you change theme files, refresh the browser and then save the templates.\n***/\n\n@import \"cpq-base-theme-variables\";",
                        "%vlocity_namespace%__Type__c": "mixin",
                        "%vlocity_namespace%__Version__c": 2,
                        "Name": "cpq-theme-variables",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/cpq-theme-variables/%vlocity_namespace%__VlocityUITemplate__c/cpq-theme-variables"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/cpq-theme-variables",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/cpq-theme-variables",
            "VlocityDataPackName": "cpq-theme-variables",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** MIXINS ***/\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "All",
                        "%vlocity_namespace%__ExternalID__c": "mixin/2/Vlocity/1510410423472",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** MIXINS ***/\n@mixin clearfix {\n    &:before, &:after {\n        content: \" \";\n        display: table;\n    }\n    &:after {\n        clear: both;\n    }\n}",
                        "%vlocity_namespace%__Type__c": "mixin",
                        "%vlocity_namespace%__Version__c": 2,
                        "Name": "mixin",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/mixin/%vlocity_namespace%__VlocityUITemplate__c/mixin"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/mixin",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/mixin",
            "VlocityDataPackName": "mixin",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CustomJavascript__c": "vlocity.cardframework.registerModule.controller('BatchErrorController', ['$scope',function($scope) {}]);",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multi-service-batch-error/1/Vlocity/1570190441231",
                        "%vlocity_namespace%__HTML__c": "<div ng-controller=\"BatchErrorController\">\n    <div aria-hidden=\"false\" aria-labelledby=\"prompt-heading-id\" aria-describedby=\"prompt-message-wrapper\" role=\"alertdialog\" class=\"slds-modal slds-modal_prompt slds-fade-in-open\">\n        <div class=\"slds-modal__container slds-modal_prompt\" role=\"document\" id=\"prompt-message-wrapper\" tabindex=\"0\">\n            <div class=\"slds-modal__header slds-theme_alert-texture slds-theme_error\" ng-class=\"theme\">\n                <h2 class=\"slds-text-heading_medium\" id=\"prompt-heading-id\">{{bpTree.response.errorLabel}}</h2>\n            </div>\n            <div class=\"slds-modal__content slds-p-around_medium\">\n                <div>\n                    <p>{{bpTree.response.message}}</p>\n                </div>\n            </div>\n            <!--\n            <div class=\"slds-modal__footer slds-theme_default\">\n                <button class=\"slds-button slds-button_neutral\" ng-click=\"$hide()\">OK</button>\n            </div>\n            -->\n        </div>\n    </div>\n    <div class=\"slds-backdrop slds-backdrop_open\"></div>\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multi-service-batch-error",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multi-service-batch-error/%vlocity_namespace%__VlocityUITemplate__c/multi-service-batch-error"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multi-service-batch-error",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multi-service-batch-error",
            "VlocityDataPackName": "multi-service-batch-error",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CustomJavascript__c": "vlocity.cardframework.registerModule.controller('MultiServiceRedirectController', ['$scope',\n    function($scope) {\n        $scope.init = function() {\n            window.top.location.href = '/'+ $scope.bpTree.response.AccountId;\n        }\n    }\n]);",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-account-redirect/1/Vlocity/1563282062513",
                        "%vlocity_namespace%__HTML__c": "<div ng-controller=\"MultiServiceRedirectController\" ng-init=\"init()\">\n    Redirect\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-account-redirect",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-account-redirect/%vlocity_namespace%__VlocityUITemplate__c/multiservice-account-redirect"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-account-redirect",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-account-redirect",
            "VlocityDataPackName": "multiservice-account-redirect",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** CPQ THEME VARIABLES ***/\n/*** \n   ***** CPQ THEME VARIABLES ****\n   Add only the theme file here. Don't add any code here.\n   It's easier to swap the theme here rather than swapping in every other template.\n   If you swap the theme here, all templates will automatically get the latest.\n   Note: You need to re save all the templates once you change the theme. Also, if you change theme files, refresh the browser and then save the templates.\n***/\n/*** CPQ BASE THEME VARIABLES ***/\n/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n/*** MIXINS ***/\n/*** MIXINS ***/\n/* $cpq-namespace is defined in cpq-base-variables */\n/*** STYLES ***/\n.vlocity.via-slds .cpq-base-grid {\n  background-color: #f4f6f9; }\n\n.vlocity.via-slds .cpq-container {\n  padding: 16px 8px; }\n\n.vlocity.via-slds .cpq-left-sidebar-wrapper {\n  transition: width 250ms ease-in; }\n  .vlocity.via-slds .cpq-left-sidebar-wrapper.hide-cpq-left-sidebar {\n    transition: width 250ms ease-out;\n    width: 0%;\n    visibility: hidden; }\n\n.vlocity.via-slds .grouplist-sidebar-wrapper {\n  transition: width 250ms ease-in; }\n  .vlocity.via-slds .grouplist-sidebar-wrapper.hide-grouplist-sidebar {\n    transition: width 250ms ease-out;\n    width: 0%;\n    visibility: hidden; }\n\n.vlocity.via-slds .cpq-cart-container-wrapper {\n  transition: width 250ms ease-in; }\n\n.vlocity.via-slds .cpq-attribute-config-panel-hide {\n  transition: margin-right 250ms ease-in;\n  margin-right: -33.5%; }\n\n.vlocity.via-slds .cpq-attribute-config-panel-show {\n  transition: margin-right 250ms ease-in;\n  margin-right: 0%; }\n\n.vlocity.via-slds .cpq-show-hide-button {\n  margin-left: -9px;\n  width: 10px;\n  height: auto;\n  /* IE */\n  height: initial;\n  border-radius: 0px;\n  border: none;\n  color: #000000;\n  opacity: 0.6;\n  font-weight: 600;\n  font-size: 40px; }\n  .vlocity.via-slds .cpq-show-hide-button:focus {\n    box-shadow: none; }\n  .vlocity.via-slds .cpq-show-hide-button:hover {\n    opacity: 1; }\n  .vlocity.via-slds .cpq-show-hide-button.cursor-point-west {\n    cursor: w-resize; }\n  .vlocity.via-slds .cpq-show-hide-button.cursor-point-east {\n    cursor: e-resize; }\n  .vlocity.via-slds .cpq-show-hide-button .hide-show-icon {\n    fill: #000000; }\n\n.vlocity.via-slds .button-divider {\n  background: white;\n  padding: 0px 5px;\n  margin: 0px 8px; }\n\n@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {\n  .vlocity.via-slds .cpq-cart-container {\n    height: calc(100vh - 80px); } }\n\n@media screen and (max-width: 64em) {\n  .vlocity.via-slds .cpq-base-grid input {\n    -webkit-appearance: none; }\n  .vlocity.via-slds .cpq-container {\n    padding: 1rem 0 0;\n    position: absolute;\n    width: 100%;\n    bottom: 0;\n    left: 0;\n    overflow: hidden; }\n    .vlocity.via-slds .cpq-container .cpq-tablet-overlay.slds-backdrop {\n      z-index: 990;\n      transition: opacity 250ms ease-in, visibility 0ms linear 250ms; }\n    .vlocity.via-slds .cpq-container.cpq-outer-col-visible .cpq-tablet-overlay.slds-backdrop--open {\n      transition: opacity 250ms ease-in; }\n  .vlocity.via-slds .cpq-left-sidebar-wrapper {\n    transition-property: left;\n    position: fixed;\n    z-index: 999;\n    margin-left: 0;\n    left: -33.33%;\n    top: 0;\n    height: 100%;\n    background-color: #f4f6f9; }\n    .vlocity.via-slds .cpq-left-sidebar-wrapper ng-include {\n      display: block; }\n    .vlocity.via-slds .cpq-left-sidebar-wrapper .cpq-left-sidebar-container {\n      width: 100%;\n      position: relative; }\n      .vlocity.via-slds .cpq-left-sidebar-wrapper .cpq-left-sidebar-container button.cpq-show-hide-button {\n        position: absolute;\n        right: -10px;\n        z-index: 9999;\n        top: 50%;\n        transform: translateY(-50%);\n        width: 2.75rem;\n        height: 2.75rem;\n        right: -2.75rem;\n        background-color: rgba(0, 0, 0, 0.5);\n        border-top-right-radius: .25rem;\n        border-bottom-right-radius: .25rem; }\n        .vlocity.via-slds .cpq-left-sidebar-wrapper .cpq-left-sidebar-container button.cpq-show-hide-button > .slds-button__icon.cpq-show-hide-button-icon {\n          position: absolute;\n          top: 50%;\n          left: 50%;\n          transform: translateY(-50%) translateX(-50%);\n          fill: #fff;\n          width: 1.25rem;\n          height: 1.25rem;\n          transition: transform 500ms ease-in; }\n    .vlocity.via-slds .cpq-left-sidebar-wrapper.cpq-left-sidebar-visible {\n      margin-left: 0;\n      left: 0;\n      box-shadow: 1px 0 5px rgba(0, 0, 0, 0.3); }\n      .vlocity.via-slds .cpq-left-sidebar-wrapper.cpq-left-sidebar-visible .cpq-left-sidebar-container button.cpq-show-hide-button > .slds-button__icon.cpq-show-hide-button-icon {\n        transform: translateY(-50%) translateX(-50%) rotate(180deg); }\n  .vlocity.via-slds .cpq-product-container-wrapper {\n    transition-property: right;\n    position: fixed;\n    z-index: 999;\n    margin-right: 0;\n    right: -33.33%;\n    top: 0;\n    height: 100%;\n    overflow-y: auto;\n    background-color: #fff; }\n    .vlocity.via-slds .cpq-product-container-wrapper ng-include {\n      display: block; }\n    .vlocity.via-slds .cpq-product-container-wrapper.cpq-product-container-visible {\n      margin-right: 0;\n      right: 0;\n      box-shadow: 0 1px 5px rgba(0, 0, 0, 0.3); } }\n\n[dir=rtl] .vlocity.via-slds.via-omni form[stepForm] {\n  margin: 0px;\n  padding: 0px;\n  border: none; }\n\n[dir=rtl] .vlocity.via-slds.via-omni ng-form {\n  padding-right: 0px; }\n\n[dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper {\n  transition-property: margin-right;\n  margin-right: -25%;\n  margin-left: 0; }\n  [dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper.cpq-left-sidebar-visible {\n    margin-right: 0; }\n\n[dir=rtl] .vlocity.via-slds .cpq-product-container-wrapper {\n  transition-property: margin-left;\n  margin-left: -25%;\n  margin-right: 0; }\n  [dir=rtl] .vlocity.via-slds .cpq-product-container-wrapper.cpq-product-container-visible {\n    margin-left: 0; }\n\n[dir=rtl] .vlocity.via-slds .cpq-show-hide-button {\n  margin-left: 0;\n  position: relative;\n  left: 8px;\n  margin-right: 0; }\n\n@media screen and (max-width: 64em) {\n  [dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper {\n    transition-property: right;\n    right: -25%;\n    left: auto;\n    margin-right: 0; }\n    [dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper .cpq-left-sidebar-container button.cpq-show-hide-button {\n      left: -2.75rem;\n      right: auto;\n      border-radius: 0.25rem 0 0 0.25rem; }\n      [dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper .cpq-left-sidebar-container button.cpq-show-hide-button > .slds-button__icon.cpq-show-hide-button-icon {\n        transform: translateY(-50%) translateX(-50%) rotate(180deg); }\n    [dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper.cpq-left-sidebar-visible {\n      right: 0;\n      left: auto; }\n      [dir=rtl] .vlocity.via-slds .cpq-left-sidebar-wrapper.cpq-left-sidebar-visible .cpq-left-sidebar-container button.cpq-show-hide-button > .slds-button__icon.cpq-show-hide-button-icon {\n        transform: translateY(-50%) translateX(-50%); }\n  [dir=rtl] .vlocity.via-slds .cpq-product-container-wrapper {\n    transition-property: left;\n    left: -25%;\n    right: auto;\n    margin-left: 0; }\n    [dir=rtl] .vlocity.via-slds .cpq-product-container-wrapper.cpq-product-container-visible {\n      left: 0;\n      right: auto; } }\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-cpq-base-grid/1/Vlocity/1562153070527",
                        "%vlocity_namespace%__HTML__c": "<div class=\"cpq-base-grid\">\n\n    <div class=\"slds-spinner_container\" ng-show=\"!isLoaded\">\n        <div class=\"slds-spinner_brand slds-spinner slds-spinner_medium\" aria-hidden=\"false\" role=\"alert\">\n            <div class=\"slds-spinner__dot-a\"></div>\n            <div class=\"slds-spinner__dot-b\"></div>\n        </div>\n    </div>\n\n    <div class=\"slds-grid slds-grid_frame slds-grid_vertical\">\n        <vloc-layout layout-name=\"multiservice-cpq-header\" ctrl=\"CPQHeaderController\" \n            enable-pricing=\"{{importedScope.featureSettings.enablePricing}}\"  \n            enable-loyalty-points=\"{{importedScope.customSettings.EnableLoyaltyPoints}}\">\n        </vloc-layout>\n\n        <div class=\"slds-col slds-grid slds-wrap slds-small-nowrap cpq-container\" ng-class=\"{'cpq-outer-col-visible': !importedScope.showProductList || importedScope.isConfigAttrsPanelEnabled}\">\n            <div class=\"slds-backdrop cpq-tablet-overlay\" ng-if=\"importedScope.isMobileTablet\" ng-click=\"importedScope.toggleOutsideCols()\" ng-class=\"{'slds-backdrop_open': !importedScope.showProductList || importedScope.isConfigAttrsPanelEnabled}\"></div>\n\n            <div class=\"slds-is-relative slds-col slds-grid slds-size_1-of-1 slds-small-size_1-of-3 slds-medium-size_2-of-6 slds-large-size_2-of-12 grouplist-sidebar-wrapper\" \n                ng-class=\"{'hide-grouplist-sidebar': !importedScope.showGroupList || importedScope.isConfigAttrsPanelEnabled}\">\n\n                <div class=\"grouplist-sidebar-container multiservice-cpq-grouplist-sidebar\">\n                    \n                    <vloc-layout layout-name=\"multiservice-cpq-grouplist-sidebar\" ctrl=\"CPQGroupSidebarController\"></vloc-layout>\n                </div>\n            </div>\n            \n            <button class=\"slds-button slds-button_icon-border cpq-show-hide-button\" ng-class=\"{'cursor-point-west': importedScope.showGroupList, 'cursor-point-east': !importedScope.showGroupList}\" ng-click=\"importedScope.toggleGroupListSidebar()\">⋮</button>\n            <span class=\"button-divider\" ng-if=\"importedScope.showProductList\"></span>\n            <div class=\"slds-is-relative slds-col slds-grid slds-size_1-of-1 slds-small-size_1-of-3 slds-medium-size_2-of-6 slds-large-size_3-of-12 cpq-left-sidebar-wrapper\"\n                ng-class=\"{'hide-cpq-left-sidebar': importedScope.showProductList || importedScope.isConfigAttrsPanelEnabled}\">\n\n                <div class=\"cpq-left-sidebar-container\">\n                    <button ng-if=\"importedScope.isMobileTablet\" class=\"slds-button slds-button_icon-border cpq-show-hide-button\" ng-click=\"importedScope.toggleOutsideCols();importedScope.toggleGroupListSidebar();\">\n                        <slds-button-svg-icon sprite=\"'utility'\" size=\"'medium'\" icon=\"'right'\" extra-classes=\"'cpq-show-hide-button-icon'\"></slds-button-svg-icon>\n                    </button>\n                    <vloc-layout layout-name=\"cpq-left-sidebar\" ctrl=\"CPQItemsController\"></vloc-layout>\n                </div>\n\n            </div>\n\n            <button ng-if=\"!importedScope.isMobileTablet\"\n                class=\"slds-button slds-button_icon-border cpq-show-hide-button\" \n                ng-class=\"{'cursor-point-west': !importedScope.showProductList, 'cursor-point-east': importedScope.showProductList}\"\n                ng-click=\"importedScope.toggleOutsideCols();\">⋮\n            </button>\n\n            <div class=\"slds-is-relative slds-col slds-grid cpq-cart-container-wrapper\">\n\n                <div class=\"cpq-cart-container\">\n                    <vloc-layout layout-name=\"cpq-product-cart\" ctrl=\"CPQCartController\" show-product-list=\"{{importedScope.showProductList}}\" show-config-panel=\"{{importedScope.isConfigAttrsPanelEnabled}}\"></vloc-layout>\n                </div>\n                \n                <div ng-if=\"$root.enableGroupCart\">\n                    <vloc-layout layout-name=\"multiservice-cpq-group-total-bar\" ctrl=\"GroupCPQTotalController\"></vloc-layout>\n                </div>\n                <div ng-if=\"!$root.enableGroupCart\">\n                    <vloc-layout layout-name=\"cpq-total-bar\" ctrl=\"CPQTotalController\"></vloc-layout>\n                </div>\n            </div>\n            \n            <div class=\"slds-is-relative slds-col slds-grid slds-size_1-of-1 slds-small-size_1-of-3 slds-medium-size_2-of-6 slds-large-size_4-of-12 slds-float_right cpq-attribute-config-panel-hide\" \n                ng-class=\"{'cpq-attribute-config-panel-show': importedScope.isConfigAttrsPanelEnabled, 'cpq-attribute-config-panel-hide': !importedScope.isConfigAttrsPanelEnabled}\">\n\n                <div class=\"cpq-product-container\">\n                    <vloc-layout layout-name=\"cpq-product-cart-config\" ctrl=\"CPQCartItemConfigController\"></vloc-layout>\n                </div>\n\n            </div>\n\n        </div>\n\n    </div>\n\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** CPQ THEME VARIABLES ***/\n@import \"cpq-theme-variables\";\n\n/*** MIXINS ***/\n@import \"cpq-mixin\";\n\n/* $cpq-namespace is defined in cpq-base-variables */\n$namespace: $cpq-namespace;\n\n/*** STYLES ***/\n.vlocity {\n    &.via-slds {\n        .#{$namespace}-base-grid {\n            background-color: $cpq-page-bg-color;\n        }\n        .#{$namespace}-container {\n            padding: $cpq-padding-large-horizontal $cpq-padding-large-horizontal/2;\n        }\n        .#{$namespace}-left-sidebar-wrapper {\n            transition: width 250ms ease-in;\n\n            &.hide-cpq-left-sidebar {\n                transition: width 250ms ease-out;\n                width: 0%;\n                visibility: hidden;\n            }\n        }\n        \n        .grouplist-sidebar-wrapper {\n            transition: width 250ms ease-in;\n\n            &.hide-grouplist-sidebar {\n                transition: width 250ms ease-out;\n                width: 0%;\n                visibility: hidden;\n            }\n        }\n        .#{$namespace}-cart-container-wrapper {\n            transition: width 250ms ease-in;\n        }\n        .#{$namespace}-attribute-config-panel-hide {\n            transition: margin-right 250ms ease-in;\n            margin-right: -33.5%;\n        }\n        .#{$namespace}-attribute-config-panel-show {\n            transition: margin-right 250ms ease-in;\n            margin-right: 0%;\n        }\n\n        .#{$namespace}-show-hide-button {\n            margin-left: -9px;\n            width: 10px;\n            height: auto; /* IE */\n            height: initial;\n            border-radius:0px;\n            border: none;\n            color: $black;\n            opacity: 0.6;\n            font-weight: 600;\n            font-size: 40px;\n\n            &:focus {\n                box-shadow: none;\n            }\n            &:hover {\n                opacity: 1;\n            }\n            &.cursor-point-west {\n                cursor: w-resize;\n            }\n            &.cursor-point-east {\n                cursor: e-resize;\n            }\n            .hide-show-icon {\n                fill: $black;\n            }\n        }\n        .button-divider {\n            background: white;\n            padding: 0px 5px;\n            margin: 0px 8px;\n        }\n        @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {\n            .#{$namespace}-cart-container {\n                height: calc(100vh - 80px);\n            }\n        }\n        // 64rem\n        @media screen and (max-width: $bp-large) {\n            .#{$namespace}-base-grid {\n                input {\n                    -webkit-appearance: none;\n                }\n            }\n\n            .#{$namespace}-container {\n                padding: 1rem 0 0;\n                position: absolute;\n                width: 100%;\n                bottom: 0;\n                left: 0;\n                overflow: hidden;\n\n                .#{$namespace}-tablet-overlay.slds-backdrop {\n                    z-index: 990;\n                    transition: opacity 250ms ease-in,\n                                visibility 0ms linear 250ms;\n                }\n                &.#{$namespace}-outer-col-visible {\n                    .#{$namespace}-tablet-overlay.slds-backdrop--open {\n                        transition: opacity 250ms ease-in;\n                    }\n                }\n            }\n            \n            .#{$namespace}-left-sidebar-wrapper {\n                transition-property: left;\n                position: fixed;\n                z-index: 999;\n                margin-left: 0;\n                left: -33.33%;\n                top: 0;\n                height: 100%;\n                background-color: $cards-gray;\n\n                ng-include {\n                    display: block;\n                }\n\n                .#{$namespace}-left-sidebar-container {\n                    width: 100%;\n                    position: relative;\n\n                    button.#{$namespace}-show-hide-button {\n                        position: absolute;\n                        right: -10px;\n                        z-index: 9999;\n                        top: 50%;\n                        transform: translateY(-50%);\n                        width: 2.75rem;\n                        height: 2.75rem;\n                        right: -2.75rem;\n                        background-color: rgba(0,0,0,0.5);\n                        border-top-right-radius: .25rem;\n                        border-bottom-right-radius: .25rem;\n\n                        > .slds-button__icon.#{$namespace}-show-hide-button-icon {\n                            position: absolute;\n                            top: 50%;\n                            left: 50%;\n                            transform: translateY(-50%) translateX(-50%);\n                            fill: #fff;\n                            width: 1.25rem;\n                            height: 1.25rem;\n                            transition: transform 500ms ease-in;\n                        } \n                    }\n                }\n\n                &.#{$namespace}-left-sidebar-visible {\n                    margin-left: 0;\n                    left: 0;\n                    box-shadow: 1px 0 5px rgba(0,0,0,0.3);\n\n                    .#{$namespace}-left-sidebar-container {\n                        button.#{$namespace}-show-hide-button {\n                            > .slds-button__icon.#{$namespace}-show-hide-button-icon {\n                                transform: translateY(-50%) translateX(-50%) rotate(180deg);\n                            }\n                        }\n                    }\n                }\n            }\n\n            .#{$namespace}-cart-container-wrapper {\n\n            }\n\n            .#{$namespace}-product-container-wrapper {\n                transition-property: right;\n                position: fixed;\n                z-index: 999;\n                margin-right: 0;\n                right: -33.33%;\n                top: 0;\n                height: 100%;\n                overflow-y: auto;\n                background-color: #fff;\n\n                ng-include {\n                    display: block;\n                }\n\n                &.#{$namespace}-product-container-visible {\n                    margin-right: 0;\n                    right: 0;\n                    box-shadow: 0 1px 5px rgba(0,0,0,0.3);\n                }\n            }\n        }\n\n        // 48rem\n        @media screen and (max-width: $bp-medium) {\n\n        }\n\n        // 30rem\n        @media screen and (max-width: $bp-small) {\n\n        }\n    }\n}\n\n[dir=rtl] .vlocity {\n    &.via-slds {\n        &.via-omni {\n            form[stepForm] {\n                margin: 0px;\n                padding: 0px;\n                border: none;\n            }\n            ng-form {\n                padding-right: 0px;\n            }\n        }\n        .#{$namespace}-left-sidebar-wrapper {\n            transition-property: margin-right;\n            margin-right: -25%;\n            margin-left: 0;\n\n            &.#{$namespace}-left-sidebar-visible {\n                margin-right: 0;\n            }\n        }\n        .#{$namespace}-product-container-wrapper {\n            transition-property: margin-left;\n            margin-left: -25%;\n            margin-right: 0;\n\n            &.#{$namespace}-product-container-visible {\n                margin-left: 0;\n            }\n        }\n        .#{$namespace}-show-hide-button {\n            margin-left: 0;\n            position: relative;\n            left: 8px;\n            margin-right:0;\n        }\n\n        // 64rem\n        @media screen and (max-width: $bp-large) {\n            .#{$namespace}-left-sidebar-wrapper {\n                transition-property: right;\n                right: -25%;\n                left: auto;\n                margin-right: 0;\n\n                .#{$namespace}-left-sidebar-container {\n                    button.#{$namespace}-show-hide-button {\n                        left: -2.75rem;\n                        right: auto;\n                        border-radius: 0.25rem 0 0 0.25rem;\n\n                        > .slds-button__icon.#{$namespace}-show-hide-button-icon {\n                            transform: translateY(-50%) translateX(-50%) rotate(180deg);\n                        }\n                    }\n                }\n\n                &.#{$namespace}-left-sidebar-visible {\n                    right: 0;\n                    left: auto;\n\n                    .#{$namespace}-left-sidebar-container {\n                        button.#{$namespace}-show-hide-button {\n                            > .slds-button__icon.#{$namespace}-show-hide-button-icon {\n                                transform: translateY(-50%) translateX(-50%);\n                            }\n                        }\n                    }\n                }\n            }\n            .#{$namespace}-product-container-wrapper {\n                transition-property: left;\n                left: -25%;\n                right: auto;\n                margin-left: 0;\n\n                &.#{$namespace}-product-container-visible {\n                    left: 0;\n                    right: auto;\n                }\n            }\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-base-grid",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-cpq-base-grid/%vlocity_namespace%__VlocityUITemplate__c/multiservice-cpq-base-grid"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-base-grid",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-base-grid",
            "VlocityDataPackName": "multiservice-cpq-base-grid",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** CPQ THEME VARIABLES ***/\n/*** \n   ***** CPQ THEME VARIABLES ****\n   Add only the theme file here. Don't add any code here.\n   It's easier to swap the theme here rather than swapping in every other template.\n   If you swap the theme here, all templates will automatically get the latest.\n   Note: You need to re save all the templates once you change the theme. Also, if you change theme files, refresh the browser and then save the templates.\n***/\n/*** CPQ BASE THEME VARIABLES ***/\n/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n/* $cpq-namespace is defined in cpq-base-variables */\n/*** STYLES ***/\n.vlocity.via-slds .cpq-base-header-card .cpq-dropdown-to-btn {\n  left: -110%; }\n\n.vlocity.via-slds .cpq-base-header-card .cpq-base-header-picklist-label {\n  width: 9rem; }\n\n.vlocity.via-slds .cpq-base-header-card .cpq-base-header-dropdown {\n  width: 9rem; }\n\n.vlocity.via-slds .cpq-base-header-card .cpq-base-header-title {\n  display: block;\n  word-wrap: break-word;\n  max-width: 10rem; }\n\n.vlocity.via-slds .cpq-base-header-card .cpq-base-header-badge {\n  padding: 5px 15px;\n  margin: auto;\n  margin-right: 5px; }\n\n.vlocity.via-slds .group-cart-badge {\n  background-color: #027e46;\n  color: white; }\n\n[dir=rtl] .vlocity.via-slds .cpq-base-header-card .cpq-dropdown-to-btn {\n  right: -1rem; }\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-cpq-base-header-card/1/Vlocity/1562577166329",
                        "%vlocity_namespace%__HTML__c": "<div class=\"slds-grid cpq-base-header-card\">\n    <div class=\"slds-col slds-has-flexi-truncate\">\n        <div class=\"slds-media\">\n            <div class=\"slds-media__figure\" ng-if=\"obj['Account.PhotoUrl']\">\n              <img class=\"slds-icon slds-icon_large\" src=\"{{obj['Account.PhotoUrl']}}\" />\n            </div>\n            <div class=\"slds-media__figure\" ng-if=\"!obj['Account.PhotoUrl']\">\n              <slds-svg-icon sprite=\"'standard'\" size=\"'large'\" icon=\"'opportunity'\" extra-classes=\"'slds-icon-standard-opportunity'\" ng-if=\"obj.ObjectType === 'Opportunity'\"></slds-svg-icon>\n              <slds-svg-icon sprite=\"'standard'\" size=\"'large'\" icon=\"'quotes'\" extra-classes=\"'slds-icon-standard-quotes'\" ng-if=\"obj.ObjectType === 'Quote'\"></slds-svg-icon>\n              <slds-svg-icon sprite=\"'standard'\" size=\"'large'\" icon=\"'orders'\" extra-classes=\"'slds-icon-standard-orders'\" ng-if=\"obj.ObjectType === 'Order'\"></slds-svg-icon>\n            </div>\n            <div class=\"slds-media__body\">\n                <div class=\"slds-grid slds-nowrap slds-size_9-of-12\">\n                    <div class=\"slds-col slds-shrink slds-text-align_left\">\n                        <div class=\"slds-grid\">\n                          <h1 class=\"slds-page-header__title slds-m-right--small slds-truncate slds-align-middle\" title=\"{{::obj.Name}}\">{{::obj.Name}}</h1>\n                          <span ng-if=\"obj.ObjectType === 'Quote' && $root.groupCart\" class=\"slds-badge group-cart-badge\">Group</span>\n                        </div>\n                        <span ng-repeat=\"field in data.fields\" class=\"slds-text-body--small slds-page-header__info\">\n                        {{::obj.OrderStatus__c | uppercase}}\n                        <span ng-if=\"!$last\" class=\"separator\">\"</span>\n                        </span>\n                    </div>\n                    <div class=\"slds-col slds-shrink slds-text-align_left\">\n                        <div ng-if=\"attrs.enablePricing\">\n                          <vloc-layout layout-name=\"cpq-base-header-pricelist\" ctrl=\"CPQPricelistsController\" parent=obj></vloc-layout>\n                        </div>\n                    </div>\n                    <div class=\"slds-col slds-shrink slds-text-align_left\">\n                        <div ng-if=\"attrs.enableLoyaltyPoints === 'true'\">\n                          <vloc-layout layout-name=\"cpq-base-header-payment-choice\" ctrl=\"CPQPricelistsController\" parent=obj></vloc-layout>\n                        </div>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n    <div class=\"slds-col slds-no-flex slds-align-top\">\n        <div class=\"slds-button-group\" role=\"group\">\n            <span ng-show=\"obj.IsChangesAllowed__c === 'false'\" class=\"slds-badge cpq-base-header-badge\">\n                {{::importedScope.customLabels.CPQCancelOrderLocked}}\n            </span>\n\n            <button class=\"slds-button slds-m-left_large slds-button_neutral\"\n                ng-click=\"importedScope.invokeOrderAction(obj.actions)\"\n                ng-show=\"obj.actions && obj.actions.prevalidate\"\n                ng-disabled=\"importedScope.progress.isProcessing\">\n                {{::importedScope.customLabels.CPQCancelOrder}}\n            </button>\n            \n            <!-- Action Buttons -->\n            <button ng-repeat=\"action in data.actions | limitTo: 2\" \n                class=\"slds-button slds-button_neutral\"\n                ng-click=\"performAction(action)\"\n                id=\"{{idPrefix}}-import-btn\" \n                title=\"{{::$root.vlocity.getCustomLabel(action[$root.nsPrefix+'CustomLabelName__c'] ? action[$root.nsPrefix+'CustomLabelName__c'] : action.displayName, action.displayName)}}\">\n                {{::$root.vlocity.getCustomLabel(action[$root.nsPrefix+'CustomLabelName__c'] ? action[$root.nsPrefix+'CustomLabelName__c'] : action.displayName, action.displayName)}}\n            </button>\n            \n            <div class=\"slds-dropdown-trigger slds-dropdown-trigger_click slds-button_last\" ng-class=\"{'slds-is-open': isOpen}\" type=\"'button-group'\" aria-expanded=\"true\" ng-if=\"data.actions.length > 2\">\n              \n                <button cpq-dropdown-handler=\"isOpen = false\" class=\"slds-button slds-button_icon-border-filled\" aria-haspopup=\"true\" ng-click=\"isOpen = !isOpen\" id=\"{{idPrefix}}-toggle\" title=\"{{::importedScope.customLabels.CPQShowMore}}\">\n                    <slds-button-svg-icon size=\"type === 'button-group' ? null : 'small'\" sprite=\"'utility'\" icon=\"'down'\" ></slds-button-svg-icon>\n                    <span class=\"slds-assistive-text\">{{::importedScope.customLabels.CPQShowMore}}</span> \n                </button>\n                \n                <div class=\"slds-dropdown slds-dropdown_down slds-dropdown_actions cpq-dropdown-to-btn\">\n                    <ul class=\"dropdown__list\" role=\"menu\">\n                        <li class=\"slds-dropdown__item\" ng-repeat=\"action in data.actions\" ng-if=\"$index >= 2\">\n                            <a role=\"menuitem\" ng-href=\"#\" ng-click=\"performAction(action)\" title=\"{{::$root.vlocity.getCustomLabel(action[$root.nsPrefix+'CustomLabelName__c'] ? action[$root.nsPrefix+'CustomLabelName__c'] : action.displayName, action.displayName)}}\">\n                                <p class=\"slds-truncate\">\n                                    <slds-svg-icon size=\"'x-small'\" extra-classes=\"'slds-m-right_x-small'\"  sprite=\"item.icon(this).sprite\" icon=\"item.icon(this).icon\" ng-show=\"item.icon(this).icon\"></slds-svg-icon>\n                                    {{::$root.vlocity.getCustomLabel(action[$root.nsPrefix+'CustomLabelName__c'] ? action[$root.nsPrefix+'CustomLabelName__c'] : action.displayName, action.displayName)}}\n                                </p>\n                            </a>\n                        </li>\n                    </ul>\n                </div>\n            </div>\n            <!-- End Action Buttons -->\n        </div>\n    </div>\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** CPQ THEME VARIABLES ***/\n@import \"cpq-theme-variables\";\n\n/* $cpq-namespace is defined in cpq-base-variables */\n$namespace: $cpq-namespace;\n\n/*** STYLES ***/\n.vlocity {\n    &.via-slds {\n        .#{$namespace}-base-header-card {\n            .#{$namespace}-dropdown-to-btn {\n                left: -110%;\n            }\n            .#{$namespace}-base-header-picklist-label {\n                width:9rem;\n            }\n            .#{$namespace}-base-header-dropdown {\n                width:9rem;\n            }\n            .#{$namespace}-base-header-title {\n                display: block;\n                word-wrap: break-word;\n                max-width: 10rem;\n            }  \n            .#{$namespace}-base-header-badge {\n                padding: 5px 15px;\n                margin: auto;\n                margin-right: 5px;\n            }  \n        }\n        .group-cart-badge {\n            background-color: #027e46;\n            color: white;\n        }\n    }\n}\n\n[dir=rtl] .vlocity {\n    &.via-slds {\n        .#{$namespace}-base-header-card {\n            .#{$namespace}-dropdown-to-btn {\n                right: -1rem;\n            }\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Cards",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-base-header-card",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-cpq-base-header-card/%vlocity_namespace%__VlocityUITemplate__c/multiservice-cpq-base-header-card"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-base-header-card",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-base-header-card",
            "VlocityDataPackName": "multiservice-cpq-base-header-card",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": ".via-slds .multiservice-group-list .highlight-group {\n  background-color: #d8edff;\n  border-left: solid 2px #0070d2; }\n\n.via-slds .multiservice-group-list .fill-success {\n  fill: #027e46; }\n\n.via-slds .multiservice-group-list .fill-warning {\n  fill: #ffb75d; }\n\n.via-slds .multiservice-group-list .fill-blue {\n  fill: #005fb2; }\n\n.via-slds .multiservice-group-list .group-validation-success-badage {\n  background-color: #027e46;\n  color: white;\n  font-size: .200rem;\n  padding: 5px;\n  float: right; }\n\n.via-slds .multiservice-group-list .circle-container {\n  border-radius: 50%;\n  padding: 1px 4px 3px 4px;\n  float: right; }\n  .via-slds .multiservice-group-list .circle-container svg {\n    fill: white; }\n\n.via-slds .multiservice-group-list .circle-container-error {\n  background-color: #d42727; }\n  .via-slds .multiservice-group-list .circle-container-error:hover {\n    background-color: #d42727; }\n  .via-slds .multiservice-group-list .circle-container-error:active {\n    background-color: #d42727; }\n\n.via-slds .multiservice-group-list .circle-container-success {\n  background-color: #027e46; }\n  .via-slds .multiservice-group-list .circle-container-success:hover {\n    background-color: #027e46; }\n  .via-slds .multiservice-group-list .circle-container-success:active {\n    background-color: #027e46; }\n\n.via-slds .multiservice-group-list .circle-container-warning {\n  background-color: #ffb75d; }\n  .via-slds .multiservice-group-list .circle-container-warning:hover {\n    background-color: #ffb75d; }\n  .via-slds .multiservice-group-list .circle-container-warning:active {\n    background-color: #ffb75d; }\n\n.via-slds .multiservice-group-list .service-name-wrapper {\n  display: inline-block;\n  max-width: 9.5vw;\n  white-space: nowrap;\n  overflow: hidden;\n  text-overflow: ellipsis; }\n\n.via-slds .multiservice-group-list section.less-right-padding {\n  padding-right: 2px; }\n\n.via-slds .multiservice-group-list .summary-action {\n  display: inline-block;\n  width: 100%; }\n  .via-slds .multiservice-group-list .summary-action:focus {\n    box-shadow: none; }\n\n.via-slds .multiservice-group-list .summary-action-icon {\n  vertical-align: top;\n  margin-top: 5px; }\n\n.via-slds .multiservice-group-list .status-icon {\n  vertical-align: top;\n  float: right;\n  margin-top: 5px;\n  margin-right: 2px; }\n\n.via-slds .multiservice-group-list .group-name-wrapper {\n  display: inline-block;\n  max-width: 9.5vw;\n  white-space: nowrap;\n  overflow: hidden;\n  text-overflow: ellipsis; }\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-cpq-group-list/1/Vlocity/1562153803300",
                        "%vlocity_namespace%__HTML__c": "<div class=\"slds-spinner_container\" ng-hide=\"isLoaded\">\n    <div class=\"slds-spinner_brand slds-spinner slds-spinner_medium\" aria-hidden=\"false\" role=\"alert\">\n        <div class=\"slds-spinner__dot-a\"></div>\n        <div class=\"slds-spinner__dot-b\"></div>\n    </div>\n</div>\n<div class=\"multiservice-group-list slds-size_1-of-1\" ng-controller=\"CPQGroupController\">\n    <div class=\"slds-size_1-of-1\">\n        <div ng-if=\"!groupList || groupList.length === 0\" class=\"slds-text-align_center slds-p-top_medium\">\n            No Records found.\n        </div>\n    </div>\n    <div class=\"slds-size_1-of-1\">\n        <ul class=\"slds-accordion\" ng-if=\"groupList.length > 0\">\n            <li class=\"slds-accordion__list-item\" ng-repeat=\"group in groupList\" \n            ng-class=\"($root.cartId === group.groupCartId) ? 'highlight-group' : ''\">\n                <section class=\"slds-accordion__section less-right-padding\" ng-class=\"{'slds-is-open': group.$toggle}\">\n                    <div class=\"slds-accordion__summary\">\n                        <button aria-controls=\"accordion-details-{{group.groupId}}\" aria-expanded=\"{{group.$toggle}}\"\n                        class=\"slds-button slds-button_reset slds-accordion__summary-action summary-action\"\n                        ng-click=\"group.$toggle = !group.$toggle; getGroupedServices(group)\">\n                            <slds-button-svg-icon sprite=\"'utility'\" size=\"'small'\" icon=\"'switch'\" \n                            extra-classes=\"'slds-accordion__summary-action-icon summary-action-icon slds-button__icon slds-button__icon_left'\"></slds-button-svg-icon>\n                            <!--<span class=\"\" ng-attr-title=\"{{group.groupName}}({{group.itemsCount ? group.itemsCount : 0}})\">-->\n                            <a class=\"group-name-wrapper\" ng-attr-title=\"{{group.groupName}}({{group.itemsCount ? group.itemsCount : 0}})\" href=\"{{group.groupCartURL}}\">{{group.groupName}} ({{group.itemsCount ? group.itemsCount : 0}})</a>\n                            <!--</span>-->\n\n                            <slds-svg-icon ng-if=\"group.applyToGroup\" sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'dash'\" \n                            extra-classes=\"'status-icon slds-icon-text-warning'\"></slds-svg-icon>\n                            <slds-svg-icon ng-if=\"!group.applyToGroup && !group.priceValidate && !group.hasUnappliedGroupItems && (!group.groupCart[$root.nsPrefix + 'IsPriced__c'] && !group.groupCart[$root.nsPrefix + 'IsValidated__c'])\"\n                            sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'check'\" extra-classes=\"'status-icon fill-blue'\"></slds-svg-icon>\n\n                            <span ng-if=\"!group.priceValidate && !group.hasUnappliedGroupItems && group.groupCart[$root.nsPrefix + 'IsPriced__c'] && group.groupCart[$root.nsPrefix + 'IsValidated__c']\" \n                                    class=\"slds-badge group-validation-success-badage\">Complete\n                            </span>\n                            <span ng-if=\"!group.priceValidate && !group.hasUnappliedGroupItems && group.groupCart[$root.nsPrefix + 'IsPriced__c'] && !group.groupCart[$root.nsPrefix + 'IsValidated__c']\" \n                                    class=\"circle-container circle-container-error\">\n                                <slds-svg-icon sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'error'\" extra-classes=\"''\"></slds-svg-icon>\n                            </span>\n                            <span ng-if=\"group.priceValidate\" class=\"circle-container circle-container-warning\">\n                                <slds-svg-icon sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'dash'\" extra-classes=\"''\"></slds-svg-icon>\n                            </span>\n                        </button>\n                    </div>\n                    <div class=\"slds-accordion__content\" id=\"accordion-details-{{group.groupId}}\">\n                        <ul class=\"slds-accordion\" >\n                            <li class=\"slds-accordion__list-item\" ng-repeat=\"groupedItem in group.services\"\n                                ng-class=\"$root.cartId === groupedItem.quoteId ? 'highlight-group' : ''\">\n                                <section class=\"slds-accordion__section less-right-padding\" ng-class=\"{'slds-is-open': groupedItem.$toggle}\">\n                                    <div class=\"slds-accordion__summary\">\n                                        <button aria-controls=\"accordion-details-{{groupedItem.Id.value}}\" aria-expanded=\"{{groupedItem.$toggle}}\"\n                                        class=\"slds-button slds-button_reset slds-accordion__summary-action summary-action\"\n                                        ng-click=\"groupedItem.$toggle = !groupedItem.$toggle\">\n                                            <slds-button-svg-icon sprite=\"'utility'\" size=\"'small'\" icon=\"'switch'\" \n                                            extra-classes=\"'slds-accordion__summary-action-icon summary-action-icon slds-button__icon slds-button__icon_left'\"></slds-button-svg-icon>\n                                            <!--<span class=\"slds-truncate\" title=\"{{groupedItem.Name.value}}\">-->\n                                            <a href=\"{{groupedItem.quoteURL}}\" title=\"{{groupedItem.Name.value}}\" class=\"service-name-wrapper\">{{groupedItem[$root.nsPrefix + 'MarketIdentifier__c'].value}}</a>\n                                            <!--</span>-->\n                                            <slds-svg-icon ng-if=\"!groupedItem.applyToGroup && !groupedItem.priceValidate && groupedItem.quoteId && !groupedItem.quote[$root.nsPrefix + 'IsPriced__c'] && !groupedItem.quote[$root.nsPrefix + 'IsValidated__c']\" \n                                            sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'check'\" extra-classes=\"'status-icon fill-blue'\"></slds-svg-icon>\n                                            <slds-svg-icon ng-if=\"groupedItem.applyToGroup\" sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'dash'\" \n                                            extra-classes=\"'status-icon slds-icon-text-warning'\"></slds-svg-icon>\n\n                                            <span ng-if=\"groupedItem.priceValidate\" class=\"circle-container circle-container-warning\">\n                                                <slds-svg-icon sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'dash'\" extra-classes=\"''\"></slds-svg-icon>\n                                            </span>\n                                            <span ng-if=\"!groupedItem.priceValidate && !groupedItem.applyToGroup && groupedItem.quote[$root.nsPrefix + 'IsPriced__c'] && groupedItem.quote[$root.nsPrefix + 'IsValidated__c']\" class=\"circle-container circle-container-success\">\n                                                <slds-svg-icon sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'check'\" extra-classes=\"''\"></slds-svg-icon>\n                                            </span>\n                                            <span ng-if=\"!groupedItem.priceValidate && !groupedItem.applyToGroup && groupedItem.quote[$root.nsPrefix + 'IsPriced__c'] && !groupedItem.quote[$root.nsPrefix + 'IsValidated__c']\" class=\"circle-container circle-container-error\">\n                                                <slds-svg-icon sprite=\"'utility'\" size=\"'xx-small'\" icon=\"'error'\" extra-classes=\"''\"></slds-svg-icon>\n                                            </span>\n                                        </button>\n                                    </div>\n                                    <div class=\"slds-accordion__content\" id=\"accordion-details-{{groupedItem.Id.value}}\">\n                                        {{groupedItem[$root.nsPrefix + 'PremisesId__r.Name'].value}}\n                                    </div>\n                                </section>\n                            </li>\n                            <li class=\"slds-accordion__list-item\" ng-if=\"group.isLoading\">\n                                <div class=\"slds-spinner_brand slds-spinner slds-spinner_x-small\" aria-hidden=\"false\" role=\"alert\">\n                                    <div class=\"slds-spinner__dot-a\"></div>\n                                    <div class=\"slds-spinner__dot-b\"></div>\n                                </div>\n                            </li>\n                            <li class=\"slds-accordion__list-item\" ng-if=\"!group.isLoading && group.services.length < group.itemsCount && group.actions.getGroupedServices\">\n                                <div class=\"slds-grid slds-grid_align-center slds-m-top_x-small\">\n                                    <button class=\"slds-button slds-button_neutral\" ng-click=\"getMoreGroupedServices(group)\">\n                                        Load More\n                                    </button>\n                                </div>\n                            </li>\n                        </ul>\n                    </div>\n                </section>\n            </li>\n            <li class=\"slds-accordion__list-item\" ng-if=\"groupTotalCount > groupList.length && records.actions.nextGroups && !isGroupsLoading\">\n                <div class=\"slds-grid slds-grid_align-center slds-m-top_x-small\">\n                    <button class=\"slds-button slds-button_neutral\" ng-click=\"getMoreGroups(records.actions.nextGroups)\">\n                        Load More\n                    </button>\n                </div>\n            </li>\n            <li class=\"slds-accordion__list-item\" ng-if=\"isGroupsLoading\">\n                <div class=\"slds-spinner_brand slds-spinner slds-spinner_x-small\" aria-hidden=\"false\" role=\"alert\">\n                    <div class=\"slds-spinner__dot-a\"></div>\n                    <div class=\"slds-spinner__dot-b\"></div>\n                </div>\n            </li>\n        </ul>\n    </div>\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": ".via-slds {\n    .multiservice-group-list{\n        .highlight-group {\n            background-color: #d8edff;\n            border-left: solid 2px #0070d2;\n        }\n        .fill-success {\n            fill: #027e46;\n        }\n        .fill-warning {\n            fill: #ffb75d;\n        }\n        .fill-blue {\n            fill: #005fb2;\n        }\n        .group-validation-success-badage {\n            background-color: #027e46;\n            color: white;\n            font-size: .200rem;\n            padding: 5px;\n            float: right;\n        }\n        .circle-container {\n            border-radius: 50%;\n            padding: 1px 4px 3px 4px;\n            float: right;\n            svg {\n                fill: white;\n            }\n        }\n        .circle-container-error {\n            background-color: #d42727;\n            &:hover {\n                background-color: #d42727;\n            }\n            &:active {\n                background-color: #d42727;\n            }\n        }\n        .circle-container-success {\n            background-color: #027e46;\n            &:hover {\n                background-color: #027e46;\n            }\n            &:active {\n                background-color: #027e46;\n            }\n        }\n        .circle-container-warning {\n            background-color: #ffb75d;\n            &:hover {\n                background-color: #ffb75d;\n            }\n            &:active {\n                background-color: #ffb75d;\n            }\n        }\n        .service-name-wrapper {\n            display: inline-block;\n            max-width: 9.5vw;\n            white-space: nowrap;\n            overflow: hidden;\n            text-overflow: ellipsis;\n        }\n        section.less-right-padding {\n            padding-right: 2px;\n        }\n        .summary-action {\n            display: inline-block;\n            width: 100%;\n            &:focus {\n                box-shadow: none;\n            }\n        }\n        .summary-action-icon {\n            vertical-align: top;\n            margin-top: 5px;\n        }\n        .status-icon {\n            vertical-align: top;\n            float: right;\n            margin-top: 5px;\n            margin-right: 2px;\n        }\n        .group-name-wrapper {\n            display: inline-block;\n            max-width: 9.5vw;\n            white-space: nowrap;\n            overflow: hidden;\n            text-overflow: ellipsis;\n        }\n\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-group-list",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-cpq-group-list/%vlocity_namespace%__VlocityUITemplate__c/multiservice-cpq-group-list"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-group-list",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-group-list",
            "VlocityDataPackName": "multiservice-cpq-group-list",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-cpq-grouplist-sidebar/1/Vlocity/1562155166040",
                        "%vlocity_namespace%__HTML__c": "<div class=\"slds-grid slds-grid_vertical cpq-left-sidebar scroll\">\n    <div class=\"slds-col slds-no-flex slds-input-has-icon slds-input-has-icon_left cpq-searchbox\">\n        <slds-svg-icon sprite=\"'utility'\" size=\"'x-small'\" icon=\"'search'\" extra-classes=\"'slds-input__icon slds-icon-text-default'\"></slds-svg-icon>\n        <input type=\"text\" class=\"slds-input\" placeholder=\"{{::importedScope.customLabels.CPQSearch}}\" ng-model=\"importedScope.searchTerm\" \n        ng-model-options=\"{ updateOn: 'default blur', debounce: { 'default': 1000, 'blur': 0 } }\"\n        ng-change=\"importedScope.searchGroups()\" />\n    </div>\n\n    <div class=\"slds-col cpq-items-container scroll\">\n        <vloc-layout layout-name=\"multiservice-cpq-group-list\" class=\"slds-size_1-of-1 slds-scrollable_y\"></vloc-layout>\n    </div>\n\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-grouplist-sidebar",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-cpq-grouplist-sidebar/%vlocity_namespace%__VlocityUITemplate__c/multiservice-cpq-grouplist-sidebar"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-grouplist-sidebar",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-grouplist-sidebar",
            "VlocityDataPackName": "multiservice-cpq-grouplist-sidebar",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": "/*** CPQ THEME VARIABLES ***/\n/*** \n   ***** CPQ THEME VARIABLES ****\n   Add only the theme file here. Don't add any code here.\n   It's easier to swap the theme here rather than swapping in every other template.\n   If you swap the theme here, all templates will automatically get the latest.\n   Note: You need to re save all the templates once you change the theme. Also, if you change theme files, refresh the browser and then save the templates.\n***/\n/*** CPQ BASE THEME VARIABLES ***/\n/*** CPQ BASE VARIABLES ***/\n/*** \n    Do not modify this variables, Instead use Themes.\n    Modify only when you are sure what you are doing and the impact it may have.\n    These variables are used in different templates/themes.\n**/\n/*** SLDS VARIABLES ***/\n/*** MIXINS ***/\n/*** MIXINS ***/\n/*** STYLES ***/\n.vlocity.via-slds .cpq-total-card {\n  margin-top: 16px; }\n  .vlocity.via-slds .cpq-total-card .cart-action button {\n    margin: 10px; }\n",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-cpq-total-card/1/Vlocity/1562582131143",
                        "%vlocity_namespace%__HTML__c": "<div class=\"slds-grid slds-nowrap cpq-total-card\">\n    <div class=\"slds-col slds-shrink slds-text-align--center\" ng-repeat=\"field in data.fields\">\n        <div class=\"slds-text-body--small\">\n            {{obj | getter: field: 'label' }}\n        </div>\n        <div class=\"slds-text-heading--medium\">\n            {{obj | getter: field | picker: field.type}}\n        </div>  \n    </div>\n    <div class=\"slds-col slds-align-middle cart-action slds-no-flex\">\n        <button class=\"slds-button slds-m-left_large slds-button_brand\"  \n          ng-repeat=\"action in data.actions | limitTo:1\"\n          ng-click=\"importedScope.actionClicked(action)\"\n          ng-disabled=\"(!records.actions || !records.actions.checkout) && (records.canCheckoutDiscounts === false || records.isCartActivated === true || records.isNotActiveContractDiscountPresent === true) || importedScope.hasError || $root.isToDisableGroupButton\">\n          <span ng-show=\"records.actions && records.actions.checkout\">{{::$root.vlocity.getCustomLabel(action[$root.nsPrefix+'CustomLabelName__c'] ? action[$root.nsPrefix+'CustomLabelName__c'] : action.displayName, action.displayName)}}</span>\n          <span ng-show=\"(!records.actions || !records.actions.checkout) && records.canCheckoutDiscounts === true && records.isCartActivated === false && records.isNotActiveContractDiscountPresent === false\">{{::importedScope.customLabels.CPQSubmit}}</span>\n          <span ng-show=\"(!records.actions || !records.actions.checkout) && (records.canCheckoutDiscounts === false || records.isCartActivated === true || records.isNotActiveContractDiscountPresent === true)\">\n            {{::importedScope.customLabels.CPQTotalIncomplete}}\n          </span>\n        </button>\n    </div>\n</div>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": "/*** CPQ THEME VARIABLES ***/\n@import \"cpq-theme-variables\";\n\n/*** MIXINS ***/\n@import \"cpq-mixin\";\n\n/*** STYLES ***/\n.vlocity {\n    &.via-slds {\n        .cpq-total-card {\n            margin-top: $cpq-padding-large-horizontal;\n            \n            .cart-action {\n                button {\n                   margin: $cpq-padding-small-horizontal;  \n                }\n            }\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Cards",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-cpq-total-card",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-cpq-total-card/%vlocity_namespace%__VlocityUITemplate__c/multiservice-cpq-total-card"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-total-card",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-cpq-total-card",
            "VlocityDataPackName": "multiservice-cpq-total-card",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": ".via-slds .vlc-slds-page--header {\n  display: none !important; }\n\n.via-slds .manage-group .table-section {\n  overflow-x: scroll; }\n  .via-slds .manage-group .table-section .sortable-column {\n    padding: 1rem .5rem; }\n    .via-slds .manage-group .table-section .sortable-column:focus {\n      box-shadow: none; }\n    .via-slds .manage-group .table-section .sortable-column .slds-icon_container {\n      background: inherit; }\n      .via-slds .manage-group .table-section .sortable-column .slds-icon_container svg {\n        fill: #006dcc; }\n    .via-slds .manage-group .table-section .sortable-column a:focus {\n      outline: none; }\n\n.via-slds .manage-group .loading-top-padding {\n  padding-top: 50px; }\n\n.via-slds .manage-group .loadmore-padding {\n  padding-top: 15px;\n  padding-bottom: 15px; }\n\n.via-slds .manage-group .service-point-text-border-color {\n  border-color: #0070d2;\n  border-bottom-width: 1.5px; }\n\n.via-slds .manage-group .service-point-filter-section {\n  border: 1.5px solid #0070d2; }\n  .via-slds .manage-group .service-point-filter-section .datetime-input .date {\n    width: 50%;\n    display: inline-block; }\n  .via-slds .manage-group .service-point-filter-section .datetime-input .time {\n    width: 30%;\n    display: inline-block; }\n\n.via-slds .manage-group .slds-input {\n  min-height: 2rem;\n  height: 2rem; }\n\n.via-slds .manage-group .add-to-group-icon {\n  fill: #FFFFFF; }\n\n.via-slds .manage-group .group-name-icon {\n  fill: #0070d2; }\n\n.via-slds .manage-group .group-row td {\n  background-color: #F8F8FE; }\n\n.via-slds .manage-group .grouped-item-row td {\n  background-color: #DFE5EF; }\n\n.via-slds .manage-group .grouped-item-selected-row td {\n  background-color: #0070d2; }\n\n.via-slds .manage-group-popup .slds-input {\n  min-height: 2rem;\n  height: 2rem; }\n\n.via-slds .slds-notify .slds-notify__content .slds-icon {\n  fill: #fff; }\n",
                        "%vlocity_namespace%__CustomJavascript__c": "vlocity.cardframework.registerModule.controller('manageGroupController', ['$rootScope', '$scope' ,'$filter', '$sldsModal', '$sldsToast', '$q', '$sldsPrompt', 'remoteActions',\n    function($rootScope, $scope ,$filter, $sldsModal, $sldsToast, $q, $sldsPrompt, remoteActions) {\n        /*\n         * table columns fields list.\n         */\n        $scope.fieldList = [];\n        /*\n         * filter columns fields list.\n         */\n        $scope.filterFieldList = [];\n        /*\n         * object list to keep describe details.\n         */\n        $scope.objectList = [];\n        /*\n         * ungrouped item list.\n         */\n        $scope.ungroupedItemList = [];\n        /*\n         * group list and each group contains its items.\n         */\n        $scope.groupList = [];\n        /*\n         * custom labels.\n         */\n        $scope.customLabels = {selectDefaultOption: '--Select--'};\n        /*\n         * Boolean picklist.\n         */\n        $scope.booleanPicklists = [{label: 'False', value: false}, {label: 'True', value: true}];\n        /*\n         * sort by string.\n         */\n        $scope.sortByString = '';\n        /*\n         * store selected filters.\n         */\n        $scope.filters = {};\n        /*\n         * keep count of selected ungrouped items.\n         */\n        $scope.ungroupedItemSelected = 0;\n        /*\n         * keep count of selected grouped items.\n         */\n        $scope.groupedItemSelected = 0;\n        /*\n         * keep count of selected groups.\n         */\n        $scope.groupSelected = 0;\n        /*\n         * this flag is to show/hide groups in tables.\n         * groupShowHideFlag = true, show groups in tables.\n         * groupShowHideFlag = false, hide groups in tables.\n         */\n        $scope.groupShowHideFlag = true;\n        /*\n         * groupFlag is to show 'Create New Group' or 'Add to Group' buttons.\n         * if groupFlag is true, show 'Create New Group' and hide 'Add to Group'\n         * if groupFlag is false, show 'Add to Group' and hide 'Create New Group'.\n         */\n        $scope.groupFlag = true;\n        /*\n         * apply filter results on grouped item flag.\n         */\n        $scope.filterApplicable = {group: false};\n        /*\n         * pagination data.\n         */\n        $scope.groupedServicePagination = {\n            offset: 0,\n            pageSize: 20\n        }\n        $scope.groupePagination = {\n            offset: 0,\n            pageSize: 20\n        }\n        $scope.unGroupedServicePagination = {\n            offset: 0,\n            pageSize: 20\n        }\n        /*\n         * number of applied filter on ungrouped items.\n         */\n        $scope.numberOfFiltersApplied = 0;\n        /*\n         *\n         */\n        $scope.selectAllUngroupedItem = false;\n        /*\n         *\n         */\n        $scope.unGroupedServiceTotalCount = 0;\n        /*\n         * custom labels\n         */\n        var customLabels = ['MSGroupLabel', 'MSServiceLabel', 'MSShowLabel', 'MSHideLabel',\n                            'MSFilterLabel', 'MSClearFilterLabel', 'MSFiltersAppliedLabel',\n                            'MSCreateNewGroupLabel', 'MSRemoveFromGroupLabel', 'MSRenameGroupLabel',\n                            'MSItemsSelectedLabel', 'MSAddNewGroupLabel', 'MSApplyFiltersGroupedLabel',\n                            'MSGroupedItemsSelectedLabel', 'MSNoRecordsFoundLabel', 'MSLoadMoreLabel',\n                            'MSNoRecordsGroupsLabel', 'MSPreviousLabel', 'MSNextLabel', 'MSGroupNameLabel',\n                            'MSGroupDescLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSCloseLabel', 'MSLoadMoreGroupsLabel',\n                            'MSCreatingGroupMsg', 'MSUpdateGroupMsg', 'MSGroupUpdatedMsg', 'MSDeletingGroupMsg',\n                            'MSDeleteGroupsLabel', 'MSGroupDeletedMsg', 'MSGroupCreatedMsg', 'MSRemovingItemGroupMsg',\n                            'MSRemovedSuccMsg', 'MSAddedSuccMsg', 'MSAddingToMsg', 'MSApplyFilterLabel', 'MSAddToGroupLabel'];\n        /*\n         * custom labels map.\n         */ \n        $scope.customLabelsMap = {};\n        \n        var nextButtonId = 'ManageGroup_nextBtn';\n\n        $scope.$watch('bpTree.response.unGroupedServicePageSize', function(newValue, oldValue) {\n            if(newValue && parseInt(newValue)) {\n                $scope.unGroupedServicePagination.pageSize = parseInt(newValue);\n                //$scope.getUnGroupedServices();\n            }\n        });\n        $scope.$watch('bpTree.response.groupedServicePageSize', function(newValue, oldValue) {\n            if(newValue && parseInt(newValue)) {\n                $scope.groupedServicePagination.pageSize = parseInt(newValue);\n            }\n        });\n        $scope.$watch('bpTree.response.groupPageSize', function(newValue, oldValue) {\n            if(newValue && parseInt(newValue)) {\n                $scope.groupePagination.pageSize = parseInt(newValue);\n                //$scope.getGroups();\n            }\n        });\n        \n        $scope.$watch('groupList.length', function (newValue, oldValue) {\n            \n            if(!newValue || newValue === 0) {\n                nextButton(true);\n                return;\n            }\n\n            checkForNextButton();\n            \n        });\n\n        function checkForNextButton() {\n            if($scope.groupList && $scope.groupList.length > 0) {\n                var length = $scope.groupList.length;\n                for (let i = 0; i < length; i++) {\n                    if($scope.groupList[i].itemsCount && $scope.groupList[i].itemsCount > 0) {\n                        nextButton(false);\n                        return;\n                    }\n                }\n            }\n            nextButton(true);\n        }\n        \n\n        $scope.$watch('bpTree.selectedQuote.masterQuoteId', function (newValue, oldValue) {\n            \n            if(newValue) {\n                $scope.getUnGroupedServices();\n                $scope.getGroups();\n                $scope.bpTree.response.masterQuoteId = newValue;\n            }\n        });\n\n        function nextButton(disable) {\n\n            if(!nextButtonId) {\n                return;\n            }\n\n            if(disable) {\n                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'none', 'cursor': 'default', 'background': '#c9c7c5'});\n            } else {\n                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'auto', 'cursor': 'pointer', 'background': '#0070d2'});\n            }\n        }\n\n        /*\n         * initialize after controller load.\n         */\n        $scope.init = function() {\n            \n            $q.all([$scope.getFieldList(), $scope.getFilterFieldList()]).then(function(){\n                var i;\n                //colllect all object names\n                for(i=0; i< $scope.filterFieldList.length; i++) {\n                    if ($scope.objectList.indexOf($scope.filterFieldList[i].objectAPIName) === -1 && $scope.filterFieldList[i] !== '') {\n                        $scope.objectList.push($scope.filterFieldList[i].objectAPIName);\n                    }\n                }\n                for(i=0; i< $scope.fieldList.length; i++) {\n                    if ($scope.objectList.indexOf($scope.fieldList[i].objectName) === -1 && $scope.fieldList[i] !== '') {\n                        $scope.objectList.push($scope.fieldList[i].objectName);\n                    }\n                }\n                \n                $scope.getObjectDesc();\n            });\n            getCustomLabels();\n        }\n\n        $scope.getObjectDesc = function() {\n            var input = {'objectNames': $scope.objectList};\n            fireRemoteAction('getObjectFieldsDescribe', input, {}, function(result){\n                $scope.objectNameToFields = angular.fromJson(result).result;\n            });\n        }\n        $scope.getFieldList = function () {\n            return fireRemoteAction('getDisplayFieldList', {}, {}, function(result){\n                $scope.fieldList = angular.fromJson(result).result;\n            });\n        }\n        $scope.getFilterFieldList = function () {\n            return fireRemoteAction('getFilterFieldList', {}, {}, function(result){\n                $scope.filterFieldList = angular.fromJson(result).result;\n                $scope.filterFieldsMap = {};\n                if($scope.filterFieldList) {\n                    $scope.filterFieldList.forEach(function(filter){\n                        $scope.filterFieldsMap[filter.fieldName] = filter; \n                    })\n                }\n            });\n        }\n\n        $scope.clearFilters = function() {\n            $scope.filters = {};\n            $scope.appliedFilters = {};\n            $scope.unGroupedServicePagination.offset = 0;\n            $scope.filterApplicable = {group: false};\n            $scope.getUnGroupedServices();\n        }\n\n        $scope.enableClearFiltersButton = function() {\n            for(var prop in $scope.filters) {\n                if($scope.filters.hasOwnProperty(prop)) {\n                    return true;\n                }\n            }\n            return false;\n        }\n\n        $scope.previousServicePoints = function() {\n            var offset = $scope.unGroupedServicePagination.offset - $scope.unGroupedServicePagination.pageSize;\n            if(offset >= 0) {\n                $scope.unGroupedServicePagination.offset = offset;\n                $scope.getUnGroupedServices();\n            }\n        }\n\n        $scope.nextServicePoints = function() {\n            $scope.unGroupedServicePagination.offset += $scope.unGroupedServicePagination.pageSize;\n            $scope.getUnGroupedServices();\n        }\n\n        $scope.applyFilters = function() {\n\n            $scope.appliedFilters = {};\n            var value, f, fieldInfo, prop;\n            if($scope.filters) {\n                for(prop in $scope.filters) {\n                    f = $scope.filterFieldsMap[prop];\n                    value = $scope.filters[prop];\n                    if(value && value !== '') {\n                        fieldInfo = $scope.objectNameToFields[f.objectAPIName][f.fieldAPIName]\n                        if(fieldInfo && fieldInfo.type === 'string') {\n                            value = '%'+ value + '%';\n                        }\n                        $scope.appliedFilters[prop] = value;\n                    } else {\n                        delete $scope.filters[prop];\n                    }\n                }\n            }\n            $scope.unGroupedServicePagination.offset = 0;\n            $scope.getUnGroupedServices();\n            //this requires to clear out grouped items.\n            $scope.getGroups();\n        }\n\n        $scope.sortByColumn = function(clickedfield) {\n\n            var i, ascDesc = '', desc = '';\n            var clickedPos = clickedfield.clickedPos;\n\n            for(i=0; i<$scope.fieldList.length; i++) {\n                $scope.fieldList[i].clickedPos = undefined;\n            }\n\n            if(clickedPos && clickedPos === 'up') {\n                ascDesc = 'DESC';\n                clickedfield.clickedPos = 'down';\n                desc = '-'\n            } else {\n                ascDesc = 'ASC';\n                clickedfield.clickedPos = 'up';\n            }\n            $scope.sortByString = clickedfield.fieldName + ' ' + ascDesc;\n            $scope.sortByAngular = desc + clickedfield.fieldName + '.value';\n            $scope.unGroupedServicePagination.offset = 0;\n\n            $scope.getUnGroupedServices();\n        }\n\n        $scope.getMoreGroupedServices = function(group) {\n            if(!group.actions || !group.actions.getGroupedServices) {\n                return;\n            }\n            group.isLoading = true;\n            fireAction(group.actions.getGroupedServices, function(result) {\n                var res = angular.fromJson(result);\n                var action;\n                if(res && res.records) {\n                    for(i=0; i<res.records.length; i++) {\n                        group.services.push(res.records[i]);\n                    }\n                }\n                if(res && res.actions) {\n                    action = res.actions.getGroupedServices;\n                }\n                group.actions.getGroupedServices = action;\n                group.isLoading = false;\n            });\n        }\n\n        $scope.getGroupedServices = function(group) {\n\n            group.showItems = !group.showItems;\n            if(!group.showItems) {\n                return;\n            }\n            if(group.itemsCount == 0 || (group.services && group.services.length > 0)) {\n                return;\n            }\n            group.isLoading = true;\n            var filters;\n            if($scope.filterApplicable.group) {\n                filters = getFilters();\n            }\n\n            if(group.actions && group.actions.getGroupedServices \n                && group.actions.getGroupedServices.remote && group.actions.getGroupedServices.remote.params) {\n\n                group.actions.getGroupedServices.remote.params.pageSize = $scope.groupedServicePagination.pageSize;\n                if(filters) {\n                    group.actions.getGroupedServices.remote.params.filters = filters;\n                }\n                if($scope.sortByString !== '') {\n                    group.actions.getGroupedServices.remote.params.sortBy = $scope.sortByString;\n                }\n            }\n            \n\n            fireAction(group.actions.getGroupedServices, function(result) {\n                var res = angular.fromJson(result);\n                var action;\n                if(res) {\n                    group.services = res.records;\n                    if(res.actions) {\n                        action = res.actions.getGroupedServices;\n                    }\n                }\n                group.actions.getGroupedServices = action;\n                group.isLoading = false;\n            });\n        }\n\n        $scope.getGroups = function() {\n            $scope.isGroupsLoading = true;\n            var input = {\n                parentId: $scope.bpTree.ContextId,\n                contextId: $scope.bpTree.selectedQuote.masterQuoteId,\n                pageSize: $scope.groupePagination.pageSize,\n                offset: $scope.groupePagination.offset\n            };\n            fireRemoteAction('getGroups', input, {}, function(result){\n                $scope.groupList = [];\n                $scope.groupedItemSelected = 0;\n                $scope.groupSelected = 0;\n\n                var groupedRecords = angular.fromJson(result);\n                if(groupedRecords) {\n                    $scope.groupList = groupedRecords.records;\n                    if(groupedRecords.actions) {\n                        $scope.nextGroupsAction = groupedRecords.actions.nextGroups;\n                    }\n                    if(groupedRecords.data && groupedRecords.data.groupTotalCount) {\n                        $scope.groupTotalCount = groupedRecords.data.groupTotalCount;\n                    }\n                    \n                }\n                $scope.isGroupsLoading = false;\n                checkForNextButton();\n            });\n        }\n        /*\n         * get more groups.\n         */ \n        $scope.getMoreGroups = function(nextGroupsAction) {\n            $scope.isGroupsLoading = true;\n            fireAction(nextGroupsAction, function(result){\n                var res = angular.fromJson(result);\n                var action;\n                if(res && res.records) {\n                    for(i=0; i<res.records.length; i++) {\n                        $scope.groupList.push(res.records[i]);\n                    }\n                }\n                if(res && res.actions) {\n                    action = res.actions.nextGroups;\n                }\n                if(res.data && res.data.groupTotalCount) {\n                    $scope.groupTotalCount = res.data.groupTotalCount;\n                }\n                $scope.nextGroupsAction = action;\n                $scope.isGroupsLoading = false;\n            });\n        }\n\n        function getCustomLabels() {\n\n            remoteActions.getCustomLabels(customLabels, '').then(\n                function (result) {\n                    if(result) {\n                        $scope.customLabelsMap = angular.fromJson(result);\n                    }\n                }\n            );\n        }\n\n        $scope.getUnGroupedServices = function() {\n            $scope.showTableLoading = true;\n            var input = {\n                parentId: $scope.bpTree.ContextId,\n                contextId: $scope.bpTree.selectedQuote.masterQuoteId,\n                offset: $scope.unGroupedServicePagination.offset, \n                pageSize: $scope.unGroupedServicePagination.pageSize\n            };\n            var filters = getFilters();\n\n            if(filters) {\n                input.filters = filters;\n            }\n            if($scope.sortByString !== '') {\n                input.sortBy = $scope.sortByString;\n            }\n            if($scope.filterApplyOnGroups) {\n                input.applyFiltersOnGroupedItems = true;\n            }\n            fireRemoteAction('getUnGroupedServices', input, {}, function(result){\n                $scope.selectAllUngroupedItem = false;\n                $scope.ungroupedItemSelected = 0;\n                $scope.ungroupedItemList = [];\n                $scope.unGroupedServiceTotalCount = 0;\n                var ungroupedRecords = angular.fromJson(result);\n                if(ungroupedRecords) {\n                    $scope.ungroupedItemList = ungroupedRecords.records;\n                    if(ungroupedRecords.data && ungroupedRecords.data.unGroupedServiceTotalCount) {\n                        $scope.unGroupedServiceTotalCount = ungroupedRecords.data.unGroupedServiceTotalCount;\n                    }\n                }\n                $scope.showTableLoading = false;\n            });\n        }\n\n        function getFilters() {\n            var filters = [];\n            var value;\n            var filterStr;\n            if($scope.appliedFilters) {\n                $scope.numberOfFiltersApplied = 0;\n                for(var prop in $scope.appliedFilters) {\n                    if($scope.appliedFilters.hasOwnProperty(prop)) {\n                        value = $scope.appliedFilters[prop];\n                        if(value) {\n                            $scope.numberOfFiltersApplied++;\n                            filters.push(prop + ':' + encodeURI(value));\n                        }\n                    }\n                }\n                if(filters.length != 0) {\n                    filterStr = filters.join(',');\n                }\n            }\n            return filterStr;\n        }\n        function fireAction(action, callBackFn) {\n            if(!action.remote || !action.remote.params) {\n                return;\n            }\n\n            var params = action.remote.params;\n            var input = {}, key;\n            for(key in params) {\n                if(key !== 'methodName') {\n                    input[key] = params[key];\n                }\n            }\n            return fireRemoteAction(params.methodName, input, {}, callBackFn);\n        }\n\n        function fireRemoteAction(methodName, input, options, callBackFn) {\n\n            var remoteActionObj = {\n                sClassName: $scope.bpService.sNSC + 'MultiServiceAppHandler',\n                sMethodName: methodName,\n                input: angular.toJson(input),\n                options: angular.toJson(options),\n                iTimeout: 30000                \n            };\n\n            return $scope.bpService.OmniRemoteInvoke(remoteActionObj).then(\n                function (result) {\n                    callBackFn(result);\n                }\n            );\n        }\n\n        $scope.renameGroup = function() {\n            var selectedGroup = undefined;\n            for(var i=0; i<$scope.groupList.length; i++) {\n                if($scope.groupList[i].isSelected) {\n                    selectedGroup = $scope.groupList[i];\n                    break;\n                }\n            }\n\n            if(!selectedGroup) {\n                return;\n            }\n\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSRenameGroupLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;\n            modalScope.SLDSICON = '';\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n\n            var groupPopup = $sldsModal({\n                templateUrl: 'groupPopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n            modalScope.group = {\n                name: selectedGroup.groupName,\n                description: selectedGroup.groupDescription,\n                groupId: selectedGroup.groupId\n            }\n            modalScope.confirmationAction = function() {\n\n                if(modalScope.group.name && modalScope.group.name !== '' \n                    && (modalScope.group.name !== selectedGroup.groupName || \n                        modalScope.group.description !== selectedGroup.groupDescription)) {\n                    var cgToast = $scope.toast($scope.customLabelsMap.MSUpdateGroupMsg, undefined, 'info');\n                    updateGroup(modalScope.group, cgToast);                    \n                }\n                groupPopup.hide();\n            }\n        }\n\n        function updateGroup(group, infoToast) {\n            var input = {\n                groupName: group.name,\n                groupDescription: group.description,\n                groupId: group.groupId,\n                parentId: $scope.bpTree.ContextId,\n                contextId: $scope.bpTree.selectedQuote.masterQuoteId\n            };\n            \n            fireRemoteAction('updateGroup', input, {}, function(result){\n                if(infoToast) {\n                    infoToast.hide();\n                }\n            \n                var response = angular.fromJson(result);\n                if(response) {\n                    if(response.message) {\n                        $scope.toast(response.message, '', 'error');\n                    } else {\n                        $scope.toast($scope.customLabelsMap.MSGroupUpdatedMsg, '', 'success');\n                        $scope.getGroups();\n                    }\n                }\n                \n            });\n        }\n\n        $scope.deleteGroups = function() {\n            var groupIds = []\n            for(var i=0; i<$scope.groupList.length; i++) {\n                if($scope.groupList[i].isSelected) {\n                    groupIds.push($scope.groupList[i].groupId);\n                }\n            }\n            if(groupIds.length > 0) {\n                $scope.alertBox($scope.customLabelsMap.MSDeleteGroupsLabel, 'Following groups will be deleted?<p><ul><li>Group1</li></ul></p>', 'Delete Group(s)', deleteGroupsCB, groupIds);\n            }\n        }\n        function deleteGroupsCB(groupIds) {\n            $scope.toast($scope.customLabelsMap.MSDeletingGroupMsg, undefined, 'success');\n            var input = {contextId: $scope.bpTree.ContextId, groupIds: groupIds};\n            return fireRemoteAction( 'removeGroups', input, {}, function(result){\n                $scope.toast($scope.customLabelsMap.MSGroupDeletedMsg, undefined, 'success');\n            });\n        }\n\n        $scope.saveNewGroup = function(name, description, infoToast) {\n\n            var input = {\n                groupName: name,\n                groupDescription: description,\n                parentId: $scope.bpTree.ContextId,\n                contextId: $scope.bpTree.selectedQuote.masterQuoteId\n            };\n            \n            fireRemoteAction('createNewGroup', input, {}, function(result){\n                if(infoToast) {\n                    infoToast.hide();\n                }\n            \n                var response = angular.fromJson(result);\n                if(response) {\n                    if(response.message) {\n                        $scope.toast(response.message, '', 'error');\n                    } else {\n                        $scope.toast(name + ' ' + $scope.customLabelsMap.MSGroupCreatedMsg, '', 'success');\n                        $scope.addToGroup(response.groupInfo, true);\n                    }\n                }\n                \n            });\n        }\n\n        $scope.removeFromGroup = function(group) {\n\n            var selectedIds, i, group, records, j, deleteGroupItems = {};\n            for(i=0; i<$scope.groupList.length; i++) {\n                group = $scope.groupList[i];\n                selectedIds = [];\n                if(group.services) {\n                    records = group.services;\n                    for(j=0; j<records.length; j++) {\n                        if(records[j].isSelected){\n                            selectedIds.push(records[j].Id.value); \n                        }\n                    }\n                    if(selectedIds.length > 0) {\n                        deleteGroupItems[group.groupCartId] = selectedIds;\n                    }\n                }\n\n            }\n            if(angular.equals({}, deleteGroupItems)) {\n                return;\n            }\n            $scope.toast($scope.customLabelsMap.MSRemovingItemGroupMsg, undefined, 'info');\n            var input = {\n                deleteGroupItemsJSON: deleteGroupItems,\n                parentId: $scope.bpTree.ContextId,\n                contextId: $scope.bpTree.selectedQuote.masterQuoteId\n            };\n\n            fireRemoteAction('removeFromGroup', input, {}, function(result){\n                var allMessages = [];\n                if(result) {\n                    result = angular.fromJson(result);\n                }\n                if(result.messages) {\n                    for(var key in result.messages) {\n                        allMessages.push(result.messages[key]);\n                    }\n                    $scope.toast(allMessages.join('\\n'), undefined, 'error');\n                } else {\n                    $scope.toast($scope.customLabelsMap.MSRemovedSuccMsg, undefined, 'success');\n                }\n                \n                $scope.getUnGroupedServices();\n                $scope.getGroups();\n                \n            });\n        }\n\n        $scope.addToGroup = function(group, reload) {\n\n            var selectedIds = [];\n            for(var i=0; i<$scope.ungroupedItemList.length; i++) {\n                if($scope.ungroupedItemList[i].isSelected)\n                {\n                    selectedIds.push($scope.ungroupedItemList[i].Id.value); \n                }\n            }\n            if(selectedIds.length === 0 || !group) {\n                if(reload) {\n                    $scope.getUnGroupedServices();\n                    $scope.getGroups();\n                }\n                return;\n            }\n            var groupInfo = {};\n            groupInfo['servicePoints'] = selectedIds;\n            var input = {\n                groupId: group.groupId,\n                groupCartId: group.groupCartId,\n                groupName: group.groupName,\n                parentId: $scope.bpTree.ContextId,\n                contextId: $scope.bpTree.selectedQuote.masterQuoteId,\n                groupJSON: groupInfo\n            };\n            var addingToast = $scope.toast($scope.customLabelsMap.MSAddingToMsg + ' ' + group.groupName + '...', undefined, 'info');\n            fireRemoteAction('addToGroup', input, {}, function(result){\n                $scope.getUnGroupedServices();\n                $scope.getGroups();\n                if(addingToast) {\n                    addingToast.hide();\n                }\n                var response = angular.fromJson(result);\n                if(response && response.message) {\n                    $scope.toast(response.message, '', 'error');\n                } else {\n                    $scope.toast($scope.customLabelsMap.MSAddedSuccMsg, undefined, 'success');\n                }\n            });\n        }\n\n        $scope.groupSelectionChange = function(group) {\n\n            if(!group){\n                return;\n            }\n            if(group.isSelected) {\n                $scope.groupSelected++;\n            } else {\n                $scope.groupSelected--;\n            }\n\n            if(!group.services) {\n                return;\n            }\n            var records = group.services;\n\n            if(!records) {\n                return;\n            }\n            var i;\n            for(i=0; i < records.length; i++) {\n\n                if(!records[i].isSelected && group.isSelected) {\n                    $scope.groupedItemSelected++;\n                } else if(records[i].isSelected && !group.isSelected && $scope.groupedItemSelected > 0){\n                    $scope.groupedItemSelected--;\n                }\n                records[i].isSelected = group.isSelected;\n            }\n        }\n\n        $scope.createNewGroup = function() {\n\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSCreateNewGroupLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;\n            modalScope.SLDSICON = '';\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n\n            var createNewGroupPopup = $sldsModal({\n                templateUrl: 'groupPopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n            modalScope.group = {};\n\n            modalScope.confirmationAction = function() {\n                var name = modalScope.group.name;\n                var description = modalScope.group.description;\n\n                if(name && name !== '') {\n                    var cgToast = $scope.toast($scope.customLabelsMap.MSCreatingGroupMsg, undefined, 'info');\n                    $scope.saveNewGroup(name, description, cgToast);                    \n                }\n                createNewGroupPopup.hide();\n            }\n        }\n\n        $scope.convertToLabel = function(name) {\n            if(name) {\n                return name.replace(/([A-Z]+)/g, \" $1\").replace(/([A-Z][a-z])/g, \" $1\");\n            }\n            return '';\n        }\n\n        $scope.selecAllUngroupedItem = function(isSelected) {\n            \n            if(isSelected === undefined) {\n                return;\n            }\n            if($scope.ungroupedItemList) {\n                $scope.ungroupedItemSelected = 0;\n                for(var i=0; i<$scope.ungroupedItemList.length; i++) {\n                    $scope.ungroupedItemList[i].isSelected = isSelected;\n                    if(isSelected) {\n                        $scope.ungroupedItemSelected++;\n                    }\n                }\n            }\n        }\n\n        $scope.groupedItemSelectionChange = function(groupedItem) {\n\n            if(!groupedItem) {\n                return;\n            }\n            \n            if(groupedItem.isSelected) {\n                $scope.groupedItemSelected++;\n            } else {\n                $scope.groupedItemSelected--;\n            }\n        }\n\n        $scope.enableAddToGroup = function() {\n\n            if($scope.ungroupedItemList) {\n                for(var i=0; i<$scope.ungroupedItemList.length; i++) {\n                    if($scope.ungroupedItemList[i].isSelected) {\n                        return true;\n                    }\n                }\n            }\n            return false;\n        }\n\n        $scope.ungroupedItemSelectionChange = function(ungroupedItem) {\n            if(!ungroupedItem) {\n                return;\n            }\n            \n            if(ungroupedItem.isSelected) {\n                $scope.ungroupedItemSelected++;\n            } else {\n                $scope.ungroupedItemSelected--;\n            }\n        }\n\n        $scope.toast = function(title, content, severity) {\n            return $sldsToast({\n                    title: title,\n                    content: content,\n                    severity: severity,\n                    icon: severity,\n                    templateUrl: 'SldsToast.tpl.html',\n                    autohide: severity === 'error'? false: true,\n                    show: true\n                }); \n        }\n\n        $scope.alertBox = function(title, message, okLabel, actionCallback, arg1) {\n            var deletePrompt = $sldsPrompt({\n                    title: title,\n                    content: message,\n                    theme: 'error',\n                    show: true,\n                    buttons: [\n                        {\n                            label: okLabel,\n                            type: 'destructive',\n                            action: function() {\n                                deletePrompt.hide();\n                                actionCallback(arg1);\n                            }\n                        },\n                        {\n                            label: 'Cancel',\n                            type: 'neutral',\n                            action: function() {\n                                deletePrompt.hide();\n                            }\n                        }\n                    ]\n                });\n        }\n    }\n]);",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-manage-group/1/Vlocity/1562156633068",
                        "%vlocity_namespace%__HTML__c": "<div class=\"manage-group slds-grid--align-center slds-container--fluid slds-p-horizontal_large\" ng-controller=\"manageGroupController\" ng-init=\"init();\">\n    <!-- header section -->\n    <div class=\"slds-size_1-of-1 header-section\">\n        <div class=\"slds-grid slds-size_1-of-1 slds-p-vertical_medium\">\n            <div class=\"slds-size_1-of-2\">\n                <span class=\"slds-text-heading_medium slds-border_bottom service-point-text-border-color\">{{bpTree.selectedQuote.masterQuoteName}}</span>\n            </div>\n            <div class=\"slds-size_1-of-2\">\n                <div class=\"slds-float_right\">\n                    <span class=\"slds-p-right_small\"> {{customLabelsMap.MSGroupLabel}}:</span>\n                    <div class=\"slds-button-group\" role=\"group\">\n                        <button class=\"slds-button slds-button_neutral\" ng-click=\"groupShowHideFlag = !groupShowHideFlag\" ng-class=\"{'slds-button_brand': groupShowHideFlag, '': !groupShowHideFlag}\">{{customLabelsMap.MSShowLabel}}</button>\n                        <button class=\"slds-button slds-button_neutral\" ng-click=\"groupShowHideFlag = !groupShowHideFlag\" ng-class=\"{'slds-button_brand': !groupShowHideFlag, '': groupShowHideFlag}\">{{customLabelsMap.MSHideLabel}}</button>\n                    </div>\n                </div>  \n            </div>\n        </div>\n        <div class=\"slds-grid slds-size_1-of-1 slds-p-bottom_medium\">\n            <div class=\"slds-size_1-of-2\">\n                <span>{{unGroupedServiceTotalCount}} {{customLabelsMap.MSServiceLabel}}</span>\n                <button class=\"slds-button slds-button_neutral slds-m-left_x-small\" ng-click=\"filterFlag = !filterFlag\">{{customLabelsMap.MSFilterLabel}}</button>\n                <button class=\"slds-button slds-p-left_small\" ng-click=\"clearFilters()\" ng-if=\"enableClearFiltersButton()\">{{customLabelsMap.MSClearFilterLabel}}</button>\n                <span class=\"slds-m-left_small\" ng-if=\"numberOfFiltersApplied > 0\">{{numberOfFiltersApplied}} {{customLabelsMap.MSFiltersAppliedLabel}}</span>\n            </div>\n\n            <div class=\"slds-size_1-of-2\">\n                \n                <button class=\"slds-button slds-button_neutral slds-float_right\" ng-if=\"ungroupedItemSelected == 0 && groupedItemSelected === 0 && groupSelected === 0\" \n                    ng-click=\"createNewGroup()\">+ {{customLabelsMap.MSCreateNewGroupLabel}}</button>\n                <button class=\"slds-button slds-button_neutral slds-float_right\" ng-if=\"groupedItemSelected > 0\" \n                    ng-click=\"removeFromGroup()\">{{customLabelsMap.MSRemoveFromGroupLabel}}</button>\n                <button class=\"slds-button slds-button_neutral slds-m-right_x-small slds-float_right\" ng-if=\"groupSelected === 1\" \n                    ng-click=\"renameGroup()\">{{customLabelsMap.MSRenameGroupLabel}}</button>\n                \n                <!-- \n                <button class=\"slds-button slds-button_neutral slds-float_right slds-m-right_x-small\" ng-if=\"groupSelected > 0\" \n                    ng-click=\"deleteGroups()\">Delete Group(s)</button> -->\n                <div class=\"slds-float_right\" ng-if=\"ungroupedItemSelected > 0\">\n                    <span class=\"slds-p-right_x-small\" ng-if=\"ungroupedItemSelected > 0 && groupedItemSelected === 0\">{{ungroupedItemSelected}} {{customLabelsMap.MSItemsSelectedLabel}}</span>\n                    \n\n                    <div class=\"slds-dropdown-trigger slds-dropdown-trigger_click slds-button_last slds-m-right_x-small\" \n                        ng-class=\"{'slds-is-open': showGropDropdown}\">\n                        <button class=\"slds-button slds-button_neutral slds-button_brand\" \n                            ng-click=\"showGropDropdown = !showGropDropdown\">{{customLabelsMap.MSAddToGroupLabel}}\n                            <slds-svg-icon size=\"'small'\" extra-classes=\"'slds-input__icon slds-icon-text-default slds-m-left_x-small add-to-group-icon'\" \n                                sprite=\"'utility'\" icon=\"'chevrondown'\"></slds-svg-icon>\n                            <span class=\"slds-assistive-text\">More options</span>\n                        </button>\n                        <div class=\"slds-dropdown slds-dropdown_right slds-dropdown_actions\">\n                            <ul class=\"slds-dropdown__list\" role=\"menu\">\n                                <li class=\"slds-dropdown__item\" role=\"presentation\" ng-click=\"addToGroup(group)\" ng-repeat=\"group in groupList\">\n                                    <a href=\"javascript:void(0);\" role=\"menuitem\" tabindex=\"0\">\n                                        <span class=\"slds-truncate\" title=\"{{group.name}}\">{{group.groupName}}</span>\n                                    </a>\n                                </li>\n                                <li class=\"slds-dropdown__item\" role=\"presentation\" ng-click=\"createNewGroup()\">\n                                    <a href=\"javascript:void(0);\" role=\"menuitem\" tabindex=\"0\">\n                                        <span class=\"slds-truncate\" title=\"Add New Group\">+ {{customLabelsMap.MSAddNewGroupLabel}}</span>\n                                    </a>\n                                </li>\n                            </ul>\n                        </div>\n                    \n                    </div>\n                </div>\n                <span class=\"slds-p-right_x-small slds-float_right slds-p-top_xx-small\" ng-if=\"groupedItemSelected > 0\">{{groupedItemSelected}} {{customLabelsMap.MSGroupedItemsSelectedLabel}}</span>\n            </div>\n        </div>\n        <!-- Filter section --> \n        <div ng-if=\"filterFlag\" class=\"slds-size_1-of-1 slds-p-vertical_medium service-point-filter-section\">\n            <div class=\"slds-grid slds-p-around_small\">\n                <div class=\"slds-size_1-of-1\">\n                    <div class=\"slds-float_right slds-form-element\">\n                        <label class=\"slds-checkbox_toggle slds-grid\">{{customLabelsMap.MSApplyFiltersGroupedLabel}}\n                            <input type=\"checkbox\" name=\"checkbox\" aria-describedby=\"toggle-desc\" ng-model=\"filterApplicable.group\"/>\n                            <span id=\"toggle-desc\" class=\"slds-checkbox_faux_container slds-p-left_x-small\" aria-live=\"assertive\">\n                                <span class=\"slds-checkbox_faux\"></span>\n                                <span class=\"slds-checkbox_on\"></span>\n                                <span class=\"slds-checkbox_off\"></span>\n                            </span>\n                        </label>\n                    </div>\n                </div>\n            </div>\n            <div class=\"slds-grid slds-wrap slds-p-around_small\">\n                <div ng-repeat=\"filterField in filterFieldList| orderBy: 'displaySequence' \" class=\"slds-col slds-size_1-of-3 slds-p-around_x-small slds-form-element\" ng-init=\"fieldInfo = objectNameToFields[filterField.objectAPIName][filterField.fieldAPIName]\">\n                    <div ng-switch=\"fieldInfo.type\">\n                        <div ng-switch-when=\"picklist\">\n                            <label class=\"slds-form-element__label\" for=\"filter-for-id-{{filterField.fieldName}}\">{{fieldInfo.label}}</label>\n                            <div class=\"slds-form-element__control\">\n                                <div class=\"slds-select_container\">\n                                    <select class=\"slds-select\" id=\"filter-for-id-{{filterField.fieldName}}\" ng-model=\"filters[filterField.fieldName]\">\n                                        <option value=\"\">{{customLabels.selectDefaultOption}}</option>\n                                        <option ng-repeat=\"picklist in fieldInfo.picklistValues\" value=\"{{picklist.value}}\">{{picklist.label}}</option>\n                                    </select>\n                                </div>\n                            </div>\n                        </div>\n                        <div ng-switch-when=\"multipicklist\">\n                            <label class=\"slds-form-element__label\" for=\"filter-for-id-{{filterField.fieldName}}\">{{fieldInfo.label}}</label>\n                            <div class=\"slds-form-element__control\">\n                                <div class=\"slds-select_container\">\n                                    <select class=\"slds-select\" id=\"filter-for-id-{{filterField.fieldName}}\" ng-model=\"filters[filterField.fieldName]\">\n                                        <option value=\"\">{{customLabels.selectDefaultOption}}</option>\n                                        <option ng-repeat=\"picklist in fieldInfo.picklistValues\" value=\"{{picklist.value}}\">{{picklist.label}}</option>\n                                    </select>\n                                </div>\n                            </div>\n                        </div>\n                        \n                        <div ng-switch-when=\"date\">\n                            <label class=\"slds-form-element__label\" for=\"filter-for-id-{{filterField.fieldName}}\">{{fieldInfo.label}}</label>\n                            <div class=\"slds-form-element__control slds-input-has-icon slds-input-has-icon_right\">\n                                <input type=\"text\" class=\"slds-input\"\n                                    id=\"filter-for-id-{{filterField.fieldName}}\"\n                                    ng-model=\"filters[filterField.fieldName]\"\n                                    slds-date-picker=\"true\"\n                                    data-date-format=\"M/d/yyyy\"\n                                    data-date-type=\"number\" />\n                                <button class=\"slds-button slds-button_icon slds-input__icon slds-input__icon_right\" title=\"Select a date\">\n                                    <slds-svg-icon sprite=\"'utility'\" size=\"'x-small'\" icon=\"'event'\" extra-class=\"'slds-input__icon_right'\"></slds-svg-icon>\n                                </button>\n                                \n                            </div>\n                        </div>\n\n                        <div ng-switch-when=\"datetime\">\n                            <label class=\"slds-form-element__label\" for=\"filter-for-id-{{filterField.fieldName}}\">{{fieldInfo.label}}</label>\n                            <div class=\"slds-form-element__control datetime-input\">\n                                <div class=\"slds-input-has-icon slds-input-has-icon_right date\">\n                                    <input type=\"text\" class=\"slds-input\"\n                                        id=\"filter-for-id-{{filterField.fieldName}}\"\n                                        ng-model=\"filters[filterField.fieldName]\"\n                                        slds-date-picker=\"true\"\n                                        data-date-format=\"M/d/yyyy\"\n                                        data-date-type=\"number\" />\n                                    <button class=\"slds-button slds-button_icon slds-input__icon slds-input__icon_right\" title=\"Select a date\">\n                                        <slds-svg-icon sprite=\"'utility'\" size=\"'x-small'\" icon=\"'event'\" extra-class=\"'slds-input__icon_right'\"></slds-svg-icon>\n                                    </button>\n                                </div>\n                                <div class=\"slds-input-has-icon slds-input-has-icon_right time\">\n                                    <input type=\"text\" class=\"slds-input\"\n                                        id=\"filter-for-time-id-{{filterField.fieldName}}\"\n                                        ng-model=\"filters[filterField.fieldName]\"\n                                        slds-time-picker=\"true\"\n                                        data-time-format=\"h:mm a\"\n                                        data-time-type=\"number\" />\n                                    <button class=\"slds-button slds-button_icon slds-input__icon slds-input__icon_right\" title=\"Select a date\">\n                                        <slds-svg-icon sprite=\"'utility'\" size=\"'x-small'\" icon=\"'clock'\" extra-class=\"'slds-input__icon_right'\"></slds-svg-icon>\n                                    </button>\n                                </div>\n                            </div>\n                        </div>\n\n                        <div ng-switch-when=\"boolean\" class=\"slds-form-element\">\n                            <label class=\"slds-form-element__label\" for=\"filter-for-id-{{filterField.fieldName}}\">{{fieldInfo.label}}</label>\n                            <div class=\"slds-form-element__control\">\n                                <div class=\"slds-select_container\">\n                                    <select class=\"slds-select\" id=\"filter-for-id-{{filterField.fieldName}}\" ng-model=\"filters[filterField.fieldName]\">\n                                        <option value=\"\">{{customLabels.selectDefaultOption}}</option>\n                                        <option ng-repeat=\"picklist in booleanPicklists\" value=\"{{picklist.value}}\">{{picklist.label}}</option>\n                                    </select>\n                                </div>\n                            </div>\n                        </div>\n\n                        <div ng-switch-default>\n                            <label class=\"slds-form-element__label\" for=\"filter-for-id-{{filterField.fieldName}}\">{{fieldInfo.label}}</label>\n                            <div class=\"slds-form-element__control\">\n                                <input type=\"text\" id=\"filter-for-id-{{filterField.fieldName}}\" placeholder=\"{{fieldInfo.label}}\" class=\"slds-input\" ng-model=\"filters[filterField.fieldName]\">\n                            </div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n            <div class=\"slds-grid slds-p-around_small\">\n                <div class=\"slds-size_1-of-1 slds-float_right\">\n                    <button class=\"slds-button slds-button_brand slds-float_right\" ng-click=\"applyFilters();\">{{customLabelsMap.MSApplyFilterLabel}}</button>\n                </div>\n            </div>\n        </div>\n    </div>\n\n    <!-- Table section -->\n    <div class=\"table-section slds-is-relative\">\n        <table aria-multiselectable=\"true\" class=\"slds-table slds-table_cell-buffer slds-no-row-hover slds-table_bordered\" role=\"grid\">\n            <thead>\n                <tr class=\"slds-text-heading--label\">\n                    <th class=\"slds-text-align_left\" scope=\"col\">\n                        <span id=\"column-group-header\" class=\"slds-assistive-text\">Choose a row</span>\n                        \n                        <div class=\"slds-checkbox\">\n                            <input type=\"checkbox\" name=\"select-all-ungrouped-item\" id=\"select-all-ungrouped-checkbox\" \n                            tabindex=\"0\" aria-labelledby=\"select-all-ungrouped-item column-group-header\" ng-model=\"selectAllUngroupedItem\"\n                            ng-change=\"selecAllUngroupedItem(selectAllUngroupedItem)\" />\n                            <label class=\"slds-checkbox__label\" for=\"select-all-ungrouped-checkbox\" id=\"select-all-ungrouped-item\">\n                                <span class=\"slds-checkbox_faux\"></span>\n                                <span class=\"slds-form-element__label slds-assistive-text\">Select All</span>\n                            </label>\n                        </div>\n                    </th>\n                    <th aria-label=\"{{field.fieldLabel}}\" aria-sort=\"ascending\" class=\"sortable-column slds-is-resizable slds-is-sortable\" \n                        scope=\"col\" ng-repeat=\"field in fieldList | orderBy: 'displaySequence'\" \n                        ng-class=\"{'slds-is-sorted slds-is-sorted_asc': field.clickedPos === 'up', 'slds-is-sorted slds-is-sorted_desc': field.clickedPos === 'down'}\"\n                        ng-click=\"sortByColumn(field);\">\n                        <a class=\"slds-text-link_reset\" href=\"javascript:void(0);\" role=\"button\" tabindex=\"0\">\n                            <span class=\"slds-assistive-text\">Sort by: </span>\n                            <div class=\"slds-grid slds-grid_vertical-align-center slds-has-flexi-truncate\">\n                                <span class=\"slds-truncate\" title=\"{{field.fieldLabel}}\">{{field.fieldLabel}}</span>\n                                <span class=\"slds-icon_container slds-icon-utility-arrowdown\">\n                                    <slds-svg-icon sprite=\"'utility'\" icon=\"'arrowdown'\" size=\"'x-small'\" extra-classes=\"'slds-icon-text-default slds-is-sortable__icon'\"></slds-svg-icon>\n                                </span>\n                            </div>\n                        </a>\n                    </th>\n                </tr>\n            </thead>\n            <tbody>\n                <tr ng-repeat-start=\"group in groupList\" class=\"group-row\" ng-if=\"groupShowHideFlag\" ng-init=\"group.limit = 20;\">\n                    <td colspan=\"{{fieldList.length + 1}}\">\n                        <slds-svg-icon sprite=\"'utility'\" icon=\"'drag_and_drop'\" size=\"'x-small'\" extra-classes=\"'slds-icon-text-default'\"></slds-svg-icon>\n                        <div class=\"slds-checkbox\">\n                            <input type=\"checkbox\" name=\"group-select-{{group.groupId}}\" id=\"group-select-{{group.groupId}}\" tabindex=\"0\" \n                            aria-labelledby=\"group-select-label-{{group.groupId}}\" ng-model=\"group.isSelected\" ng-change=\"groupSelectionChange(group)\"/>\n                            <label class=\"slds-checkbox__label\" for=\"group-select-{{group.groupId}}\" id=\"group-select-label-{{group.groupId}}\">\n                                <span class=\"slds-checkbox_faux\"></span>\n                                <span class=\"slds-form-element__label slds-assistive-text\">Select group</span>\n                            </label>\n                        </div>\n                        <slds-svg-icon sprite=\"'utility'\" icon=\"'chevronright'\" size=\"'x-small'\" \n                            extra-classes=\"'slds-icon-text-default group-name-icon'\" \n                            ng-click=\"getGroupedServices(group)\"\n                            ng-if=\"!group.showItems\">\n                        </slds-svg-icon>\n                        <slds-svg-icon sprite=\"'utility'\" icon=\"'chevrondown'\" size=\"'x-small'\" \n                            extra-classes=\"' slds-icon-text-default group-name-icon'\" \n                            ng-click=\"group.showItems = !group.showItems\"\n                            ng-if=\"group.showItems\">\n                        </slds-svg-icon>\n                        <span>{{group.groupName}} ({{group.itemsCount ? group.itemsCount: 0}})</span>\n                    </td>\n                </tr>\n                <tr class=\"grouped-item-row\" ng-if=\"group.showItems && (!group.services || group.services.length === 0) && !group.isLoading\">\n                    <td colspan=\"{{fieldList.length + 1}}\"class=\"slds-text-align_center\">\n                        {{customLabelsMap.MSNoRecordsFoundLabel}}\n                    </td>\n                </tr>\n                <tr ng-repeat=\"groupedItem in group.services\" class=\"grouped-item-row\" \n                    ng-if=\"groupShowHideFlag && group.showItems\">\n                    <td class=\"slds-text-align_right\" role=\"gridcell\">\n                        <div class=\"slds-checkbox slds-p-left_medium\">\n                            <input type=\"checkbox\" name=\"groupedItem-select-{{groupedItem.Id.value}}\" id=\"groupedItem-select-{{groupedItem.Id.value}}\" tabindex=\"0\" \n                            aria-labelledby=\"groupedItem-select-label-{{groupedItem.Id.value}}\" ng-model=\"groupedItem.isSelected\" ng-change=\"groupedItemSelectionChange(groupedItem)\"/>\n                            <label class=\"slds-checkbox__label\" for=\"groupedItem-select-{{groupedItem.Id.value}}\" id=\"item-select-label-{{groupedItem.Id.value}}\">\n                                <span class=\"slds-checkbox_faux\"></span>\n                                <span class=\"slds-form-element__label slds-assistive-text\">Select item</span>\n                            </label>\n                        </div>\n                    </td>\n                    <td ng-repeat=\"field in fieldList | orderBy: 'displaySequence'\">\n                        {{groupedItem[field.fieldName].value}}\n                    </td>\n                </tr>\n                <tr class=\"\" ng-if=\"group.showItems && group.isLoading\">\n                    <td colspan=\"{{fieldList.length + 1}}\"class=\"slds-text-align_center loading-top-padding\">\n                        <div class=\"slds-spinner_brand slds-spinner slds-spinner_x-small\" aria-hidden=\"false\" role=\"alert\">\n                            <div class=\"slds-spinner__dot-a\"></div>\n                            <div class=\"slds-spinner__dot-b\"></div>\n                        </div>\n                    </td>\n                </tr>\n                <!-- load more button -->\n                <tr ng-repeat-end ng-if=\"groupShowHideFlag && group.showItems && !group.isLoading && group.services.length < group.itemsCount && group.actions.getGroupedServices\">\n                    <td colspan=\"{{fieldList.length + 1}}\"class=\"slds-text-align_center loadmore-padding\">\n                        <button class=\"slds-button slds-button_neutral\" ng-click=\"getMoreGroupedServices(group)\">\n                            {{customLabelsMap.MSLoadMoreLabel}}\n                        </button>\n                    </td>\n                </tr>\n                <tr ng-if=\"groupShowHideFlag && groupTotalCount > groupList.length && nextGroupsAction && !isGroupsLoading \">\n                    <td colspan=\"{{fieldList.length + 1}}\"class=\"slds-text-align_center loadmore-padding\">\n                        <button class=\"slds-button slds-button_neutral\" ng-click=\"getMoreGroups(nextGroupsAction)\">\n                            {{customLabelsMap.MSLoadMoreGroupsLabel}}\n                        </button>\n                    </td>\n                </tr>\n                <tr class=\"\" ng-if=\"groupShowHideFlag && isGroupsLoading && !showTableLoading\">\n                    <td colspan=\"{{fieldList.length + 1}}\"class=\"slds-text-align_center loading-top-padding\">\n                        <div class=\"slds-spinner_brand slds-spinner slds-spinner_x-small\" aria-hidden=\"false\" role=\"alert\">\n                            <div class=\"slds-spinner__dot-a\"></div>\n                            <div class=\"slds-spinner__dot-b\"></div>\n                        </div>\n                    </td>\n                </tr>\n\n                <!--<tr ng-repeat-end ng-show=\"false\"></tr>-->\n\n                <tr class=\"\" ng-repeat=\"item in ungroupedItemList\" ng-class=\"{'slds-is-selected': item.isSelected}\">\n                    <td class=\"slds-text-align_left\" role=\"gridcell\">\n                        \n                        <div class=\"slds-checkbox\">\n                            <input type=\"checkbox\" name=\"item-select-{{item.Id.value}}\" id=\"item-select-{{item.Id.value}}\" tabindex=\"0\" \n                            aria-labelledby=\"item-select-label-{{item.Id.value}} column-group-header\" ng-model=\"item.isSelected\" ng-change=\"ungroupedItemSelectionChange(item)\" />\n                            <label class=\"slds-checkbox__label\" for=\"item-select-{{item.Id.value}}\" id=\"item-select-label-{{item.Id.value}}\">\n                                <span class=\"slds-checkbox_faux\"></span>\n                                <span class=\"slds-form-element__label slds-assistive-text\">Select item</span>\n                            </label>\n                        </div>\n                    </td>\n                    <td ng-repeat=\"field in fieldList | orderBy: 'displaySequence'\">\n                        {{item[field.fieldName].value}}\n                    </td>\n                </tr>\n            </tbody>\n        </table>\n        <div ng-if=\"!ungroupedItemList || ungroupedItemList.length === 0\" class=\"\">{{customLabelsMap.MSNoRecordsGroupsLabel}}</div>\n        <div class=\"slds-grid slds-m-top_small\" ng-show=\"!showTableLoading\">\n            <div class=\"slds-size_1-of-2\">\n                <button class=\"slds-button slds-button_neutral slds-float_right\" ng-click=\"nextServicePoints()\" ng-disabled=\"!ungroupedItemList || ungroupedItemList.length < unGroupedServicePagination.pageSize\">{{customLabelsMap.MSNextLabel}}</button>\n                <button class=\"slds-button slds-button_neutral slds-float_right slds-m-right_small\" ng-click=\"previousServicePoints()\" ng-disabled=\"unGroupedServicePagination.offset === 0\">{{customLabelsMap.MSPreviousLabel}}</button>\n            </div>\n        </div>\n        <div class=\"slds-spinner_container\" ng-if=\"showTableLoading\">\n            <div class=\"slds-spinner_brand slds-spinner slds-spinner_medium\" aria-hidden=\"false\" role=\"alert\">\n                <div class=\"slds-spinner__dot-a\"></div>\n                <div class=\"slds-spinner__dot-b\"></div>\n            </div>\n        </div>\n    </div>\n</div>\n\n\n<script type=\"text/ng-template\" id=\"groupPopup.html\">\n    <div class=\"manage-group-popup slds-modal slds-fade-in-open\" aria-hidden=\"false\" role=\"dialog\">\n        <div class=\"slds-modal__container\" ng-form name=\"groupForm\">\n            <div class=\"slds-modal__header\">\n                <button class=\"slds-button slds-button_icon-inverse slds-modal__close\" ng-click=\"$hide()\">\n                    <slds-svg-icon sprite=\"'utility'\" size=\"'small'\" icon=\"'close'\" extra-classes=\"'slds-button__icon slds-button__icon_large'\" ></slds-svg-icon>\n                    <span class=\"slds-assistive-text\">{{closeLabel}}</span>\n                </button>\n                <h2 class=\"slds-text-heading_medium\">{{confirmationTitle}}</h2>\n            </div>\n\n            <div class=\"slds-modal__content slds-p-around_medium\" >\n                <div class=\"slds-form-element slds-m-around_small\">\n                    <label class=\"slds-form-element__label\" for=\"name-input-id\">{{customLabelsMap.MSGroupNameLabel}}<abbr class=\"slds-required\" title=\"required\">*</abbr></label>\n                    <div class=\"slds-form-element__control\">\n                        <input type=\"text\" id=\"name-input-id\" placeholder=\"Group Name\" class=\"slds-input\" ng-model=\"group.name\" ng-required=\"true\" />\n                    </div>\n                </div>      \n\n                <div class=\"slds-form-element slds-m-around_small\">\n                    <label class=\"slds-form-element__label\" for=\"description-input-id\" ng-model=\"group.description\">{{customLabelsMap.MSGroupDescLabel}}</label>\n                    <div class=\"slds-form-element__control\">\n                        <input type=\"text\" id=\"description-input-id\" placeholder=\"Group Description\" class=\"slds-input\" ng-model=\"group.description\" />\n                    </div>\n                </div>\n\n            </div>\n\n            <div class=\"slds-modal__footer\">\n                <button type=\"button\" class=\"slds-button slds-button_neutral\" ng-click=\"$hide()\">{{cancelActionLbl}}</button>\n                <button type=\"button\" class=\"slds-button slds-button_neutral slds-button_brand\" ng-click=\"confirmationAction()\" ng-disabled=\"groupForm.$invalid\">{{confirmActionLbl}}</button>\n            </div>\n        </div>\n    </div>\n    <div class=\"slds-backdrop slds-backdrop_open\"></div>\n</script>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": ".via-slds {\n    .vlc-slds-page--header {\n        display: none !important;\n    }\n   .manage-group {\n       .table-section {\n           overflow-x: scroll;\n           .sortable-column {\n               padding: 1rem .5rem;\n\n                &:focus {\n                    box-shadow: none;\n                }\n               .slds-icon_container {\n                   background: inherit;\n                   svg {\n                       fill: #006dcc;\n                   }\n               }\n               a {\n                   &:focus {\n                       outline: none;\n                   }\n               }\n           }\n\n       }\n       .loading-top-padding {\n           padding-top: 50px;\n       }\n       .loadmore-padding {\n            padding-top: 15px;\n            padding-bottom: 15px;\n       }\n       .service-point-text-border-color {\n           border-color: #0070d2;\n           border-bottom-width: 1.5px;\n       }\n       .service-point-filter-section {\n            border: 1.5px solid #0070d2;\n            .datetime-input {\n                .date {\n                    width: 50%;\n                    display: inline-block;\n                }\n                .time {\n                    width: 30%;\n                    display: inline-block;\n                }\n            }\n       }\n       .slds-input {\n           min-height: 2rem;\n           height: 2rem;\n       }\n       .add-to-group-icon {\n           fill: #FFFFFF;\n       }\n       .group-name-icon {\n           fill: #0070d2;\n       }\n       .group-row {\n           td {\n            background-color: #F8F8FE;\n           }\n       }\n       .grouped-item-row {\n            td {\n                background-color: #DFE5EF;\n            }\n       }\n       .grouped-item-selected-row {\n            td {\n                background-color: #0070d2;\n            }\n       }\n   }\n   .manage-group-popup {\n       .slds-input {\n           min-height: 2rem;\n           height: 2rem;\n       }\n   }\n   .slds-notify {\n       .slds-notify__content {\n           .slds-icon {\n               fill: #fff;\n           }\n       }\n   }\n}",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-manage-group",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-manage-group/%vlocity_namespace%__VlocityUITemplate__c/multiservice-manage-group"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-manage-group",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-manage-group",
            "VlocityDataPackName": "multiservice-manage-group",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        },
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__VlocityUITemplate__c": [
                    {
                        "%vlocity_namespace%__Active__c": true,
                        "%vlocity_namespace%__Author__c": "Vlocity",
                        "%vlocity_namespace%__CSS__c": ".via-slds .select-master-quote .margin-top-two {\n  margin-top: 2px; }\n\n.via-slds .select-master-quote .radio-selection-cell {\n  width: 5%; }\n",
                        "%vlocity_namespace%__CustomJavascript__c": "vlocity.cardframework.registerModule.controller('ManageMasterQuoteController', ['$scope', '$sldsModal', '$sldsToast', 'remoteActions',\n    function($scope, $sldsModal, $sldsToast, remoteActions) {\n        /*\n         * Master quote list.\n         */\n        $scope.masterQuoteList = [];\n        /*\n         * fields to display.\n         */ \n        $scope.fieldList = [];\n        /*\n         * custom labels\n         */\n        var customLabels = ['MSUpdatingMQMsg', 'MSCreatingMQMsg', 'MSCloningMQMsg', 'MSClonedSuccMsg', 'MSCreatedSuccMsg',\n                            'MSUpdatedSuccMsg','MSCloneMQLabel', 'MSNewMQLabel', 'MSRenameMQLabel', 'MSNameLabel', 'MSCloneLabel',\n                            'MSCloseLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSSelectMQLabel', 'MSRenameLabel', 'MSNewLabel',\n                            'MSRequestExternalLabel', 'MSGetExternalLabel', 'MSRequestExternalMsg', 'MSGetExternalMsg',\n                            'MSRequestedStatusLabel'];\n        /*\n         * custom labels map.\n         */ \n        $scope.customLabelsMap = {};\n        /*\n         * next button id.\n         */\n        var nextButtonId = 'SelectMasterQuote_nextBtn';\n        /*\n         * keep watch on selected quote.\n         */ \n        $scope.$watch('bpTree.selectedQuote.masterQuoteId', function (newValue, oldValue) {\n            if(newValue) {\n                nextButton(false);\n            } else {\n                nextButton(true);\n            }\n        });\n        /*\n         * controller init.\n         */ \n        $scope.init = function() {\n            $scope.bpTree.selectedQuote = {};\n            getFieldList();\n            getCustomLabels();\n            $scope.loadMasterQuotes();\n            $scope.nsp = $scope.bpService.sNS + '__';\n        }\n        /*\n         * load master quotes.\n         */ \n        $scope.loadMasterQuotes = function() {\n            $scope.bpTree.selectedQuote = {};\n            $scope.showTableLoading = true;\n            var input = {'parentId': $scope.bpTree.ContextId};\n            fireRemoteAction('getMasterQuotes', input, {}, function(result){\n\n                var response = angular.fromJson(result);\n                if(response) {\n                    $scope.masterQuoteList = response.result;\n                }\n                $scope.showTableLoading = false;\n            });\n        }\n        $scope.isToShowExtraActions = function() {\n            return $scope.bpTree.selectedQuote.masterQuoteId && \n                    ( $scope.selectedQuote[$scope.nsp + 'ExternalPricingStatus__c'] === 'Ready' ||\n                    $scope.selectedQuote[$scope.nsp + 'ExternalPricingStatus__c'] === 'Request Confirmed');\n        }\n        $scope.getExternalPricingClick = function() {\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSGetExternalLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSGetExternalLabel;\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n            modalScope.confirmationMsg = $scope.customLabelsMap.MSGetExternalMsg;\n\n            var confirmationPopupPopup = $sldsModal({\n                templateUrl: 'confirmationPopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n\n            modalScope.confirmationAction = function() {\n                var infoToast = toast('Getting external pricing...', undefined, 'info');\n                getExternalPricing(infoToast);\n                confirmationPopupPopup.hide();\n            }\n        }\n\n        $scope.requestExternalPricingClick = function() {\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSRequestExternalLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSRequestExternalLabel;\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n            modalScope.confirmationMsg = $scope.customLabelsMap.MSRequestExternalMsg;\n\n            var confirmationPopupPopup = $sldsModal({\n                templateUrl: 'confirmationPopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n\n            modalScope.confirmationAction = function() {\n                var infoToast = toast('Requesting external pricing...', undefined, 'info');\n                requestExternalPricing(infoToast);\n                confirmationPopupPopup.hide();\n                \n            }\n        }\n\n        function getExternalPricing (infoToast) {\n            var messageLevel = 'success';\n            var input = {\n                masterQuoteId: $scope.bpTree.selectedQuote.masterQuoteId\n            };\n            \n            fireRemoteAction('getExternalPricing', input, {}, function(result){\n\n                var response = angular.fromJson(result);\n                console.log(response);\n                if(infoToast) {\n                    infoToast.hide();\n                }\n                if(response.message) {\n                    if(response.isFailed) {\n                        messageLevel = 'error';\n                    }\n                    toast(response.message, undefined, messageLevel);\n                    $scope.loadMasterQuotes();\n                }\n            });\n        }\n\n        function requestExternalPricing (infoToast) {\n            var messageLevel = 'success';\n            var input = {\n                masterQuoteId: $scope.bpTree.selectedQuote.masterQuoteId\n            };\n            fireRemoteAction('requestExternalPricing', input, {}, function(result){\n\n                var response = angular.fromJson(result);\n                console.log(response);\n                if(infoToast) {\n                    infoToast.hide();\n                }\n                if(response.message) {\n                    if(response.isFailed) {\n                        messageLevel = 'error';\n                    }\n                    toast(response.message, undefined, messageLevel);\n                    $scope.loadMasterQuotes();\n                }\n            });\n        }\n        /*\n         * on change of radio button.\n         */ \n        $scope.selectMasterQuote = function(quote) {\n            if(!$scope.bpTree.selectedQuote) {\n                $scope.bpTree.selectedQuote = {};\n            }\n            $scope.selectedQuote = quote;\n            //$scope.bpTree.selectedQuote.masterQuoteId = quote.Id;\n            $scope.bpTree.selectedQuote.masterQuoteName = quote.Name;\n        }\n\n        $scope.rename = function(masterQuote) {\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSRenameMQLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;;\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n\n            var masterQuotePopup = $sldsModal({\n                templateUrl: 'masterQuotePopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n            modalScope.masterQuote = {\n                id: masterQuote.masterQuoteId,\n                name: masterQuote.masterQuoteName\n            };\n\n            modalScope.confirmationAction = function() {\n                var name = modalScope.masterQuote.name;\n\n                if(name && name !== '') {\n                    var cgToast = toast($scope.customLabelsMap.MSUpdatingMQMsg, undefined, 'info');\n                    updateMasterQuote(modalScope.masterQuote, cgToast);                   \n                }\n                masterQuotePopup.hide();\n            }\n        }\n        /*\n         * new master quote button click.\n         */ \n        $scope.newMasterQuote = function() {\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSNewMQLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n\n            var createNewMasterQuotePopup = $sldsModal({\n                templateUrl: 'masterQuotePopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n            modalScope.masterQuote = {};\n\n            modalScope.confirmationAction = function() {\n                var name = modalScope.masterQuote.name;\n\n                if(name && name !== '') {\n                    var cgToast = toast($scope.customLabelsMap.MSCreatingMQMsg, undefined, 'info');\n                    saveNewMasterQuote(name, cgToast);                   \n                }\n                createNewMasterQuotePopup.hide();\n            }\n        }\n        /*\n         * clone button click.\n         */ \n        $scope.clone = function() {\n\n            var modalScope = $scope.$new();\n            modalScope.confirmationTitle = $scope.customLabelsMap.MSCloneMQLabel;\n            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;\n            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;\n            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;\n\n            var cloneMasterQuotePopup = $sldsModal({\n                templateUrl: 'masterQuotePopup.html',\n                backdrop: 'static',\n                scope: modalScope,\n                show: true\n\t\t\t});\n            modalScope.masterQuote = {name: 'Clone - ' + $scope.bpTree.selectedQuote.masterQuoteName};\n\n            modalScope.confirmationAction = function() {\n                var name = modalScope.masterQuote.name;\n\n                if(name && name !== '') {\n                    var cgToast = toast($scope.customLabelsMap.MSCloningMQMsg, undefined, 'info');\n                    clone(name, cgToast);                   \n                }\n                cloneMasterQuotePopup.hide();\n            }\n\n        }\n        function getCustomLabels() {\n\n            remoteActions.getCustomLabels(customLabels, '').then(\n                function (result) {\n                    if(result) {\n                        $scope.customLabelsMap = angular.fromJson(result);\n                    }\n                }\n            );\n        }\n        /*\n         *\n         */ \n        function updateMasterQuote(masterQuote, infoToast) {\n            var input = {\n                masterQuoteId: masterQuote.id,\n                name: masterQuote.name,\n                parentId: $scope.bpTree.ContextId\n            };\n            \n            fireRemoteAction('updateMasterQuote', input, {}, function(result){\n                if(infoToast) {\n                    infoToast.hide();\n                }\n                var res = angular.fromJson(result);\n                if(res.masterQuoteId) {\n                    toast(name + ' ' + $scope.customLabels.MSUpdatedSuccMsg, '', 'success');\n                    //reload master quotes\n                    $scope.loadMasterQuotes();\n                } else if(res.message) {\n                    toast(res.message, '', 'error');\n                } else {\n                    toast('Failed', '', 'error');\n                }\n            });\n        }\n        /*\n         * save New Master Quote.\n         */ \n        function saveNewMasterQuote(name, infoToast) {\n\n            var input = {\n                name: name,\n                parentId: $scope.bpTree.ContextId\n            };\n            \n            fireRemoteAction('createNewMasterQuote', input, {}, function(result){\n                if(infoToast) {\n                    infoToast.hide();\n                }\n                var res = angular.fromJson(result);\n                if(res.masterQuoteId) {\n                    toast(name + ' ' + $scope.customLabelsMap.MSCreatedSuccMsg, '', 'success');\n                    //reload master quotes\n                    $scope.loadMasterQuotes();\n                } else if(res.message) {\n                    toast(res.message, '', 'error');\n                } else {\n                    toast('Failed', '', 'error');\n                }\n            });\n        }\n        /*\n         * get field list.\n         */ \n        function getFieldList() {\n            fireRemoteAction('getMasterQuoteFieldList', {}, {}, function(result){\n                $scope.fieldList = angular.fromJson(result).result;\n            });\n        }\n        /*\n         * clone of master quote.\n         */ \n        function clone(name, infoToast) {\n\n            var input = {\n                parentId: $scope.bpTree.ContextId,\n                masterQuoteId: $scope.bpTree.selectedQuote.masterQuoteId,\n                name: name\n            };\n            \n            fireRemoteAction('cloneMasterQuote', input, {}, function(result){\n                if(infoToast) {\n                    infoToast.hide();\n                }\n                var res = angular.fromJson(result);\n                if(res.masterQuoteId) {\n                    toast(name + ' ' + $scope.customLabelsMap.MSClonedSuccMsg, '', 'success');\n                    //reload master quotes\n                    $scope.loadMasterQuotes();\n                } else if(res.message) {\n                    toast(res.message, '', 'error');\n                } else {\n                    toast('Failed', '', 'error');\n                }\n            });\n        }\n\n        /*\n         * toast messages.\n         */ \n        function toast(title, content, severity) {\n            return $sldsToast({\n                    title: title,\n                    content: content,\n                    severity: severity,\n                    icon: severity,\n                    templateUrl: 'SldsToast.tpl.html',\n                    autohide: true,\n                    show: true\n                }); \n        }\n\n\n        /*\n         * fire remote action.\n         */ \n        function fireRemoteAction(methodName, input, options, callBackFn) {\n\n            var remoteActionObj = {\n                sClassName: $scope.bpService.sNSC + 'MultiServiceAppHandler',\n                sMethodName: methodName,\n                input: angular.toJson(input),\n                options: angular.toJson(options),\n                iTimeout: 30000                \n            };\n\n            return $scope.bpService.OmniRemoteInvoke(remoteActionObj).then(\n                function (result) {\n                    callBackFn(result);\n                }\n            );\n        }\n        /*\n         * next button disable/enable.\n         */\n        function nextButton(disable) {\n\n            if(!nextButtonId) {\n                return;\n            }\n\n            if(disable) {\n                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'none', 'cursor': 'default', 'background': '#c9c7c5'});\n            } else {\n                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'auto', 'cursor': 'pointer', 'background': '#0070d2'});\n            }\n        }\n    }\n]);",
                        "%vlocity_namespace%__Definition__c": "",
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__DisplayOn__c": "",
                        "%vlocity_namespace%__ExternalID__c": "multiservice-select-master-quote/1/Vlocity/1565333952976",
                        "%vlocity_namespace%__HTML__c": "<div class=\"select-master-quote slds-grid--align-center slds-container--fluid slds-p-horizontal_large\" ng-controller=\"ManageMasterQuoteController\" ng-init=\"init();\">\n    \n    <!-- header section -->\n    <div class=\"slds-size_1-of-1\">\n        <div class=\"slds-grid slds-size_1-of-1 slds-p-vertical_medium\">\n            <div class=\"slds-size_1-of-2\">\n                <span class=\"slds-text-heading_medium slds-border_bottom service-point-text-border-color\">{{customLabelsMap.MSSelectMQLabel}}</span>\n            </div>\n        </div>\n        <div class=\"slds-clearfix slds-p-bottom_medium\">\n            <div class=\"slds-size_1-of-2 slds-float_right\">\n                <div class=\"slds-button-group slds-float_right\" role=\"group\">\n                    <button class=\"slds-button slds-button_neutral\" \n                        ng-click=\"newMasterQuote()\">\n                        {{customLabelsMap.MSNewLabel}}\n                    </button>\n                    <button class=\"slds-button slds-button_neutral\" \n                        ng-click=\"clone()\" \n                        ng-if=\"bpTree.selectedQuote.masterQuoteId\">\n                        {{customLabelsMap.MSCloneLabel}}\n                    </button>\n                    <button class=\"slds-button slds-button_neutral\" \n                        ng-click=\"rename(bpTree.selectedQuote)\" \n                        ng-if=\"bpTree.selectedQuote.masterQuoteId\">\n                        {{customLabelsMap.MSRenameLabel}}\n                    </button>\n                    <div class=\"slds-dropdown-trigger slds-dropdown-trigger_click slds-button_last\" \n                        ng-click=\"actionDropdownClicked = !actionDropdownClicked\"\n                        ng-class=\"{'slds-is-open': actionDropdownClicked}\"\n                        ng-if=\"isToShowExtraActions()\">\n\n                        <button class=\"slds-button slds-button_icon slds-button_icon-border-filled\" aria-haspopup=\"true\" title=\"Show More\">\n                            <slds-svg-icon size=\"'xx-small'\" extra-classes=\"''\" \n                                sprite=\"'utility'\" icon=\"'down'\"></slds-svg-icon>\n                            <span class=\"slds-assistive-text\">Show More</span>\n                        </button>\n                        <div class=\"slds-dropdown slds-dropdown_right slds-dropdown_actions\">\n                            <ul class=\"slds-dropdown__list\" role=\"menu\">\n                                <li class=\"slds-dropdown__item\" role=\"presentation\" \n                                    ng-if=\"selectedQuote[nsp + 'ExternalPricingStatus__c'] === 'Ready'\">\n                                    <a href=\"javascript:void(0);\" role=\"menuitem\" tabindex=\"-1\" \n                                    ng-click=\"requestExternalPricingClick()\">\n                                        <span class=\"slds-truncate\" title=\"{{::customLabelsMap.MSRequestExternalLabel}}\">{{::customLabelsMap.MSRequestExternalLabel}}</span>\n                                    </a>\n                                </li>\n                                <li class=\"slds-dropdown__item\" role=\"presentation\"\n                                    ng-if=\"selectedQuote[nsp + 'ExternalPricingStatus__c'] === 'Request Confirmed'\">\n                                    <a href=\"javascript:void(0);\" role=\"menuitem\" tabindex=\"-1\" ng-click=\"getExternalPricingClick()\">\n                                        <span class=\"slds-truncate\" title=\"{{::customLabelsMap.MSGetExternalLabel}}\">{{::customLabelsMap.MSGetExternalLabel}}</span>\n                                    </a>\n                                </li>\n                            </ul>\n                        </div>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n\n    <!-- content -->\n    <div class=\"slds-size_1-of-1\">\n\n        <!-- <div class=\"table-section slds-is-relative\"> -->\n        <table class=\"slds-table slds-table_cell-buffer slds-no-row-hover slds-table_bordered\" role=\"grid\" ng-if=\"masterQuoteList.length !== 0\">\n            <thead>\n                <tr class=\"slds-text-heading--label\">\n                    <th class=\"slds-text-align_left radio-selection-cell\" scope=\"col\"></th>\n                    <th aria-label=\"{{field.fieldLabel}}\" aria-sort=\"ascending\" class=\"slds-is-resizable\" \n                        scope=\"col\" ng-repeat=\"field in fieldList | orderBy: 'displaySequence'\">\n                        <span class=\"slds-truncate\" title=\"{{field.fieldLabel}}\">{{field.fieldLabel}}</span>\n                    </th>\n                </tr>\n            </thead>\n            <tbody>\n                <tr ng-repeat=\"quote in masterQuoteList\">\n                    <td>\n                        <div class=\"slds-radio\">\n                            <input type=\"radio\" name=\"master-quote-select\" id=\"master-quote-select-{{$index}}\" tabindex=\"0\" \n                            aria-labelledby=\"master-quote-select-label-{{$index}}\" ng-model=\"bpTree.selectedQuote.masterQuoteId\" ng-value=\"quote.Id\"\n                            ng-change=\"selectMasterQuote(quote)\"/>\n                            <label class=\"slds-radio__label\" for=\"master-quote-select-{{$index}}\" id=\"master-quote-select-label-{{$index}}\">\n                                <span class=\"slds-radio_faux\"></span>\n                                <span class=\"slds-form-element__label slds-assistive-text\">Select item</span>\n                            </label>\n                        </div>\n                    </td>\n                    <td ng-repeat=\"field in fieldList | orderBy: 'displaySequence'\">\n                        {{quote[field.fieldAPIName]}}\n                    </td>\n                </tr>\n            </tbody>\n        </table>\n        <div class=\"\" ng-if=\"masterQuoteList.length === 0\">\n            No Records Found.\n        </div>\n        <!--\n        <div class=\"slds-size_1-of-4\" ng-if=\"!showTableLoading\">\n            <div class=\"slds-grid slds-size_1-of-1 slds-m-vertical_small\" ng-repeat=\"quote in masterQuoteList\">\n                <div class=\"slds-radio\">\n                    <input type=\"radio\" name=\"master-quote-select\" id=\"master-quote-select-{{$index}}\" tabindex=\"0\" \n                    aria-labelledby=\"master-quote-select-label-{{$index}}\" ng-model=\"bpTree.selectedQuote.masterQuoteId\" ng-value=\"quote.Id\"\n                    ng-change=\"selectMasterQuote(quote)\"/>\n                    <label class=\"slds-radio__label\" for=\"master-quote-select-{{$index}}\" id=\"master-quote-select-label-{{$index}}\">\n                        <span class=\"slds-radio_faux\"></span>\n                        <span class=\"slds-form-element__label slds-assistive-text\">Select item</span>\n                    </label>\n                </div>\n                <div class=\"margin-top-two\">\n                    {{quote.Name}}\n                </div>\n            </div>\n            <div class=\"\" ng-if=\"masterQuoteList.length == 0\">\n                No Records Found.\n            </div>\n        </div>\n        -->\n        \n        <div class=\"slds-spinner_container\" ng-if=\"showTableLoading\">\n            <div class=\"slds-spinner_brand slds-spinner slds-spinner_medium\" aria-hidden=\"false\" role=\"alert\">\n                <div class=\"slds-spinner__dot-a\"></div>\n                <div class=\"slds-spinner__dot-b\"></div>\n            </div>\n        </div>\n    </div>\n</div>\n\n<!-- create new popup -->\n<script type=\"text/ng-template\" id=\"masterQuotePopup.html\">\n    <div class=\"manage-group-popup slds-modal slds-fade-in-open\" aria-hidden=\"false\" role=\"dialog\">\n        <div class=\"slds-modal__container\" ng-form name=\"masterQuoteForm\">\n            <div class=\"slds-modal__header\">\n                <button class=\"slds-button slds-button_icon-inverse slds-modal__close\" ng-click=\"$hide()\">\n                    <slds-svg-icon sprite=\"'utility'\" size=\"'small'\" icon=\"'close'\" extra-classes=\"'slds-button__icon slds-button__icon_large'\" ></slds-svg-icon>\n                    <span class=\"slds-assistive-text\">{{closeLabel}}</span>\n                </button>\n                <h2 class=\"slds-text-heading_medium\">{{confirmationTitle}}</h2>\n            </div>\n\n            <div class=\"slds-modal__content slds-p-around_medium\">\n                <div class=\"slds-form-element slds-m-around_small\">\n                    <label class=\"slds-form-element__label\" for=\"name-input-id\">{{customLabelsMap.MSNameLabel}}<abbr class=\"slds-required\" title=\"required\">*</abbr></label>\n                    <div class=\"slds-form-element__control\">\n                        <input type=\"text\" id=\"name-input-id\" placeholder=\"Name\" class=\"slds-input\" ng-model=\"masterQuote.name\" ng-required=\"true\" />\n                    </div>\n                </div>\n            </div>\n\n            <div class=\"slds-modal__footer\">\n                <button type=\"button\" class=\"slds-button slds-button_neutral\" ng-click=\"$hide()\">{{cancelActionLbl}}</button>\n                <button type=\"button\" class=\"slds-button slds-button_neutral slds-button_brand\" ng-click=\"confirmationAction()\" ng-disabled=\"masterQuoteForm.$invalid\">{{confirmActionLbl}}</button>\n            </div>\n        </div>\n    </div>\n    <div class=\"slds-backdrop slds-backdrop_open\"></div>\n</script>\n<!-- confirmation popup -->\n<script type=\"text/ng-template\" id=\"confirmationPopup.html\">\n    <div class=\"manage-group-popup slds-modal slds-fade-in-open\" aria-hidden=\"false\" role=\"dialog\">\n        <div class=\"slds-modal__container\">\n            <div class=\"slds-modal__header\">\n                <button class=\"slds-button slds-button_icon-inverse slds-modal__close\" ng-click=\"$hide()\">\n                    <slds-svg-icon sprite=\"'utility'\" size=\"'small'\" icon=\"'close'\" extra-classes=\"'slds-button__icon slds-button__icon_large'\" ></slds-svg-icon>\n                    <span class=\"slds-assistive-text\">{{closeLabel}}</span>\n                </button>\n                <h2 class=\"slds-text-heading_medium\">{{confirmationTitle}}</h2>\n            </div>\n\n            <div class=\"slds-modal__content slds-p-around--medium\"> \n                <div> \n                    <p ng-bind-html=\"confirmationMsg\"></p>\n                </div> \n            </div>\n\n            <div class=\"slds-modal__footer\"> \n                <button type=\"button\" class=\"slds-button slds-button--neutral\" ng-click=\"$hide()\">{{cancelActionLbl}}</button> \n                <button type=\"button\" class=\"slds-button slds-button--neutral slds-button--brand\" ng-click=\"confirmationAction()\">{{confirmActionLbl}}</button> \n            </div>\n        </div>\n    </div>\n    <div class=\"slds-backdrop slds-backdrop_open\"></div>\n</script>",
                        "%vlocity_namespace%__ParentID__c": "",
                        "%vlocity_namespace%__Sass__c": ".via-slds {\n    .select-master-quote {\n        .margin-top-two {\n            margin-top: 2px;\n        }\n        .radio-selection-cell {\n            width: 5%;\n        }\n    }\n}",
                        "%vlocity_namespace%__Type__c": "Containers",
                        "%vlocity_namespace%__Version__c": 1,
                        "Name": "multiservice-select-master-quote",
                        "VlocityDataPackIsIncluded": true,
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityUITemplate__c",
                        "VlocityRecordSourceKey": "VlocityUITemplate/multiservice-select-master-quote/%vlocity_namespace%__VlocityUITemplate__c/multiservice-select-master-quote"
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "VlocityUITemplate/multiservice-select-master-quote",
                "VlocityDataPackType": "VlocityUITemplate"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "VlocityUITemplate/multiservice-select-master-quote",
            "VlocityDataPackName": "multiservice-select-master-quote",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "VlocityUITemplate"
        }
    ],
    "name": "DP_CARDS_MultiServiceCPQ",
    "primaryDataPackKey": "VlocityDeploy",
    "processMultiple": true,
    "status": "Complete",
    "version": 1
}