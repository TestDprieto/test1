{
  "warnings": {
    "0a524ea50f199f0c0892d17c847eef8b": [
      {
        "VlocityDataPackData": {
          "VlocityDataPackRelationshipType": "Metadata",
          "VlocityDataPackKey": "0a524ea50f199f0c0892d17c847eef8b",
          "VlocityDataPackLabel": "Apex Class",
          "VlocityDataPackType": "Apex Class",
          "Id": "ContractProcessingService"
        },
        "VlocityDataPackIsNotSupported": false,
        "VlocityDataPackRelationshipType": "Metadata",
        "VlocityDataPackType": "Apex Class",
        "VlocityDataPackName": "ContractProcessingService",
        "VlocityDataPackKey": "0a524ea50f199f0c0892d17c847eef8b",
        "VlocityDataPackLabel": "Apex Class",
        "VlocityDataPackMessage": "Apex Class Export Not Supported",
        "VlocityDataPackStatus": "Ignored"
      }
    ]
  },
  "status": "Complete",
  "primaryDataPackKey": "e80c205ca1ca0d93d8d9ebe9b8f0c80e",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a0t15000004FMMZAA4",
      "VlocityDataPackType": "VlocityAction",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "20425dec496c2e955b50f25089743638"
      ],
      "VlocityDataPackName": "Id: a0t15000004FMMZAA4",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity Action",
      "VlocityDataPackKey": "e80c205ca1ca0d93d8d9ebe9b8f0c80e",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__VlocityAction__c": [
          {
            "%vlocity_namespace%__IsSeedAction__c": true,
            "%vlocity_namespace%__VlocityIcon__c": "icon-v-revoke-for-e-signature",
            "%vlocity_namespace%__StateModelId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a12150000020u7CAAQ",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityStateModel__c",
              "Name": "Contract State Model"
            },
            "%vlocity_namespace%__StateId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a1415000003ap0jAAA",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityState__c",
              "Name": "Negotiating",
              "%vlocity_namespace%__DTPStateModelName__c": "Contract State Model"
            },
            "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
            "%vlocity_namespace%__LinkType__c": "Other",
            "%vlocity_namespace%__IsActive__c": true,
            "%vlocity_namespace%__InvokeMethodName__c": "revokeEnvelope",
            "%vlocity_namespace%__InvokeClassName__c": "ContractProcessingService",
            "%vlocity_namespace%__Filter__c": "Status='Awaiting Signature'",
            "%vlocity_namespace%__DisplaySequence__c": 7,
            "%vlocity_namespace%__DisplayOn__c": "Web Client",
            "%vlocity_namespace%__DisplayLabel__c": "Revoke eSignature",
            "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
            "%vlocity_namespace%__ApplicableTypes__c": "Contract",
            "Name": "Revoke eSignature",
            "Id": "a0t15000004FMMZAA4",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0t15000004FMMZAA4",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a0t15000004FMMZAA4",
        "VlocityDataPackType": "VlocityAction",
        "VlocityDataPackLabel": "Vlocity Action",
        "VlocityDataPackKey": "e80c205ca1ca0d93d8d9ebe9b8f0c80e",
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
      "VlocityDataPackName": "ContractProcessingService",
      "VlocityDataPackMessage": "Apex Class Export Not Supported",
      "VlocityDataPackLabel": "Apex Class",
      "VlocityDataPackKey": "0a524ea50f199f0c0892d17c847eef8b",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Metadata",
        "VlocityDataPackKey": "0a524ea50f199f0c0892d17c847eef8b",
        "VlocityDataPackLabel": "Apex Class",
        "VlocityDataPackType": "Apex Class",
        "Id": "ContractProcessingService"
      }
    }
  ],
  "dataPackId": "a0x1500000D9AB9AAN",
  "name": "revokeSignatureAction",
  "version": 1
}