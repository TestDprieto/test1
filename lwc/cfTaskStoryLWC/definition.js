let definition = 
                {"GlobalKey__c":"Task Story LWC/Vlocity/2/1580726190622","dataSource":{"type":null},"enableLwc":true,"filter":{"['objAPIName']":"Task"},"states":[{"collapse":false,"conditions":{"group":[{"field":"$scope.data.status","operator":"===","type":"system","value":"'active'"},{"field":"['onGoing']","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}]},"definedActions":{"actions":[]},"disableAddCondition":false,"fields":[{"collapse":true,"displayLabel":"['highlight']","editing":false,"fieldType":"standard","group":"Custom Properties","label":"Status","name":"['highlight']","type":"string"},{"collapse":true,"displayLabel":"['subtitle']","editing":false,"fieldType":"standard","group":"Custom Properties","label":"Priority","name":"['subtitle']","type":"string"}],"filter":"$scope.data.status === 'active' && $scope.obj['onGoing'] == false","flyout":{"lwc":{"DeveloperName":"storyEditStateFlyout","Id":"0Rb5e0000017Qk9CAI","MasterLabel":"storyEditStateFlyout","name":"storyEditStateFlyout"}},"flyoutAttributes":[{"name":"parent","val":"$scope.obj"}],"lwc":{"DeveloperName":"storyNormalState","Id":"0Rb5e0000017QkBCAI","MasterLabel":"storyNormalState","name":"storyNormalState"},"name":"Task Normal","templateUrl":"story-card"}],"title":"Task"}; 
            export default definition