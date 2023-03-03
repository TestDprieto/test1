public with sharing class TRNGProcessAttributes
{

 public ApexPages.StandardSetController controller;
 public TRNGProcessAttributes(ApexPages.StandardSetController constructor) {
 controller = constructor;
 }
    public pageReference RunProcess()  // you can pass parameters
    { 
           List<Id> productIds = new List<Id>();
        for (Product2 prod : [ Select Id from Product2 where vlocity_cmt__ObjectTypeId__c != null ])
        {
          productIds.add(prod.Id);
        }
        Database.executeBatch(new vlocity_cmt.EPCProductAttribJSONBatchJob(productIds), 1);
      return controller.cancel();
    }
   
}