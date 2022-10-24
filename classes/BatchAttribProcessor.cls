global class BatchAttribProcessor
{
    webservice static void RunProcess() // you can pass parameters
    { 
        List<Id> productIds = new List<Id>();
        for (Product2 prod : [ Select Id from Product2 where vlocity_cmt__ObjectTypeId__c != null ])
        {
          productIds.add(prod.Id);
        }
        Database.executeBatch(new vlocity_cmt.EPCProductAttribJSONBatchJob(productIds), 1);
    }
}