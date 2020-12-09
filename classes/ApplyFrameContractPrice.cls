global with sharing class ApplyFrameContractPrice implements vlocity_cmt.VlocityOpenInterface{
   public Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)    {
        if (methodName.equals('priceItems')){
            return priceItems(input,output,options);
        }
        return true;
    }
     
    private Boolean priceItems(Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionsMap){
        Map<String, Object> filterEvaluatorOutput = (Map<String, Object>)inputMap.get('filterEvaluatorOutput');
        Map<Id, Sobject> sobjectIdToSobject = (Map<Id, Sobject>)filterEvaluatorOutput.get('sobjectIdToSobject');
        List<Id> qualifiedObjectIds = new List<Id>((Set <Id>)inputMap.get('qualifiedObjectIds'));
        if(qualifiedObjectIds !=null && qualifiedObjectIds.size()>0){
        	Schema.SObjectType itemObjType =  Id.valueOf(qualifiedObjectIds[0]).getSObjectType();
	   	    String itemObjName = itemObjType.getDescribe().getName();
	   	    String nameSpaceprefix = 'vlocity_cmt__'; //.ApplicationUtilities.getNameSpacePrefix();
	   	    List<Id> productIdList = new List<Id> ();	
	   	    
	   	    String parentObjName;
	   	    if(itemObjName=='OpportunityLineItem'){
	   	    	parentObjName='Opportunity';
	   	    }
	   	    else if(itemObjName=='OrderItem'){
	   	    	parentObjName='Order';
	   	    }
	   	    else if(itemObjName=='QuoteLineItem'){
	   	    	parentObjName='Quote';
	   	    }
	   	    String parentIdName = parentObjName+'Id';
	   	    Id parentId;  
	   	    
	   	    Map<Id, List<SObject>> productIdToSObject = new Map<Id, List<SObject>> ();   

	        for(Integer i = 0; i < qualifiedObjectIds.size(); i++){
	        	
	            Sobject objectSO = sobjectIdToSobject.get(qualifiedObjectIds[i]);

	            if(objectSO !=null && objectSO.getSObject('PricebookEntry') !=null){
		            Id productId = (Id)objectSO.getSObject('PricebookEntry').get('Product2Id');
		            productIdList.add(productId);
		            if(productIdToSObject.get(productId) !=null){
		            	List<SObject> itemSoList = productIdToSObject.get(productId);
		            	itemSoList.add(objectSO);
		            }
		            else{
		            	List<SObject> itemSoList = new List<SObject> ();
		            	itemSoList.add(objectSO);
		            	productIdToSObject.put(productId, itemSoList);
		            }
		            
		            parentId = (Id) objectSO.get(parentIdName);
	            }
	        }
	        if(productIdList !=null && productIdList.size()>0){
		        List<SObject> listContractLineItems = getFrameContractLineItems(productIdList, parentId, parentObjName);
		        List<SObject> lineItemSObject = new List<SObject> ();
		        if(listContractLineItems !=null && listContractLineItems.size()>0){
			        for(SObject line : listContractLineItems){
			        	 Id cLineProductId = (Id) line.get(nameSpaceprefix+'Product2Id__c');
			        	 List<SObject> oObjectSOList = productIdToSObject.get(cLineProductId);
			        	 if(oObjectSOList !=null && oObjectSOList.size()>0){
			        	 	for(SObject oObjectSO : oObjectSOList){
			        	 	
				             	oObjectSO.put(nameSpacePrefix+'OneTimeTotal__c', (Decimal) line.get(nameSpacePrefix+'OneTimeTotal__c'));
				             	oObjectSO.put(nameSpacePrefix+'OneTimeCharge__c', (Decimal) line.get(nameSpaceprefix+'OneTimeCharge__c'));	
				             	oObjectSO.put(nameSpacePrefix+'OneTimeDiscountPrice__c', (Decimal) line.get(nameSpacePrefix+'OneTimeDiscountPrice__c'));
				             	oObjectSO.put(nameSpacePrefix+'OneTimeManualDiscount__c', (Decimal) line.get(nameSpaceprefix+'OneTimeManualDiscount__c'));
				             		
				             	oObjectSO.put(nameSpacePrefix+'OverageCharge__c', (Decimal) line.get(nameSpacePrefix+'OverageCharge__c'));
				             	oObjectSO.put(nameSpacePrefix+'OverageDiscountPrice__c', (Decimal) line.get(nameSpaceprefix+'OverageDiscountPrice__c'));	
				             	oObjectSO.put(nameSpacePrefix+'OverageManualDiscount__c', (Decimal) line.get(nameSpacePrefix+'OverageManualDiscount__c'));
				             	oObjectSO.put(nameSpacePrefix+'OverageTotal__c', (Decimal) line.get(nameSpaceprefix+'OverageTotal__c'));          		
				             	oObjectSO.put(nameSpacePrefix+'OverageUOM__c', (String) line.get(nameSpacePrefix+'OverageUOM__c'));
				             	
				             	oObjectSO.put(nameSpacePrefix+'RecurringCharge__c', (Decimal) line.get(nameSpaceprefix+'RecurringCharge__c'));	
				             	oObjectSO.put(nameSpacePrefix+'RecurringDiscountPrice__c', (Decimal) line.get(nameSpacePrefix+'RecurringDiscountPrice__c'));
				             	oObjectSO.put(nameSpacePrefix+'RecurringManualDiscount__c', (Decimal) line.get(nameSpaceprefix+'RecurringManualDiscount__c'));	
				             	oObjectSO.put(nameSpacePrefix+'RecurringTotal__c', (Decimal) line.get(nameSpacePrefix+'RecurringTotal__c'));
				             	oObjectSO.put(nameSpacePrefix+'RecurringUOM__c', (String) line.get(nameSpaceprefix+'RecurringUOM__c'));	
				             	
				             	lineItemSObject.add(oObjectSO);	  
			        	 	}           	
			             }		             
			       }
			       //update lineItemSObject;
		        }
	        }
        }
        return true;
         
    }
    
    private List<SObject> getFrameContractLineItems(List<Id> productIdList, Id parentId, String parentObjName){
    	String nameSpaceprefix = 'vlocity_cmt__'; //ApplicationUtilities.getNameSpacePrefix();
    	//List<Schema.SObjectField> objfields =  ObjectDescriber.getDescribe(nameSpaceprefix+'ContractLineItem__c').getFields().values();
	   	SObjectType contractLineObj = Schema.getGlobalDescribe().get(nameSpaceprefix+'ContractLineItem__c');
        Map<String,Schema.SObjectField> objfields = contractLineObj.getDescribe().fields.getMap();
	   	String query = 'Select ';
        Boolean firstField = true;

        for (String field : objfields.keySet())
        {
            if(firstField)
            	query += field;
            else{
            	query +=' , ';
            	query += field;
            }

            firstField = false;
        }

        query += ' FROM ' + nameSpaceprefix+'ContractLineItem__c';
        
    	
    	String whereClause = ' where '+nameSpaceprefix+'Product2Id__c IN :productIdList  AND '+nameSpaceprefix+'ContractId__c In (select '+nameSpaceprefix+'frameContractId__c from '+parentObjName +' where Id= \'' +parentId+'\''+')';
        query +=whereClause;
        System.debug(' line item query is ' +query);
        List<Sobject> contractLineList = database.query(query);
        
        return contractLineList;
    }
    
}