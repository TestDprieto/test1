@isTest(seeAllData=false)
public with sharing class ValidationRulesFlowImplementationTest {
private static testMethod void testValidationRulesFlowImplementation()
	{
		
		 // Create Products
        Product2 p1 = new Product2(Name='Medical PPO 200');
        Product2 p2 = new Product2(Name='Medical PPO 300');
        Product2 p3 = new Product2(Name='Dental PPO 200');
        Product2 p4 = new Product2(Name='Vision PPO 200');
        List<Product2> prodList = new List<Product2> ();
        prodList.add(p1);
        prodList.add(p2);
        prodList.add(p3);
        prodList.add(p4);
        insert prodList;
        // Create Price book and Price book entries
        Pricebook2 standardBook =  new Pricebook2(Id=Test.getStandardPricebookId(), Name = 'StandardPricebook', IsActive = true);
      
        Pricebook2 testPricebook = new Pricebook2(Name = 'TestPricebook', IsActive = true);
        insert testPricebook;
        
        // Create Pricebook entries
        List<PricebookEntry> stdpbEntryList = new List<PricebookEntry>();
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p1.Id, UnitPrice = 10, IsActive = true, UseStandardPrice = false));
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p2.Id, UnitPrice = 20, IsActive = true, UseStandardPrice = false));
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p3.Id, UnitPrice = 30, IsActive = true, UseStandardPrice = false));
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p4.Id, UnitPrice = 40, IsActive = true, UseStandardPrice = false));

        insert stdpbEntryList;
        
        List<PricebookEntry> testpbEntryList = new List<PricebookEntry>();
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p1.Id, UnitPrice = 11, IsActive = true, UseStandardPrice = false));
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p2.Id, UnitPrice = 22, IsActive = true, UseStandardPrice = false));
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p3.Id, UnitPrice = 33, IsActive = true, UseStandardPrice = false));
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p4.Id, UnitPrice = 44, IsActive = true, UseStandardPrice = false));

        insert testpbEntryList;
        /*
		PricebookEntry standardPricebookEntry = new PricebookEntry(Pricebook2Id =standardBook.Id , Product2Id = product.Id, UnitPrice = 100, IsActive = true, UseStandardPrice = false);
		insert standardPricebookEntry;
		*/
		Account testAccount = new Account();
		testAccount.Name = 'Test Account';
		insert testAccount;
		
		Order testOrder = new Order();
        testOrder.AccountId = testAccount.Id; 
        testOrder.Pricebook2Id = testPricebook.Id;
        testOrder.Name = 'TestOrderHeader';
        testOrder.EffectiveDate = system.today();
        testOrder.Status = 'Draft';
        testOrder.ShippingPostalCode = '94549';
        testOrder.ShippingState = 'NY';
        insert testOrder;
        
        List<OrderItem> orderItems = new List<OrderItem>();
        
        // Add P2 to Order
        OrderItem testOrderItem2 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0001',
          PricebookEntryId = testpbEntryList[1].Id, Quantity = 2, UnitPrice = 22,vlocity_cmt__ProvisioningStatus__c = 'New', vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10);
        orderItems.add(testOrderItem2);
        
        
        // Add P3 to Order
        OrderItem testOrderItem3 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0002',
          PricebookEntryId = testpbEntryList[2].Id, Quantity = 3, UnitPrice = 33,vlocity_cmt__ProvisioningStatus__c = 'InProgress', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
        orderItems.add(testOrderItem3);
        
        // Add P4 to Order
        OrderItem testOrderItem4 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0003',
          PricebookEntryId = testpbEntryList[3].Id, Quantity = 4, UnitPrice = 44,vlocity_cmt__ProvisioningStatus__c = 'Active', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
        orderItems.add(testOrderItem4);
        
        insert orderItems;
         List<ID> orderItemIds = new List<ID>();
        for (OrderItem orderItem : orderItems) {    
            orderItemIds.add(orderItem.Id);
        }
         List<SObject> sObjectList = [SELECT Id, OrderId, PricebookEntryId, PricebookEntry.Product2Id , vlocity_cmt__LineNumber__c, Quantity, UnitPrice, vlocity_cmt__ProvisioningStatus__c, vlocity_cmt__RecurringManualDiscount__c,  vlocity_cmt__OneTimeManualDiscount__c FROM OrderItem WHERE Id IN :orderItemIds];

        // Create ItemWrappers
        List<vlocity_cmt.ItemWrapper> itemWrapperList = new List<vlocity_cmt.ItemWrapper>();
		for (SObject sObj : sObjectList) {
           itemWrapperList.add(new vlocity_cmt.ItemWrapper(sObj));
        }
      
        ValidationRulesFlowImplementation bfi = new ValidationRulesFlowImplementation();
        Test.startTest();
		 bfi.validateLineItems(itemWrapperList);
		Test.stopTest();
	}
}