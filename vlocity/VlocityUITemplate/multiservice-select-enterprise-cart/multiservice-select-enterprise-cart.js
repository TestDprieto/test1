vlocity.cardframework.registerModule.controller('EnterpriseCartController', ['$scope', '$sldsModal', '$sldsToast', '$q', 'remoteActions',
    function($scope, $sldsModal, $sldsToast, $q, remoteActions) {
        /*
         * Enterprise quote list.
         */
        $scope.enterpriseCartList = [];
        $scope.recordTypeNames = [];
        $scope.cartDefaultFields;
        /*
         * fields to display.
         */ 
        $scope.fieldList = [];
        /*
         * custom labels
         */
        var customLabels = ['MSCreatingQMsg', 'MSUpdatingQMsg', 'MSCreatedSuccMsg', 'MSCreatingOMsg', 'MSUpdatingOMsg',
                            'MSUpdatedSuccMsg','MSSelectEOLabel', 'MSNameLabel', 'MSSelectEQLabel', 'MSRenameLabel', 'MSNewLabel',
                            'MSCloseLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSNoRecordsFoundLabel', 'MSCreateFailure', 'MSUpdateFailure'];
        /*
         * next button id.
         */
        var nextButtonId = 'SelectEnterpriseCart_nextBtn';
        /*
         * keep watch on selected quote.
         */ 
        $scope.$watch('bpTree.wrapperCart.Id', function (newValue, oldValue) {
            if(newValue) {
                nextButton(false);
            } else {
                nextButton(true);
            }
        });
        /*
         * set cart type.
         */ 
        $scope.$watch('bpTree.response.cartType', function (newValue, oldValue) {

            if (newValue && !$scope.cartType) {
                $scope.cartType = newValue.toLowerCase();
                $scope.bpTree.cartType = newValue;
                $q.all([getCustomSettings($scope.nsp + 'CpqConfigurationSetup__c'), loadFields()]).then(function(){
                    loadEnterpriseCarts();
                });
                getParent();
            }
        });

        /*
         * controller init.
         */ 
        $scope.init = function() {
            $scope.showTableLoading = true;
            $scope.bpTree.wrapperCart = {};
            //this is for ng-model of radio.
            //can't keep object which get replaced.
            $scope.userSelectedObj = {};
            getCustomLabels();
            $scope.nsp = $scope.bpService.sNS + '__';
            let objectList = ['Quote'];
            getObjectDesc(objectList);
        }
        /*
         * load enterprise carts.
         */ 
        function loadEnterpriseCarts() {
            $scope.userSelectedObj = {};
            $scope.bpTree.wrapperCart = {};
            $scope.showTableLoading = true;
            var customSettingsName, recordTypeNames = [], sobjectName;
            if($scope.cartType === 'quote') {
                customSettingsName = 'MultiServiceSingleQuoteRecordTypes';
                sobjectName = 'Quote';
            } else if($scope.cartType === 'order') {
                customSettingsName = 'MultiServiceSingleOrderRecordTypes';
                sobjectName = 'Order';
            }

            var recordTypes = $scope.bpTree.cpqCustomSettings[customSettingsName];
            
            if(recordTypes) {
                let rtList = recordTypes.split(',');
                if(rtList){
                    for(let i=0; i<rtList.length; i++) {
                        let n = rtList[i].trim();
                        if(n && n !== '') {
                            recordTypeNames.push({name: n});
                            $scope.recordTypeNames.push(n);
                        }
                    }
                }
            }
            if(recordTypeNames.length === 0) {
                if($scope.cartType === 'quote') {
                    recordTypeNames.push({name: 'EnterpriseQuote'});
                    $scope.recordTypeNames.push('EnterpriseQuote');
                } else if($scope.cartType === 'order') {
                    recordTypeNames.push({name: 'EnterpriseOrder'});
                    $scope.recordTypeNames.push('EnterpriseOrder');
                }
            }
            
            let apiInput = {
                'DRParams': {
                    opportunityId: $scope.bpTree.ContextId,
                    recordTypeNames: recordTypeNames,
                    sobjectName: sobjectName
                },
                'Bundle': 'MultiService - Load Enterprise ' + sobjectName + 's'
            };
            
            fireApi ('DefaultDROmniScriptIntegration','invokeOutboundDR', apiInput, {}, function(resp) {

                if (resp)
                {
                    let response = angular.fromJson(resp);
                    if(response.OBDRresp && response.OBDRresp.result) {
                        resetEnterpriseCarts();
                        if(Array.isArray(response.OBDRresp.result)) {
                            $scope.enterpriseCartList  = response.OBDRresp.result;
                        } else if(!angular.equals(response.OBDRresp.result, {}) ) {
                            $scope.enterpriseCartList.push(response.OBDRresp.result);
                        }
                    }                    
                }
                $scope.showTableLoading = false;
            });
        }

        function resetEnterpriseCarts() {
            $scope.enterpriseCartList = [];
        }
        function getParent() 
        {
            var sobjectName = 'Quote';
            if($scope.cartType === 'order') {
                sobjectName = 'Order';
            }
            let apiInput = {
                'DRParams': {
                    'opportunityId': $scope.bpTree.ContextId
                },
                'Bundle': 'MultiService - Load Default fields for Enterprise ' + sobjectName
            }
            fireApi ('DefaultDROmniScriptIntegration','invokeOutboundDR', apiInput, {}, function(resp){
                if (resp)
                {
                    let response = angular.fromJson(resp);
                    $scope.cartDefaultFields = response.OBDRresp.result;
                }
            });
        }
        /*
         * on change of radio button.
         */ 
        $scope.selectEnterpriseRecord = function(cartObj) {
            if(!$scope.bpTree.wrapperCart) {
                $scope.bpTree.wrapperCart = {};
            }
            //$scope.selectedEnterpriseCart = cartObj;
            $scope.bpTree.wrapperCart = cartObj;
            if ($scope.cartType.toLowerCase() === 'order' && cartObj && 'Ready To Submit' != cartObj.status) {
                $scope.bpTree.disableGroupActions = true;
            } else {
                $scope.bpTree.disableGroupActions = false;
            }
        }

        $scope.update = function(selectedObj) {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSRenameLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var enterpriseCartPopup = $sldsModal({
                templateUrl: 'enterpriseCartPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.enterpriseCart = angular.copy(selectedObj);

            modalScope.confirmationAction = function() {
                var name = modalScope.enterpriseCart.Name;
                if (!isValidName(name)) {
                    toast('Invalid Name!', undefined, 'error');
                    return;
                }
                let msg = $scope.cartType === 'order' ? $scope.customLabelsMap.MSUpdatingOMsg: $scope.customLabelsMap.MSUpdatingQMsg;                
                var cgToast = toast(msg, undefined, 'info');
                updateEnterpriseCart(modalScope.enterpriseCart, cgToast);
                enterpriseCartPopup.hide();
            }
        }
        /*
         * new Enterprise cart button click.
         */ 
        $scope.newEnterpriseCart = function() {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSNewEnterpriseLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var createCartPopup = $sldsModal({
                templateUrl: 'enterpriseCartPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.enterpriseCart = {};

            modalScope.confirmationAction = function() {
                var input = {...modalScope.enterpriseCart};
                if (!isValidName(input.Name)) {
                    toast('Invalid Name!', undefined, 'error');
                    return;
                }
                let msg = $scope.cartType === 'order' ? $scope.customLabelsMap.MSCreatingOMsg: $scope.customLabelsMap.MSCreatingQMsg;
                var cgToast = toast(msg, undefined, 'info');
                saveEnterpriseCart(input, cgToast);
                createCartPopup.hide();
            }
        }

        function getCustomLabels() {

            remoteActions.getCustomLabels(customLabels, '').then(
                function (result) {
                    if(result) {
                        $scope.customLabelsMap = angular.fromJson(result);
                    }
                }
            );
        }
        function isValidName(name) {
            if (!name)
                return false;
            return true;
        }
        /*
         *
         */ 
        function updateEnterpriseCart(enterpriseCart, infoToast) {
            let name = enterpriseCart.Name;
            
            fireApi('CpqAppHandler','updateCarts', formUpdateCartInput({...enterpriseCart}), {}, function(result) {
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if (res.records && res.records.length) {
                    toast(name + ' ' + $scope.customLabelsMap.MSUpdatedSuccMsg, '', 'success');
                    //reload Enterprise quotes
                    loadEnterpriseCarts();
                } else if(res.message) {
                    toast($scope.customLabelsMap.MSUpdateFailure, res.message, 'error');
                } else if(res.messages && res.messages.length && res.messages[0].message){
                    toast($scope.customLabelsMap.MSUpdateFailure, res.messages[0].message, 'error');
                } else {
                    toast($scope.customLabelsMap.MSUpdateFailure, '', 'error');
                }
            });
        }
        /*
         * save new enterprise Quote.
         */ 
        function saveEnterpriseCart(input, infoToast) {
            let name = input.Name;

            fireApi('CpqAppHandler','createCart', formCreateCartInput(input), {}, function(result) {
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if (res.records && res.records.length) {
                    toast(name + ' ' + $scope.customLabelsMap.MSCreatedSuccMsg, '', 'success');
                    //reload Enterprise quotes
                    loadEnterpriseCarts();
                } else if(res.message) {
                    toast($scope.customLabelsMap.MSCreateFailure, res.message, 'error');
                } else if(res.messages && res.messages.length && res.messages[0].message){
                    toast($scope.customLabelsMap.MSCreateFailure, res.messages[0].message, 'error');
                } else {
                    toast($scope.customLabelsMap.MSCreateFailure, '', 'error');
                }
            });
        }

        function formCPQAPIInput(input) {
            let apiInput = {
                'inputFields': [] 
            };
            for (let key in input)
            {
                if (key)
                {
                    let obj = {};
                    obj[key] = input[key];
                    apiInput.inputFields.push(obj);
                }
            }
            return apiInput;
        }
        function addDefaultFields(input) {
            for (let key in $scope.cartDefaultFields)
            {
                input[key] = $scope.cartDefaultFields[key];
            }
        }

        function formCreateCartInput(input) {
            if(!input.recordType) {
                input.recordType = $scope.recordTypeNames[0];
            }
            input.OpportunityId = $scope.bpTree.ContextId;
            addDefaultFields(input);
            let apiInput = formCPQAPIInput(input);
            apiInput['objectType'] = $scope.bpTree.cartType;
            return apiInput;
        }

        function formUpdateCartInput(input) {
            let id = input.Id;
            delete input.Id;
            delete input.status;
            let apiInput = formCPQAPIInput(input);
            apiInput['cartId'] = id;
            return apiInput;
        }

        function getObjectDesc(objectList) {
            var input = {'objectNames': objectList};
            fireRemoteAction('getObjectFieldsDescribe', input, {}, function(result){
                var res = angular.fromJson(result);
                if(res.message) {
                    $scope.toast(res.message, undefined, 'error');
                    return;
                }
                if(!$scope.bpTree.objectNameToFields) {
                    $scope.bpTree.objectNameToFields = {};
                }
                $scope.bpTree.objectNameToFields = res.result;
                for(let key in res.result) {
                    $scope.bpTree.objectNameToFields[key] = res.result[key];
                }
            });
        }

        function loadFields() {
            return getFieldList().then(function(){
                //colllect all object names
                var objectList = [];
                for(field of $scope.fieldList) {
                    if (field !== '' && objectList.indexOf(field.objectName) === -1) {
                        objectList.push(field.objectName);
                    }
                }
                if(objectList.length > 0) {
                    getObjectDesc(objectList);
                }
            });
        }

        /*
         * get field list.
         */ 
        function getFieldList() {
            var input = {
                featureName: 'MultiServiceEnterpriseCartFields',
                objectName: $scope.bpTree.cartType
            }
            return fireRemoteAction('getFieldList', input, {}, function(result){
                $scope.fieldList = angular.fromJson(result).result;
                if(!$scope.fieldList || $scope.fieldList.length === 0) {
                    $scope.fieldList = [];
                    var nameField = {
                        fieldName: 'Name',
                        fieldAPIName: 'Name',
                        fieldLabel: 'Name',
                        objectName: $scope.bpTree.cartType,
                        displaySequence: 1,
                        objectAPIName: $scope.bpTree.cartType
                    };
                    if($scope.cartType === 'order') {
                        var effectiveField = {
                            fieldName: 'EffectiveDate',
                            fieldAPIName: 'EffectiveDate',
                            fieldLabel: 'Order Start Date',
                            objectName: $scope.bpTree.cartType,
                            displaySequence: 2,
                            objectAPIName: $scope.bpTree.cartType
                        };
                        $scope.fieldList.push(effectiveField);
                    }
                    $scope.fieldList.push(nameField);
                }
            });
        }
        /*
         * toast messages.
         */ 
        function toast(title, content, severity) {
            return $sldsToast({
                    title: title,
                    content: content,
                    severity: severity,
                    icon: severity,
                    templateUrl: 'SldsToast.tpl.html',
                    autohide: true,
                    show: true
                }); 
        }

        function getCustomSettings(name) {
            var input = {
                customSettingsName: name
            };
             var remoteActionObj = {
                sClassName: $scope.bpService.sNSC + 'CardCanvasController',
                sMethodName: 'getCustomSettings',
                input: angular.toJson(input),
                options: angular.toJson({}),
                iTimeout: 30000                
            };

            return $scope.bpService.OmniRemoteInvoke(remoteActionObj).then(
                function (result) {
                    var response = angular.fromJson(result);
                    if(response && response.result) {
                        response = angular.fromJson(response.result);
                        $scope.bpTree.cpqCustomSettings = {};
                        for(let i=0; i<response.length; i++) {
                            var record = response[i];
                            $scope.bpTree.cpqCustomSettings[record.Name] = record[$scope.nsp + 'SetupValue__c'];
                        }
                    }
                }
            );
        }


        /*
         * fire remote action.
         */ 
        function fireRemoteAction(methodName, input, options, callBackFn) {
            return fireApi('MultiServiceAppHandler', methodName, input, options, callBackFn);
        }

        function fireApi(handler, methodName, input, options, callBackFn) {
            var remoteActionObj = {
                sClassName: $scope.bpService.sNSC + handler,
                sMethodName: methodName,
                input: angular.toJson(input),
                options: angular.toJson(options),
                iTimeout: 30000                
            };

            return $scope.bpService.OmniRemoteInvoke(remoteActionObj).then(
                function (result) {
                    callBackFn(result);
                }
            );
        }
        /*
         * next button disable/enable.
         */
        function nextButton(disable) {

            if(!nextButtonId) {
                return;
            }

            if(disable) {
                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'none', 'cursor': 'default', 'background': '#c9c7c5'});
            } else {
                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'auto', 'cursor': 'pointer', 'background': '#0070d2'});
            }
        }
    }
]);