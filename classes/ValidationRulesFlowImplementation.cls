global with sharing class ValidationRulesFlowImplementation implements vlocity_cmt.GlobalInterfaces.ProductValidationInterface {
	global Flow.Interview.ValidationRulesFlow myFlow {get; set;}
	global void validateLineItems(List<vlocity_cmt.ItemWrapper> itemsList){
		
		
		List<SObject> itemList = new List<SObject>();
		Map<Id,vlocity_cmt.ItemWrapper> masterObjectIdToItemWrapper = new Map<Id,vlocity_cmt.ItemWrapper>();
      	for(vlocity_cmt.ItemWrapper item : itemsList){
			itemList.add(item.itemSObject);
			masterObjectIdToItemWrapper.put(item.itemSObject.Id, item);
		}
		
		vlocity_cmt.FlowStaticMap.flowMap.put('itemList',itemList);	
		vlocity_cmt.FlowStaticMap.flowMap.put('parentObjectList',itemList);
		vlocity_cmt.FlowStaticMap.flowMap.put('childItemsList',itemsList);	
		vlocity_cmt.FlowStaticMap.flowMap.put('masterObjectIdToItemWrapper',masterObjectIdToItemWrapper);
		Map<String, Object> myMap = new Map<String, Object>();
		myFlow = new Flow.Interview.ValidationRulesFlow(myMap);
		try {
			myFlow.start(); 

			
		} catch (System.FlowException e){
			System.debug(LoggingLevel.ERROR,'exception::::' + e);
		}
		
		
	}
}