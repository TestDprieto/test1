global class BestFitImplementation implements vlocity_cmt.VlocityOpenInterface {

    public static  Set<String> reparentableStatuses = new Set<String> { 'New',   'Pending' };
    static   String nsp = 'vlocity_cmt__';

    global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)  {


        if (methodName.equals('executeCustomAction')) {
            System.debug('BEST FIT  ______________________________');

            return bestFit(input, output, options);
        }
        return false;
    }

    public Boolean bestFit(Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionsMap) {



        Map<String, Object> flowMap = (Map<String, Object>)inputMap.get('flowMap');
        if (flowMap.get('itemList') == null) {
            return false;
        }

        Map<Id, vlocity_cmt.ItemWrapper> masterObjectIdToItemWrapper = (Map<Id, vlocity_cmt.ItemWrapper>)flowMap.get('masterObjectIdToItemWrapper');
        List<Sobject> itemlist = (List<Sobject>)inputMap.get('itemList');

        /**************************** GET BEST FIT based on package defintion ****************************/
        try {

            Id objectId =  masterObjectIdToItemWrapper.values()[0].getParentId();
            String message;

            Set<Id> currentProducts = new Set<Id>();
            //Maintains all the products in the cart instead of only unique products which the previous implementation was maintaining 
            Map<String,Id> allProducts = new Map<String,Id>();

            //get LI from itemList with ProvisioningStatus in reparentableStatuses
            for (vlocity_cmt.ItemWrapper item : masterObjectIdToItemWrapper.values()) {
            	/*Commenting this as now all children line items to add more than 1 best fit packages
            	which was not supported previously*/ 
            	/*
                if (item.lineNumber != null && item.lineNumber.split('\\.').size() >2 )
                    return false;
                */    
                if (reparentableStatuses.contains((String)item.itemSObject.get(nsp + 'ProvisioningStatus__c'))) {
                    currentProducts.add((Id)item.itemSObject.getSobject('PriceBookEntry').get('Product2Id'));
                    allProducts.put((String)item.itemSObject.get(nsp + 'LineNumber__c'),(Id)item.itemSObject.getSobject('PriceBookEntry').get('Product2Id'));
                }
            }

            vlocity_cmt.ProductListUtility prodUtil = new vlocity_cmt.ProductListUtility(objectId);

            Set<Id> validProductIds = new Set<Id>();

            //getProducts() runs Availability and Eligibility.  Add to validProductIds
            List<vlocity_cmt.ProductWrapper> productsWithEligibility = prodUtil.getProducts();

            for (vlocity_cmt.ProductWrapper wrap : productsWithEligibility) {
                validProductIds.add(wrap.productId);
            }


            List<vlocity_cmt__ProductChildItem__c> childProducts = [SELECT vlocity_cmt__ChildProductId__c, vlocity_cmt__ParentProductId__c
                    FROM vlocity_cmt__ProductChildItem__c
                    WHERE vlocity_cmt__ChildProductId__c in :currentProducts AND vlocity_cmt__ParentProductId__c in :validProductIds];

            Set<Id> potentialParents = new Set<Id>();

            // get potential parents for all child items in the current LI list
            for (vlocity_cmt__ProductChildItem__c child : childProducts) {
                potentialParents.add(child.vlocity_cmt__ParentProductId__c);
            }


            List<vlocity_cmt__ProductChildItem__c> allChildProductsForPotentialParents = [SELECT
                    vlocity_cmt__ChildProductId__c, vlocity_cmt__ParentProductId__c, vlocity_cmt__Quantity__c
                    FROM vlocity_cmt__ProductChildItem__c WHERE vlocity_cmt__ParentProductId__c in :potentialParents 
                    AND vlocity_cmt__IsRootProductChildItem__c = false ];
            //Bundle can contain a bundle
            //    AND ChildProductId__r.Type__c != 'Product Bundle' ];
            system.debug(':::allChildProducts: ' + allChildProductsForPotentialParents);

            Map<Id, Set<Id>> parentsToChildren = new Map<Id, Set<Id>>();

            for (vlocity_cmt__ProductChildItem__c child : allChildProductsForPotentialParents) {
                if (!parentsToChildren.containsKey(child.vlocity_cmt__ParentProductId__c)) {
                    parentsToChildren.put(child.vlocity_cmt__ParentProductId__c, new Set<Id>());
                }

                parentsToChildren.get(child.vlocity_cmt__ParentProductId__c).add(child.vlocity_cmt__ChildProductId__c);
            }


            //get the highestMatchId from the all the line items in the cart which will be used to do a best fit
			Id highestMatchId = getHighestMatchId(allProducts, parentsToChildren);
			//get the active pricebookid
			Id activePricebookId = (Id) masterObjectIdToItemWrapper.values()[0].itemSObject.getSobject('PriceBookEntry').get('Pricebook2Id');
			
			//the highestMatchId can be checked for availability and eligibility criteria 
            
			//the list contains the line items that should be used for best fit
			List<String> itemsToBeCombined = bestFitLineItems(highestMatchId,objectId, activePricebookId);


            if (highestMatchId == null) {

                Id currentBundleParent;

                for (vlocity_cmt.ItemWrapper obj : masterObjectIdToItemWrapper.values()) {

                    // get the current bundle parent.  Product2.Type__c must be 'Product Bundle'.
                    // might not work if child items are bundles
                    if (currentBundleParent == null && obj.itemSObject.getSobject('PriceBookEntry').getSobject('Product2').get(nsp + 'Type__c') == 'Product Bundle') {
                        currentBundleParent = obj.getId();
                        system.debug(':::currentBundleParent in if: ' + currentBundleParent);
                    }
                }
                Id pricebookId = (Id) masterObjectIdToItemWrapper.values()[0].itemSObject.getSobject('PriceBookEntry').get('Pricebook2Id');

                List<PricebookEntry> entry = [SELECT Id FROM PricebookEntry
                                              WHERE PriceBook2Id = :pricebookId AND Product2Id = : highestMatchId LIMIT 1];

                if (currentBundleParent == null || currentBundleParent == entry[0].Id) {
                    return  false;
                }

                vlocity_cmt.ProductLineItemActionParam productLineItemActionParam = new vlocity_cmt.ProductLineItemActionParam();
                productLineItemActionParam.action = 'Unparent';
                productLineItemActionParam.lineItemId = currentBundleParent;
                productLineItemActionParam.parentId = objectId;
                vlocity_cmt.ProductLineItemEventHandler productLineItemEventHandler = new vlocity_cmt.ProductLineItemEventHandler();
                // productLineItemEventHandler.handleLineItemAction(productLineItemActionParam);
                message = productLineItemEventHandler.handleLIAction(productLineItemActionParam);
            } else if (itemsToBeCombined.size() > 1) {
            	

                Id pricebookId = (Id) masterObjectIdToItemWrapper.values()[0].itemSObject.getSobject('PriceBookEntry').get('Pricebook2Id');

                List<PricebookEntry> entry = [SELECT Id FROM PricebookEntry
                                              WHERE PriceBook2Id = :pricebookId AND Product2Id = : highestMatchId LIMIT 1];
                vlocity_cmt.ProductLineItemActionParam productLineItemActionParam = new vlocity_cmt.ProductLineItemActionParam();
                productLineItemActionParam.action = 'MakeParent';
                productLineItemActionParam.priceBookEntryId = entry[0].Id;  // pbe for highestMatchId
                productLineItemActionParam.parentId = objectId;
                system.debug(':::productLineItemActionParam : ' + productLineItemActionParam);
                vlocity_cmt.ProductLineItemEventHandler productLineItemEventHandler = new vlocity_cmt.ProductLineItemEventHandler();
                //productLineItemEventHandler.handleLineItemAction(productLineItemActionParam);
                message = productLineItemEventHandler.handleLIAction(productLineItemActionParam);
            }

            /******************************************************************************************************************/

        } catch (Exception e) {
            System.debug('BEST FIT ERROR:::' + e);
        }
        return true;

    }
    
    private static List<String> bestFitLineItems(Id highestMatchId, Id objectId, Id pricebookId){
    	
    	SObjectType lineItemTypeForPage = null;
    	SObjectType parentObjectTypeForPage = objectId.getSObjectType();
        
        if (parentObjectTypeForPage == Order.SObjectType)
        {
            lineItemTypeForPage = OrderItem.SObjectType;            
        }
        else if (parentObjectTypeForPage == Quote.SObjectType)
        {
            lineItemTypeForPage = QuoteLineItem.SObjectType;
        }
        else if (parentObjectTypeForPage == Opportunity.SObjectType)
        {
            lineItemTypeForPage = OpportunityLineItem.SObjectType;          
        }

        List<PricebookEntry> entry = [SELECT Id FROM PricebookEntry
                                              WHERE PriceBook2Id = :pricebookId AND Product2Id = : highestMatchId LIMIT 1];
             
        //get all the line items in the cart                                      
    	List<SObject> allItemsUpdated = Database.query('SELECT Id, vlocity_cmt__ProvisioningStatus__c, Quantity, PricebookEntryId, vlocity_cmt__LineNumber__c '
        	+ 'FROM ' + lineItemTypeForPage + ' WHERE ' + objectId.getSObjectType() + 'Id = \'' 
        	+ objectId + '\' ORDER BY '+nsp+'LineNumber__c' + ' DESC NULLS FIRST');        	
        
        //get all the pricebookentires for the children of the highestMatchId product
        Set<Id> pbEntries = getChildrenPBE(entry[0].Id, highestMatchId,pricebookId);
        return lineItemsToCombine(pbEntries, allItemsUpdated);
        	
    }
    
    private static Set<Id> getChildrenPBE(Id pricebookEntryId, Id highestMatchProdId,Id pricebookId){
    	List<vlocity_cmt__ProductChildItem__c> childItems = [SELECT Id, vlocity_cmt__ChildProductId__c,
		                                        vlocity_cmt__ChildLineNumber__c, vlocity_cmt__Quantity__c
		                                        FROM vlocity_cmt__ProductChildItem__c
		                                        WHERE vlocity_cmt__ParentProductId__c = :highestMatchProdId];
		//get the PriceBookEntryid's for each of the childitem 
		List<Id> priceBookEntryIds = new List<Id>();
		List<String> childProductIds = new LIST<String>();
		for (vlocity_cmt__ProductChildItem__c pbi : childItems) {
			childProductIds.add(pbi.vlocity_cmt__ChildProductId__c);
		}
		List<PriceBookEntry> pbEntries = [SELECT Id
		                                  FROM PriceBookEntry
		                                  WHERE Product2Id in :childProductIds
		                                  and Pricebook2Id = :pricebookId]; 
		for (PriceBookEntry pbe : pbEntries) {
			priceBookEntryIds.add(pbe.Id);
		}               
		                                          
		 Set<Id> priceBookEntryIdSet = new Set<Id>(priceBookEntryIds);                                 
		 return  priceBookEntryIdSet; 	                                        
    }
    
    private static List<String> lineItemsToCombine(Set<Id> pbEntries, List<SObject> allItemsUpdated){
    	
        Map<String,Id> allProducts = new Map<String,Id>();
    	for(SObject item : allItemsUpdated){
    		allProducts.put((String)item.get( nsp + 'LineNumber__c'),
    						(Id)item.get('PricebookEntryId'));
    	}
    	List<String> itemsToBeCombined = new List<String>();
    	Map<String,Integer> items = new Map<String,Integer>(); 
    	List<String> toBeDeleted = new List<String>();
    	Integer noOfChildren = 0;
    	for(SObject item : allItemsUpdated){
    		//check if the current line item pricebookid is to be added
    		if(pbEntries.contains((Id)item.get('PricebookEntryId'))){
    			//check if the parent of this is null
    			//then the lineitem can be a potential item to combine    		
    			String lineNumber = (String)item.get( nsp +'LineNumber__c');
            	List<String> lineNumArray = lineNumber.split('\\.');
        		toBeDeleted = new List<String>();
            	noOfChildren = 0;
            	//then the parent is null
    			if(lineNumArray.size() == 1){
    				itemsToBeCombined.add(lineNumArray[0]);
    			}
    			else{
    				//get all the children of this lineNumber
					for(String s: allProducts.keySet()){
		    			if(s.startsWith(lineNumArray[0])){
		    				if(s != lineNumArray[0]){
		    				  	noOfChildren++;
		    				  	toBeDeleted.add(s);
		    				  }	
		    			}
		    		}
		    		//only the top chidren are considered for matches
					if(noOfChildren < pbEntries.size()){
						for(String s1 : toBeDeleted){
							itemsToBeCombined.add(s1);
						}
						break;
					}
    			}
    			
    		}
    		if(itemsToBeCombined.size() == pbEntries.size()){
    			break;
    		}
    	}
    	if(itemsToBeCombined.size() != pbEntries.size()){
    		itemsToBeCombined = new List<String>();
    	}
    	return itemsToBeCombined;
    }
    
    private static Id getHighestMatchId(Map<String, Id> currentProducts, Map<Id, Set<Id>> parentsToChildren){
    	
    	Boolean itemRemoved = false;
    	Id highestMatchId;
        	
      	highestMatchId = getMatchId(currentProducts,parentsToChildren);
    	
    	List<String> lineNos = new List<String>();
    	List<String> toBeDeleted = new List<String>();
    	Integer noOfChildren = 0;
    	
    	while(highestMatchId != null && !itemRemoved) {
    		for(String s : currentProducts.keySet()){
    			if(currentProducts.get(s) == highestMatchId){
    				lineNos.add(s);
    			}
    		}
    		itemRemoved = true;
	    	for(Integer i = 0 ; i < lineNos.size(); i++){	
	    		for(String s: currentProducts.keySet()){
	    			if(s.startsWith(lineNos.get(i))){
	    				  noOfChildren++;
	    				  toBeDeleted.add(s);
	    			}
	    		}
	   			
	    		if(noOfChildren == parentsToChildren.get(highestMatchId).size() + 1){
	    			for(Integer j = 0 ; j < toBeDeleted.size() ; j++){
	    				currentProducts.remove(toBeDeleted.get(j));
	    				itemRemoved = false;
	    			}
	    		}
	    		noOfChildren = 0;
	    		toBeDeleted = new List<String>();
	    	}
	    
	    	//The highestId has to be recalculated as if there are both for eg TriplePlay(DP+Product3) and DoublePlay(Prod1+Prod2) in the cart,and if a 
	    	//product belonging to DoublePlay is added to cart the DoublePlay entire product has to be deleted so that the
	    	//a new DoublePlay is added to the cart
	    	highestMatchId = getMatchId(currentProducts,parentsToChildren);
    	}
    	
    	return highestMatchId;
    }
    
    private static Id getMatchId(Map<String, Id> currentProducts, Map<Id, Set<Id>> parentsToChildren){
    	Id highestMatchId = null;
    	Map<Id, Set<Id>> matches = new Map<Id,  Set<Id>>();
            for (Id prod : currentProducts.values()) {
                for (Id parent : parentsToChildren.keySet()) {
                    if (!matches.containsKey(parent)) {
                        matches.put(parent, new Set<Id>());
                    }

                    for (Id child : parentsToChildren.get(parent)) {
                        if (child == prod) {
                            matches.get(parent).add(prod);
                        }
                    }
                }
            }
            
            for (Id parentId : matches.keySet()) {
                if (matches.get(parentId).size() == parentsToChildren.get(parentId).size()
                        && (highestMatchId == null || matches.get(parentId).size() > matches.get(highestMatchId).size())) {
                    highestMatchId = parentId;
                }
        	}
        return 	highestMatchId;
    }

}