{
  "warnings": {
    "2008a4f28fc91da182da9e8f532742b8": [
      {
        "VlocityDataPackData": {
          "VlocityDataPackRelationshipType": "Metadata",
          "VlocityDataPackKey": "2008a4f28fc91da182da9e8f532742b8",
          "VlocityDataPackLabel": "Apex Class",
          "VlocityDataPackType": "Apex Class",
          "Id": "StateTransitionVOIService"
        },
        "VlocityDataPackIsNotSupported": false,
        "VlocityDataPackRelationshipType": "Metadata",
        "VlocityDataPackType": "Apex Class",
        "VlocityDataPackName": "StateTransitionVOIService",
        "VlocityDataPackKey": "2008a4f28fc91da182da9e8f532742b8",
        "VlocityDataPackLabel": "Apex Class",
        "VlocityDataPackMessage": "Apex Class Export Not Supported",
        "VlocityDataPackStatus": "Ignored"
      }
    ]
  },
  "status": "Complete",
  "primaryDataPackKey": "a01a82e34b3be430c27af9739216e264",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a0t15000004FMMbAAO",
      "VlocityDataPackType": "VlocityAction",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "20425dec496c2e955b50f25089743638"
      ],
      "VlocityDataPackName": "Id: a0t15000004FMMbAAO",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity Action",
      "VlocityDataPackKey": "a01a82e34b3be430c27af9739216e264",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__VlocityAction__c": [
          {
            "%vlocity_namespace%__IsSeedAction__c": false,
            "%vlocity_namespace%__VlocityIcon__c": "icon-v-edit2",
            "%vlocity_namespace%__StateModelId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a12150000020u7CAAQ",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityStateModel__c",
              "Name": "Contract State Model"
            },
            "%vlocity_namespace%__StateId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a1415000003ap0nAAA",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityState__c",
              "Name": "Draft",
              "%vlocity_namespace%__DTPStateModelName__c": "Contract State Model"
            },
            "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
            "%vlocity_namespace%__LinkType__c": "Other",
            "%vlocity_namespace%__IsActive__c": true,
            "%vlocity_namespace%__InvokeMethodName__c": "updateObjectState",
            "%vlocity_namespace%__InvokeClassName__c": "StateTransitionVOIService",
            "%vlocity_namespace%__Filter__c": "Status in ('Negotiating', 'Rejected Internally', 'Signature Declined')",
            "%vlocity_namespace%__DisplaySequence__c": 4,
            "%vlocity_namespace%__DisplayOn__c": "Web Client",
            "%vlocity_namespace%__DisplayLabel__c": "Re-Draft Contract",
            "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
            "%vlocity_namespace%__ApplicableTypes__c": "Contract",
            "Name": "Re-Draft Contract",
            "Id": "a0t15000004FMMbAAO",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0t15000004FMMbAAO",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a0t15000004FMMbAAO",
        "VlocityDataPackType": "VlocityAction",
        "VlocityDataPackLabel": "Vlocity Action",
        "VlocityDataPackKey": "a01a82e34b3be430c27af9739216e264",
        "VlocityDataPackRelationshipType": "Primary",
        "VlocityDataPackIsIncluded": true
      }
    },
    {
      "VlocityPrimarySourceId": null,
      "VlocityDataPackType": "Apex Class",
      "VlocityDataPackStatus": "Not Included",
      "VlocityDataPackRelationshipType": "Metadata",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [],
      "VlocityDataPackName": "StateTransitionVOIService",
      "VlocityDataPackMessage": "Apex Class Export Not Supported",
      "VlocityDataPackLabel": "Apex Class",
      "VlocityDataPackKey": "2008a4f28fc91da182da9e8f532742b8",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Metadata",
        "VlocityDataPackKey": "2008a4f28fc91da182da9e8f532742b8",
        "VlocityDataPackLabel": "Apex Class",
        "VlocityDataPackType": "Apex Class",
        "Id": "StateTransitionVOIService"
      }
    }
  ],
  "dataPackId": "a0x1500000D9AAzAAN",
  "name": "redraftContractAction",
  "version": 1
}