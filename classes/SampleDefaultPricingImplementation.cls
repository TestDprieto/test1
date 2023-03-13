global with sharing class SampleDefaultPricingImplementation  implements vlocity_cmt.GlobalInterfaces.PricingInterface {

	public void priceLineItems(SObject parent, List<SObject> lineItemList) {

	system.debug(':::enter priceLineItems');

    	String nsp =  'vlocity_cmt__';
		Set<String> priceBookEntryIDs = new Set<String>();    	

    	for (SObject item : lineItemList) {
    		priceBookEntryIDs.add(String.valueOf(item.get('PricebookEntryId')));
    	}

		// Need current prices
    	List<PricebookEntry> pbEntries = [SELECT Id, UnitPrice, vlocity_cmt__FloorPrice__c, 
    									   vlocity_cmt__RecurringPrice__c 
    									FROM PricebookEntry
    									WHERE Id IN :priceBookEntryIDs];

		Map<String,PricebookEntry> entryMap = new Map<String,PricebookEntry>();

	    for(PricebookEntry pbe: pbEntries) 
		{
			entryMap.put(pbe.Id,pbe);
		} 	
		for (SObject item : lineItemList)
	    {		

			Id pbeId = (Id)item.get('PricebookEntryId');
			
			PricebookEntry pbi = entryMap.get(pbeId);

			Decimal unitPrice = (Decimal)pbi.get('UnitPrice');
			Decimal recurPrice = (Decimal)pbi.get(nsp + 'RecurringPrice__c');
			Decimal qty = (Decimal)item.get('Quantity');
			Decimal otManDiscount = (Decimal) item.get(nsp + 'OneTimeManualDiscount__c');
			Decimal recManDiscount = (Decimal) item.get(nsp + 'RecurringManualDiscount__c');

			// Check for null values.  Shouldn't happen.
			qty = (qty != null) ? qty : 1;				
			unitPrice = (unitPrice != null) ? unitPrice : Decimal.valueOf(100000000); // Default price is expensive.
			recurPrice = (recurPrice != null) ? recurPrice : 0.0;

			otManDiscount = (otManDiscount != null) ? otManDiscount : 0.0;
			recManDiscount = (recManDiscount != null) ? recManDiscount : 0.0;

			Decimal oneTimeComputePrice = unitPrice - unitPrice * otManDiscount/100;
			Decimal oneTimeTotal = onetimeComputePrice * qty;
			
			Decimal recComputePrice = recurPrice - recurPrice * recManDiscount/100; 
			Decimal recTotal = recComputePrice * qty;
	
			item.put(nsp + 'OneTimeCharge__c', unitPrice);
			item.put(nsp + 'RecurringCharge__c', recurPrice);	 
			item.put(nsp + 'OneTimeCalculatedPrice__c', oneTimeComputePrice);	
			item.put(nsp + 'RecurringCalculatedPrice__c' , recComputePrice);
			item.put(nsp + 'RecurringTotal__c', recTotal);		
			item.put(nsp + 'OneTimeTotal__c', oneTimeTotal);

			// If discount fields were null this will update them to 0.0 
			item.put(nsp + 'OneTimeManualDiscount__c', otManDiscount);
			item.put(nsp + 'RecurringManualDiscount__c', recManDiscount);
			
		}
		
        system.debug(':::Executed SampleDefaultPricingImplementation');	
		update lineItemList;				
	}	

}