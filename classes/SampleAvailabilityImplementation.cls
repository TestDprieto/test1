global with sharing class SampleAvailabilityImplementation implements vlocity_cmt.GlobalInterfaces.ProductAvailabilityInterface{

    public List<PriceBookEntry> getAvailableProducts(SObject parentItem, List<PriceBookEntry> pricebookEntryList){
    /*
    *  Normally Availability runs before Eligibility
    *  This sample runs Eligibility first, then Availability
    */
        String nsp = 'vlocity_cmt__';
  
        // run the Eligibility that is set up
        String productElig = 'SampleDefaultEligibilityImplementation';//CustomSettingsUtilities.getCustomClassImplemenationName('ProductEligibility');
        Type et = Type.forName(productElig); 
        vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface pei = (vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface)et.newInstance();
        pricebookEntryList = pei.getEligibleProducts(parentItem, pricebookEntryList);
             
        //now run the specific Availability that you want - here 'Default...'  
        // have to specify the implementation since this file presumeably overrides it     
        String impl = 'vlocity_cmt.LocaleProductAvailability';
        Type t = Type.forName(impl);    
        vlocity_cmt.GlobalInterfaces.ProductAvailabilityInterface pai = (vlocity_cmt.GlobalInterfaces.ProductAvailabilityInterface)t.newInstance();
        pricebookEntryList = pai.getAvailableProducts(parentItem,pricebookEntryList);
        
        //this logic excludes products based on Order(Quote).ShippingCity which compares to
        //record in ProductAvailability__c object where City__c can be set
    /*
    *	To run this code for an Oppty you will have to create a formula field for ShippingCity
    *   In Opportunity add field: ShippingCity__c as formula: Account.ShippingCity
    */
    	String shipCityQry;
    	String objectName = String.valueOf(parentItem.getSObjectType());
        if(objectName == 'Opportunity') {
        // without adding the field to Opportunity this won't work, but it shouldn't fail since it's just setting up 
        // the query string
        	shipCityQry ='ShippingCity__c';
        }
        else {
       		shipCityQry ='ShippingCity'; 
        }
        String shipCity = (String)parentItem.get(shipCityQry);
       	String pricebkId = (String)parentItem.get('Pricebook2Id');
       	
       	Map<ID, String> productIdMap = new Map<ID, String> ();
        for(PriceBookEntry pbe: pricebookEntryList){
           productIdMap.put(pbe.Product2Id, 'ProductId');
        }
        List<vlocity_cmt__ProductAvailability__c> ruleList  = [SELECT ID, vlocity_cmt__City__c, vlocity_cmt__Product2Id__c From vlocity_cmt__ProductAvailability__c 
        	WHERE vlocity_cmt__Product2Id__c IN :productIdMap.keySet()  AND vlocity_cmt__City__c != null];
		for(vlocity_cmt__ProductAvailability__c pat: ruleList){  

			 if(pat.vlocity_cmt__City__c == shipCity){
                  productIdMap.remove(pat.vlocity_cmt__Product2Id__c); 
             }
		}  
		if(productIdMap !=null){
             pricebookEntryList = [SELECT Id,Pricebook2Id,Product2Id,Product2.vlocity_cmt__Type__c,Product2.vlocity_cmt__SubType__c,ProductCode,
             		Product2.Description,Product2.Name,UnitPrice,Name,Product2.vlocity_cmt__JSONAttribute__c,vlocity_cmt__RecurringPrice__c,IsActive
                    FROM PricebookEntry 
                    WHERE Pricebook2Id = :pricebkId AND IsActive=true AND Product2Id IN :productIdMap.keySet() Order by Product2.Name];
		}             
        
        system.debug(':::Executed SampleAvailabilityImplementation');
        
        return pricebookEntryList;
    }
     
}