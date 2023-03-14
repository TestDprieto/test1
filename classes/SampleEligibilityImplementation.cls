global with sharing class SampleEligibilityImplementation implements vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface{
	
	public List<PricebookEntry> getEligibleProducts (SObject parentItem, List<PriceBookEntry> pricebookEntryList) {
/* 
*  This code runs the AccountTypeProductEligibility (our original code)
*  It then further limits that result set based on Annual Revenue.  
*		Account.AnnualRevenue is a std field
*       ProductChildItem__c.AnnualRevenue__c is a telco field that has been there since the beginning but not
*          exposed in the layout.  The logic below excludes the product if the PCI.AnnualRevenue > Account.AnnualRevenue
*/		
		// run the  Vloc Eligibility 
		String impl = 'vlocity_cmt.AccountTypeProductEligibility';
        Type et = Type.forName(impl);
        vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface pei = (vlocity_cmt.GlobalInterfaces.ProductEligibilityInterface)et.newInstance();
        pricebookEntryList = pei.getEligibleProducts(parentItem, pricebookEntryList);

        // now exclude products for accounts with < specified Annual Revenue
        String pricebkId = (String)parentItem.get('Pricebook2Id');
       	ID recordId = (ID)parentItem.get('AccountId'); 
       	
        Map<ID, String> productIdMap = new Map<ID, String> ();
        for(PriceBookEntry pbe: pricebookEntryList){
           productIdMap.put(pbe.Product2Id, 'ProductId');
        }
        
        Schema.SObjectType objType =  parentItem.getSObjectType();  
        String objName = objType.getDescribe().getName();
        Account acct = [SELECT ID, AnnualRevenue FROM Account WHERE ID =:recordId LIMIT 1];
        Double annRevenue = acct.AnnualRevenue;
       
        List<vlocity_cmt__ProductEligibility__c> ruleList  = [SELECT ID, vlocity_cmt__AnnualRevenue__c, vlocity_cmt__Product2Id__c From vlocity_cmt__ProductEligibility__c 
        	WHERE vlocity_cmt__Product2Id__c IN :productIdMap.keySet()  AND vlocity_cmt__AnnualRevenue__c != null];
		for(vlocity_cmt__ProductEligibility__c pet: ruleList){  

			 if(pet.vlocity_cmt__AnnualRevenue__c > annRevenue){
                  productIdMap.remove(pet.vlocity_cmt__Product2Id__c);
             }
		}  
		if(productIdMap !=null){
             pricebookEntryList = [SELECT Id,Pricebook2Id,Product2Id,Product2.vlocity_cmt__Type__c,Product2.vlocity_cmt__SubType__c,ProductCode,
             		Product2.Description,Product2.Name,UnitPrice,Name,Product2.vlocity_cmt__JSONAttribute__c,vlocity_cmt__RecurringPrice__c,IsActive
                    FROM PricebookEntry 
                    WHERE Pricebook2Id = :pricebkId AND IsActive=true AND Product2Id IN :productIdMap.keySet() Order by Product2.Name];
		}             
    
        system.debug(':::Executed Sample Eligibility Implementation');
        
        return pricebookEntryList;
	}
}