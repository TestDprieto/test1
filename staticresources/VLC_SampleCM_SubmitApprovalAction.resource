{
  "warnings": {
    "075f5bf6ca1e1ffbfaa9f6f5f641883d": [
      {
        "VlocityDataPackData": {
          "VlocityDataPackRelationshipType": "Metadata",
          "VlocityDataPackKey": "075f5bf6ca1e1ffbfaa9f6f5f641883d",
          "VlocityDataPackLabel": "Apex Class",
          "VlocityDataPackType": "Apex Class",
          "Id": "SubmitApprovalRequest"
        },
        "VlocityDataPackIsNotSupported": false,
        "VlocityDataPackRelationshipType": "Metadata",
        "VlocityDataPackType": "Apex Class",
        "VlocityDataPackName": "SubmitApprovalRequest",
        "VlocityDataPackKey": "075f5bf6ca1e1ffbfaa9f6f5f641883d",
        "VlocityDataPackLabel": "Apex Class",
        "VlocityDataPackMessage": "Apex Class Export Not Supported",
        "VlocityDataPackStatus": "Ignored"
      }
    ]
  },
  "status": "Complete",
  "primaryDataPackKey": "e392ea8820129c78ccc291232c67c884",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a0t15000004FMMaAAO",
      "VlocityDataPackType": "VlocityAction",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "20425dec496c2e955b50f25089743638"
      ],
      "VlocityDataPackName": "Id: a0t15000004FMMaAAO",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity Action",
      "VlocityDataPackKey": "e392ea8820129c78ccc291232c67c884",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__VlocityAction__c": [
          {
            "%vlocity_namespace%__IsSeedAction__c": false,
            "%vlocity_namespace%__VlocityIcon__c": "icon-v-submit-for-approval",
            "%vlocity_namespace%__StateModelId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a12150000020u7CAAQ",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityStateModel__c",
              "Name": "Contract State Model"
            },
            "%vlocity_namespace%__StateId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a1415000003ap0rAAA",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityState__c",
              "Name": "Awaiting Approval",
              "%vlocity_namespace%__DTPStateModelName__c": "Contract State Model"
            },
            "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
            "%vlocity_namespace%__LinkType__c": "Other",
            "%vlocity_namespace%__IsActive__c": true,
            "%vlocity_namespace%__InvokeMethodName__c": "submitApproval",
            "%vlocity_namespace%__InvokeClassName__c": "SubmitApprovalRequest",
            "%vlocity_namespace%__Filter__c": "Status='Draft'",
            "%vlocity_namespace%__DisplaySequence__c": 1,
            "%vlocity_namespace%__DisplayOn__c": "Web Client",
            "%vlocity_namespace%__DisplayLabel__c": "Submit for Approval",
            "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
            "%vlocity_namespace%__ApplicableTypes__c": "Contract",
            "Name": "Submit for Approval",
            "Id": "a0t15000004FMMaAAO",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0t15000004FMMaAAO",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a0t15000004FMMaAAO",
        "VlocityDataPackType": "VlocityAction",
        "VlocityDataPackLabel": "Vlocity Action",
        "VlocityDataPackKey": "e392ea8820129c78ccc291232c67c884",
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
      "VlocityDataPackName": "SubmitApprovalRequest",
      "VlocityDataPackMessage": "Apex Class Export Not Supported",
      "VlocityDataPackLabel": "Apex Class",
      "VlocityDataPackKey": "075f5bf6ca1e1ffbfaa9f6f5f641883d",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "VlocityDataPackRelationshipType": "Metadata",
        "VlocityDataPackKey": "075f5bf6ca1e1ffbfaa9f6f5f641883d",
        "VlocityDataPackLabel": "Apex Class",
        "VlocityDataPackType": "Apex Class",
        "Id": "SubmitApprovalRequest"
      }
    }
  ],
  "dataPackId": "a0x1500000D9AAVAA3",
  "name": "SubmitForApprovalAction",
  "version": 1
}