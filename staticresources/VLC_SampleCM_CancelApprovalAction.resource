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
  "primaryDataPackKey": "9c92eac1e3fae3fbb7539fcdbc8c5741",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a0t15000004FMMYAA4",
      "VlocityDataPackType": "VlocityAction",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "20425dec496c2e955b50f25089743638"
      ],
      "VlocityDataPackName": "Id: a0t15000004FMMYAA4",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity Action",
      "VlocityDataPackKey": "9c92eac1e3fae3fbb7539fcdbc8c5741",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__VlocityAction__c": [
          {
            "%vlocity_namespace%__IsSeedAction__c": false,
            "%vlocity_namespace%__VlocityIcon__c": "icon-v-cancel-approval",
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
            "%vlocity_namespace%__InvokeMethodName__c": "cancelApproval",
            "%vlocity_namespace%__InvokeClassName__c": "SubmitApprovalRequest",
            "%vlocity_namespace%__Filter__c": "Status='Awaiting Approval'",
            "%vlocity_namespace%__DisplaySequence__c": 3,
            "%vlocity_namespace%__DisplayOn__c": "Web Client",
            "%vlocity_namespace%__DisplayLabel__c": "Cancel Approval",
            "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
            "%vlocity_namespace%__ApplicableTypes__c": "Contract",
            "Name": "Cancel Approval",
            "Id": "a0t15000004FMMYAA4",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0t15000004FMMYAA4",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a0t15000004FMMYAA4",
        "VlocityDataPackType": "VlocityAction",
        "VlocityDataPackLabel": "Vlocity Action",
        "VlocityDataPackKey": "9c92eac1e3fae3fbb7539fcdbc8c5741",
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
  "dataPackId": "a0x1500000D9AApAAN",
  "name": "cancelApprovalAction",
  "version": 1
}