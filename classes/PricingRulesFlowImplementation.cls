global with sharing class PricingRulesFlowImplementation implements vlocity_cmt.GlobalInterfaces.PricingInterface {
	global Flow.Interview.PricingRulesFlow myFlow {get; set;}
	global void priceLineItems(SObject parent, List<SObject> itemList) {
		if (itemList == null || itemList.isEmpty()) {
            // nothing to price
            return;
        }
		vlocity_cmt.FlowStaticMap.flowMap.put('parent',parent);
		vlocity_cmt.FlowStaticMap.flowMap.put('itemList',itemList);	
		
		Map<String, Object> myMap = new Map<String, Object>();
		
		if(parent instanceof Opportunity)MyMap.put('parentType', 'Opportunity');
		if(parent instanceof Order)MyMap.put('parentType', 'Order');
		if(parent instanceof Quote)MyMap.put('parentType', 'Quote');
		myFlow = new Flow.Interview.PricingRulesFlow(myMap);
      	
		try {
			myFlow.start(); 
			Object objMap = (Object)vlocity_cmt.FlowStaticMap.flowMap.get('sobjectIdToSobject');
            if(objMap == null) return;
            Map<Id, SObject> sobjectIdToSobject = (Map<Id, SObject>)objMap;
            integer index = 0;
            for(SObject item : itemList){
                if(sobjectIdToSobject.get(item.Id) != null){
                    itemList[index] = sobjectIdToSobject.get(item.Id);
                }
                index++;
            } 
		} catch (System.FlowException e){
			System.debug(LoggingLevel.ERROR,'exception::::' + e);
		}
		
		
	}
}