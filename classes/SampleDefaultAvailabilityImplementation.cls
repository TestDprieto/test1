global with sharing class SampleDefaultAvailabilityImplementation implements vlocity_cmt.GlobalInterfaces.ProductAvailabilityInterface{

	public List<PriceBookEntry> getAvailableProducts(SObject parentItem, List<PriceBookEntry> pbeList){
		if(pbeList ==null || (pbeList !=null && pbeList.size()==0)) {     
       		pbeList = new List<PriceBookEntry> ();
	        try{
		        Id itemId = (Id)parentItem.get('Pricebook2Id');
		        pbeList = [Select Id
		                         ,Pricebook2Id
		                         ,Product2Id
		                         ,ProductCode
		                         ,Product2.vlocity_cmt__Type__c
		                         ,Product2.vlocity_cmt__SubType__c
		                         ,Product2.Description
		                         ,UnitPrice
		                         ,Name
		                         ,Product2.Name
		                         ,Product2.vlocity_cmt__JSONAttribute__c
		                         ,vlocity_cmt__RecurringPrice__c
		                         ,IsActive 
		                        from PricebookEntry
		                        where Pricebook2Id = :itemId 
		                        	AND (Product2.recordTypeId = null OR Product2.recordType.DeveloperName = 'Product')];
	        }catch(Exception e){
	        	throw e;
	        }
       }
       
       system.debug(':::Executed SampleDefaultAvailabilityImplementation');	
       return pbeList;
		
	}
}