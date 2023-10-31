{
    "dataPackId": "",
    "dataPacks": [ 
        {
            "VlocityDataPackData": {
                "%vlocity_namespace%__PricingPlan__c": [
                    {
                        "%vlocity_namespace%__Code__c": "LINE_ITEM_PRICING_PLAN",
                        "%vlocity_namespace%__CountOfActivePricingPlanSteps__c": 10,
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__EffectiveFromDate__c": "",
                        "%vlocity_namespace%__EffectiveUntilDate__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                        "%vlocity_namespace%__IsActive__c": true,
                        "Name": "Line Item Pricing Plan",
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c",
                        "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                        "%vlocity_namespace%__PricingPlanStep__c": [
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "00a07ffd-43a7-879e-baba-9114f5490eb2",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "SaveLineItems",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 80,
                                "Name": "Save Line Items",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/00a07ffd-43a7-879e-baba-9114f5490eb2"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "3d07c4db-4d85-d133-d5e3-3e21f7b35354",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "CalculateRollups",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 70,
                                "Name": "Calculate Rollups",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/3d07c4db-4d85-d133-d5e3-3e21f7b35354"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "489e0d5d-66cf-8026-763e-ec9f8ca0b79d",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "ApplyContextDiscounts",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 35,
                                "Name": "Apply Context Discounts",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/489e0d5d-66cf-8026-763e-ec9f8ca0b79d"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "88a8d83e-6b95-e8d4-c98b-4fb84f15188b",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "InitializePricingContext",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 10,
                                "Name": "Initialize Pricing Context",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/88a8d83e-6b95-e8d4-c98b-4fb84f15188b"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "96c90b39-46ad-3af0-049c-82625d0519db",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "ApplyPromotionAdjustments",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 50,
                                "Name": "Apply Promotion Adjustments",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/96c90b39-46ad-3af0-049c-82625d0519db"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "9b50cfc1-36f3-05e5-ce06-964323a3fadf",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "ApplyChargeManualAdjustments",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 60,
                                "Name": "Apply Charge Manual Adjustments",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/9b50cfc1-36f3-05e5-ce06-964323a3fadf"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "c601ebf8-973a-9df6-1015-7425866d93cf",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "InitializePricingVariables",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 30,
                                "Name": "Initialize Pricing Variables",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/c601ebf8-973a-9df6-1015-7425866d93cf"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "d7cfbe8a-868c-08eb-1845-c00011f47a41",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "LoadTightestMatchPriceListEntries",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 20,
                                "Name": "Load Price List Entries",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/d7cfbe8a-868c-08eb-1845-c00011f47a41"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "effc9ad5-9d90-c3bb-14ba-5c4aba2d9569",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "LoadMarginRanges",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 75,
                                "Name": "Load Margin Ranges",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/effc9ad5-9d90-c3bb-14ba-5c4aba2d9569"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "f71abbb0-d7fb-c8e5-c611-5b228aba6c11",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "ApplyOfferAdjustments",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "5d218588-a387-333e-0616-fd067379cf2f",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Line Item Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 40,
                                "Name": "Apply Offer Adjustments",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/f71abbb0-d7fb-c8e5-c611-5b228aba6c11"
                            }
                        ]
                    },
                    {
                        "%vlocity_namespace%__Code__c": "CART_ROLLUP_PRICING_PLAN",
                        "%vlocity_namespace%__CountOfActivePricingPlanSteps__c": 2,
                        "%vlocity_namespace%__Description__c": "",
                        "%vlocity_namespace%__EffectiveFromDate__c": "",
                        "%vlocity_namespace%__EffectiveUntilDate__c": "",
                        "%vlocity_namespace%__GlobalKey__c": "73929476-e9b6-3e6a-19ff-4c635787666b",
                        "%vlocity_namespace%__IsActive__c": true,
                        "Name": "Cart Rollup Pricing Plan",
                        "VlocityDataPackType": "SObject",
                        "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c",
                        "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Cart Rollup Pricing Plan",
                        "%vlocity_namespace%__PricingPlanStep__c": [
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "b5d46bc0-db9f-0215-25ac-bf65b0830a4d",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "InitializePricingContext",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "73929476-e9b6-3e6a-19ff-4c635787666b",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Cart Rollup Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 10,
                                "Name": "Initialize Pricing Context",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/b5d46bc0-db9f-0215-25ac-bf65b0830a4d"
                            },
                            {
                                "%vlocity_namespace%__Description__c": "",
                                "%vlocity_namespace%__GlobalKey__c": "ceeeefe5-347f-1b17-9940-e5dffddc9db7",
                                "%vlocity_namespace%__ImplementationName__c": "DefaultPricingPlanImplementation",
                                "%vlocity_namespace%__IsActive__c": true,
                                "%vlocity_namespace%__MethodName__c": "ApplyParentVariables",
                                "%vlocity_namespace%__Parameters__c": "",
                                "%vlocity_namespace%__PricingPlanId__c": {
                                    "%vlocity_namespace%__GlobalKey__c": "73929476-e9b6-3e6a-19ff-4c635787666b",
                                    "VlocityDataPackType": "VlocityMatchingKeyObject",
                                    "VlocityMatchingRecordSourceKey": "%vlocity_namespace%__PricingPlan__c/Cart Rollup Pricing Plan",
                                    "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlan__c"
                                },
                                "%vlocity_namespace%__Sequence__c": 90,
                                "Name": "Apply Parent Variables",
                                "VlocityDataPackType": "SObject",
                                "VlocityRecordSObjectType": "%vlocity_namespace%__PricingPlanStep__c",
                                "VlocityRecordSourceKey": "%vlocity_namespace%__PricingPlanStep__c/ceeeefe5-347f-1b17-9940-e5dffddc9db7"
                            }
                        ]
                    }
                ],
                "VlocityDataPackIsIncluded": true,
                "VlocityDataPackKey": "PricingPlan/Custom Pricing Plan",
                "VlocityDataPackType": "PricingPlan"
            },
            "VlocityDataPackIsIncluded": true,
            "VlocityDataPackKey": "PricingPlan/Custom Pricing Plan",
            "VlocityDataPackName": "Custom Pricing Plan",
            "VlocityDataPackRelationshipType": "Primary",
            "VlocityDataPackStatus": "Success",
            "VlocityDataPackType": "PricingPlan"
        }
    ],
    "name": "VlocityDeploy",
    "primaryDataPackKey": "VlocityDeploy",
    "processMultiple": true,
    "status": "Complete",
    "version": 1
}