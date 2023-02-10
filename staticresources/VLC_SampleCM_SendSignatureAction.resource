{
  "status": "Complete",
  "primaryDataPackKey": "d5b0cef406ccc7dd9a928262867c8366",
  "dataPacks": [
    {
      "VlocityPrimarySourceId": "a0t15000004FMMTAA4",
      "VlocityDataPackType": "VlocityAction",
      "VlocityDataPackStatus": "Success",
      "VlocityDataPackRelationshipType": "Primary",
      "VlocityDataPackRecords": [],
      "VlocityDataPackParents": [
        "20425dec496c2e955b50f25089743638"
      ],
      "VlocityDataPackName": "Id: a0t15000004FMMTAA4",
      "VlocityDataPackMessage": null,
      "VlocityDataPackLabel": "Vlocity Action",
      "VlocityDataPackKey": "d5b0cef406ccc7dd9a928262867c8366",
      "VlocityDataPackIsNotSupported": false,
      "VlocityDataPackData": {
        "%vlocity_namespace%__VlocityAction__c": [
          {
            "%vlocity_namespace%__IsSeedAction__c": true,
            "%vlocity_namespace%__VlocityIcon__c": "icon-v-send-for-e-signature",
            "%vlocity_namespace%__Url__c": "/apex/ContractDocuSignEnvelope?Id={0}",
            "%vlocity_namespace%__UrlParameters__c": "Id",
            "%vlocity_namespace%__StateModelId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a12150000020u7CAAQ",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityStateModel__c",
              "Name": "Contract State Model"
            },
            "%vlocity_namespace%__StateId__c": {
              "VlocityLookupRecordSourceKey": "VlocityRecordSourceKey:a1415000003ap0oAAA",
              "VlocityDataPackType": "VlocityLookupMatchingKeyObject",
              "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityState__c",
              "Name": "Awaiting Signature",
              "%vlocity_namespace%__DTPStateModelName__c": "Contract State Model"
            },
            "%vlocity_namespace%__OpenUrlMode__c": "Current Window",
            "%vlocity_namespace%__LinkType__c": "Other",
            "%vlocity_namespace%__IsActive__c": true,
            "%vlocity_namespace%__Filter__c": "Status='Negotiating'",
            "%vlocity_namespace%__DisplaySequence__c": 5,
            "%vlocity_namespace%__DisplayOn__c": "Web Client",
            "%vlocity_namespace%__DisplayLabel__c": "Send for eSignature",
            "%vlocity_namespace%__ApplicableUserProfiles__c": "All",
            "%vlocity_namespace%__ApplicableTypes__c": "Contract",
            "Name": "Send for eSignature",
            "Id": "a0t15000004FMMTAA4",
            "VlocityRecordSourceKey": "VlocityRecordSourceKey:a0t15000004FMMTAA4",
            "VlocityDataPackType": "SObject",
            "VlocityRecordSObjectType": "%vlocity_namespace%__VlocityAction__c",
            "VlocityDataPackIsIncluded": true
          }
        ],
        "Id": "a0t15000004FMMTAA4",
        "VlocityDataPackType": "VlocityAction",
        "VlocityDataPackLabel": "Vlocity Action",
        "VlocityDataPackKey": "d5b0cef406ccc7dd9a928262867c8366",
        "VlocityDataPackRelationshipType": "Primary",
        "VlocityDataPackIsIncluded": true
      }
    }
  ],
  "dataPackId": "a0x1500000D9ABEAA3",
  "name": "sendSignatureAction",
  "version": 1
}