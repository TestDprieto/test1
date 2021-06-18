global with sharing class CalculateEFFTotalAction implements vlocity_cmt.VlocityOpenInterface{
    SObjectType lineItemTypeForPage = null;
    public Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)  {
        if (methodName.equals('executeCustomAction')){
            return executeCustomAction(input,output,options);
        }
        return true;
    }
    
    private Boolean executeCustomAction(Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionsMap){
        Map<String,Object> flowMap = (Map<String,Object>)inputMap.get('flowMap');
        String nsp = 'vlocity_cmt__';
        List<Sobject> itemList = (List<SObject>)flowMap.get('itemList');
        SObject parent = (SObject)flowMap.get('parent');
    List<Sobject> itemsToupdate = new List<Sobject>();
        lineItemTypeForPage = itemList[0].Id.getSObjectType();
        
        try{
            
        Map<Id, Object> itemIdToItem = new Map<Id, Object>();

        for (SObject item : itemList) {
          itemIdToItem.put(item.Id, item);
        }
        
                itemsToupdate = getLineItems(itemIdToItem.keyset());
        for (SObject item : itemsToupdate) {
          Decimal effQuant = calculateEffectiveQuantity(item, itemIdToItem);
          Decimal oneTimeComputePrice = (Decimal)item.get(nsp + 'OneTimeCalculatedPrice__c');   
          Decimal recComputePrice = (Decimal)item.get(nsp + 'RecurringCalculatedPrice__c'); 
          Decimal effOneTimeTotalPrice = effQuant * oneTimeComputePrice;
          Decimal effRecTotalPrice = effQuant * recComputePrice;

          item.put(nsp + 'EffectiveQuantity__c', effQuant); 
          item.put(nsp + 'EffectiveRecurringTotal__c', effRecTotalPrice);       
          item.put(nsp + 'EffectiveOneTimeTotal__c', effOneTimeTotalPrice);
        }

                update itemsToupdate;
      } catch (Exception e){
        System.debug(LoggingLevel.ERROR, e);
      }
            return true;
        
    }
  
  
  private Decimal calculateEffectiveQuantity(SObject item, Map<Id, Object> itemIdToItem){
        String nsp = 'vlocity_cmt__';
        Decimal effectiveQuant;
        if(item.get(nsp + 'ParentItemId__c') != null) {
            Id parId = (Id)item.get(nsp + 'ParentItemId__c');
            Decimal quant = (Decimal)item.get('Quantity');
            effectiveQuant = quant * calculateEffectiveQuantity((SObject)itemIdToItem.get(parId), itemIdToItem);
            return effectiveQuant;
        }
        return (Decimal)item.get('Quantity');
    }
  
  private List<SObject> getLineItems(Set<Id> itemIds){
      String nsp = 'vlocity_cmt__';
      if(itemIds != null && itemIds.size() > 0){
        String query = 'Select Id, Quantity,' +
                        nsp + 'ParentItemId__c,' +
                        nsp+'OneTimeCalculatedPrice__c,' +
                        nsp+'RecurringCalculatedPrice__c ' +
                        ' FROM ' + lineItemTypeForPage + ' WHERE Id IN :itemIds';
        List<SObject> lineItems = Database.query(query);
        return lineItems;
      }
      return null;
  }
  
}