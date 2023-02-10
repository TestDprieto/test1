global with sharing class CustomProductDefinitionImplementation implements vlocity_cmt.GLobalInterfaces.ProductDefinitionInterface
{
    SObject parentItem;
    SobjectType parentObjectTypeForPage;
    SObjectType lineItemTypeForPage = null;
    vlocity_cmt.ProductLineItemActionParam productLineItemActionParam;
    Map<String, Object> outputMap;
    Id lnItemId;
    Map<Id, List<Id>> parentProductToChildProds = new Map<Id, List<Id>>();
    Map<String, vlocity_cmt__ProductChildItem__c> parentChildToProductChildItemMap = new Map<String, vlocity_cmt__ProductChildItem__c>();
    Map<Id, Map<String, Object>> offerProdIdToInfoMap = new Map<Id, Map<String, Object>>();
    
   
    global void handleAction(vlocity_cmt.ProductLineItemActionParam productLineItemActionParam, Map<String, Object> outputMap)
    {
        System.debug('Inside New handleAction of CustomProductDefinitionImplementation');
        this.productLineItemActionParam = productLineItemActionParam;
        this.outputMap = outputMap;
        if (productLineItemActionParam.action.equalsIgnoreCase('AddLineItems'))
        {
            vlocity_cmt.DefaultProductDefinitionImplementation prodDef = new vlocity_cmt.DefaultProductDefinitionImplementation();
            Id priceBookEntryId = productLineItemActionParam.pricebookEntryId;
            System.debug('priceBookEntryId is :: '+priceBookEntryId);
            if(priceBookEntryId == '01u36000001SJlsAAG') {  // here we are checking based on pbe id, but we can have custom logic to filter out the prods and child prods
                productLineItemActionParam.action = 'getProductHierarchy';
                prodDef.handleAction(productLineItemActionParam, outputMap);
                List<vlocity_cmt.ProductWrapper> products = (List<vlocity_cmt.ProductWrapper>)outputMap.get('prodHierarchy');
                String prodDefSer = '[';
                for(Integer i=0; i < products.size(); i++) {
                    vlocity_cmt.ProductWrapper prod = products[i];
                    if(prod.pricebookEntryId == '01u36000001SJm2AAG') // here we can have code to change service account ids.
                        continue;
                    else    
                        prodDefSer = prodDefSer + prod.toJSON() +',';
                }
                prodDefSer = prodDefSer.trim().removeEnd(',');
                prodDefSer += ']';
                productLineItemActionParam.productDefinition = prodDefSer;
                productLineItemActionParam.action = 'AddLineItems';
             }
                prodDef.handleAction(productLineItemActionParam, outputMap);
        }
        else {
            vlocity_cmt.DefaultProductDefinitionImplementation prodDef = new vlocity_cmt.DefaultProductDefinitionImplementation();
            prodDef.handleAction(productLineItemActionParam, outputMap);
        }
    }
 }