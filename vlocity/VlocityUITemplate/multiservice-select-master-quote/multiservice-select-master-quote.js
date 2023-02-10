vlocity.cardframework.registerModule.controller('ManageMasterQuoteController', ['$scope', '$sldsModal', '$sldsToast', 'remoteActions',
    function($scope, $sldsModal, $sldsToast, remoteActions) {
        /*
         * Master quote list.
         */
        $scope.masterQuoteList = [];
        /*
         * fields to display.
         */ 
        $scope.fieldList = [];
        /*
         * custom labels
         */
        var customLabels = ['MSUpdatingMQMsg', 'MSCreatingMQMsg', 'MSCloningMQMsg', 'MSClonedSuccMsg', 'MSCreatedSuccMsg',
                            'MSUpdatedSuccMsg','MSCloneMQLabel', 'MSNewMQLabel', 'MSRenameMQLabel', 'MSNameLabel', 'MSCloneLabel',
                            'MSCloseLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSSelectMQLabel', 'MSRenameLabel', 'MSNewLabel',
                            'MSRequestExternalLabel', 'MSGetExternalLabel', 'MSRequestExternalMsg', 'MSGetExternalMsg',
                            'MSRequestedStatusLabel'];
        /*
         * custom labels map.
         */ 
        $scope.customLabelsMap = {};
        /*
         * next button id.
         */
        var nextButtonId = 'SelectMasterQuote_nextBtn';
        /*
         * keep watch on selected quote.
         */ 
        $scope.$watch('bpTree.selectedQuote.masterQuoteId', function (newValue, oldValue) {
            if(newValue) {
                nextButton(false);
            } else {
                nextButton(true);
            }
        });
        /*
         * controller init.
         */ 
        $scope.init = function() {
            $scope.bpTree.selectedQuote = {};
            getFieldList();
            getCustomLabels();
            $scope.loadMasterQuotes();
            $scope.nsp = $scope.bpService.sNS + '__';
        }
        /*
         * load master quotes.
         */ 
        $scope.loadMasterQuotes = function() {
            $scope.bpTree.selectedQuote = {};
            $scope.showTableLoading = true;
            var input = {'parentId': $scope.bpTree.ContextId};
            fireRemoteAction('getMasterQuotes', input, {}, function(result){

                var response = angular.fromJson(result);
                if(response) {
                    $scope.masterQuoteList = response.result;
                }
                $scope.showTableLoading = false;
            });
        }
        $scope.isToShowExtraActions = function() {
            return $scope.bpTree.selectedQuote.masterQuoteId && 
                    ( $scope.selectedQuote[$scope.nsp + 'ExternalPricingStatus__c'] === 'Ready' ||
                    $scope.selectedQuote[$scope.nsp + 'ExternalPricingStatus__c'] === 'Request Confirmed');
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

        function getExternalPricing (infoToast) {
            var messageLevel = 'success';
            var input = {
                masterQuoteId: $scope.bpTree.selectedQuote.masterQuoteId
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
                    $scope.loadMasterQuotes();
                }
            });
        }

        function requestExternalPricing (infoToast) {
            var messageLevel = 'success';
            var input = {
                masterQuoteId: $scope.bpTree.selectedQuote.masterQuoteId
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
                    $scope.loadMasterQuotes();
                }
            });
        }
        /*
         * on change of radio button.
         */ 
        $scope.selectMasterQuote = function(quote) {
            if(!$scope.bpTree.selectedQuote) {
                $scope.bpTree.selectedQuote = {};
            }
            $scope.selectedQuote = quote;
            //$scope.bpTree.selectedQuote.masterQuoteId = quote.Id;
            $scope.bpTree.selectedQuote.masterQuoteName = quote.Name;
        }

        $scope.rename = function(masterQuote) {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSRenameMQLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var masterQuotePopup = $sldsModal({
                templateUrl: 'masterQuotePopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.masterQuote = {
                id: masterQuote.masterQuoteId,
                name: masterQuote.masterQuoteName
            };

            modalScope.confirmationAction = function() {
                var name = modalScope.masterQuote.name;

                if(name && name !== '') {
                    var cgToast = toast($scope.customLabelsMap.MSUpdatingMQMsg, undefined, 'info');
                    updateMasterQuote(modalScope.masterQuote, cgToast);                   
                }
                masterQuotePopup.hide();
            }
        }
        /*
         * new master quote button click.
         */ 
        $scope.newMasterQuote = function() {
            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSNewMQLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var createNewMasterQuotePopup = $sldsModal({
                templateUrl: 'masterQuotePopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.masterQuote = {};

            modalScope.confirmationAction = function() {
                var name = modalScope.masterQuote.name;

                if(name && name !== '') {
                    var cgToast = toast($scope.customLabelsMap.MSCreatingMQMsg, undefined, 'info');
                    saveNewMasterQuote(name, cgToast);                   
                }
                createNewMasterQuotePopup.hide();
            }
        }
        /*
         * clone button click.
         */ 
        $scope.clone = function() {

            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSCloneMQLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var cloneMasterQuotePopup = $sldsModal({
                templateUrl: 'masterQuotePopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.masterQuote = {name: 'Clone - ' + $scope.bpTree.selectedQuote.masterQuoteName};

            modalScope.confirmationAction = function() {
                var name = modalScope.masterQuote.name;

                if(name && name !== '') {
                    var cgToast = toast($scope.customLabelsMap.MSCloningMQMsg, undefined, 'info');
                    clone(name, cgToast);                   
                }
                cloneMasterQuotePopup.hide();
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
        /*
         *
         */ 
        function updateMasterQuote(masterQuote, infoToast) {
            var input = {
                masterQuoteId: masterQuote.id,
                name: masterQuote.name,
                parentId: $scope.bpTree.ContextId
            };
            
            fireRemoteAction('updateMasterQuote', input, {}, function(result){
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if(res.masterQuoteId) {
                    toast(name + ' ' + $scope.customLabels.MSUpdatedSuccMsg, '', 'success');
                    //reload master quotes
                    $scope.loadMasterQuotes();
                } else if(res.message) {
                    toast(res.message, '', 'error');
                } else {
                    toast('Failed', '', 'error');
                }
            });
        }
        /*
         * save New Master Quote.
         */ 
        function saveNewMasterQuote(name, infoToast) {

            var input = {
                name: name,
                parentId: $scope.bpTree.ContextId
            };
            
            fireRemoteAction('createNewMasterQuote', input, {}, function(result){
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if(res.masterQuoteId) {
                    toast(name + ' ' + $scope.customLabelsMap.MSCreatedSuccMsg, '', 'success');
                    //reload master quotes
                    $scope.loadMasterQuotes();
                } else if(res.message) {
                    toast(res.message, '', 'error');
                } else {
                    toast('Failed', '', 'error');
                }
            });
        }
        /*
         * get field list.
         */ 
        function getFieldList() {
            fireRemoteAction('getMasterQuoteFieldList', {}, {}, function(result){
                $scope.fieldList = angular.fromJson(result).result;
            });
        }
        /*
         * clone of master quote.
         */ 
        function clone(name, infoToast) {

            var input = {
                parentId: $scope.bpTree.ContextId,
                masterQuoteId: $scope.bpTree.selectedQuote.masterQuoteId,
                name: name
            };
            
            fireRemoteAction('cloneMasterQuote', input, {}, function(result){
                if(infoToast) {
                    infoToast.hide();
                }
                var res = angular.fromJson(result);
                if(res.masterQuoteId) {
                    toast(name + ' ' + $scope.customLabelsMap.MSClonedSuccMsg, '', 'success');
                    //reload master quotes
                    $scope.loadMasterQuotes();
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


        /*
         * fire remote action.
         */ 
        function fireRemoteAction(methodName, input, options, callBackFn) {

            var remoteActionObj = {
                sClassName: $scope.bpService.sNSC + 'MultiServiceAppHandler',
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