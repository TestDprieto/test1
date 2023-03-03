@isTest(seeAllData=false)
public with sharing class QuotePdfControllerUnmanagedTest {
private static testMethod void testQuotePdfControllerUnmanaged()
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
		 QuoteLineItem testLI = new QuoteLineItem();
        testLI.QuoteId = quote.Id;
        testLI.PriceBookEntryId = standardPricebookEntry.Id;
        testLI.UnitPrice = 2.00;
        testLI.vlocity_cmt__OneTimeCharge__c = 2.00;
        testLI.vlocity_cmt__RecurringCharge__c = 3.00;
        testLI.Quantity = 1;
        insert testLI;
		Test.startTest();
		ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
		QuotePdfControllerUnmanaged quoteCtr = new QuotePdfControllerUnmanaged(stdController);
		quoteCtr.savePdf();
		QuotePdfControllerUnmanaged.padSpace(5);
		Test.stopTest();
	}
}