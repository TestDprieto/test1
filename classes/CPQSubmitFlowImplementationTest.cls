@isTest(seeAllData=false)
public with sharing class CPQSubmitFlowImplementationTest {
	private static testMethod void testCPQSubmitFlowImplementation()
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
		Map<String,Object> inputMap = new Map<String,Object>();
		Map<String,Object> out = new Map<String,Object>();
		inputMap.put('objectId', testOrder.Id);
		CPQSubmitFlowImplementation avbImp = new CPQSubmitFlowImplementation();
		avbImp.invokeMethod('cpqSubmit',inputMap,out,null);
		avbImp.invokeMethod('',inputMap,out,null);
		Test.stopTest();
	}

}