{
  "status": "Complete",
  "primaryDataPackKey": "aca5112f49053d28c8510b7d6fd085c5",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a0t15000004FMMVAA4",
      "VlocityDataPackType": "VlocityAction",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "20425dec496c2e955b50f25089743638"
      ],
      "VlocityDataPackName": "Id: a0t15000004FMMVAA4",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity Action",
      "VlocityDataPackKey": "aca5112f49053d28c8510b7d6fd085c5",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__VlocityAction__c": [
          {
            "%vlocity_namespace%__IsSeedAction__c": false,
            "%vlocity_namespace%__VlocityIcon__c": "icon-v-terminate-contract",
            "%vlocity_namespace%__Url__c": "/apex/OmniScriptUniversalPage?id={0}#/OmniScriptType/Contract/OmniScriptSubType/Terminate/OmniScriptLang/English/ContextId/{0}/PrefillDataRaptorBundle//false/true",
            "%vlocity_namespace%__UrlParameters__c": "Id",
            "%vlocity_namespace%__StateModelId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a12150000020u7CAAQ",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityStateModel__c",
              "Name": "Contract State Model"
            },
            "%vlocity_namespace%__StateId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a1415000003ap0sAAA",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityState__c",
              "Name": "Terminated",
              "%vlocity_namespace%__DTPStateModelName__c": "Contract State Model"
            },
            "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
            "%vlocity_namespace%__LinkType__c": "OmniScript",
            "%vlocity_namespace%__IsActive__c": true,
            "%vlocity_namespace%__Filter__c": "(Status='Signed' OR Status='Activated')",
            "%vlocity_namespace%__DisplaySequence__c": 10,
            "%vlocity_namespace%__DisplayOn__c": "Web Client",
            "%vlocity_namespace%__DisplayLabel__c": "Terminate Contract",
            "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
            "%vlocity_namespace%__ApplicableTypes__c": "Contract",
            "Name": "Terminate Contract",
            "Id": "a0t15000004FMMVAA4",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0t15000004FMMVAA4",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a0t15000004FMMVAA4",
        "VlocityDataPackType": "VlocityAction",
        "VlocityDataPackLabel": "Vlocity Action",
        "VlocityDataPackKey": "aca5112f49053d28c8510b7d6fd085c5",
        "VlocityDataPackRelationshipType": "Primary",
        "VlocityDataPackIsIncluded": true
      }
    }
  ],
  "dataPackId": "a0x1500000D9ABJAA3",
  "name": "terminateContractAction",
  "version": 1
}