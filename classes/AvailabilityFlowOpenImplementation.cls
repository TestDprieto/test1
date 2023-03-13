global with sharing class AvailabilityFlowOpenImplementation implements vlocity_cmt.VlocityOpenInterface {
	global Flow.Interview.AvailabilityRulesFlow myFlow {get; set;}
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Boolean success = true;
        try
        {
            if (outputMap == null)                
            {
                outputMap = new Map<String, Object>();
            }
            if (methodName == 'getAllAvailabilityProducts') 
            {                
                doAvailability(inputMap, outputMap, true);
            }
            else if (methodName == 'getAvailableProducts')
            {
                doAvailability(inputMap, outputMap, false);
            }
            else if (methodName == 'implements')
            {
                outputMap.put('implements', new Set<String>{'ProductAvailabilityOpenInterface'});
            }   
        }catch(Exception e){
            success = false;
            outputMap.put('error', e.getMessage());
            outputMap.put('itemWrapperList', new List<vlocity_cmt.ItemWrapper>()); 
        }
        return success; 
    }

    private void doAvailability(Map<String,Object> inputMap, Map<String,Object> outputMap, Boolean returnAll) 
    {
        SObject item = (SObject)inputMap.get('parentItem');
        List<PriceBookEntry> pricebookEntryList = (List<PricebookEntry>)inputMap.get('pricebookEntryList');
        Map<Id, vlocity_cmt.ItemWrapper> pricebookIdToItemWrapper = new Map<Id, vlocity_cmt.ItemWrapper>();
        
        for(integer index = 0; index < pricebookEntryList.size(); index++){
            pricebookIdToItemWrapper.put(pricebookEntryList[index].Id, new vlocity_cmt.ItemWrapper(pricebookEntryList[index]));
            
        }
        
        String objectName = String.valueOf(item.getSObjectType());
        Id headerId = item.Id;
        List<Sobject> sobjectsList = new List<Sobject>();
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
        myFlow = new Flow.Interview.AvailabilityRulesFlow(myMap);
        
        try {
            myFlow.start(); 
            Map<Id, vlocity_cmt.ItemWrapper> pbMap = (Map<Id, vlocity_cmt.ItemWrapper>)vlocity_cmt.FlowStaticMap.flowMap.get('pricebookIdToItemWrapper');
            List<vlocity_cmt.ItemWrapper> pbWrappers = pbMap.values();
            List<vlocity_cmt.ItemWrapper> result;
            if (returnAll) {
                result = new List<vlocity_cmt.ItemWrapper>(pbWrappers);
            }
            else {
                result = new List<vlocity_cmt.ItemWrapper>();
                for(Integer index = 0; index < pbWrappers.size(); index++){
                    if(pbWrappers[index].isQualified == false)continue;
                    result.add(pbWrappers[index]);            
                }
            }
            outputMap.put('itemWrapperList', result);
        } catch (System.FlowException e){
            System.debug(LoggingLevel.ERROR,'exception::::' + e);
            outputMap.put('error', e.getMessage());
            outputMap.put('itemWrapperList', new List<vlocity_cmt.ItemWrapper>()); 
        }
    }
}