@isTest(seeAllData=false)
public with sharing class AvailabilityRulesFlowImplementationTest {
private static testMethod void testAvailabilityRulesFlowImplementation()
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
		AvailabilityRulesFlowImplementation avbImp = new AvailabilityRulesFlowImplementation();
		avbImp.getAvailableProducts(testOrder,tempPbList);
		avbImp.getAvailableProducts(oppty,tempPbList);
		avbImp.getAvailableProducts(quote,tempPbList);
		Test.stopTest();
	}
}