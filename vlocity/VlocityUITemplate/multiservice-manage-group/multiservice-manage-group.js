vlocity.cardframework.registerModule.controller('manageGroupController', ['$rootScope', '$scope' ,'$filter', '$sldsModal', '$sldsToast', '$q', '$sldsPrompt', 'remoteActions',
    function($rootScope, $scope ,$filter, $sldsModal, $sldsToast, $q, $sldsPrompt, remoteActions) {
        /*
         * table columns fields list.
         */
        $scope.fieldList = [];
        /*
         * filter columns fields list.
         */
        $scope.filterFieldList = [];
        /*
         * object list to keep describe details.
         */
        $scope.objectList = [];
        /*
         * ungrouped item list.
         */
        $scope.ungroupedItemList = [];
        /*
         * group list and each group contains its items.
         */
        $scope.groupList = [];
        /*
         * custom labels.
         */
        $scope.customLabels = {selectDefaultOption: '--Select--'};
        /*
         * Boolean picklist.
         */
        $scope.booleanPicklists = [{label: 'False', value: false}, {label: 'True', value: true}];
        /*
         * sort by string.
         */
        $scope.sortByString = '';
        /*
         * store selected filters.
         */
        $scope.filters = {};
        /*
         * keep count of selected ungrouped items.
         */
        $scope.ungroupedItemSelected = 0;
        /*
         * keep count of selected grouped items.
         */
        $scope.groupedItemSelected = 0;
        /*
         * keep count of selected groups.
         */
        $scope.groupSelected = 0;
        /*
         * this flag is to show/hide groups in tables.
         * groupShowHideFlag = true, show groups in tables.
         * groupShowHideFlag = false, hide groups in tables.
         */
        $scope.groupShowHideFlag = true;
        /*
         * groupFlag is to show 'Create New Group' or 'Add to Group' buttons.
         * if groupFlag is true, show 'Create New Group' and hide 'Add to Group'
         * if groupFlag is false, show 'Add to Group' and hide 'Create New Group'.
         */
        $scope.groupFlag = true;
        /*
         * apply filter results on grouped item flag.
         */
        $scope.filterApplicable = {group: false};
        /*
         * pagination data.
         */
        $scope.groupedServicePagination = {
            offset: 0,
            pageSize: 20
        }
        $scope.groupePagination = {
            offset: 0,
            pageSize: 20
        }
        $scope.unGroupedServicePagination = {
            offset: 0,
            pageSize: 20
        }
        /*
         * number of applied filter on ungrouped items.
         */
        $scope.numberOfFiltersApplied = 0;
        /*
         *
         */
        $scope.selectAllUngroupedItem = false;
        /*
         *
         */
        $scope.unGroupedServiceTotalCount = 0;
        /*
         * custom labels
         */
        var customLabels = ['MSGroupLabel', 'MSServiceLabel', 'MSShowLabel', 'MSHideLabel',
                            'MSFilterLabel', 'MSClearFilterLabel', 'MSFiltersAppliedLabel',
                            'MSCreateNewGroupLabel', 'MSRemoveFromGroupLabel', 'MSRenameGroupLabel',
                            'MSItemsSelectedLabel', 'MSAddNewGroupLabel', 'MSApplyFiltersGroupedLabel',
                            'MSGroupedItemsSelectedLabel', 'MSNoRecordsFoundLabel', 'MSLoadMoreLabel',
                            'MSNoRecordsGroupsLabel', 'MSPreviousLabel', 'MSNextLabel', 'MSGroupNameLabel',
                            'MSGroupDescLabel', 'MSCancelLabel', 'MSSaveLabel', 'MSCloseLabel', 'MSLoadMoreGroupsLabel',
                            'MSCreatingGroupMsg', 'MSUpdateGroupMsg', 'MSGroupUpdatedMsg', 'MSDeletingGroupMsg',
                            'MSDeleteGroupsLabel', 'MSGroupDeletedMsg', 'MSGroupCreatedMsg', 'MSRemovingItemGroupMsg',
                            'MSRemovedSuccMsg', 'MSAddedSuccMsg', 'MSAddingToMsg', 'MSApplyFilterLabel', 'MSAddToGroupLabel'];
        /*
         * custom labels map.
         */ 
        $scope.customLabelsMap = {};
        
        var nextButtonId = 'ManageGroup_nextBtn';

        $scope.$watch('bpTree.response.unGroupedServicePageSize', function(newValue, oldValue) {
            if(newValue && parseInt(newValue)) {
                $scope.unGroupedServicePagination.pageSize = parseInt(newValue);
                //$scope.getUnGroupedServices();
            }
        });
        $scope.$watch('bpTree.response.groupedServicePageSize', function(newValue, oldValue) {
            if(newValue && parseInt(newValue)) {
                $scope.groupedServicePagination.pageSize = parseInt(newValue);
            }
        });
        $scope.$watch('bpTree.response.groupPageSize', function(newValue, oldValue) {
            if(newValue && parseInt(newValue)) {
                $scope.groupePagination.pageSize = parseInt(newValue);
                //$scope.getGroups();
            }
        });
        
        $scope.$watch('groupList.length', function (newValue, oldValue) {
            
            if(!newValue || newValue === 0) {
                nextButton(true);
                return;
            }

            checkForNextButton();
            
        });

        function checkForNextButton() {
            if($scope.groupList && $scope.groupList.length > 0) {
                var length = $scope.groupList.length;
                for (let i = 0; i < length; i++) {
                    if($scope.groupList[i].itemsCount && $scope.groupList[i].itemsCount > 0) {
                        nextButton(false);
                        return;
                    }
                }
            }
            nextButton(true);
        }
        

        $scope.$watch('bpTree.selectedQuote.masterQuoteId', function (newValue, oldValue) {
            
            if(newValue) {
                $scope.getUnGroupedServices();
                $scope.getGroups();
                $scope.bpTree.response.masterQuoteId = newValue;
            }
        });

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
            
            $q.all([$scope.getFieldList(), $scope.getFilterFieldList()]).then(function(){
                var i;
                //colllect all object names
                for(i=0; i< $scope.filterFieldList.length; i++) {
                    if ($scope.objectList.indexOf($scope.filterFieldList[i].objectAPIName) === -1 && $scope.filterFieldList[i] !== '') {
                        $scope.objectList.push($scope.filterFieldList[i].objectAPIName);
                    }
                }
                for(i=0; i< $scope.fieldList.length; i++) {
                    if ($scope.objectList.indexOf($scope.fieldList[i].objectName) === -1 && $scope.fieldList[i] !== '') {
                        $scope.objectList.push($scope.fieldList[i].objectName);
                    }
                }
                
                $scope.getObjectDesc();
            });
            getCustomLabels();
        }

        $scope.getObjectDesc = function() {
            var input = {'objectNames': $scope.objectList};
            fireRemoteAction('getObjectFieldsDescribe', input, {}, function(result){
                $scope.objectNameToFields = angular.fromJson(result).result;
            });
        }
        $scope.getFieldList = function () {
            return fireRemoteAction('getDisplayFieldList', {}, {}, function(result){
                $scope.fieldList = angular.fromJson(result).result;
            });
        }
        $scope.getFilterFieldList = function () {
            return fireRemoteAction('getFilterFieldList', {}, {}, function(result){
                $scope.filterFieldList = angular.fromJson(result).result;
                $scope.filterFieldsMap = {};
                if($scope.filterFieldList) {
                    $scope.filterFieldList.forEach(function(filter){
                        $scope.filterFieldsMap[filter.fieldName] = filter; 
                    })
                }
            });
        }

        $scope.clearFilters = function() {
            $scope.filters = {};
            $scope.appliedFilters = {};
            $scope.unGroupedServicePagination.offset = 0;
            $scope.filterApplicable = {group: false};
            $scope.getUnGroupedServices();
        }

        $scope.enableClearFiltersButton = function() {
            for(var prop in $scope.filters) {
                if($scope.filters.hasOwnProperty(prop)) {
                    return true;
                }
            }
            return false;
        }

        $scope.previousServicePoints = function() {
            var offset = $scope.unGroupedServicePagination.offset - $scope.unGroupedServicePagination.pageSize;
            if(offset >= 0) {
                $scope.unGroupedServicePagination.offset = offset;
                $scope.getUnGroupedServices();
            }
        }

        $scope.nextServicePoints = function() {
            $scope.unGroupedServicePagination.offset += $scope.unGroupedServicePagination.pageSize;
            $scope.getUnGroupedServices();
        }

        $scope.applyFilters = function() {

            $scope.appliedFilters = {};
            var value, f, fieldInfo, prop;
            if($scope.filters) {
                for(prop in $scope.filters) {
                    f = $scope.filterFieldsMap[prop];
                    value = $scope.filters[prop];
                    if(value && value !== '') {
                        fieldInfo = $scope.objectNameToFields[f.objectAPIName][f.fieldAPIName]
                        if(fieldInfo && fieldInfo.type === 'string') {
                            value = '%'+ value + '%';
                        }
                        $scope.appliedFilters[prop] = value;
                    } else {
                        delete $scope.filters[prop];
                    }
                }
            }
            $scope.unGroupedServicePagination.offset = 0;
            $scope.getUnGroupedServices();
            //this requires to clear out grouped items.
            $scope.getGroups();
        }

        $scope.sortByColumn = function(clickedfield) {

            var i, ascDesc = '', desc = '';
            var clickedPos = clickedfield.clickedPos;

            for(i=0; i<$scope.fieldList.length; i++) {
                $scope.fieldList[i].clickedPos = undefined;
            }

            if(clickedPos && clickedPos === 'up') {
                ascDesc = 'DESC';
                clickedfield.clickedPos = 'down';
                desc = '-'
            } else {
                ascDesc = 'ASC';
                clickedfield.clickedPos = 'up';
            }
            $scope.sortByString = clickedfield.fieldName + ' ' + ascDesc;
            $scope.sortByAngular = desc + clickedfield.fieldName + '.value';
            $scope.unGroupedServicePagination.offset = 0;

            $scope.getUnGroupedServices();
        }

        $scope.getMoreGroupedServices = function(group) {
            if(!group.actions || !group.actions.getGroupedServices) {
                return;
            }
            group.isLoading = true;
            fireAction(group.actions.getGroupedServices, function(result) {
                var res = angular.fromJson(result);
                var action;
                if(res && res.records) {
                    for(i=0; i<res.records.length; i++) {
                        group.services.push(res.records[i]);
                    }
                }
                if(res && res.actions) {
                    action = res.actions.getGroupedServices;
                }
                group.actions.getGroupedServices = action;
                group.isLoading = false;
            });
        }

        $scope.getGroupedServices = function(group) {

            group.showItems = !group.showItems;
            if(!group.showItems) {
                return;
            }
            if(group.itemsCount == 0 || (group.services && group.services.length > 0)) {
                return;
            }
            group.isLoading = true;
            var filters;
            if($scope.filterApplicable.group) {
                filters = getFilters();
            }

            if(group.actions && group.actions.getGroupedServices 
                && group.actions.getGroupedServices.remote && group.actions.getGroupedServices.remote.params) {

                group.actions.getGroupedServices.remote.params.pageSize = $scope.groupedServicePagination.pageSize;
                if(filters) {
                    group.actions.getGroupedServices.remote.params.filters = filters;
                }
                if($scope.sortByString !== '') {
                    group.actions.getGroupedServices.remote.params.sortBy = $scope.sortByString;
                }
            }
            

            fireAction(group.actions.getGroupedServices, function(result) {
                var res = angular.fromJson(result);
                var action;
                if(res) {
                    group.services = res.records;
                    if(res.actions) {
                        action = res.actions.getGroupedServices;
                    }
                }
                group.actions.getGroupedServices = action;
                group.isLoading = false;
            });
        }

        $scope.getGroups = function() {
            $scope.isGroupsLoading = true;
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.selectedQuote.masterQuoteId,
                pageSize: $scope.groupePagination.pageSize,
                offset: $scope.groupePagination.offset
            };
            fireRemoteAction('getGroups', input, {}, function(result){
                $scope.groupList = [];
                $scope.groupedItemSelected = 0;
                $scope.groupSelected = 0;

                var groupedRecords = angular.fromJson(result);
                if(groupedRecords) {
                    $scope.groupList = groupedRecords.records;
                    if(groupedRecords.actions) {
                        $scope.nextGroupsAction = groupedRecords.actions.nextGroups;
                    }
                    if(groupedRecords.data && groupedRecords.data.groupTotalCount) {
                        $scope.groupTotalCount = groupedRecords.data.groupTotalCount;
                    }
                    
                }
                $scope.isGroupsLoading = false;
                checkForNextButton();
            });
        }
        /*
         * get more groups.
         */ 
        $scope.getMoreGroups = function(nextGroupsAction) {
            $scope.isGroupsLoading = true;
            fireAction(nextGroupsAction, function(result){
                var res = angular.fromJson(result);
                var action;
                if(res && res.records) {
                    for(i=0; i<res.records.length; i++) {
                        $scope.groupList.push(res.records[i]);
                    }
                }
                if(res && res.actions) {
                    action = res.actions.nextGroups;
                }
                if(res.data && res.data.groupTotalCount) {
                    $scope.groupTotalCount = res.data.groupTotalCount;
                }
                $scope.nextGroupsAction = action;
                $scope.isGroupsLoading = false;
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

        $scope.getUnGroupedServices = function() {
            $scope.showTableLoading = true;
            var input = {
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.selectedQuote.masterQuoteId,
                offset: $scope.unGroupedServicePagination.offset, 
                pageSize: $scope.unGroupedServicePagination.pageSize
            };
            var filters = getFilters();

            if(filters) {
                input.filters = filters;
            }
            if($scope.sortByString !== '') {
                input.sortBy = $scope.sortByString;
            }
            if($scope.filterApplyOnGroups) {
                input.applyFiltersOnGroupedItems = true;
            }
            fireRemoteAction('getUnGroupedServices', input, {}, function(result){
                $scope.selectAllUngroupedItem = false;
                $scope.ungroupedItemSelected = 0;
                $scope.ungroupedItemList = [];
                $scope.unGroupedServiceTotalCount = 0;
                var ungroupedRecords = angular.fromJson(result);
                if(ungroupedRecords) {
                    $scope.ungroupedItemList = ungroupedRecords.records;
                    if(ungroupedRecords.data && ungroupedRecords.data.unGroupedServiceTotalCount) {
                        $scope.unGroupedServiceTotalCount = ungroupedRecords.data.unGroupedServiceTotalCount;
                    }
                }
                $scope.showTableLoading = false;
            });
        }

        function getFilters() {
            var filters = [];
            var value;
            var filterStr;
            if($scope.appliedFilters) {
                $scope.numberOfFiltersApplied = 0;
                for(var prop in $scope.appliedFilters) {
                    if($scope.appliedFilters.hasOwnProperty(prop)) {
                        value = $scope.appliedFilters[prop];
                        if(value) {
                            $scope.numberOfFiltersApplied++;
                            filters.push(prop + ':' + encodeURI(value));
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

        $scope.renameGroup = function() {
            var selectedGroup = undefined;
            for(var i=0; i<$scope.groupList.length; i++) {
                if($scope.groupList[i].isSelected) {
                    selectedGroup = $scope.groupList[i];
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
                    updateGroup(modalScope.group, cgToast);                    
                }
                groupPopup.hide();
            }
        }

        function updateGroup(group, infoToast) {
            var input = {
                groupName: group.name,
                groupDescription: group.description,
                groupId: group.groupId,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.selectedQuote.masterQuoteId
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
                        $scope.getGroups();
                    }
                }
                
            });
        }

        $scope.deleteGroups = function() {
            var groupIds = []
            for(var i=0; i<$scope.groupList.length; i++) {
                if($scope.groupList[i].isSelected) {
                    groupIds.push($scope.groupList[i].groupId);
                }
            }
            if(groupIds.length > 0) {
                $scope.alertBox($scope.customLabelsMap.MSDeleteGroupsLabel, 'Following groups will be deleted?<p><ul><li>Group1</li></ul></p>', 'Delete Group(s)', deleteGroupsCB, groupIds);
            }
        }
        function deleteGroupsCB(groupIds) {
            $scope.toast($scope.customLabelsMap.MSDeletingGroupMsg, undefined, 'success');
            var input = {contextId: $scope.bpTree.ContextId, groupIds: groupIds};
            return fireRemoteAction( 'removeGroups', input, {}, function(result){
                $scope.toast($scope.customLabelsMap.MSGroupDeletedMsg, undefined, 'success');
            });
        }

        $scope.saveNewGroup = function(name, description, infoToast) {

            var input = {
                groupName: name,
                groupDescription: description,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.selectedQuote.masterQuoteId
            };
            
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
                        $scope.addToGroup(response.groupInfo, true);
                    }
                }
                
            });
        }

        $scope.removeFromGroup = function(group) {

            var selectedIds, i, group, records, j, deleteGroupItems = {};
            for(i=0; i<$scope.groupList.length; i++) {
                group = $scope.groupList[i];
                selectedIds = [];
                if(group.services) {
                    records = group.services;
                    for(j=0; j<records.length; j++) {
                        if(records[j].isSelected){
                            selectedIds.push(records[j].Id.value); 
                        }
                    }
                    if(selectedIds.length > 0) {
                        deleteGroupItems[group.groupCartId] = selectedIds;
                    }
                }

            }
            if(angular.equals({}, deleteGroupItems)) {
                return;
            }
            $scope.toast($scope.customLabelsMap.MSRemovingItemGroupMsg, undefined, 'info');
            var input = {
                deleteGroupItemsJSON: deleteGroupItems,
                parentId: $scope.bpTree.ContextId,
                contextId: $scope.bpTree.selectedQuote.masterQuoteId
            };

            fireRemoteAction('removeFromGroup', input, {}, function(result){
                var allMessages = [];
                if(result) {
                    result = angular.fromJson(result);
                }
                if(result.messages) {
                    for(var key in result.messages) {
                        allMessages.push(result.messages[key]);
                    }
                    $scope.toast(allMessages.join('\n'), undefined, 'error');
                } else {
                    $scope.toast($scope.customLabelsMap.MSRemovedSuccMsg, undefined, 'success');
                }
                
                $scope.getUnGroupedServices();
                $scope.getGroups();
                
            });
        }

        $scope.addToGroup = function(group, reload) {

            var selectedIds = [];
            for(var i=0; i<$scope.ungroupedItemList.length; i++) {
                if($scope.ungroupedItemList[i].isSelected)
                {
                    selectedIds.push($scope.ungroupedItemList[i].Id.value); 
                }
            }
            if(selectedIds.length === 0 || !group) {
                if(reload) {
                    $scope.getUnGroupedServices();
                    $scope.getGroups();
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
                contextId: $scope.bpTree.selectedQuote.masterQuoteId,
                groupJSON: groupInfo
            };
            var addingToast = $scope.toast($scope.customLabelsMap.MSAddingToMsg + ' ' + group.groupName + '...', undefined, 'info');
            fireRemoteAction('addToGroup', input, {}, function(result){
                $scope.getUnGroupedServices();
                $scope.getGroups();
                if(addingToast) {
                    addingToast.hide();
                }
                var response = angular.fromJson(result);
                if(response && response.message) {
                    $scope.toast(response.message, '', 'error');
                } else {
                    $scope.toast($scope.customLabelsMap.MSAddedSuccMsg, undefined, 'success');
                }
            });
        }

        $scope.groupSelectionChange = function(group) {

            if(!group){
                return;
            }
            if(group.isSelected) {
                $scope.groupSelected++;
            } else {
                $scope.groupSelected--;
            }

            if(!group.services) {
                return;
            }
            var records = group.services;

            if(!records) {
                return;
            }
            var i;
            for(i=0; i < records.length; i++) {

                if(!records[i].isSelected && group.isSelected) {
                    $scope.groupedItemSelected++;
                } else if(records[i].isSelected && !group.isSelected && $scope.groupedItemSelected > 0){
                    $scope.groupedItemSelected--;
                }
                records[i].isSelected = group.isSelected;
            }
        }

        $scope.createNewGroup = function() {

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
                    $scope.saveNewGroup(name, description, cgToast);                    
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

        $scope.selecAllUngroupedItem = function(isSelected) {
            
            if(isSelected === undefined) {
                return;
            }
            if($scope.ungroupedItemList) {
                $scope.ungroupedItemSelected = 0;
                for(var i=0; i<$scope.ungroupedItemList.length; i++) {
                    $scope.ungroupedItemList[i].isSelected = isSelected;
                    if(isSelected) {
                        $scope.ungroupedItemSelected++;
                    }
                }
            }
        }

        $scope.groupedItemSelectionChange = function(groupedItem) {

            if(!groupedItem) {
                return;
            }
            
            if(groupedItem.isSelected) {
                $scope.groupedItemSelected++;
            } else {
                $scope.groupedItemSelected--;
            }
        }

        $scope.enableAddToGroup = function() {

            if($scope.ungroupedItemList) {
                for(var i=0; i<$scope.ungroupedItemList.length; i++) {
                    if($scope.ungroupedItemList[i].isSelected) {
                        return true;
                    }
                }
            }
            return false;
        }

        $scope.ungroupedItemSelectionChange = function(ungroupedItem) {
            if(!ungroupedItem) {
                return;
            }
            
            if(ungroupedItem.isSelected) {
                $scope.ungroupedItemSelected++;
            } else {
                $scope.ungroupedItemSelected--;
            }
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

        $scope.alertBox = function(title, message, okLabel, actionCallback, arg1) {
            var deletePrompt = $sldsPrompt({
                    title: title,
                    content: message,
                    theme: 'error',
                    show: true,
                    buttons: [
                        {
                            label: okLabel,
                            type: 'destructive',
                            action: function() {
                                deletePrompt.hide();
                                actionCallback(arg1);
                            }
                        },
                        {
                            label: 'Cancel',
                            type: 'neutral',
                            action: function() {
                                deletePrompt.hide();
                            }
                        }
                    ]
                });
        }
    }
]);