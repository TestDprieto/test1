vlocity.cardframework.registerModule.controller('manageGroupController', ['$rootScope', '$scope' ,'$filter', '$sldsModal', '$sldsToast', '$sldsPopover', '$q', '$sldsPrompt', 'remoteActions',
    function($rootScope, $scope ,$filter, $sldsModal, $sldsToast, $sldsPopover, $q, $sldsPrompt, remoteActions) {

        var initialContext = {
            fieldList: [],
            filterFieldList: [],
            ungroupedItemList: [],
            groupList: [],
            filters: {},
            sortByString: '',
            ungroupedItemSelected: 0,
            groupedItemSelected: 0,
            groupSelected: 0,
            filterApplicable: {
                group: false
            },
            numberOfFiltersApplied: 0,
            selectedAll: false,
            unGroupedMemberTotalCount: 0,
            showFilter: false
        }
        /*
         * object list to keep describe details.
         */
        $scope.objectList = [];
        /*
         * custom labels.
         */
        $scope.customLabels = {selectDefaultOption: '--Select--'};
        /*
         * Boolean picklist.
         */
        $scope.booleanPicklists = [{label: 'False', value: false}, {label: 'True', value: true}];

        $scope.rootLevelFlag = {
            showGroups: true
        };
        /*
         * pagination data.
         */
        $scope.memberPagination = {
            offset: 0,
            pageSize: 20
        }
        $scope.groupPagination = {
            offset: 0,
            pageSize: 20
        }
        $scope.ungroupedMemberPagination = {
            offset: 0,
            pageSize: 20
        }

        $scope.disableGroupActions = false;

        $scope.tab = {activeIndex: 0};
        /*
         * custom labels
         */
        var customLabels = ['MSGroupLabel', 'MSServiceLabel', 'MSShowLabel', 'MSHideLabel',
                            'MSFilterLabel', 'MSClearFilterLabel', 'MSFiltersAppliedLabel',
                            'MSCreateNewGroupLabel', 'MSRemoveFromGroupLabel', 'MSRenameGroupLabel',
                            'MSItemsSelectedLabel', 'MSAddNewGroupLabel', 'MSApplyFiltersGroupedLabel',
                            'MSGroupedItemsSelectedLabel', 'MSNoRecordsFoundLabel', 'MSLoadMoreLabel',
                            'MSPreviousLabel', 'MSNextLabel', 'MSGroupNameLabel', 'MSNoActiveMemberTypeMsg',
                            'MSGroupDescLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSCloseLabel', 'MSLoadMoreGroupsLabel',
                            'MSCreatingGroupMsg', 'MSUpdateGroupMsg', 'MSGroupUpdatedMsg', 'MSDeletingGroupMsg',
                            'MSDeleteGroupsLabel', 'MSGroupDeletedMsg', 'MSGroupCreatedMsg', 'MSRemovingItemGroupMsg',
                            'MSRemovedSuccMsg', 'MSAddedSuccMsg', 'MSAddingToMsg', 'MSApplyFilterLabel', 'MSAddToGroupLabel',
                            'MSNoChangeAllowedLabel', 'MSBatchStarting','MSBatchStarted','MSNoPriceValidateMsg',
                            'MSSeletectedGroupsToDeleteLabel', 'MSRunApplyToGroupMsg',
                            'MSApplyToGroups','MSPriceAndValidate','MultiServiceCPQQuoteCheckoutAction', 'MultiServiceCPQOrderCheckoutAction',
                            'MSGroupName', 'MSReason', 'MSNoGroupSelMsg', 'MSApplyToGroup',
                            'MSInvalidConfigMsg', 'MSNoMemberMsg', 'MSPriceAndValidateErrMsg', 'MSReRunATGMsg', 'MSNoRecordsMemberLabel'];
        /*
         * custom labels map.
         */ 
        $scope.customLabelsMap = {};
        /*
         * Group object list.
         */ 
        $scope.memberTypeList = [];
        /*
         * selected group object
         */ 
        $scope.selectedGroupObject = undefined;
        $scope.defaultGroupObject = undefined;
        $scope.selectedGroupObjDetails = {};

        $scope.groupObjectContext = {};
        $scope.cpqCustomSettings = {};

        var nextButtonId = 'ManageGroup_nextBtn';

        $scope.$watch('bpTree.response.ungroupedMemberPageSize', function(newValue, oldValue) {
            if(newValue && parseInt(newValue)) {
                $scope.ungroupedMemberPagination.pageSize = parseInt(newValue);
            }
        });
        $scope.$watch('bpTree.response.memberPageSize', function(newValue, oldValue) {
            if(newValue && parseInt(newValue)) {
                $scope.memberPagination.pageSize = parseInt(newValue);
            }
        });
        $scope.$watch('bpTree.response.groupPageSize', function(newValue, oldValue) {
            if(newValue && parseInt(newValue)) {
                $scope.groupPagination.pageSize = parseInt(newValue);
            }
        });

        $scope.$watch('bpTree.wrapperCart.Id', function (newValue, oldValue) {    
            if(newValue) {
                //Not expecting more than 5 member type.
                var i;
                for(i=0; i < $scope.memberTypeList.length; i++) {
                    loadConfig(i);
                }
                if ($scope.bpTree.disableGroupActions) {
                    $scope.disableGroupActions = true;
                } else {
                    $scope.disableGroupActions = false;
                }
            }
        });

        function checkForNextButton() {
            //check in all context
            var atLeastOneGroup = false, invalidGroup = false, i, key;
            for(key in $scope.groupObjectContext) {
                var context = $scope.groupObjectContext[key];
                if($scope.groupObjectContext.hasOwnProperty(key) && context.groupList && context.groupList.length > 0) {
                    for (i = 0; i < context.groupList.length; i++) {
                        if(context.groupList[i].itemsCount && context.groupList[i].itemsCount > 0) {
                            atLeastOneGroup = true;
                        } else {
                            invalidGroup = true;
                            break;
                        }
                    }
                    if(invalidGroup) {
                        nextButton(true);
                        return;
                    }
                }
            }
            if(atLeastOneGroup) {
                nextButton(false);
            } else {
                nextButton(true);
            }
        }

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

        /*
         * initialize after controller load.
         */
        $scope.init = function() {
            $scope.nsp = $scope.bpService.sNS + '__';
            getMemberTypeList();
            getCustomLabels();
            getCustomSettings($scope.nsp + 'CpqConfigurationSetup__c');
            //random count to couter cart URL, should start with 1
            // as zErO is false
            $scope.bpTree.randomCount = 1;
        }

        function loadConfig(index) {
            //find group object config developer name
            var groupObjectConfig = $scope.memberTypeList[index];
            if(!groupObjectConfig) {
                return;
            }
            var developerName = groupObjectConfig.developerName;
            //check for context
            var context = $scope.groupObjectContext[developerName];
            if(!context) {
                return;
            }
            if(context.fieldList.length === 0) {
                loadFields(context);
            }
            $scope.isGroupsLoading = true;
            $scope.showTableLoading = true;
            
            $scope.getGroups(context);
            $scope.getUngroupedRecords(context);
            
        }
        function loadFields(context) {
            $q.all([getFieldList(context), getFilterFieldList(context)]).then(function(){
                var i, oName;
                //colllect all object names
                var objectList = [];
                for(i=0; i< context.filterFieldList.length; i++) {
                    if(!context.filterFieldList[i]) {
                        continue;
                    }
                    oName = context.filterFieldList[i].objectAPIName;

                    if (objectList.indexOf(oName) === -1) {
                        objectList.push(oName);
                    }
                }
                for(i=0; i< context.fieldList.length; i++) {
                    if(!context.fieldList[i]) {
                        continue;
                    }
                    oName = context.fieldList[i].objectName;
                    if (objectList.indexOf(oName) === -1) {
                        objectList.push(oName);
                    }
                }
                if(objectList.length > 0) {
                    getObjectDesc(context, objectList);
                }
            });
        }

        function getMemberTypeList() {
            fireRemoteAction('getMemberTypeList', {}, {}, function(result) {
                var res = angular.fromJson(result);
                //res.defaultGroupObjectName
                if(res.message)
                {
                    $scope.toast(res.message, undefined, 'error');
                    return;
                }
                var memberTypeList = res.result;
                var groupObj, i;
                $scope.memberTypeList = [];
                for(i=0; i< memberTypeList.length; i++) {
                    groupObj = {
                        label: memberTypeList[i].MasterLabel,
                        name:  memberTypeList[i][$scope.nsp + 'MemberObjectName__c'],
                        quoteMemberFieldName: memberTypeList[i][$scope.nsp + 'QuoteMemberFieldName__c'],
                        orderMemberFieldName: memberTypeList[i][$scope.nsp + 'OrderMemberFieldName__c'],
                        developerName: memberTypeList[i].DeveloperName
                    };
                    groupObj
                    $scope.memberTypeList[i] = groupObj;
                    $scope.groupObjectContext[memberTypeList[i].DeveloperName]  = angular.copy(initialContext);
                    $scope.groupObjectContext[memberTypeList[i].DeveloperName].memberType = memberTypeList[i].DeveloperName;
                    $scope.groupObjectContext[memberTypeList[i].DeveloperName].ungroupedMemberPagination = angular.copy($scope.ungroupedMemberPagination);
                    $scope.groupObjectContext[memberTypeList[i].DeveloperName].groupPagination = angular.copy($scope.groupPagination);
                }
            });
        }

        function getObjectDesc(context, objectList) {
            var input = {'objectNames': objectList};
            fireRemoteAction('getObjectFieldsDescribe', input, {}, function(result){
                var res = angular.fromJson(result);
                if(res.message)
                {
                    $scope.toast(res.message, undefined, 'error');
                    return;
                }

                context.objectNameToFields = res.result;
            });
        }
        function getFieldList(context) {
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                memberType: context.memberType
            }
            return fireRemoteAction('getDisplayFieldList', input, {}, function(result) {
                var res = angular.fromJson(result);
                if(res.message) {
                    $scope.toast(res.message, undefined, 'error');
                } else {
                    context.fieldList = res.result;
                }
            });
        }
        function getFilterFieldList(context) {
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                memberType: context.memberType
            }
            return fireRemoteAction('getFilterFieldList', input, {}, function(result){
                var res = angular.fromJson(result);
                if(res.message) {
                    $scope.toast(res.message, undefined, 'error');
                } else {
                    context.filterFieldList = res.result;
                    context.filterFieldsMap = {};
                    if(context.filterFieldList) {
                        context.filterFieldList.forEach(function(filter){
                            context.filterFieldsMap[filter.fieldName] = filter; 
                        })
                    }
                }
            });
        }

        $scope.clearFilters = function(context) {
            context.filters = {};
            context.appliedFilters = {};
            context.ungroupedMemberPagination.offset = 0;
            context.filterApplicable = {group: false};
            $scope.getUngroupedRecords(context);
        }

        $scope.enableClearFiltersButton = function(context) {
            var prop;
            for(prop in context.filters) {
                if(context.filters.hasOwnProperty(prop)) {
                    return true;
                }
            }
            return false;
        }

        $scope.previousPage = function(context) {
            var offset = context.ungroupedMemberPagination.offset - context.ungroupedMemberPagination.pageSize;
            if(offset >= 0) {
                context.ungroupedMemberPagination.offset = offset;
                $scope.getUngroupedRecords(context);
            }
        }

        $scope.nextPage = function(context) {
            context.ungroupedMemberPagination.offset += context.ungroupedMemberPagination.pageSize;
            $scope.getUngroupedRecords(context);
        }

        $scope.applyFilters = function(context) {

            context.appliedFilters = {};
            var value, f, fieldInfo, prop;
            if(context.filters) {
                for(prop in context.filters) {
                    f = context.filterFieldsMap[prop];
                    value = context.filters[prop];
                    if(value && value !== '') {
                        fieldInfo = context.objectNameToFields[f.objectAPIName][f.fieldAPIName]
                        if(fieldInfo && fieldInfo.type === 'string') {
                            value = '%'+ value + '%';
                        }
                        context.appliedFilters[prop] = value;
                    } else {
                        delete context.filters[prop];
                    }
                }
            }
            context.ungroupedMemberPagination.offset = 0;
            $scope.getUngroupedRecords(context);
            //this requires to clear out grouped items.
            $scope.getGroups(context);
        }

        $scope.sortByColumn = function(context, clickedfield) {

            var fieldInfo = null;
            if (context && context.objectNameToFields && context.objectNameToFields[clickedfield.objectAPIName]) {
                fieldInfo = context.objectNameToFields[clickedfield.objectAPIName][clickedfield.fieldAPIName];
            }
            if (fieldInfo && fieldInfo.type && fieldInfo.type === 'textarea') {
                return;
            }
            var i, ascDesc = '', desc = '';
            var clickedPos = clickedfield.clickedPos;

            for(i=0; i<context.fieldList.length; i++) {
                context.fieldList[i].clickedPos = undefined;
            }

            if(clickedPos && clickedPos === 'up') {
                ascDesc = 'DESC';
                clickedfield.clickedPos = 'down';
                desc = '-'
            } else {
                ascDesc = 'ASC';
                clickedfield.clickedPos = 'up';
            }
            context.sortByString = clickedfield.fieldName + ' ' + ascDesc;
            context.sortByAngular = desc + clickedfield.fieldName + '.value';
            context.ungroupedMemberPagination.offset = 0;

            $scope.getUngroupedRecords(context);
        }

        $scope.getMoreMembers = function(context, group) {
            if(!group.actions || !group.actions.getGroupMembers) {
                return;
            }
            group.isLoading = true;
            fireAction(group.actions.getGroupMembers, function(result) {
                var res = angular.fromJson(result);
                var action;
                if(res && res.records) {
                    for(i=0; i<res.records.length; i++) {
                        group.members.push(res.records[i]);
                        group.members[i].applyToGroup = group.applyToGroup;
                        group.members[i].priceValidate = group.priceValidate;
                        setMessageAtMember(group.members[i]);
                    }
                }
                if(res && res.actions) {
                    action = res.actions.getGroupMembers;
                }
                group.actions.getGroupMembers = action;
                group.isLoading = false;
            });
        }

        $scope.getGroupMembers = function(context, group, silentUpdate, customPageSize) {

            if(!silentUpdate) {
                group.showItems = !group.showItems;
            }
            if(!group.showItems) {
                return;
            }
            if(group.itemsCount == 0 || (!silentUpdate && group.members && group.members.length > 0)) {
                return;
            }
            if(!silentUpdate) {
                group.isLoading = true;
            }
            
            var filters;
            if(context && context.filterApplicable.group) {
                filters = getFilters(context);
            }

            if(group.actions) {
                
                var memberAction = group.actions.getGroupMembers;
                if(memberAction && memberAction.remote && memberAction.remote.params) {
                    memberAction.remote.params.pageSize = $scope.memberPagination.pageSize;
                    if(customPageSize && !isNaN(customPageSize)) {
                        memberAction.remote.params.pageSize = customPageSize;
                    }
                    if(filters) {
                        memberAction.remote.params.filters = filters;
                    }
                    if(context && context.sortByString !== '') {
                        memberAction.remote.params.sortBy = context.sortByString;
                    }
                }
            }
            

            fireAction(group.actions.getGroupMembers, function(result) {
                var res = angular.fromJson(result);
                var action;
                if(res) {
                    group.members = res.records;
                    if(group.members) {
                        for(i=0; i<group.members.length; i++) {
                            group.members[i].applyToGroup = group.applyToGroup;
                            group.members[i].priceValidate = group.priceValidate;
                            setMessageAtMember(group.members[i]);
                        }
                    }
                    if(res.actions) {
                        action = res.actions.getGroupMembers;
                    }
                }
                group.actions.getGroupMembers = action;
                group.isLoading = false;
            });
        }

        function setMessageAtMember(member) {
            if (member.cart) {
                var messageData = member.cart[$scope.nsp + 'MultiServiceMessageData__c'];
                
                if (!messageData) {
                    return;
                }
                var msgDataObj = angular.fromJson(messageData);
                var parsedMsgDataList = null;
                if (msgDataObj && msgDataObj.messages) {
                    parsedMsgDataList = msgDataObj.messages;
                }
                if (!parsedMsgDataList) {
                    return;
                }
                var messageReport = {};
                for (var j=0; j<parsedMsgDataList.length; j++) {
                    var severity = parsedMsgDataList[j].severity;
                    if (!messageReport[severity]) {
                        messageReport[severity] = [];
                    }
                    messageReport[severity].push(parsedMsgDataList[j].displayText);
                }
                member.messageReport = messageReport;
            }
        }
        function setMessageAtGroup(group) {
            var groupMessage = group[$scope.nsp + 'MultiServiceMessageData__c'];
            if(groupMessage && groupMessage.value) {
                group.errorReport = angular.fromJson(groupMessage.value);
            }
        }

        $scope.getGroups = function(context) {
            context.isGroupsLoading = true;
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                pageSize: context.groupPagination.pageSize,
                offset: context.groupPagination.offset,
                memberType: context.memberType
            };
            fireRemoteAction('getGroups', input, {}, function(result){
                context.groupList = [];
                context.groupedItemSelected = 0;
                context.groupSelected = 0;

                var groupedRecords = angular.fromJson(result), iDx;
                if(groupedRecords && groupedRecords.message) {
                    $scope.toast(groupedRecords.message, '', 'error');
                }
                if(groupedRecords) {
                    context.groupList = groupedRecords.records;

                    if (context.groupList) {
                        for (iDx = 0; iDx < context.groupList.length; iDx++) {
                            setMessageAtGroup(context.groupList[iDx]);
                        }
                    }

                    if(groupedRecords.actions) {
                        context.nextGroupsAction = groupedRecords.actions.nextGroups;
                    }
                    if(groupedRecords.data && groupedRecords.data.groupTotalCount) {
                        context.groupTotalCount = groupedRecords.data.groupTotalCount;
                    }
                    
                }
                context.isGroupsLoading = false;
                checkForNextButton();
            });
        }
        /*
         * get more groups.
         */ 
        $scope.getMoreGroups = function(context, nextGroupsAction) {
            context.isGroupsLoading = true;
            fireAction(nextGroupsAction, function(result){
                var res = angular.fromJson(result);
                var action, groupMessage;
                if(res && res.records) {
                    for(i=0; i<res.records.length; i++) {
                        context.groupList.push(res.records[i]);

                        setMessageAtGroup(context.groupList[i]);
                    }
                }
                if(res && res.actions) {
                    action = res.actions.nextGroups;
                }
                if(res.data && res.data.groupTotalCount) {
                    context.groupTotalCount = res.data.groupTotalCount;
                }
                context.nextGroupsAction = action;
                context.isGroupsLoading = false;
            });
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

            $scope.bpService.OmniRemoteInvoke(remoteActionObj).then(
                function (result) {
                    var response = angular.fromJson(result), i;
                    if(response && response.result) {
                        response = angular.fromJson(response.result);
                        for(i=0; i<response.length; i++) {
                            var record = response[i];
                            $scope.cpqCustomSettings[record.Name] = record[$scope.nsp + 'SetupValue__c'];
                        }
                    }
                }
            );
        }

        $scope.getUngroupedRecords = function(context) {
            context.showTableLoading = true;
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                offset: context.ungroupedMemberPagination.offset, 
                pageSize: context.ungroupedMemberPagination.pageSize,
                memberType: context.memberType
            };
            var filters = getFilters(context);

            if(filters) {
                input.filters = filters;
            }
            if(context.sortByString !== '') {
                input.sortBy = context.sortByString;
            }
            if(context.filterApplicable && context.filterApplicable.group) {
                input.applyFiltersOnGroupedItems = true;
            }
            fireRemoteAction('getUngroupedRecords', input, {}, function(result){
                context.selectedAll = false;
                context.ungroupedItemSelected = 0;
                context.ungroupedItemList = [];
                context.unGroupedMemberTotalCount = 0;
                var ungroupedRecords = angular.fromJson(result);
                //check for message
                if(ungroupedRecords && ungroupedRecords.message) {
                    $scope.toast(ungroupedRecords.message, '', 'error');
                }
                if(ungroupedRecords && ungroupedRecords.records) {
                    context.ungroupedItemList = ungroupedRecords.records;
                    if(ungroupedRecords.data && ungroupedRecords.data.totalCount) {
                        context.unGroupedMemberTotalCount = ungroupedRecords.data.totalCount;
                    }
                }
                context.showTableLoading = false;
            });
        }

        function getFilters(context) {
            var filters = [], prop;
            var value;
            var filterStr;
            if(context.appliedFilters) {
                context.numberOfFiltersApplied = 0;
                for(prop in context.appliedFilters) {
                    if(context.appliedFilters.hasOwnProperty(prop)) {
                        value = context.appliedFilters[prop];
                        if(value) {
                            context.numberOfFiltersApplied++;
                            value = encodeURI(value);
                            if(value.includes('_')) {
                                value = value.replace(/\_/g, '%5f');
                            }
                            filters.push(prop + ':' + value);
                        }
                    }
                }
                if(filters.length != 0) {
                    filterStr = filters.join(',');
                }
            }
            return filterStr;
        }
        function fireAction(action, callBackFn) {
            if(!action.remote || !action.remote.params) {
                return;
            }

            var params = action.remote.params;
            var input = {}, key;
            for(key in params) {
                if(key !== 'methodName') {
                    input[key] = params[key];
                }
            }
            return fireRemoteAction(params.methodName, input, {}, callBackFn);
        }

        function fireRemoteAction(methodName, input, options, callBackFn) {

            input.cartType = $scope.bpTree.cartType;
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

        function fireIP(name, input, callBackFn) {
            if(name === '') {
                return;
            }
            var configObj = {
                sClassName: $scope.bpService.sNSC + "IntegrationProcedureService",
                sMethodName: name,
                input: angular.toJson(input),
                options: angular.toJson({}),
                iTimeout: 30000
            };
            $scope.bpService.OmniRemoteInvoke(configObj).then(
                function(result) {
                    callBackFn(result);
                });
        }

        function fireDR(bundle, params, callBackFn) {
            if(bundle === '') {
                return;
            }
            var input = {
                "DRParams": params,
                "Bundle": bundle
            }
            var configObj = {
                sClassName: $scope.bpService.sNSC + "DefaultDROmniScriptIntegration",
                sMethodName: "invokeOutboundDR",
                input: angular.toJson(input),
                options: angular.toJson({}),
                iTimeout: 30000
                //label: { label: element && element.name }
            };
            $scope.bpService.OmniRemoteInvoke(configObj).then(
                function(result) {
                    callBackFn(result);
                });
        }

        function startWatchOnGroups(groupIds, groupIdToGroupMap) {
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                groupIds: groupIds
            };
            fireRemoteAction('getGroups', input, {}, function(result){
                

                var groupedRecords = angular.fromJson(result);
                var newGroupIds = [], gObj, group, i;
                if(groupedRecords && groupedRecords.records) {
                    for(i=0; i<groupedRecords.records.length; i++) {
                        gObj = groupedRecords.records[i];
                        group = groupIdToGroupMap[gObj.groupId];
                        if(group) {
                            //merge values
                            for (var attrname in gObj) { 
                                if(gObj.hasOwnProperty(attrname)) {
                                    group[attrname] = gObj[attrname];
                                }
                            }
                            setMessageAtGroup(group);
                            if(group[$scope.nsp + 'LockedBy__c'].value) {
                                newGroupIds.push(group.groupId);
                            } else {
                                delete groupIdToGroupMap[group.groupId];
                            }
                            if(group.members && group.members.length > 0) {
                                $scope.getGroupMembers(undefined, group, true, group.members.length);
                            }
                        }   
                    }
                }
                if(newGroupIds.length > 0) {
                    setTimeout(startWatchOnGroups, 5000, newGroupIds, groupIdToGroupMap);
                }
            });
        }

        $scope.fireBulkAction = function(actionName) {

            var groupList = [], group, i, memberType,
                groupIdToGroupMap = {}, actionVIP, batchSize=1;
            //collect all selected groups
            for(memberType in $scope.groupObjectContext) {
                if($scope.groupObjectContext.hasOwnProperty(memberType)) {
                    var context = $scope.groupObjectContext[memberType];
                    if(!context.groupList) {
                        continue;
                    }
                    for(i=0; i<context.groupList.length; i++) {
                        if(context.groupList[i].isSelected && !context.groupList[i][$scope.nsp + 'LockedBy__c'].value) {
                            //keeping copy of original obj.
                            group = angular.copy(context.groupList[i]);
                            groupList.push(group);
                            //putting original group
                            groupIdToGroupMap[group.groupId] = context.groupList[i];
                            //check for number of members in that group.
                            if(!group.itemsCount || group.itemsCount === 0) {
                                group.isActionValid = false;
                                if($scope.customLabelsMap.MSNoMemberMsg) {
                                    var actionLabel;
                                    if(actionName === 'applyToGroup') {
                                        actionLabel = $scope.customLabelsMap.MSApplyToGroup;
                                    } else if(actionName === 'validateAndPrice') {
                                        actionLabel = $scope.customLabelsMap.MSPriceAndValidate;
                                    }
                                    else if(actionName === 'createAndSubmitOrders') {
                                        actionLabel = $scope.customLabelsMap.MultiServiceCPQQuoteCheckoutAction;
                                    }
                                    else if(actionName === 'submitOrders') {
                                        actionLabel = $scope.customLabelsMap.MultiServiceCPQOrderCheckoutAction;
                                    }
                                    group.actionMessage = $scope.customLabelsMap.MSNoMemberMsg.replace('{0}', actionLabel);
                                }
                                
                            }

                        }
                    }
                }
            }

            var modalScope = $scope.$new();
            modalScope.groupList = groupList;
            modalScope.action = actionName;
            modalScope.customLabelsMap = $scope.customLabelsMap;

            if(actionName === 'applyToGroup') {
                modalScope.confirmationTitle = $scope.customLabelsMap.MSApplyToGroups;
                modalScope.confirmActionLbl = $scope.customLabelsMap.MSApplyToGroups;
                actionVIP = 'MultiService_StartApplyToGroup';
            } else if(actionName === 'validateAndPrice') {
                modalScope.confirmationTitle = $scope.customLabelsMap.MSPriceAndValidate;
                modalScope.confirmActionLbl = $scope.customLabelsMap.MSPriceAndValidate;
                actionVIP = 'MultiService_StartValidatePrice';
            } else if(actionName === 'createAndSubmitOrders') {
                modalScope.confirmationTitle = $scope.customLabelsMap.MultiServiceCPQQuoteCheckoutAction;
                modalScope.confirmActionLbl = $scope.customLabelsMap.MultiServiceCPQQuoteCheckoutAction;
                actionVIP = 'MultiService_StartCreateAndSubmitOrders';
            }
            else if(actionName === 'submitOrders') {
                modalScope.confirmationTitle = $scope.customLabelsMap.MultiServiceCPQOrderCheckoutAction;
                modalScope.confirmActionLbl = $scope.customLabelsMap.MultiServiceCPQOrderCheckoutAction;
                actionVIP = 'MultiService_StartSubmitOrders';
            }
            
            
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.SLDSICON = '';
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var groupPopup = $sldsModal({
                templateUrl: 'bulkAction.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.confirmationAction = function() {

                //remove unqualified groups
                var j = modalScope.groupList.length;
                while (j--) {
                    if (!modalScope.groupList[j].isActionValid) { 
                        modalScope.groupList.splice(j, 1);
                    } 
                }       
                
                var input = {
                    groupCartId: modalScope.groupList[0].groupCartId,
                    groupId: modalScope.groupList[0].groupId,
                    parentId: $scope.bpTree.ContextId,
                    contextId: $scope.bpTree.wrapperCart.Id,
                    cartType: $scope.bpTree.cartType,
                    startJobVIPName: actionVIP
                }
                //modalScope.groupList.splice(modalScope.groupList.length, 1);
                var groupIds = [], i;
                for(i=1; i<modalScope.groupList.length; i++) {
                    groupIds.push(modalScope.groupList[i].groupId);
                }
                input.groupIds = groupIds;
                $scope.toast($scope.customLabelsMap.MSBatchStarting, undefined, 'info');
                fireIP(actionVIP, input, function(result){
                    var res = angular.fromJson(result).IPResult;
                    if(res.isJobStarted) {
                        $scope.toast(modalScope.confirmationTitle + ' ' + $scope.customLabelsMap.MSBatchStarted, undefined, 'success');
                        //start tracking...
                        groupIds.push(modalScope.groupList[0].groupId);
                        startWatchOnGroups(groupIds, groupIdToGroupMap);
                    } else {
                        $scope.toast(res.errorLabel, res.message, 'error');
                    }
                });

                groupPopup.hide();
            }
            modalScope.init = function() {
               
                if(modalScope.groupList && modalScope.groupList.length > 0) {
                     modalScope.isLoading = true;
                    validationBeforeAction(modalScope.action, modalScope.groupList, modalScope);
                }
            }
        }

        function validationBeforeAction(action, groupList, modalScope) {
            if(action === 'applyToGroup') {
                applyToGroupValidation(groupList, modalScope);
            } else if(action === 'validateAndPrice') {
                priceValidateValidation(groupList, modalScope);
            } else if(action === 'createAndSubmitOrders' || action === 'submitOrders') {
                checkoutValidation(groupList, modalScope);
            }
        }

        function applyToGroupValidation(groupList, modalScope) {
            var objectList = [], messageObj, allMessages, i, j, groupCart;
            var cartType = $scope.bpTree.cartType;
            var postFix = cartType + ' Products';
            for(i=0; i<groupList.length; i++) {
                //check for group cart messages.
                groupCart = groupList[i][$scope.nsp + 'GroupCartId__r'];
                if(groupCart && groupCart[$scope.nsp + 'MultiServiceMessageData__c']) {
                    messageObj = angular.fromJson(groupCart[$scope.nsp + 'MultiServiceMessageData__c']);
                    if(messageObj) {
                        
                        groupList[i].isActionValid = messageObj.canCheckout || messageObj.canCheckoutDiscounts;
                        
                        allMessages = '';
                        if(messageObj.messages) {
                            mList = messageObj.messages;
                            for(j=0; j<mList.length; j++) {
                               allMessages += mList[j].displayText;
                            }
                        }
                        groupList[i].actionMessage = allMessages;
                    }
                }
                if(!groupList[i].isActionValid && groupList[i].actionMessage) {
                    continue;
                }
                var obj = {
                    Id: groupList[i].groupCartId
                };
                objectList.push(obj);
            }
            fireDR('MultiService - Load '+ postFix, {objectList: objectList}, function(result){

                var groupCartIdToLineItemCount = {}, i, groupCartId;
                var response = angular.fromJson(result);
                if(response.OBDRresp) {
                    if(Array.isArray(response.OBDRresp)) {
                        for(i=0; i<response.OBDRresp.length; i++) {
                            groupCartId = response.OBDRresp[i][cartType + 'Id'];
                            if(groupCartIdToLineItemCount[groupCartId]) {
                                groupCartIdToLineItemCount[groupCartId]++;
                            } else {
                                groupCartIdToLineItemCount[groupCartId] = 1;
                            }
                        }
                    } else {
                        groupCartId = response.OBDRresp[cartType + 'Id'];
                        if(groupCartIdToLineItemCount[groupCartId]) {
                            groupCartIdToLineItemCount[groupCartId]++;
                        } else {
                            groupCartIdToLineItemCount[groupCartId] = 1;
                        }
                    }
                }

                for(i=0; i<groupList.length; i++) {

                    if(!groupList[i].isActionValid && groupList[i].actionMessage) {
                        continue;
                    }
                    //get group item count??
                    var itemCount = groupCartIdToLineItemCount[groupList[i].groupCartId];
                    if(!itemCount || itemCount < 1) {
                        groupList[i].isActionValid = false;
                        groupList[i].actionMessage = $scope.customLabelsMap.MSInvalidConfigMsg;
                    } else if(!groupList[i].hasUnappliedGroupItems) {
                        groupList[i].isActionValid = true;
                        groupList[i].hasWarning = true;
                        if($scope.customLabelsMap.MSReRunATGMsg) {
                            groupList[i].actionMessage = $scope.customLabelsMap.MSReRunATGMsg.replace('{0}', $scope.bpTree.cartType.toLowerCase());
                        }
                        modalScope.hasAtleastOneValidGroup = true;
                    }else {
                        groupList[i].isActionValid = true;
                        modalScope.hasAtleastOneValidGroup = true;
                    }
                }
                modalScope.isLoading = false;
            });
        }

        function priceValidateValidation(groupList, modalScope) {
            var i, groupCart, group;
            for(i=0; i<groupList.length; i++) {
                group = groupList[i];
                groupCart = group.groupCart;

                if(!group.isActionValid && group.actionMessage) {
                    continue;
                }

                if(group.hasUnappliedGroupItems)
                {
                    group.isActionValid = false;
                    group.actionMessage = $scope.customLabelsMap.MSRunApplyToGroupMsg;
                } else if(groupCart[$scope.nsp + 'IsPriced__c'] && groupCart[$scope.nsp + 'IsValidated__c']) {
                    group.isActionValid = false;
                    group.actionMessage = $scope.customLabelsMap.MSPriceAndValidateErrMsg;
                }
                else {
                    group.isActionValid = true;
                    modalScope.hasAtleastOneValidGroup = true;
                }
            }
            modalScope.isLoading = false;
        }

        function checkoutValidation(groupList, modalScope) {
            var i, group, groupCart;
            for(i=0; i<groupList.length; i++) {
                group = groupList[i];
                groupCart = group.groupCart;

                if(!group.isActionValid && group.actionMessage) {
                    continue;
                }

                if(group.hasUnappliedGroupItems)
                {
                    group.isActionValid = false;
                    group.actionMessage = $scope.customLabelsMap.MSRunApplyToGroupMsg;
                } else if(!groupCart || !groupCart[$scope.nsp + 'IsPriced__c'] 
                    || !groupCart[$scope.nsp + 'IsValidated__c']) {
                    group.isActionValid = false;
                    group.actionMessage = $scope.customLabelsMap.MSNoPriceValidateMsg;
                }else {
                    group.isActionValid = true;
                    //group.actionMessage = '';
                    modalScope.hasAtleastOneValidGroup = true;
                }
            }
            modalScope.isLoading = false;
        }

        $scope.renameGroup = function(context) {
            var selectedGroup = undefined, i;
            for(i=0; i<context.groupList.length; i++) {
                if(context.groupList[i].isSelected) {
                    selectedGroup = context.groupList[i];
                    break;
                }
            }

            if(!selectedGroup) {
                return;
            }

            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSRenameGroupLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.SLDSICON = '';
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var groupPopup = $sldsModal({
                templateUrl: 'groupPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.group = {
                name: selectedGroup.groupName,
                description: selectedGroup.groupDescription,
                groupId: selectedGroup.groupId
            }
            modalScope.confirmationAction = function() {

                if(modalScope.group.name && modalScope.group.name !== '' 
                    && (modalScope.group.name !== selectedGroup.groupName || 
                        modalScope.group.description !== selectedGroup.groupDescription)) {
                    var cgToast = $scope.toast($scope.customLabelsMap.MSUpdateGroupMsg, undefined, 'info');
                    updateGroup(context, modalScope.group, cgToast);                    
                }
                groupPopup.hide();
            }
        }

        function updateGroup(context, group, infoToast) {
            var input = {
                groupName: group.name,
                groupDescription: group.description,
                groupId: group.groupId,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id
            };
            
            fireRemoteAction('updateGroup', input, {}, function(result){
                if(infoToast) {
                    infoToast.hide();
                }
            
                var response = angular.fromJson(result);
                if(response) {
                    if(response.message) {
                        $scope.toast(response.message, '', 'error');
                    } else {
                        $scope.toast($scope.customLabelsMap.MSGroupUpdatedMsg, '', 'success');
                        $scope.getGroups(context);
                        $scope.bpTree.randomCount++;
                    }
                }
                
            });
        }

        $scope.deleteGroups = function(context) {
            var groupIds = [], i;
            var selectedGroupNames = '';
            for(i=0; i<context.groupList.length; i++) {
                if(context.groupList[i].isSelected) {
                    groupIds.push(context.groupList[i].groupId);
                    selectedGroupNames += context.groupList[i].groupName + '<br>';
                }
            }
            if(groupIds.length > 0) {
                $scope.alertBox($scope.customLabelsMap.MSDeleteGroupsLabel, 
                    $scope.customLabelsMap.MSSeletectedGroupsToDeleteLabel+'<p><ul><li>'+selectedGroupNames+'</li></ul></p>',
                    $scope.customLabelsMap.MSDeleteGroupsLabel, deleteGroupsCB, context, groupIds);
            }
        }

        function deleteGroupsCB(context, groupIds) {
            $scope.toast($scope.customLabelsMap.MSDeletingGroupMsg, undefined, 'info');
            var input = {contextId: $scope.bpTree.wrapperCart.Id, groupIds: groupIds};
            return fireRemoteAction( 'removeGroups', input, {}, function(result){
                var response = angular.fromJson(result);
                if(response.message) {
                    $scope.toast(response.message, '', 'error');
                } else {
                    $scope.toast($scope.customLabelsMap.MSGroupDeletedMsg, undefined, 'success');
                    $scope.getUngroupedRecords(context);
                    $scope.getGroups(context);
                }
                $scope.bpTree.randomCount++;
            });
        }

        function saveNewGroup(context, name, description, infoToast) {

            var input = {
                groupName: name,
                groupDescription: description,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                memberType: context.memberType
            };

            if($scope.bpTree.response.cartTypeStrategy === 'single' || 
                $scope.bpTree.response.selectedCartStrategy === 'single') {
                input.isGroupAssociatedWithCart = false;
            }
            
            fireRemoteAction('createNewGroup', input, {}, function(result){
                if(infoToast) {
                    infoToast.hide();
                }
            
                var response = angular.fromJson(result);
                if(response) {
                    if(response.message) {
                        $scope.toast(response.message, '', 'error');
                    } else {
                        $scope.toast(name + ' ' + $scope.customLabelsMap.MSGroupCreatedMsg, '', 'success');
                        $scope.addToGroup(context, response.groupInfo, true);
                    }
                }
                
            });
        }

        $scope.deleteMembers = function(context, group) {

            var selectedIds = [], i, group, records, j;
            for(i=0; i<context.groupList.length; i++) {
                group = context.groupList[i];
                if(group.members) {
                    records = group.members;
                    for(j=0; j<records.length; j++) {
                        if(records[j].isSelected){
                            selectedIds.push(records[j].Id.value); 
                        }
                    }
                }

            }
            if(selectedIds.length === 0) {
                return;
            }
            $scope.toast($scope.customLabelsMap.MSRemovingItemGroupMsg, undefined, 'info');
            var input = {
                memberIds: selectedIds,
                memberType: context.memberType,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id
            };

            fireRemoteAction('deleteMembers', input, {}, function(result){
                var allMessages = [], key;
                if(result) {
                    result = angular.fromJson(result);
                }
                if(result.messages) {
                    for(key in result.messages) {
                        allMessages.push(result.messages[key]);
                    }
                    $scope.toast(allMessages.join('\n'), undefined, 'error');
                } else {
                    $scope.toast($scope.customLabelsMap.MSRemovedSuccMsg, undefined, 'success');
                }
                
                $scope.getUngroupedRecords(context);
                $scope.getGroups(context);
                $scope.bpTree.randomCount++;
            });
        }

        $scope.addToGroup = function(context, group, reload) {

            var selectedIds = [], i;
            for(i=0; i<context.ungroupedItemList.length; i++) {
                if(context.ungroupedItemList[i].isSelected)
                {
                    selectedIds.push(context.ungroupedItemList[i].Id.value); 
                }
            }
            if(selectedIds.length === 0 || !group) {
                if(reload) {
                    $scope.getUngroupedRecords(context);
                    $scope.getGroups(context);
                }
                return;
            }
            var groupInfo = {};
            groupInfo['servicePoints'] = selectedIds;
            var input = {
                groupId: group.groupId,
                groupCartId: group.groupCartId,
                groupName: group.groupName,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.wrapperCart.Id,
                groupJSON: groupInfo,
                memberType: context.memberType
            };
            var addingToast = $scope.toast($scope.customLabelsMap.MSAddingToMsg + ' ' + group.groupName + '...', undefined, 'info');
            fireRemoteAction('addToGroup', input, {}, function(result){
                $scope.getUngroupedRecords(context);
                $scope.getGroups(context);
                if(addingToast) {
                    addingToast.hide();
                }
                var response = angular.fromJson(result);
                if(response && response.message) {
                    $scope.toast(response.message, '', 'error');
                } else {
                    $scope.toast($scope.customLabelsMap.MSAddedSuccMsg, undefined, 'success');
                }
                $scope.bpTree.randomCount++;
            });
        }

        $scope.groupSelectionChange = function(context, group) {

            if(!group){
                return;
            }
            if(group.isSelected) {
                context.groupSelected++;
            } else {
                context.groupSelected--;
            }

            if(!group.members) {
                return;
            }
            var records = group.members;

            if(!records) {
                return;
            }
            var i;
            for(i=0; i < records.length; i++) {

                if(!records[i].isSelected && group.isSelected) {
                    context.groupedItemSelected++;
                } else if(records[i].isSelected && !group.isSelected && context.groupedItemSelected > 0){
                    context.groupedItemSelected--;
                }
                records[i].isSelected = group.isSelected;
            }
        }

        $scope.createNewGroup = function(context) {

            var modalScope = $scope.$new();
            modalScope.confirmationTitle = $scope.customLabelsMap.MSCreateNewGroupLabel;
            modalScope.cancelActionLbl = $scope.customLabelsMap.MSCancelLabel;;
            modalScope.confirmActionLbl = $scope.customLabelsMap.MSSaveLabel;
            modalScope.SLDSICON = '';
            modalScope.closeLabel = $scope.customLabelsMap.MSCloseLabel;

            var createNewGroupPopup = $sldsModal({
                templateUrl: 'groupPopup.html',
                backdrop: 'static',
                scope: modalScope,
                show: true
			});
            modalScope.group = {};

            modalScope.confirmationAction = function() {
                var name = modalScope.group.name;
                var description = modalScope.group.description;

                if(name && name !== '') {
                    var cgToast = $scope.toast($scope.customLabelsMap.MSCreatingGroupMsg, undefined, 'info');
                    saveNewGroup(context, name, description, cgToast);                    
                }
                createNewGroupPopup.hide();
            }
        }

        $scope.convertToLabel = function(name) {
            if(name) {
                return name.replace(/([A-Z]+)/g, " $1").replace(/([A-Z][a-z])/g, " $1");
            }
            return '';
        }

        $scope.selecAllUngroupedItem = function(context, isSelected) {
            var i;
            if(isSelected === undefined) {
                return;
            }
            if(context.ungroupedItemList) {
                context.ungroupedItemSelected = 0;
                for(i=0; i<context.ungroupedItemList.length; i++) {
                    context.ungroupedItemList[i].isSelected = isSelected;
                    if(isSelected) {
                        context.ungroupedItemSelected++;
                    }
                }
            }
        }

        $scope.groupedItemSelectionChange = function(context, groupedItem) {

            if(!groupedItem) {
                return;
            }
            
            if(groupedItem.isSelected) {
                context.groupedItemSelected++;
            } else {
                context.groupedItemSelected--;
            }
        }

        $scope.enableAddToGroup = function(context) {
            var i;
            if(context.ungroupedItemList) {
                for(i=0; i<context.ungroupedItemList.length; i++) {
                    if(context.ungroupedItemList[i].isSelected) {
                        return true;
                    }
                }
            }
            return false;
        }

        $scope.ungroupedItemSelectionChange = function(context, ungroupedItem) {
            if(!ungroupedItem) {
                return;
            }
            
            if(ungroupedItem.isSelected) {
                context.ungroupedItemSelected++;
            } else {
                context.ungroupedItemSelected--;
            }
        }

        $scope.getValue = function(member, fieldName, memberType) {
            var memberFieldName;
            if(memberType) {
                memberFieldName = memberType.quoteMemberFieldName;
                if($scope.bpTree.cartType && 
                    $scope.bpTree.cartType.toLowerCase() === 'order') {
                    memberFieldName = memberType.orderMemberFieldName;
                }
                fieldName = memberFieldName.replace('__c', '__r') + '.' + fieldName;
            }
            
            var indexOfDot = fieldName.indexOf('.');
            var pre, post, value, memberObj=member;
            while(indexOfDot !== -1) {
                pre = fieldName.substring(0, indexOfDot);
                post = fieldName.substring(indexOfDot + 1, fieldName.length);
                fieldName = post;
                memberObj = memberObj[pre];
                indexOfDot = fieldName.indexOf('.');
            }

            value = memberObj[fieldName];
            if(value && value instanceof Object) {
                value = value.value;
            }
            return value;

        }

        $scope.getContext = function(groupObject) {
            return $scope.groupObjectContext[groupObject.developerName];
        }

        $scope.getMessage = function(message, replace) {
            if(message) {
                message = message.replace(/\{0\}/g, replace);
            }
            return message;
        }

        $scope.getHtmlMessage = function(messages) {
            var message = '';
            if(messages) {
                message = '<ul class="slds-list_dotted">';
                for(i=0; i<messages.length; i++) {
                    message += '<li>' + messages[i] + '</li>';
                }
                message += '</ul>';
            }
            return message;
        }

        $scope.toast = function(title, content, severity) {
            return $sldsToast({
                    title: title,
                    content: content,
                    severity: severity,
                    icon: severity,
                    templateUrl: 'SldsToast.tpl.html',
                    autohide: severity === 'error'? false: true,
                    show: true
                }); 
        }

        $scope.alertBox = function(title, message, okLabel, actionCallback, arg1, arg2) {
            var deletePrompt = $sldsPrompt({
                    title: title,
                    content: message,
                    theme: 'error',
                    show: true,
                    buttons: [
                        {
                            label: $scope.customLabelsMap.MSCancelLabel,
                            type: 'neutral',
                            action: function() {
                                deletePrompt.hide();
                            }
                        },
                        {
                            label: okLabel,
                            type: 'destructive',
                            action: function() {
                                deletePrompt.hide();
                                actionCallback(arg1, arg2);
                            }
                        }
                    ]
                });
        }
    }
]);