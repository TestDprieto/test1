let definition = 
                {"states":[{"fields":[{"name":"['Name']","label":"Name","displayLabel":"['Name']","type":"string","fieldType":"standard","group":"Custom Properties","collapse":true},{"name":"['Industry']","label":"Industry","displayLabel":"['Industry']","type":"string","fieldType":"standard","group":"Custom Properties","collapse":true},{"name":"['Type']","label":"Type","displayLabel":"['Type']","type":"string","fieldType":"standard","group":"Custom Properties","collapse":true}],"conditions":{"group":[{"field":"$scope.data.status","operator":"===","value":"'active'","type":"system"}]},"definedActions":{"actions":[]},"name":"Active","lwc":{"MasterLabel":"left-profile-state","DeveloperName":"leftProfileState","Id":"0Rb4x000000TQ0nSAM","name":"leftProfileState"},"isSmartAction":false,"smartAction":{}}],"filter":{},"dataSource":{"type":"Query","value":{"jsonMap":"{\"params.id\":\"{{params.id}}\"}"},"contextVariables":[{"name":"params.id","val":"0014x0000033lVUQAS"}]},"title":"Account Profile","enableLwc":true,"GlobalKey__c":"Top Left Account Profile/vlocityDev/1/1594355042781"}; 
            export default definition