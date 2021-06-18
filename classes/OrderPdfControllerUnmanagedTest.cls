@isTest(seeAllData=false)
public with sharing class OrderPdfControllerUnmanagedTest {
private static testMethod void testOrderPdfControllerUnmanaged()
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
		OrderItem testOrderItem = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0001',
          PricebookEntryId = standardPricebookEntry.Id, Quantity = 2, UnitPrice = 22,vlocity_cmt__ProvisioningStatus__c = 'New', vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10);
        insert testOrderItem;
		Test.startTest();
		ApexPages.StandardController stdController = new ApexPages.StandardController(testOrder);
		OrderPdfControllerUnmanaged orderCtr = new OrderPdfControllerUnmanaged(stdController);
		orderCtr.savePdf();
		OrderPdfControllerUnmanaged.padSpace(4);
		Test.stopTest();
	}
}