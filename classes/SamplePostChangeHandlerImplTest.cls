@isTest(seeAllData=false)
public with sharing class SamplePostChangeHandlerImplTest {
	
	private static testMethod void testPostChange(){
		
		//creating Data (Account)
		Account testAccount = new Account();
		testAccount.Name = 'TestAccount';
		insert testAccount;
		
		Product2 testProductPlain = new Product2(Name = 'ProductPlain', ProductCode='INT-209');
		insert testProductPlain;
		Product2 testProductZip = new Product2(Name = 'ProductZip', ProductCode='SET-UP');
		insert testProductZip;
		Product2 testProductState = new Product2(Name = 'ProductState', ProductCode='NFL-');
		insert testProductState;
		
		//Get Standard Pricebook should exist in every org
		Pricebook2 standardBook =  new Pricebook2(Id=Test.getStandardPricebookId(), Name = 'TestPricebook', IsActive = true);		
		//Create a Pricebook
		Pricebook2 testPricebook = new Pricebook2(Name = 'TestPricebook', IsActive = true);
		insert testPricebook;
			
		//Create Standard Pricebook Entries
		PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardBook.Id,
			Product2Id = testProductPlain.Id, UnitPrice = 10, IsActive = true, UseStandardPrice = false, vlocity_cmt__RecurringPrice__c=10);
		insert standardPrice;
		PricebookEntry standardPriceZip = new PricebookEntry(Pricebook2Id = standardBook.Id,
			Product2Id = testProductZip.Id, UnitPrice = 20, IsActive = true, UseStandardPrice = false, vlocity_cmt__RecurringPrice__c=10);
		insert standardPriceZip;
		PricebookEntry standardPriceState = new PricebookEntry(Pricebook2Id = standardBook.Id,
			Product2Id = testProductState.Id, UnitPrice = 30, IsActive = true, UseStandardPrice = false, vlocity_cmt__RecurringPrice__c=10);
		insert standardPriceState;
		
		//Create PricebookEntries
		PricebookEntry testPricebookEntryPlain = new PricebookEntry(Pricebook2Id = testPricebook.Id,
			Product2Id = testProductPlain.Id, UnitPrice = 11, IsActive = true, UseStandardPrice = false, vlocity_cmt__RecurringPrice__c=10);
		insert testPricebookEntryPlain;
		PricebookEntry testPricebookEntryZip = new PricebookEntry(Pricebook2Id = testPricebook.Id,
			Product2Id = testProductZip.Id, UnitPrice = 22, IsActive = true, UseStandardPrice = false, vlocity_cmt__RecurringPrice__c=10);
		insert testPricebookEntryZip;
		PricebookEntry testPricebookEntryState = new PricebookEntry(Pricebook2Id = testPricebook.Id,
			Product2Id = testProductState.Id, UnitPrice = 33, IsActive = true, UseStandardPrice = false, vlocity_cmt__RecurringPrice__c=10);
		insert testPricebookEntryState;
		
		// Create Order header	
		Order testOrder = new Order();
		testOrder.AccountId = testAccount.Id;	
		testOrder.Pricebook2Id = testPricebook.Id;
		testOrder.Name = 'TestOrderHeader';
		testOrder.EffectiveDate = system.today();
		testOrder.Status = 'Draft';
		insert testOrder;
		
		OrderItem testOrderItem1 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0001',
			PricebookEntryId = testPricebookEntryPlain.Id, Quantity = 5, UnitPrice = 100,vlocity_cmt__ProvisioningStatus__c = 'New' , 
			vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10, vlocity_cmt__ServiceAccountId__c = testAccount.Id,
			vlocity_cmt__BillingAccountId__c = testAccount.Id);
		insert testOrderItem1;
		OrderItem testOrderItem2 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0002',
			PricebookEntryId = testPricebookEntryZip.Id, Quantity = 100, UnitPrice = 200,vlocity_cmt__ProvisioningStatus__c = 'New' , 
			vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10);
		insert testOrderItem2;
		OrderItem testOrderItem3 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0003',
			PricebookEntryId = testPricebookEntryState.Id, Quantity = 10, UnitPrice = 300,vlocity_cmt__ProvisioningStatus__c = 'New', 
			vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
		insert testOrderItem3;
		List<OrderItem> liList = new List<OrderItem>();
		liList.add(testOrderItem1);
		liList.add(testOrderItem2);
		liList.add(testOrderItem3);

		//starting actual test
		Test.startTest();
		SamplePostChangeHandlerImplementation tecloImp = new SamplePostChangeHandlerImplementation();
		String methodName = 'postChangeForOrder';
		Map<String, Object> input = new Map<String, Object>();
		input.put('createdObjectId', testOrder.Id);
		tecloImp.invokeMethod(methodName, input, null, null);
		List<Order> updatedOrder = [SELECT Id, Name, vlocity_cmt__TrackingNumber__c FROM Order WHERE Id = :testOrder.Id];
		Order ord;
		if(updatedOrder != null){
			ord = updatedOrder[0];
		}
		String trackingNum = (String)ord.get('vlocity_cmt__TrackingNumber__c');
		if(trackingNum != null)
			System.assertEquals(trackingNum, '1000000', 'Tracking num doesnt match');
		Test.stopTest();
	}
}