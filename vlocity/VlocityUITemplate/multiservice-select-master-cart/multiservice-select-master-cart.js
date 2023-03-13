vlocity.cardframework.registerModule.controller('ManageMasterCartController', ['$scope', '$sldsModal', '$sldsToast', '$q', 'remoteActions',
    function($scope, $sldsModal, $sldsToast, $q, remoteActions) {
        /*
         * Master quote list.
         */
        $scope.masterCartList = [];
        /*
         * fields to display.
         */ 
        $scope.fieldList = [];
        /*
         * custom labels
         */
        var customLabels = ['MSUpdatingMQMsg', 'MSUpdatingMOMsg', 'MSCreatingMQMsg', 'MSCreatingMOMsg', 'MSCloningMQMsg', 'MSCloningMOMsg', 'MSClonedSuccMsg', 'MSCreatedSuccMsg',
                            'MSUpdatedSuccMsg','MSCloneMQLabel', 'MSCloneMOLabel', 'MSNewMQLabel', 'MSNewMOLabel', 'MSRenameMQLabel', 'MSUpdateMOLabel', 'MSNameLabel', 'MSCloneLabel',
                            'MSCloseLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSSelectMQLabel', 'MSSelectMOLabel', 'MSRenameLabel', 'MSNewLabel',
                            'MSRequestExternalLabel', 'MSGetExternalLabel', 'MSRequestExternalMsg', 'MSGetExternalMsg', 'MSEmptyNameMsg', 'MSDupNameMsg',
                            'MSRequestedStatusLabel', 'MSCreateFailure', 'MSUpdateFailure'];
        /*
         * custom labels map.
         */ 
        $scope.customLabelsMap = {};
        /*
         * next button id.
         */
        var nextButtonId = 'SelectMasterCart_nextBtn';
        /*
         * keep watch on selected wrapper cart.
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
                $scope.cartType = newValue;
                $scope.bpTree.cartType = newValue;
                $q.all([loadFields()]).then(function(){
                    loadMasterCarts();
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
        }
        $scope.isToShowExtraActions = function() {
            return $scope.bpTree.wrapperCart.Id && 
                    ( $scope.selectedMasterCart[$scope.nsp + 'ExternalPricingStatus__c'] === 'Ready' ||
                    $scope.selectedMasterCart[$scope.nsp + 'ExternalPricingStatus__c'] === 'Request Confirmed');
        }
        /*
         * load master quotes.
         */ 
        function loadMasterCarts() {
            $scope.userSelectedObj = {};
            $scope.bpTree.wrapperCart = {};
            $scope.showTableLoading = true;
            var input = {'parentId': $scope.bpTree.ContextId, cartType: $scope.cartType};
            fireRemoteAction('getMasterCarts', input, {}, function(result){

                var response = angular.fromJson(result);
                if (response && response.result && response.result.length) {
                    $scope.masterCartList = response.result;
                }
                $scope.showTableLoading = false;
            });
        }
        $scope.getExternalPricingClick = function() {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSGetExternalLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSGetExternalLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;
            modalScope.confirmationMsg = $scope.customLabelsMap.MSGetExternalMsg;

            var confirmationPopupPopup = $sldsModal({
                templateUrl: 'confirmationPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});

            modalScope.confirmationAction = function() {
                var infoToast = toast('Getting external pricing...', undefined, 'info');
                getExternalPricing(infoToast);
                confirmationPopupPopup.hide();
            }
        }

        $scope.requestExternalPricingClick = function() {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSRequestExternalLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSRequestExternalLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;
            modalScope.confirmationMsg = $scope.customLabelsMap.MSRequestExternalMsg;

            var confirmationPopupPopup = $sldsModal({
                templateUrl: 'confirmationPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});

            modalScope.confirmationAction = function() {
                var infoToast = toast('Requesting external pricing...', undefined, 'info');
                requestExternalPricing(infoToast);
                confirmationPopupPopup.hide();
                
            }
        }

        function getParent() 
        {
            var postFix = 'Quote';
            if($scope.cartType.toLowerCase() === 'order') {
                postFix = 'Order';
            }
            let apiInput = {
                'DRParams': {
                    'opportunityId': $scope.bpTree.ContextId
                },
                'Bundle': 'MultiService - Load Default fields for Master '+ postFix
            }
            fireApi ('DefaultDROmniScriptIntegration','invokeOutboundDR', apiInput, {}, function(resp){
                if (resp)
                {
                    let response = angular.fromJson(resp);
                    $scope.cartDefaultFields = response.OBDRresp.result;
                }
            });
        }
        function getExternalPricing (infoToast) {
            var messageLevel = 'success';
            var input = {
                masterQuoteId: $scope.bpTree.wrapperCart.Id
            };
            
            fireRemoteAction('getExternalPricing', input, {}, function(result){

                var response = angular.fromJson(result);
                console.log(response);
                if(infoToast) {
                    infoToast.hide();
                }
                if(response.message) {
                    if(response.isFailed) {
                        messageLevel = 'error';
                    }
                    toast(response.message, undefined, messageLevel);
                    loadMasterCarts();
                }
            });
        }

        function requestExternalPricing (infoToast) {
            var messageLevel = 'success';
            var input = {
                masterQuoteId: $scope.bpTree.wrapperCart.Id
            };
            fireRemoteAction('requestExternalPricing', input, {}, function(result){

                var response = angular.fromJson(result);
                console.log(response);
                if(infoToast) {
                    infoToast.hide();
                }
                if(response.message) {
                    if(response.isFailed) {
                        messageLevel = 'error';
                    }
                    toast(response.message, undefined, messageLevel);
                    loadMasterCarts();
                }
            });
        }
        /*
         * on change of radio button.
         */ 
        $scope.selectMasterCart = function(cart) {
            $scope.bpTree.wrapperCart = cart;
            $scope.selectedMasterCart = cart;
            let status = cart[$scope.nsp + 'OrderStatus__c'];
            if ($scope.cartType.toLowerCase() === 'order' && 'Ready To Submit' != status) {
                $scope.bpTree.disableGroupActions = true;
            } else {
                $scope.bpTree.disableGroupActions = false;
            }
        }

        $scope.update = function(selectedObj) {
            var modalScope = $scope.$new();
            let oldName = selectedObj.Name;
            modalScope.confirmationTitle = ($scope.cartType != 'Order') ? $scope.customLabelsMap.MSRenameMQLabel : $scope.customLabelsMap.MSUpdateMOLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var masterCartPopup = $sldsModal({
                templateUrl: 'masterCartPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.masterCart = angular.copy(selectedObj);

            modalScope.confirmationAction = function() {
                var name = modalScope.masterCart.Name;
                if (oldName != name && !isValidName(name)) {
                    return;
                }
                let msg = ($scope.cartType != 'Order') ? $scope.customLabelsMap.MSUpdatingMQMsg : $scope.customLabelsMap.MSUpdatingMOMsg;                
                var cgToast = toast(msg, undefined, 'info');
                updateMasterCart(modalScope.masterCart, cgToast);
                masterCartPopup.hide();
            }
        }
        /*
         * new master cart button click.
         */
        $scope.newMasterCart = function() {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = ($scope.cartType != 'Order') ? $scope.customLabelsMap.MSNewMQLabel : $scope.customLabelsMap.MSNewMOLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var createNewMasterCartPopup = $sldsModal({
                templateUrl: 'masterCartPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.masterCart = {};

            modalScope.confirmationAction = function() {
                var input = {...modalScope.masterCart};
                if (!isValidName(input.Name)) {
                    return;
                }
                let msg = ($scope.cartType != 'Order') ? $scope.customLabelsMap.MSCreatingMQMsg : $scope.customLabelsMap.MSCreatingMOMsg;
                var cgToast = toast(msg, undefined, 'info');
                saveNewMasterCart(input, cgToast);   
                createNewMasterCartPopup.hide();
            }
        }
        /*
         * clone button click.
         */ 
        $scope.clone = function() {

            var modalScope = $scope.$new();
            modalScope.confirmationTitle = ($scope.cartType != 'Order') ? $scope.customLabelsMap.MSCloneMQLabel : $scope.customLabelsMap.MSCloneMOLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var cloneMasterCartPopup = $sldsModal({
                templateUrl: 'masterCartPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.masterCart = angular.copy($scope.bpTree.wrapperCart);
            modalScope.masterCart.Name = 'Clone - ' + modalScope.masterCart.Name;
            modalScope.confirmationAction = function() {

                var name = modalScope.masterCart.Name;
                if (!isValidName(name)) {
                    return;
                }
                let msg = ($scope.cartType != 'Order') ? $scope.customLabelsMap.MSCloningMQMsg : $scope.customLabelsMap.MSCloningMOMsg;
                var cgToast = toast(msg, undefined, 'info');
                clone(name, cgToast);
                cloneMasterCartPopup.hide();
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
            if (!name) {
                toast($scope.cartType + ' ' + $scope.customLabelsMap.MSEmptyNameMsg, undefined, 'error');
                return false;
            }
            return true;
        }
        /*
         *
         */ 
        function updateMasterCart(masterCart, infoToast) {
            let name = masterCart.Name;
            
            fireApi('CpqAppHandler','updateCarts', formUpdateCartInput({...masterCart}), {}, function(result) {
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if (res.records && res.records.length) {
                    toast(name + ' ' + $scope.customLabelsMap.MSUpdatedSuccMsg, '', 'success');
                    //reload master quotes
                    loadMasterCarts();
                }  else if(res.message) {
                    toast($scope.customLabelsMap.MSUpdateFailure, res.message, 'error');
                } else if(res.messages && res.messages.length && res.messages[0].message){
                    toast($scope.customLabelsMap.MSUpdateFailure, res.messages[0].message, 'error');
                } else {
                    toast($scope.customLabelsMap.MSUpdateFailure, '', 'error');
                }
            });
        }
        /*
         * save New Master Quote.
         */ 
        function saveNewMasterCart(input, infoToast) {
            let name = input.Name;

            fireApi('CpqAppHandler','createCart', formCreateCartInput(input), {}, function(result) {
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if (res.records && res.records.length) {
                    toast(name + ' ' + $scope.customLabelsMap.MSCreatedSuccMsg, '', 'success');
                    //reload master quotes
                    loadMasterCarts();
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
            input.recordType = 'Master' + $scope.cartType;
            input.OpportunityId = $scope.bpTree.ContextId;
            addDefaultFields(input);
            let apiInput = formCPQAPIInput(input);
            apiInput['objectType'] = $scope.cartType;
            return apiInput;
        }

        function formUpdateCartInput(input) {
            let id = input.Id;
            delete input.Id;
            let apiInput = formCPQAPIInput(input);
            apiInput['cartId'] = id;
            return apiInput;
        }

        function getObjectDesc(objectList) {
            var input = {'objectNames': objectList};
            fireRemoteAction('getObjectFieldsDescribe', input, {}, function(result){
                var res = angular.fromJson(result);
                if(res.message)
                {
                    $scope.toast(res.message, undefined, 'error');
                    return;
                }
                $scope.objectNameToFields = res.result;
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
                featureName: 'MultiServiceMasterCartFields',
                objectName: $scope.cartType
            };
            return fireRemoteAction('getFieldList', input, {}, function(result){
                $scope.fieldList = angular.fromJson(result).result;
                if(!$scope.fieldList || $scope.fieldList.length === 0) {
                    $scope.fieldList = [];
                    var nameField = {
                        fieldName: 'Name',
                        fieldAPIName: 'Name',
                        fieldLabel: 'Name',
                        objectName: $scope.cartType,
                        displaySequence: 1,
                        objectAPIName: $scope.cartType
                    };
                    if($scope.cartType.toLowerCase() === 'order') {
                        var effectiveField = {
                            fieldName: 'EffectiveDate',
                            fieldAPIName: 'EffectiveDate',
                            fieldLabel: 'Order Start Date',
                            objectName: $scope.cartType,
                            displaySequence: 2,
                            objectAPIName: $scope.cartType
                        };
                        $scope.fieldList.push(effectiveField);
                    }
                    $scope.fieldList.push(nameField);
                }
            });
        }
        /*
         * clone of master quote.
         */ 
        function clone(name, infoToast) {

            var input = {
                parentId: $scope.bpTree.ContextId,
                masterQuoteId: $scope.bpTree.wrapperCart.Id,
                name: name,
                cartType: $scope.cartType
            };
            
            fireRemoteAction('cloneMasterCart', input, {}, function(result){
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if(res.masterCartId) {
                    toast(name + ' ' + $scope.customLabelsMap.MSClonedSuccMsg, '', 'success');
                    //reload master quotes
                    loadMasterCarts();
                } else if(res.message) {
                    toast(res.message, '', 'error');
                } else {
                    toast('Failed', '', 'error');
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