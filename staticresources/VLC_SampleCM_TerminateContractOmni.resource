{
  "status": "Complete",
  "primaryDataPackKey": "b459aa08434f140be2cbd9e7abb43f79",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a14o0000001W9FtAAK",
      "VlocityDataPackType": "OmniScript",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "e96b60d04fc8238a7c4fa3fc8ddedfb7"
      ],
      "VlocityDataPackName": "Id: a14o0000001W9FtAAK ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "OmniScript",
      "VlocityDataPackKey": "b459aa08434f140be2cbd9e7abb43f79",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__OmniScript__c": [
          {
            "%vlocity_namespace%__Element__c": [
              {
                "%vlocity_namespace%__Type__c": "Step",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"field\":\"Terminate Option\",\"data\":\"Partially terminate lines in the contract\"}]}},\"label\":\"Choose Items to be terminated\",\"validationRequired\":true,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"nextLabel\":\"Inactivate\",\"nextWidth\":3,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"instruction\":\"\",\"showPersistentComponent\":[false,false],\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteTimeout\":30000,\"remoteOptions\":{},\"knowledgeOptions\":{\"language\":\"English\",\"publishStatus\":\"Online\",\"keyword\":\"\",\"dataCategoryCriteria\":\"\",\"remoteTimeout\":30000},\"conditionType\":\"Hide if False\"}",
                "%vlocity_namespace%__Order__c": 4,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 0,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Step 2",
                "Id": "a11o0000003nk9fAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9fAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "DataRaptor Extract Action",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"field\":\"Terminate Option\",\"data\":\"Partially terminate lines in the contract\"}]}},\"label\":null,\"controlWidth\":12,\"bundle\":\"ExtractContractLine\",\"dataRaptor Input Parameters\":[{\"inputParam\":\"Id\",\"element\":\"ContextId\"}],\"remoteTimeout\":30000,\"responseJSONPath\":\"\",\"responseJSONNode\":\"\",\"inProgressMessage\":\"In Progress\",\"postMessage\":\"Done\",\"failureNextLabel\":\"Continue\",\"failureAbortLabel\":\"Abort\",\"failureAbortMessage\":\"Are you sure?\",\"validationRequired\":\"None\",\"redirectPageName\":\"\",\"redirectTemplateUrl\":\"vlcAcknowledge.html\",\"redirectNextLabel\":\"Next\",\"redirectNextWidth\":3,\"redirectPreviousLabel\":\"Previous\",\"redirectPreviousWidth\":3,\"showPersistentComponent\":[false,false]}",
                "%vlocity_namespace%__Order__c": 3,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 0,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Extract contract line items",
                "Id": "a11o0000003nk9gAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9gAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Date",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":null,\"label\":\"Terminate Date\",\"controlWidth\":12,\"required\":false,\"repeat\":false,\"repeatClone\":false,\"readOnly\":false,\"help\":false,\"helpText\":\"\",\"dateFormat\":\"MM-dd-yyyy\",\"conditionType\":\"Hide if False\",\"accessibleInFutureSteps\":false,\"debounceValue\":0}",
                "%vlocity_namespace%__ParentElementId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9iAAA",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                  "%vlocity_namespace%__OmniScriptId__c": "a14o0000001W9FtAAK",
                  "Name": "Step 1"
                },
                "%vlocity_namespace%__Order__c": 1,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 1,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Terminate Date",
                "Id": "a11o0000003nk9hAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9hAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Step",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":null,\"label\":null,\"validationRequired\":true,\"previousLabel\":\"Previous\",\"previousWidth\":3,\"nextLabel\":\"Next\",\"nextWidth\":3,\"cancelLabel\":\"Cancel\",\"cancelMessage\":\"Are you sure?\",\"saveLabel\":\"Save for later\",\"saveMessage\":\"Are you sure you want to save it for later?\",\"completeLabel\":\"Complete\",\"completeMessage\":\"Are you sure you want to complete the script?\",\"instruction\":\"\",\"showPersistentComponent\":[false,false],\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteTimeout\":30000,\"remoteOptions\":{},\"knowledgeOptions\":{\"language\":\"English\",\"publishStatus\":\"Online\",\"keyword\":\"\",\"dataCategoryCriteria\":\"\",\"remoteTimeout\":30000},\"conditionType\":\"Hide if False\"}",
                "%vlocity_namespace%__Order__c": 1,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 0,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Step 1",
                "Id": "a11o0000003nk9iAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9iAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Radio",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":null,\"label\":\"Terminate Option\",\"controlWidth\":12,\"required\":false,\"repeat\":false,\"repeatClone\":false,\"readOnly\":false,\"horizontalMode\":false,\"help\":false,\"helpText\":\"\",\"options\":[{\"name\":\"Terminate the entire contract\",\"value\":\"Terminate the entire contract\"},{\"name\":\"Partially terminate lines in the contract\",\"value\":\"Partially terminate lines in the contract\"}],\"optionSource\":{\"type\":\"\",\"source\":\"\"},\"controllingField\":{\"element\":\"\",\"type\":\"\",\"source\":\"\"},\"conditionType\":\"Hide if False\",\"accessibleInFutureSteps\":false}",
                "%vlocity_namespace%__ParentElementId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9iAAA",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                  "%vlocity_namespace%__OmniScriptId__c": "a14o0000001W9FtAAK",
                  "Name": "Step 1"
                },
                "%vlocity_namespace%__Order__c": 5,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 1,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Terminate Option",
                "Id": "a11o0000003nk9jAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9jAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Radio",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"field\":\"Terminate Type\",\"data\":\"With Cause\"}]}},\"label\":\"Terminate Reason\",\"controlWidth\":12,\"required\":false,\"repeat\":false,\"repeatClone\":false,\"readOnly\":false,\"horizontalMode\":false,\"help\":false,\"helpText\":\"\",\"options\":[{\"name\":\"\",\"value\":\"\"}],\"optionSource\":{\"type\":\"SObject\",\"source\":\"Contract.TerminationReason__c\"},\"controllingField\":{\"element\":\"\",\"type\":\"\",\"source\":\"\"},\"conditionType\":\"Hide if False\",\"accessibleInFutureSteps\":false}",
                "%vlocity_namespace%__ParentElementId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9iAAA",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                  "%vlocity_namespace%__OmniScriptId__c": "a14o0000001W9FtAAK",
                  "Name": "Step 1"
                },
                "%vlocity_namespace%__Order__c": 3,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 1,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Terminate Reason",
                "Id": "a11o0000003nk9kAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9kAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "DataRaptor Post Action",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"field\":\"Terminate Option\",\"data\":\"Terminate the entire contract\"}]}},\"label\":null,\"controlWidth\":12,\"bundle\":\"Terminate Contract\",\"remoteTimeout\":30000,\"postTransformBundle\":\"\",\"sendJSONPath\":\"\",\"sendJSONNode\":\"\",\"inProgressMessage\":\"In Progress\",\"postMessage\":\"Done\",\"failureNextLabel\":\"Continue\",\"failureAbortLabel\":\"Abort\",\"failureAbortMessage\":\"Are you sure?\",\"validationRequired\":\"Submit\",\"redirectPageName\":\"\",\"redirectTemplateUrl\":\"vlcAcknowledge.html\",\"redirectNextLabel\":\"Next\",\"redirectNextWidth\":3,\"redirectPreviousLabel\":\"Previous\",\"redirectPreviousWidth\":3,\"showPersistentComponent\":[false,false]}",
                "%vlocity_namespace%__Order__c": 2,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 0,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Terminate Contract",
                "Id": "a11o0000003nk9lAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9lAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Selectable Items",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":null,\"label\":\"List of active line items\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteOptions\":{\"preTransformBundle\":\"\",\"postTransformBundle\":\"\"},\"remoteTimeout\":30000,\"preTransformBundle\":\"\",\"postTransformBundle\":\"\",\"sendJSONPath\":\"\",\"sendJSONNode\":\"\",\"responseJSONPath\":\"\",\"responseJSONNode\":\"\",\"HTMLTemplateId\":\"contractItems.html\",\"itemsKey\":\"recSet\",\"selectMode\":\"Multi\",\"dataJSON\":true,\"modalHTMLTemplateId\":\"vlcModalContent.html\",\"modalController\":\"ModalInstanceCtrl\",\"modalSize\":\"\",\"maxCompareSize\":4,\"modalConfigurationSetting\":{\"modalHTMLTemplateId\":\"vlcProductConfig.html\",\"modalController\":\"ModalProductCtrl\",\"modalSize\":\"lg\"},\"accessibleInFutureSteps\":false}",
                "%vlocity_namespace%__ParentElementId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9fAAA",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                  "%vlocity_namespace%__OmniScriptId__c": "a14o0000001W9FtAAK",
                  "Name": "Step 2"
                },
                "%vlocity_namespace%__Order__c": 1,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 1,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "ContractItem",
                "Id": "a11o0000003nk9mAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9mAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Done Action",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":null,\"label\":\"Done\",\"controlWidth\":12,\"type\":\"SObject\",\"source\":\"%ContextId%\",\"validationRequired\":\"Submit\",\"redirectPageName\":\"mobileDone\",\"redirectTemplateUrl\":\"vlcMobileConfirmation.html\"}",
                "%vlocity_namespace%__Order__c": 6,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 0,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Done Action",
                "Id": "a11o0000003nk9nAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9nAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "Radio",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":null,\"label\":\"Terminate Type\",\"controlWidth\":12,\"required\":false,\"repeat\":false,\"repeatClone\":false,\"readOnly\":false,\"horizontalMode\":false,\"help\":false,\"helpText\":\"\",\"options\":[{\"name\":\"\",\"value\":\"\"}],\"optionSource\":{\"type\":\"SObject\",\"source\":\"Contract.TerminationType__c\"},\"controllingField\":{\"element\":\"\",\"type\":\"\",\"source\":\"\"},\"conditionType\":\"Hide if False\",\"accessibleInFutureSteps\":false}",
                "%vlocity_namespace%__ParentElementId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9iAAA",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                  "%vlocity_namespace%__OmniScriptId__c": "a14o0000001W9FtAAK",
                  "Name": "Step 1"
                },
                "%vlocity_namespace%__Order__c": 2,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 1,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "Terminate Type",
                "Id": "a11o0000003nk9oAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9oAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              },
              {
                "%vlocity_namespace%__Type__c": "DataRaptor Post Action",
                "%vlocity_namespace%__ReusableOmniScript__c": false,
                "%vlocity_namespace%__PropertySet__c": "{\"show\":{\"group\":{\"operator\":\"AND\",\"rules\":[{\"condition\":\"=\",\"field\":\"Terminate Option\",\"data\":\"Partially terminate lines in the contract\"}]}},\"label\":null,\"controlWidth\":12,\"bundle\":\"InactiveSelectedContractItems\",\"remoteTimeout\":30000,\"postTransformBundle\":\"\",\"sendJSONPath\":\"\",\"sendJSONNode\":\"\",\"inProgressMessage\":\"In Progress\",\"postMessage\":\"Done\",\"failureNextLabel\":\"Continue\",\"failureAbortLabel\":\"Abort\",\"failureAbortMessage\":\"Are you sure?\",\"validationRequired\":\"Submit\",\"redirectPageName\":\"\",\"redirectTemplateUrl\":\"vlcAcknowledge.html\",\"redirectNextLabel\":\"Next\",\"redirectNextWidth\":3,\"redirectPreviousLabel\":\"Previous\",\"redirectPreviousWidth\":3,\"showPersistentComponent\":[false,false]}",
                "%vlocity_namespace%__Order__c": 5,
                "%vlocity_namespace%__OmniScriptVersion__c": 1,
                "%vlocity_namespace%__Level__c": 0,
                "%vlocity_namespace%__Active__c": true,
                "%vlocity_namespace%__OmniScriptId__c": {
                  "VlocityMatchingRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
                  "VlocityDataPackType": "VlocityMatchingKeyObject",
                  "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
                  "Name": "Terminate Contract"
                },
                "Name": "DataRaptor Post Action 2",
                "Id": "a11o0000003nk9pAAA",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a11o0000003nk9pAAA",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSObjectType": "%vlocity_namespace%__Element__c",
                "VlocityDataPackIsIncluded": true
              }
            ],
            "%vlocity_namespace%__CustomJavaScript__c": "baseCtrl.prototype.onSelectItemCustomized = function(control, option, index, scp, bFlip)\n        {\n            if(control === undefined || control === null || option === undefined || option === null)\n                return;\n            // multi-select, single select\n            var bSetVal = true;\n            var response = [];\n            if(bFlip)\n            {\n                if(option.vlcSelected === undefined || option.vlcSelected === null)\n                {\n                    option.vlcSelected = bSetVal;\n                }\n                else\n                {\n                    bSetVal = !option.vlcSelected;\n                    option.vlcSelected = bSetVal;\n                }\n            }\n\n            // update 'Selectable Items' response\n            var recSet = control.vlcSI[control.itemsKey];\n            // HP bug, use $$hashKey to check\n            for(var i=0; i<recSet.length; i++)\n            {\n                if(option.$$hashKey !== recSet[i].$$hashKey && bFlip && bSetVal && control.propSetMap.selectMode === 'Single')\n                     recSet[i].vlcSelected = false;\n                if(recSet[i].vlcSelected === true)\n                {\n                    recSet[i].Status = 'Inactive';\n                    response.push(recSet[i]);\n                }\n            }\n\n            if(response.length > 0)\n                control.response = response;\n            else\n                control.response = null;\n\n            if(control.propSetMap.dataJSON === true)\n                scp.aggregate(scp, control.index, control.indexInParent, true, -1);\n        };",
            "%vlocity_namespace%__Version__c": 1,
            "%vlocity_namespace%__Type__c": "Contract",
            "%vlocity_namespace%__TestHTMLTemplates__c": "<script type=\"text/ng-template\" id=\"contractItems.html\">\n            <div class=\"panel panel-default\">\n                <table class=\"table\">\n                    <thead>\n                        <tr>\n                            <th/>\n                            <th>Name</th>\n                            <th>Product Name</th>\n                            <th>Status</th>\n                        </tr>\n                    </thead>\n                    <tbody class='contractLine'>\n                        <tr ng-repeat='p in control.vlcSI[control.itemsKey]' ng-class=\"{ 'vlc-selectableitem-selected' : p.vlcSelected }\" >\n                            <td>\n                                <input type='checkbox' ng-model='p.vlcSelected' ng-change='baseCtrl.onSelectItemCustomized(control, p, $index, this, false)'/>\n                            </td>\n                            <td>{{p.Name}}</td>\n                            <td>{{p.ProdName}}</td>\n                            <td>{{p.Status}}</td>\n                        </tr>\n                    </tbody>\n                </table>\n            </div>\n\t</script>",
            "%vlocity_namespace%__SubType__c": "Terminate",
            "%vlocity_namespace%__PropertySet__c": "{\"includeCustomization\":true,\"persistentComponent\":[{\"render\":false,\"label\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteTimeout\":30000,\"remoteOptions\":{\"preTransformBundle\":\"\",\"postTransformBundle\":\"\"},\"preTransformBundle\":\"\",\"postTransformBundle\":\"\",\"sendJSONPath\":\"\",\"sendJSONNode\":\"\",\"responseJSONPath\":\"\",\"responseJSONNode\":\"\",\"id\":\"vlcCart\",\"itemsKey\":\"cartItems\",\"modalConfigurationSetting\":{\"modalHTMLTemplateId\":\"vlcProductConfig.html\",\"modalController\":\"ModalProductCtrl\",\"modalSize\":\"lg\"}},{\"render\":false,\"label\":\"\",\"remoteClass\":\"\",\"remoteMethod\":\"\",\"remoteTimeout\":30000,\"remoteOptions\":{\"preTransformBundle\":\"\",\"postTransformBundle\":\"\"},\"preTransformBundle\":\"\",\"postTransformBundle\":\"\",\"id\":\"vlcKnowledge\",\"itemsKey\":\"knowledgeItems\",\"modalConfigurationSetting\":{\"modalHTMLTemplateId\":\"\",\"modalController\":\"\",\"modalSize\":\"lg\"}}],\"allowSaveForLater\":true,\"saveNameTemplate\":null,\"saveExpireInDays\":null,\"saveForLaterRedirectPageName\":\"sflRedirect\",\"saveForLaterRedirectTemplateUrl\":\"vlcSaveForLaterAcknowledge.html\",\"saveContentEncoded\":false,\"autoSaveOnStepNext\":false,\"elementTypeToHTMLTemplateMapping\":{},\"seedDataJSON\":{},\"enableKnowledge\":false,\"knowledgeArticleTypeQueryFieldsMap\":{},\"timeTracking\":true}",
            "%vlocity_namespace%__Language__c": "English",
            "%vlocity_namespace%__IsReusable__c": false,
            "%vlocity_namespace%__IsActive__c": true,
            "%vlocity_namespace%__DataRaptorBundleName__c": "Terminate Contract",
            "%vlocity_namespace%__DataRaptorBundleId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a0Lo0000007VXrFEAW",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__DRBundle__c",
              "Name": "Terminate Contract"
            },
            "Name": "Terminate Contract",
            "Id": "a14o0000001W9FtAAK",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a14o0000001W9FtAAK",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__OmniScript__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a14o0000001W9FtAAK",
        "VlocityDataPackType": "OmniScript",
        "VlocityDataPackLabel": "OmniScript",
        "VlocityDataPackKey": "b459aa08434f140be2cbd9e7abb43f79",
        "VlocityDataPackRelationshipType": "Primary",
        "VlocityDataPackIsIncluded": true
      }
    },
    {
      "VlocityPrimarySourceId": "a0Lo0000007VXrFEAW",
      "VlocityDataPackType": "DataRaptor",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Parent",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [],
      "VlocityDataPackName": "Id: a0Lo0000007VXrFEAW ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "DataRaptor",
      "VlocityDataPackKey": "e96b60d04fc8238a7c4fa3fc8ddedfb7",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Parent",
        "VlocityDataPackKey": "e96b60d04fc8238a7c4fa3fc8ddedfb7",
        "VlocityDataPackLabel": "DataRaptor",
        "VlocityDataPackType": "DataRaptor",
        "Id": "a0Lo0000007VXrFEAW",
        "%vlocity_namespace%__DRBundle__c": [
          {
            "VlocityRecordSObjectType": "%vlocity_namespace%__DRBundle__c",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Lo0000007VXrFEAW",
            "Id": "a0Lo0000007VXrFEAW",
            "Name": "Terminate Contract",
            "%vlocity_namespace%__BatchSize__c": 200,
            "%vlocity_namespace%__DRMapName__c": "Terminate Contract",
            "%vlocity_namespace%__DeleteOnSuccess__c": false,
            "%vlocity_namespace%__IgnoreErrors__c": false,
            "%vlocity_namespace%__InputJson__c": "{\n  \"ContextId\": \"\",\n  \"timeStamp\": \"2016-01-21T19:12:50.271Z\",\n  \"userName\": \"bzhantelco2@vlocity.com\",\n  \"userProfile\": \"System Administrator\",\n  \"vlcPersistentComponent\": {},\n  \"vlcTimeTracking\": {},\n  \"Step 1\": {\n    \"Terminate Date\": \"2016-01-31T08:00:00.000Z\",\n    \"Terminate Type\": \"With Cause\",\n    \"Terminate Reason\": \"Customer Not Compliance\"\n  }\n}",
            "%vlocity_namespace%__InterfaceObject__c": "json",
            "%vlocity_namespace%__IsDefaultForInterface__c": false,
            "%vlocity_namespace%__IsProcessSuperBulk__c": false,
            "%vlocity_namespace%__ProcessNowThreshold__c": 0,
            "%vlocity_namespace%__Type__c": "Load (JSON)",
            "%vlocity_namespace%__DRMapItem__c": [
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0A1EAI",
                "Id": "a0Mo0000006y0A1EAI",
                "Name": "Terminate Contract",
                "%vlocity_namespace%__DomainObjectAPIName__c": "Contract",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "Id",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "ContextId",
                "%vlocity_namespace%__InterfaceObjectName__c": "json",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Terminate ContractCustom8344",
                "%vlocity_namespace%__UpsertKey__c": true,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0A2EAI",
                "Id": "a0Mo0000006y0A2EAI",
                "Name": "Terminate Contract",
                "%vlocity_namespace%__DomainObjectAPIName__c": "Contract",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "%vlocity_namespace%__TerminateDate__c",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Step 1:Terminate Date",
                "%vlocity_namespace%__InterfaceObjectName__c": "json",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Terminate ContractCustom4057",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0A3EAI",
                "Id": "a0Mo0000006y0A3EAI",
                "Name": "Terminate Contract",
                "%vlocity_namespace%__DomainObjectAPIName__c": "Contract",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "%vlocity_namespace%__TerminationReason__c",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Step 1:Terminate Reason",
                "%vlocity_namespace%__InterfaceObjectName__c": "json",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Terminate ContractCustom7057",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0A4EAI",
                "Id": "a0Mo0000006y0A4EAI",
                "Name": "Terminate Contract",
                "%vlocity_namespace%__DomainObjectAPIName__c": "Contract",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "%vlocity_namespace%__TerminationType__c",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Step 1:Terminate Type",
                "%vlocity_namespace%__InterfaceObjectName__c": "json",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Terminate ContractCustom2137",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              }
            ],
            "VlocityDataPackIsIncluded": true
          }
        ],
        "VlocityDataPackIsIncluded": true
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "VlocityUITemplate",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Children",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "b459aa08434f140be2cbd9e7abb43f79"
      ],
      "VlocityDataPackName": "Id: vlcProductConfig.html ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity UI Template",
      "VlocityDataPackKey": "afb3b311cf9beb4a62d933c8c2d90042",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Children",
        "VlocityDataPackKey": "afb3b311cf9beb4a62d933c8c2d90042",
        "VlocityDataPackLabel": "Vlocity UI Template",
        "VlocityDataPackType": "VlocityUITemplate",
        "Id": "vlcProductConfig.html"
      }
    },
    {
      "VlocityPrimarySourceId": "a0Lo0000007UW0xEAG",
      "VlocityDataPackType": "DataRaptor",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Sibling",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [],
      "VlocityDataPackName": "Id: ExtractContractLine ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "DataRaptor",
      "VlocityDataPackKey": "7425b5810eb13ebddbdb31efda778c42",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Sibling",
        "VlocityDataPackKey": "7425b5810eb13ebddbdb31efda778c42",
        "VlocityDataPackLabel": "DataRaptor",
        "VlocityDataPackType": "DataRaptor",
        "Id": "ExtractContractLine",
        "%vlocity_namespace%__DRBundle__c": [
          {
            "VlocityRecordSObjectType": "%vlocity_namespace%__DRBundle__c",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Lo0000007UW0xEAG",
            "Id": "a0Lo0000007UW0xEAG",
            "Name": "ExtractContractLine",
            "%vlocity_namespace%__BatchSize__c": 200,
            "%vlocity_namespace%__DRMapName__c": "ExtractContractLine",
            "%vlocity_namespace%__DeleteOnSuccess__c": false,
            "%vlocity_namespace%__IgnoreErrors__c": false,
            "%vlocity_namespace%__InterfaceObject__c": "json",
            "%vlocity_namespace%__IsDefaultForInterface__c": true,
            "%vlocity_namespace%__IsProcessSuperBulk__c": false,
            "%vlocity_namespace%__ProcessNowThreshold__c": 0,
            "%vlocity_namespace%__Type__c": "Extract (JSON)",
            "%vlocity_namespace%__DRMapItem__c": [
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0A5EAI",
                "Id": "a0Mo0000006y0A5EAI",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 0,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "Contract",
                "%vlocity_namespace%__FilterOperator__c": "=",
                "%vlocity_namespace%__FilterValue__c": "Id",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Id",
                "%vlocity_namespace%__InterfaceObjectLookupOrder__c": 1,
                "%vlocity_namespace%__InterfaceObjectName__c": "Contract",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Extract Contract LineCustom5429",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0AOEAY",
                "Id": "a0Mo0000006y0AOEAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 0,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "Contract:ContractItem",
                "%vlocity_namespace%__FilterOperator__c": "=",
                "%vlocity_namespace%__FilterValue__c": "Contract:Id",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "%vlocity_namespace%__ContractId__c",
                "%vlocity_namespace%__InterfaceObjectLookupOrder__c": 2,
                "%vlocity_namespace%__InterfaceObjectName__c": "%vlocity_namespace%__ContractLineItem__c",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Extract Contract LineCustom2405",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0APEAY",
                "Id": "a0Mo0000006y0APEAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "ContractItem:Id",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Contract:ContractItem:Id",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Extract Contract LineCustom4536",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0AQEAY",
                "Id": "a0Mo0000006y0AQEAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "ContractItem:ItemNumber",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Contract:ContractItem:%vlocity_namespace%__LineNumber__c",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Extract Contract LineCustom162",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0AREAY",
                "Id": "a0Mo0000006y0AREAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "ContractItem:Name",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Contract:ContractItem:Name",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "Extract Contract LineCustom8481",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0ASEAY",
                "Id": "a0Mo0000006y0ASEAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 0,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "Contract:ContractItem",
                "%vlocity_namespace%__FilterOperator__c": "=",
                "%vlocity_namespace%__FilterValue__c": "'Active'",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "%vlocity_namespace%__Status__c",
                "%vlocity_namespace%__InterfaceObjectLookupOrder__c": 2,
                "%vlocity_namespace%__InterfaceObjectName__c": "%vlocity_namespace%__ContractLineItem__c",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "ExtractContractLineCustom2286",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0ATEAY",
                "Id": "a0Mo0000006y0ATEAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "ContractItem:Status",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Contract:ContractItem:%vlocity_namespace%__Status__c",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "ExtractContractLineCustom5735",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0AUEAY",
                "Id": "a0Mo0000006y0AUEAY",
                "Name": "ExtractContractLine",
                "%vlocity_namespace%__DomainObjectAPIName__c": "json",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "ContractItem:ProdName",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Contract:ContractItem:%vlocity_namespace%__ProductName__c",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "ExtractContractLineCustom147",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              }
            ],
            "VlocityDataPackIsIncluded": true
          }
        ],
        "VlocityDataPackIsIncluded": true
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "VlocityUITemplate",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Children",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "b459aa08434f140be2cbd9e7abb43f79"
      ],
      "VlocityDataPackName": "Id: vlcAcknowledge.html ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity UI Template",
      "VlocityDataPackKey": "3ab74d368e12ae197750f91e4fc2c5b8",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Children",
        "VlocityDataPackKey": "3ab74d368e12ae197750f91e4fc2c5b8",
        "VlocityDataPackLabel": "Vlocity UI Template",
        "VlocityDataPackType": "VlocityUITemplate",
        "Id": "vlcAcknowledge.html"
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "DataRaptor",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Sibling",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [],
      "VlocityDataPackName": "Id: Terminate Contract ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "DataRaptor",
      "VlocityDataPackKey": "0af83b664195033558e325d103411ff1",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Sibling",
        "VlocityDataPackKey": "0af83b664195033558e325d103411ff1",
        "VlocityDataPackLabel": "DataRaptor",
        "VlocityDataPackType": "DataRaptor",
        "Id": "Terminate Contract"
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "VlocityUITemplate",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Children",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "b459aa08434f140be2cbd9e7abb43f79"
      ],
      "VlocityDataPackName": "Id: contractItems.html ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity UI Template",
      "VlocityDataPackKey": "824891b55861186e9b06cd9e1ef31bb0",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Children",
        "VlocityDataPackKey": "824891b55861186e9b06cd9e1ef31bb0",
        "VlocityDataPackLabel": "Vlocity UI Template",
        "VlocityDataPackType": "VlocityUITemplate",
        "Id": "contractItems.html"
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "VlocityUITemplate",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Children",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "b459aa08434f140be2cbd9e7abb43f79"
      ],
      "VlocityDataPackName": "Id: vlcModalContent.html ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity UI Template",
      "VlocityDataPackKey": "74254f5a5a3b3a172afbdea37d19ffc3",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Children",
        "VlocityDataPackKey": "74254f5a5a3b3a172afbdea37d19ffc3",
        "VlocityDataPackLabel": "Vlocity UI Template",
        "VlocityDataPackType": "VlocityUITemplate",
        "Id": "vlcModalContent.html"
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "VlocityUITemplate",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Children",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "b459aa08434f140be2cbd9e7abb43f79"
      ],
      "VlocityDataPackName": "Id: vlcMobileConfirmation.html ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity UI Template",
      "VlocityDataPackKey": "ade8e7557a91a32cd9d5e3369e7da583",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Children",
        "VlocityDataPackKey": "ade8e7557a91a32cd9d5e3369e7da583",
        "VlocityDataPackLabel": "Vlocity UI Template",
        "VlocityDataPackType": "VlocityUITemplate",
        "Id": "vlcMobileConfirmation.html"
      }
    },
    {
      "VlocityPrimarySourceId": "a0Lo0000007UYeHEAW",
      "VlocityDataPackType": "DataRaptor",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Sibling",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [],
      "VlocityDataPackName": "Id: InactiveSelectedContractItems ",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "DataRaptor",
      "VlocityDataPackKey": "898e5d1c78e5de6a6d144739f62c9552",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Sibling",
        "VlocityDataPackKey": "898e5d1c78e5de6a6d144739f62c9552",
        "VlocityDataPackLabel": "DataRaptor",
        "VlocityDataPackType": "DataRaptor",
        "Id": "InactiveSelectedContractItems",
        "%vlocity_namespace%__DRBundle__c": [
          {
            "VlocityRecordSObjectType": "%vlocity_namespace%__DRBundle__c",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Lo0000007UYeHEAW",
            "Id": "a0Lo0000007UYeHEAW",
            "Name": "InactiveSelectedContractItems",
            "%vlocity_namespace%__BatchSize__c": 200,
            "%vlocity_namespace%__DRMapName__c": "InactiveSelectedContractItems",
            "%vlocity_namespace%__DeleteOnSuccess__c": false,
            "%vlocity_namespace%__IgnoreErrors__c": false,
            "%vlocity_namespace%__InputJson__c": "{\n  \"ContextId\": \"800o00000000cui\",\n  \"timeStamp\": \"2016-01-22T21:46:40.821Z\",\n  \"userName\": \"bzhantelco2@vlocity.com\",\n  \"userProfile\": \"System Administrator\",\n  \"vlcPersistentComponent\": {},\n  \"vlcTimeTracking\": {\n    \"Step 1\": 59812,\n    \"Extract contract line items\": 1027\n  },\n  \"Step 1\": {\n    \"Terminate Date\": \"2016-01-20T08:00:00.000Z\",\n    \"Terminate Type\": \"With Cause\",\n    \"Terminate Reason\": \"Customer Not Compliance\",\n    \"Terminate Option\": \"Partially terminate lines in the contract\"\n  },\n  \"Step 2\": {\n    \"ContractItem\": [\n      {\n        \"Name\": \"GenWatt Diesel 10kW\",\n        \"Status\": \"Inactive\",\n        \"Id\": \"a1Eo0000002Dc3MEAS\",\n        \"$$hashKey\": \"object:202\",\n        \"vlcSelected\": true\n      }\n    ]\n  }\n}",
            "%vlocity_namespace%__InterfaceObject__c": "json",
            "%vlocity_namespace%__IsDefaultForInterface__c": false,
            "%vlocity_namespace%__IsProcessSuperBulk__c": false,
            "%vlocity_namespace%__ProcessNowThreshold__c": 0,
            "%vlocity_namespace%__Type__c": "Load (JSON)",
            "%vlocity_namespace%__DRMapItem__c": [
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0AVEAY",
                "Id": "a0Mo0000006y0AVEAY",
                "Name": "InactiveSelectedContractItems",
                "%vlocity_namespace%__DomainObjectAPIName__c": "%vlocity_namespace%__ContractLineItem__c",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "Id",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Step 2:ContractItem:Id",
                "%vlocity_namespace%__InterfaceObjectName__c": "json",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "InactiveSelectedContractItemsCustom1537",
                "%vlocity_namespace%__UpsertKey__c": true,
                "VlocityDataPackIsIncluded": true
              },
              {
                "VlocityRecordSObjectType": "%vlocity_namespace%__DRMapItem__c",
                "VlocityDataPackType": "SObject",
                "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0Mo0000006y0AWEAY",
                "Id": "a0Mo0000006y0AWEAY",
                "Name": "InactiveSelectedContractItems",
                "%vlocity_namespace%__DomainObjectAPIName__c": "%vlocity_namespace%__ContractLineItem__c",
                "%vlocity_namespace%__DomainObjectCreationOrder__c": 1,
                "%vlocity_namespace%__DomainObjectFieldAPIName__c": "%vlocity_namespace%__Status__c",
                "%vlocity_namespace%__InterfaceFieldAPIName__c": "Step 2:ContractItem:Status",
                "%vlocity_namespace%__InterfaceObjectName__c": "json",
                "%vlocity_namespace%__IsDisabled__c": false,
                "%vlocity_namespace%__LinkCreatedIndex__c": 0,
                "%vlocity_namespace%__MapId__c": "InactiveSelectedContractItemsCustom3263",
                "%vlocity_namespace%__UpsertKey__c": false,
                "VlocityDataPackIsIncluded": true
              }
            ],
            "VlocityDataPackIsIncluded": true
          }
        ],
        "VlocityDataPackIsIncluded": true
      }
    }
  ],
  "dataPackId": "a1zo0000001iTCDAA2"
}