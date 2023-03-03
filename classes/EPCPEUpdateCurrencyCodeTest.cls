@isTest
private class EPCPEUpdateCurrencyCodeTest
{
    @testSetup static void setupData()
    {
        vlocity_cmt__PriceList__c pl1 = new vlocity_cmt__PriceList__c(vlocity_cmt__Pricebook2Id__c = Test.getStandardPricebookId(), vlocity_cmt__IsActive__c = true,
            vlocity_cmt__Code__c = 'TestPricebook', vlocity_cmt__CurrencyCode__c = 'USD', vlocity_cmt__LoyaltyCode__c = 'PTS');
        insert pl1;
        pl1 = [Select Id From vlocity_cmt__PriceList__c limit 1];

        List<String> types = new List<String>();
        types.add('vlocity_cmt__ObjectClass__c');
        List<Schema.DescribeSobjectResult> results = Schema.describeSObjects(types);
        Map<String,Schema.RecordTypeInfo> rtMapByName = results[0].getRecordTypeInfosByName();
        Id objectRTId = rtMapByName.get('Object Type').getRecordTypeId();

        vlocity_cmt__ObjectClass__c chargeObjType = new vlocity_cmt__ObjectClass__c(Name = 'Charge', vlocity_cmt__ObjectApiName__c = 'PricingElement__c', RecordTypeId = objectRTId);
        insert chargeObjType;
        chargeObjType = [Select Id, Name from vlocity_cmt__ObjectClass__c where Name like 'Charge' limit 1];

        vlocity_cmt__PricingVariable__c pv = new vlocity_cmt__PricingVariable__c(
        Name ='One Time Std Price',
        vlocity_cmt__AdjustmentMethod__c = null,
        vlocity_cmt__Aggregation__c = 'Unit',
        vlocity_cmt__AppliesToVariableId__c = null,
        vlocity_cmt__ChargeType__c = 'One-time',
        vlocity_cmt__Code__c = 'OT_STD_PRC',
        vlocity_cmt__IsActive__c = true,
        vlocity_cmt__RecurringFrequency__c = null,
        vlocity_cmt__Scope__c = 'Line',
        vlocity_cmt__SubType__c = 'Standard',
        vlocity_cmt__Type__c = 'Price',
        vlocity_cmt__ValueType__c = 'Pricing Element',
        vlocity_cmt__CurrencyType__c = 'Currency'
        );
        insert pv;
        pv = [Select Id From vlocity_cmt__PricingVariable__c limit 1];

        vlocity_cmt__PricingElement__c pElem1 = new vlocity_cmt__PricingElement__c(Name = 'One Time $100 Standalone Price', vlocity_cmt__ObjectTypeId__c = chargeObjType.Id, vlocity_cmt__Amount__c = 100.00,
                vlocity_cmt__Code__c = 'PELEM1', vlocity_cmt__CurrencyCode__c=null, vlocity_cmt__EffectiveFromDate__c = Datetime.now(), vlocity_cmt__IsActive__c = true, vlocity_cmt__IsReusable__c = true, vlocity_cmt__PricingVariableId__c = pv.Id, vlocity_cmt__PriceListId__c = pl1.Id);
        insert pElem1;
        vlocity_cmt__PricingElement__c pElem2 = [Select Id from vlocity_cmt__PricingElement__c where vlocity_cmt__PriceListId__c != null AND vlocity_cmt__CurrencyCode__c = null];

    }

    @isTest static void testBatch()
    {
        Id batchId = Database.executeBatch(new EPCPEUpdateCurrencyCode());
        System.assertNotEquals(batchId, null);
    }
}