global with sharing class EligibilityMatrixFlowImplementation implements vlocity_cmt.VlocityOpenInterface, vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface {
    global Flow.Interview.EligibilityMatrixFlow myFlow {get; set;}
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Boolean success = true;
        try
        {
            if (outputMap == null)                
            {
                outputMap = new Map<String, Object>();
            }
            if (methodName == 'getAllEligibilityProducts') 
            {                
                SObject header = (SObject)inputMap.get('parentItem');
                List<PricebookEntry> pricebookEntryList = (List<PricebookEntry>)inputMap.get('pricebookEntryList');
                outputMap.put('itemWrapperList', getAllEligibilityProducts(header, pricebookEntryList));         
            }
            else if (methodName == 'getEligibleProducts')
            {
                SObject header = (SObject)inputMap.get('parentItem');
                List<PricebookEntry> pricebookEntryList = (List<PricebookEntry>)inputMap.get('pricebookEntryList');
                outputMap.put('eligiblePricebookEntryList', getEligibleProducts(header, pricebookEntryList));
            }
            else if (methodName == 'implements')
            {
                outputMap.put('implements', new Set<String>{'ProductEligibilityInterface'});
            }   
        }catch(Exception e){
            success = false;
        }

        return success; 
    }

    public List<vlocity_cmt.ItemWrapper> getAllEligibilityProducts(SObject header, List<PriceBookEntry> retval)
    {
        doEligibility(header, retval);
        Map<Id, vlocity_cmt.ItemWrapper> pbMap = (Map<Id, vlocity_cmt.ItemWrapper>)vlocity_cmt.FlowStaticMap.flowMap.get('pricebookIdToItemWrapper');
        List<vlocity_cmt.ItemWrapper> pbWrappers = pbMap.values();
        List<vlocity_cmt.ItemWrapper> result = new List<vlocity_cmt.ItemWrapper>();
        for (Integer index = 0; index < retval.size(); index++)
        {
            result.add(pbMap.get(retval[index].Id));            
        }
        return result;
    }


    public List<PriceBookEntry> getEligibleProducts(SObject header, List<PriceBookEntry> retval)
    {        
        doEligibility(header, retval);
        Map<Id, vlocity_cmt.ItemWrapper> pbMap = (Map<Id, vlocity_cmt.ItemWrapper>)vlocity_cmt.FlowStaticMap.flowMap.get('pricebookIdToItemWrapper');
        List<vlocity_cmt.ItemWrapper> pbWrappers = pbMap.values();
        List<PriceBookEntry> filteredPricebookEntries = new List<PriceBookEntry>();
        for(Integer index = 0; index < pbWrappers.size(); index++){
            if(pbWrappers[index].isQualified == false)continue;
            filteredPricebookEntries.add((PricebookEntry)pbWrappers[index].itemSObject);            
        }
        return filteredPricebookEntries;
    }

    private void doEligibility(SObject header, List<PriceBookEntry> retval)
    {
        Map<Id, vlocity_cmt.ItemWrapper> pricebookIdToItemWrapper = new Map<Id, vlocity_cmt.ItemWrapper>();
        
        for(integer index = 0; index < retval.size(); index++){
            pricebookIdToItemWrapper.put(retval[index].Id, new vlocity_cmt.ItemWrapper(retval[index]));
            
        }
        
        String objectName = String.valueOf(header.getSObjectType());
        Id headerId = header.Id;
        List<Sobject> sobjectsList = new List<Sobject>();
        if(objectName == 'Order'){
            sobjectsList = [SELECT Id From OrderItem WHERE OrderId =:headerId];            
        } else if(objectName == 'Quote'){
            sobjectsList = [SELECT Id From QuoteLineItem WHERE QuoteId =:headerId];
        } else if(objectName == 'Opportunity'){
            sobjectsList = [SELECT Id From OpportunityLineItem WHERE OpportunityId =:headerId];
        }
        
        vlocity_cmt.FlowStaticMap.flowMap.put('itemList',new List<SObject>{header});  
        vlocity_cmt.FlowStaticMap.flowMap.put('parentObjectList',new List<SObject>{header});
        vlocity_cmt.FlowStaticMap.flowMap.put('childItemsList',sobjectsList);   
        vlocity_cmt.FlowStaticMap.flowMap.put('pricebookIdToItemWrapper', pricebookIdToItemWrapper);
        System.debug('pricebookIdToItemWrapper before flow ' + pricebookIdToItemWrapper);
        Map<String, Object> myMap = new Map<String, Object>();
        myMap.put('parentType', objectName);
        myFlow = new Flow.Interview.EligibilityMatrixFlow(myMap);        
        try {
            myFlow.start();             
            System.debug('pricebookIdToItemWrapper after flow ' + pricebookIdToItemWrapper);
        } catch (System.FlowException e){
            System.debug(LoggingLevel.ERROR,'exception::::' + e);
        }
    }
}