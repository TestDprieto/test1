global with sharing class EligibilityRulesFlowImplementation implements vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface {
	global Flow.Interview.EligibilityRulesFlow myFlow {get; set;}
	
	global List<PriceBookEntry> getEligibleProducts(SObject item, List<PriceBookEntry> retval){
		
		Map<Id, vlocity_cmt.ItemWrapper> pricebookIdToItemWrapper = new Map<Id, vlocity_cmt.ItemWrapper>();
		
		for(integer index = 0; index < retval.size(); index++){
			pricebookIdToItemWrapper.put(retval[index].Id, new vlocity_cmt.ItemWrapper(retval[index]));
			
		}
		
		String objectName = String.valueOf(item.getSObjectType());
		//run eligibility against children
		Id headerId = item.Id;
		List<Sobject> sobjectsList = new List<Sobject>();
		//TODO change to a dynamic query
		if(objectName == 'Order'){
			sobjectsList = [SELECT Id From OrderItem WHERE OrderId =:headerId];
			
		} else if(objectName == 'Quote'){
			sobjectsList = [SELECT Id From QuoteLineItem WHERE QuoteId =:headerId];
		} else if(objectName == 'Opportunity'){
			sobjectsList = [SELECT Id From OpportunityLineItem WHERE OpportunityId =:headerId];
		}
		
		vlocity_cmt.FlowStaticMap.flowMap.put('itemList',new List<SObject>{item});	
		vlocity_cmt.FlowStaticMap.flowMap.put('parentObjectList',new List<SObject>{item});
		vlocity_cmt.FlowStaticMap.flowMap.put('childItemsList',sobjectsList);	
		vlocity_cmt.FlowStaticMap.flowMap.put('pricebookIdToItemWrapper', pricebookIdToItemWrapper);
		Map<String, Object> myMap = new Map<String, Object>();
		myFlow = new Flow.Interview.EligibilityRulesFlow(myMap);
      	
		try {
			myFlow.start(); 
			Map<Id, vlocity_cmt.ItemWrapper> pbMap = (Map<Id, vlocity_cmt.ItemWrapper>)vlocity_cmt.FlowStaticMap.flowMap.get('pricebookIdToItemWrapper');
			List<vlocity_cmt.ItemWrapper> pbWrappers = pbMap.values();
			List<PriceBookEntry> filteredPricebookEntries = new List<PriceBookEntry>();
			for(Integer index = 0; index < pbWrappers.size(); index++){
				if(pbWrappers[index].isQualified == false)continue;
				filteredPricebookEntries.add((PricebookEntry)pbWrappers[index].itemSObject);
					
			}
		
			return filteredPricebookEntries;
		} catch (System.FlowException e){
			System.debug(LoggingLevel.ERROR,'exception::::' + e);
			return null;
		}
		
		
	}
}