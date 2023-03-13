APIHandler__c,APIParams__c,APIResponseHandler__c,APIUrl__c,IsActive__c,APIName__c,Sequence__c, BatchClassName__c
DefaultEcomDataProfilerCHandler,{"batchSize":1},,,TRUE,EcomDataProfileGenerator,1,EcomDataProfileGeneratorBatch
DefaultRuleSetCombinationsCHandler,{"batchSize":1},,,TRUE,RuleSetCombinationGenerator,2,RuleSetCombinationGeneratorBatch
DefaultCtxCombinationsCHandler,{"batchSize":1},,,TRUE,ContextEligibilityGenerator,3,ContextEligibilityGeneratorBatch
DefaultGetOfferHierarchyCHandler,{"batchSize":1},,,TRUE,GetOffersHierarchyHelper,4,GetOffersHierarchyHelperBatch
DefaultGetOffersItemCHandler,{"batchSize":1},,,TRUE,GetOffersItem,5,GetOffersItemBatch
DefaultGetOffersCHandler,{"batchSize":1},DefaultGetOffersRHandler,/v3/catalogs/{catalog_code}/offers,TRUE,GetOffers,6,GetOffersBatch
DefaultGetRelatedOffersCHandler,{"batchSize":1},DefaultGetRelatedOffersRHandler,/v3/catalogs/{catalogCode}/offers?contains={productCode}&context={contextParams},TRUE,GetContainOffers,7,GetContainOffersBatch
DefaultGetPricesCHandler,{"batchSize":20__COMMA_TOKEN__"scopeAll":true},DefaultGetPricesCHandler,/v3/prices,true,GetPrices,8, GetPricesBatch
DefaultGetOfferDetailsCHandler,{"batchSize":1},DefaultGetOfferDetailsRHandler,/v3/catalogs/{catalog_code}/offers/{offer_code},TRUE,GetOfferDetails,9,GetOfferDetailsBatch
null,,DefaultConfigureOfferRHandler,/v3/catalogs/{catalog_code}/offers/{offer_code},TRUE,ConfigureOfferDetail,10,
null,,DefaultCreateEcomCartRHandler,/v3/carts,TRUE,CreateEcomCart,11,
null,,DefaultBasketOperationsRHandler,,TRUE,basketOperations,12,
null,,DefaultContextInfoRHandler,,TRUE,contextInfo,13,
null,,DefaultCacheMigrationImplementation,/v3/migrationstatus,TRUE,CacheMigration,14,