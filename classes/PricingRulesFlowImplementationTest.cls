@isTest(seeAllData=false)
public with sharing class PricingRulesFlowImplementationTest {
private static testMethod void testPricingRulesFlowImplementation()
    {
        Product2 product = new Product2(Name='Test Product', Description='This is a Description');
        insert product;
        Pricebook2 standardBook =  new Pricebook2(Id=Test.getStandardPricebookId(), IsActive = true, vlocity_cmt__IsDefault__c = true);
        update standardBook;
        PricebookEntry standardPricebookEntry = new PricebookEntry(Pricebook2Id =standardBook.Id , Product2Id = product.Id, UnitPrice = 100, vlocity_cmt__RecurringPrice__c = 100, IsActive = true, UseStandardPrice = false);
        insert standardPricebookEntry;
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        insert testAccount;
        Opportunity oppty = new Opportunity(Name='Test Oppty', AccountId = testAccount.Id, Pricebook2Id=standardBook.Id,
                                           StageName='Prospecting',CloseDate = System.today());
        insert oppty;
        Quote quote = new Quote();
            quote.name = 'Test Name';
            quote.OpportunityId = oppty.Id;
            quote.Pricebook2Id = standardBook.Id;
            insert quote;
        Order testOrder = new Order();
        testOrder.AccountId = testAccount.Id;   
        testOrder.Pricebook2Id = standardBook.Id;
        testOrder.Name = 'TestOrderHeader';
        testOrder.ShippingStreet = '425 Market1 Street';
        testOrder.ShippingCity = 'San Francisco';
        testOrder.ShippingState = 'CA';
        testOrder.ShippingPostalCode = '94105'; 
        testOrder.EffectiveDate = system.today();
        testOrder.Status = 'Draft';
        insert testOrder;
        
        Test.startTest();
        List<PricebookEntry> tempPbList = new List<PricebookEntry>();
        tempPbList.add(standardPricebookEntry);
        PricingRulesFlowImplementation avbImp = new PricingRulesFlowImplementation();
        avbImp.priceLineItems(testOrder,null);
        avbImp.priceLineItems(testOrder,tempPbList);
        avbImp.priceLineItems(oppty,tempPbList);
        avbImp.priceLineItems(quote,tempPbList);
        Test.stopTest();
    }
    
    
private static testMethod void effTotalsTest(){ 

        vlocity_cmt__TriggerSetup__c myTrigger = new vlocity_cmt__TriggerSetup__c(Name='AllTriggers', vlocity_cmt__IsTriggerOn__c=true);
        insert myTrigger;
         
        List<RecordType> recordType = [SELECT ID, Name, DeveloperName from RecordType where SobjectType='Account'];
        Account acct = null;
        acct = new Account (Name='Vlocity Inc');
        insert acct;
 
        ID standardPriceBookPriceBookId = Test.getStandardPricebookId();
 
        //Insert 10 products
        List<Product2> proList = new List<Product2> ();
        for (Integer i=0;i<10;i++)
        {
            Product2 product = new Product2(Name='Test Product '+i);
            proList.add(product);
        }
        insert proList;
        List<PricebookEntry> pbeList = new List<PricebookEntry> ();
        for (integer i=0; i<10; i++){
            PricebookEntry pbe1 = new PricebookEntry(Pricebook2Id=standardPriceBookPriceBookId, IsActive=true, Product2Id=proList[i].Id, UnitPrice=500 );
            pbeList.add(pbe1);

        }
        insert pbeList;
        List<Id> productIdList = new List<Id>();

        for (Product2 product: proList)
        {
            productIdList.add(product.id);
        }
        Order neworder = new Order (Name='Test order', AccountId=acct.Id, EffectiveDate=System.today(), Status='Draft',PriceBook2Id=standardPriceBookPriceBookId);
        insert neworder;
        List<OrderItem> itemList = new List<OrderItem> ();
        OrderItem item1 = new OrderItem (OrderId=newOrder.Id, Quantity=10, PriceBookEntryId=pbeList[0].Id, UnitPrice=200);
        OrderItem item2 = new OrderItem (OrderId=newOrder.Id, Quantity=20, PriceBookEntryId=pbeList[1].Id, UnitPrice=300);

        itemList.add(item1);
        itemList.add(item2);

        insert itemList;
        test.startTest();
        Map<String, Object> flowMap = new Map<String, Object>();
        flowMap.put('parent', neworder);
        flowMap.put('itemList', itemList);
        Map<String, Object> inputMap = new Map<String, Object> ();
        Map<String, Object> outputMap = new Map<String, Object> ();
        Map<String, Object> optionsMap = new Map<String, Object> ();
        inputMap.put('flowMap', flowMap); 

        Type t = Type.forName('CalculateEFFTotalAction');
        vlocity_cmt.VlocityOpenInterface vpsi = (vlocity_cmt.VlocityOpenInterface)t.newInstance();
        vpsi.invokeMethod('executeCustomAction', inputMap, outputMap, optionsMap);

        test.stopTest();
    }
    
}