@isTest 
private class ApplyFrameContractPricingTest {
    static testMethod void testGetFrameContract()
    {  
        vlocity_cmt__TriggerSetup__c allTrigger = new  vlocity_cmt__TriggerSetup__c(Name='AllTriggers',  vlocity_cmt__IsTriggerOn__c=true);
        insert allTrigger;
                   
         //products and pricebook and pricebookentry
        List<Product2> productList = new List<Product2>();
        List<String> productNames = new List<String>();
        Pricebook2 standardBook =  new Pricebook2(Id=Test.getStandardPricebookId(), Name = 'TestPricebook', IsActive = true);
        //Insert 10 Products
        for (Integer i=1;i<=10;i++)
        {
            String name = 'Product'+i;
            Product2 product = new Product2(Name=name, Description='This is a Description'+i);
            productList.add(product);
            productNames.add(name); 
        }
        insert productList;
        //Create a Pricebook
        Pricebook2 testPricebook = new Pricebook2(Name = 'TestPricebook', IsActive = true);
        insert testPricebook;
        //Associate Products with a Pricebook entry
        List<PricebookEntry> stdPriceBookEntryList = new List<PricebookEntry>();
        productList = new List<Product2>();
        productList = [Select Id,Name from Product2 where Name IN :productNames];
        Integer j=1;
        for (Product2 product: productList)
        {           
            PricebookEntry standardPricebookEntry = new PricebookEntry(Pricebook2Id = standardBook.Id,
            Product2Id = product.Id, UnitPrice = j*2, vlocity_cmt__RecurringPrice__c = j*17, IsActive = true, UseStandardPrice = false);
            stdPriceBookEntryList.add(standardPricebookEntry);
            j++;
        }
        insert stdPriceBookEntryList;
                                                                                                                                  
        //account
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        insert testAccount;
        
        //Insert Opportunity and Line Item
         Opportunity testOpp = new Opportunity(Name ='testOpp',
                                                AccountId = testAccount.Id,
                                                StageName = 'test stage',
                                                CloseDate = Date.today(),
                                                Pricebook2Id = testPricebook.Id);
                                                
        insert testOpp;
        
        Quote testQuote = new Quote(Name='TestQuote',Pricebook2Id = standardBook.Id, OpportunityId=testOpp.Id );
        insert testQuote;
        List<QuoteLineItem> quoteItemList = new List<QuoteLineItem>();
        Integer i=1;
        for (PricebookEntry wrapper: stdPriceBookEntryList)
        {
            QuoteLineItem qItem = new QuoteLineItem(QuoteId=testQuote.Id, PricebookEntryId = wrapper.Id, Quantity = 1, vlocity_cmt__OneTimeTotal__c = 100, vlocity_cmt__RecurringTotal__c=200, UnitPrice=100);
            quoteItemList.add(qItem);
            i++;
            if (i>5)
                break;
        }
        insert quoteItemList;
        
        List<QuoteLineItem> quoteItemsAfter = [Select Id, QuoteId, PricebookEntry.Product2Id, Quantity, vlocity_cmt__OneTimeTotal__c, vlocity_cmt__RecurringTotal__c, UnitPrice from QuoteLineItem where QuoteId=:testQuote.Id ];
        
        //Insert Order and Order Line Items
        Order orders = new Order(Name='Test Order',EffectiveDate=System.today(),status='Draft',AccountId = testAccount.Id, Pricebook2Id=Test.getStandardPricebookId());
        insert orders;
        
        Contract cont1 = new Contract(Name='c1', StartDate=System.today().addDays(-10), Status='Draft', AccountId=testAccount.Id, vlocity_cmt__IsFrameContract__c=true);
        Contract cont2 =  new Contract(Name='c1', StartDate=System.today().addDays(+10), Status='Draft', AccountId=testAccount.Id, vlocity_cmt__IsFrameContract__c=true);
        Contract cont3 =  new Contract(Name='c1', StartDate=System.today().addDays(-10), Status='Draft', AccountId=testAccount.Id, vlocity_cmt__IsFrameContract__c=false);
        List<Contract> listContract = new List<Contract> ();
        listContract.add(cont1);
        listContract.add(cont2);
        listContract.add(cont3);
        insert listContract;
        
        testQuote.vlocity_cmt__FrameContractId__c = listContract[0].Id;
        update testQuote;

        test.startTest();
       
        List<vlocity_cmt__ContractLineItem__c> contractItemList = new List<vlocity_cmt__ContractLineItem__c>();
        i=1;
        for (PricebookEntry wrapper: stdPriceBookEntryList)
        {
            vlocity_cmt__ContractLineItem__c cItem = new vlocity_cmt__ContractLineItem__c(vlocity_cmt__ContractId__c=listContract[0].Id, vlocity_cmt__PricebookEntryId__c = wrapper.Id,vlocity_cmt__Product2Id__c=wrapper.Product2Id, vlocity_cmt__Quantity__c = 1, vlocity_cmt__OneTimeTotal__c = 1000, vlocity_cmt__RecurringTotal__c=2000);
            contractItemList.add(cItem);
            i++;
            if (i>5)
                break;
        }
        insert contractItemList;
                      
        
        String className='ApplyFrameContractPrice';
        //String nameSpaceprefix = 'vlocity_cmt__';
        Type classType = Type.forName(className);
        
        if(classType !=null){             
              Map<String, Object> inputMap = new Map<String, Object> ();
              Map<String, Object> outputMap = new Map<String, Object> ();
              Map<String, Object> options = new Map<String, Object> ();
              vlocity_cmt.VlocityOpenInterface vpsi = (vlocity_cmt.VlocityOpenInterface)classType.newInstance();   
              Map<Id, Sobject> sobjectIdToSobject = new Map<Id, Sobject> ();
              sobjectIdToSobject.put(quoteItemsAfter[0].Id, quoteItemsAfter[0]);
              sobjectIdToSobject.put(quoteItemsAfter[1].Id, quoteItemsAfter[1]);   
              Map<String, Object>  filterEvaluatorOutput = new Map<String, Object> ();
              filterEvaluatorOutput.put('sobjectIdToSobject', sobjectIdToSobject);
              
              inputMap.put('filterEvaluatorOutput', filterEvaluatorOutput); 
              Set<Id> qualifiedObjectIds = new Set<Id>();
              qualifiedObjectIds.add(quoteItemsAfter[0].Id);
              qualifiedObjectIds.add(quoteItemsAfter[1].Id);
              inputMap.put('qualifiedObjectIds', qualifiedObjectIds);
              vpsi.invokeMethod('priceItems',inputMap, outputMap, options);
              
              System.assertEquals(quoteItemsAfter[0].vlocity_cmt__RecurringTotal__c, 2000);
        }
        
        test.stopTest();
    }
}