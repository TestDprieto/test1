/**
 * VLOCITY, INC. CONFIDENTIAL
 * __________________
 *
 *  2014-[Current Year] Vlocity, Inc.
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Vlocity, Inc. and its suppliers,
 * if any. The intellectual and technical concepts contained
 * herein are proprietary to Vlocity, Inc. and its suppliers and may be
 * covered by U.S. and Foreign Patents, patents in process, and are
 * protected by trade secret or copyright law. Dissemination of this
 * information and reproduction, modification or reverse-engineering
 * of this material, is prohibited unless prior written permission
 * is obtained from Vlocity, Inc.


 * CC7CustomHybridTokenDataExtractor
 *
 * Jojo Pagador
 * v1
 *
 * Sample implementation that can be used to create custom extraction of Contract and
 * ContractLineItems using DataRaptor for header information and direct queries for
 * line items.
 */
global with sharing class CC7CustomHybridTokenDataExtractor implements vlocity_cmt.VlocityOpenInterface2 
{   
    /**
     *
     */
    private static final Integer DEFAULT_PAGE_OFFSET = 200;
    
    /**
     * Message used when DataRaptor processing encountered any error
     */
    private static final String ERROR_DR_MESSAGE = 'Error encountered while processing request. Please check log for details.';

    /**
     * Message used when method name supplied is not 'getTokenData'
     */
    private static final String ERROR_UNSUPPORTED = 'Unsupported method. Only method [getTokenData] is supported.';

    /**
     * Specify the DataRaptor Extractor for header data
     */
    private static final String DR_EXTRACT_HEADER = 'CC7 Custom Class Docx Header Extract';

    /**
     * Specify the namespace prefix of deployed package
     */
    private static final String NAMESPACE_PREFIX = 'vlocity_cmt__';
    
    /**
     * 
     */
    private static final String QUERY_DRMAP_ITEM;
    
    /**
     * 
     */
    private static final String COUNT_CONTRACT_LINES;
    
    /**
     * 
     */
    private static final String QUERY_CONTRACT_DETAILS;
    
    /**
     * 
     */
    private static final String QUERY_INITIAL_CONTRACT_LINES;
    
    /**
     * 
     */
    private static final String QUERY_SUCCEEDING_CONTRACT_LINES;  
     
    /**
     * Initialize queries to be used to include namespace prefix
     */
    static
    {
        String queryContractLines = 
            'SELECT count() ' +
            'FROM $nmspc$ContractLineItem__c ' +
            'WHERE $nmspc$ContractId__c=:contractId';
        COUNT_CONTRACT_LINES = queryContractLines.replace('$nmspc$', NAMESPACE_PREFIX);
        
        String queryDrMapItem = 
            'SELECT Id, $nmspc$FilterValue__c ' +
            'FROM $nmspc$DRMapItem__c ' +
            'WHERE $nmspc$FilterOperator__c=\'LIMIT\' AND Name=:extractDR';
        QUERY_DRMAP_ITEM = queryDrMapItem.replace('$nmspc$', NAMESPACE_PREFIX);
        
        String queryInitialContractLines =
            'SELECT Id, Name, $nmspc$Quantity__c, $nmspc$OneTimeTotal__c, $nmspc$RecurringTotal__c ' +
            'FROM $nmspc$ContractLineItem__c ' +
            'WHERE ($nmspc$ContractId__c =: contractId) ' +
            'ORDER BY Id ' +
            'LIMIT :pageOffset';
        QUERY_INITIAL_CONTRACT_LINES = queryInitialContractLines.replace('$nmspc$', NAMESPACE_PREFIX);
        
        String querySucceedingContractLines = 
            'SELECT Id, Name, $nmspc$Quantity__c, $nmspc$OneTimeTotal__c, $nmspc$RecurringTotal__c ' +
            'FROM $nmspc$ContractLineItem__c ' +
            'WHERE ($nmspc$ContractId__c =: contractId AND Id >: lastItemId) ' +
            'ORDER BY Id ' +
            'LIMIT :pageOffset';
        QUERY_SUCCEEDING_CONTRACT_LINES = querySucceedingContractLines.replace('$nmspc$', NAMESPACE_PREFIX);
    }
    
    /**
     * 
     */
    global Object invokeMethod(
        String methodName, 
        Map<String, Object> input,
        Map<String, Object> output, 
        Map<String, Object> options) 
    {
        Boolean success = false;
            
        System.debug('invokeMethod:methodName -> ' + methodName);
        System.debug('invokeMethod:input-> ' + input);
        
        if (methodName == 'getTokenData') 
        {
            success = getTokenData(input, output, options);
        } 
        else 
        {
            throw new CC7CustomHybridTokenDataExtractorException(ERROR_UNSUPPORTED);
        }

        System.debug('invokeMethod:output -> ' + output);
        System.debug('invokeMethod:success -> ' + success);
        return success;
    }

    /**
     *
     */
    private Boolean getTokenData(
        Map<String, Object> input, 
        Map<String, Object> output, 
        Map<String, Object> options)
    {        
        Boolean success = false;
        
        Id contractId = (Id) input.get('contextId');
                
        if (!input.containsKey('tokenDataQueryInfo')) 
        {
            success = getContractTokenData(input, output, options);
        } 
        else 
        {
            success = getContractItemsTokenData(input, output, options);
        }
        
        System.debug('getTokenData:success -> ' + success);
        return success;
    }
    
    /**
     *
     */
    private Boolean getContractTokenData(
        Map<String, Object> input, 
        Map<String, Object> output, 
        Map<String, Object> options)
    { 
        Boolean success = false;
        
        Id contractId = (Id) input.get('contextId');
        
        List<Map<String, Object>> DRinputs = new List<Map<String, Object>>();
        Map<String, Object> DRinput = new Map<String, Object>();
        
        DRinput.put('Id', contractId); 
        DRinputs.add(DRinput);
        
        vlocity_cmt.DRProcessResult drProcessResult = vlocity_cmt.DRGlobal.process(DRInputs, DR_EXTRACT_HEADER);
        System.debug('getContractTokenData:drProcessResult ->' + drProcessResult);
        
        if (!drProcessResult.hasErrors())
        {
            Map<String, Object> paginationInformation = initializePaginationInfo(contractId);
            Integer totalItems = (Integer) paginationInformation.get('totalItems');  
            output.put('hasMoreTokenData', totalItems > 0);
            output.put('tokenMap', drProcessResult.toJson());
            output.put('tokenDataQueryInfo', paginationInformation);

            success = true;
        }
        else 
        {
            throw new CC7CustomHybridTokenDataExtractorException(ERROR_DR_MESSAGE);
        }
        
        System.debug('getContractTokenData:output -> ' + output);
        System.debug('getContractTokenData:success -> ' + success);
        return success;
    }
    
    /**
     *
     */
    private Boolean getContractItemsTokenData(
        Map<String, Object> input, 
        Map<String, Object> output, 
        Map<String, Object> options)
    { 
        Boolean success = false;
        
        Id contractId = (Id) input.get('contextId');
        
        Map<String, Object> paginationInformation = 
            (Map<String, Object>) Json.deserializeUntyped((String) input.get('tokenDataQueryInfo'));
        
        Id lastItemId = (Id) paginationInformation.get('lastItemId');
        Integer recordNumber = (Integer) paginationInformation.get('recordNumber');
        Integer totalItems = (Integer) paginationInformation.get('totalItems');
        Integer pageOffset = (Integer) paginationInformation.get('pageOffset');
        
        List<vlocity_cmt__ContractLineItem__c> lineItems = getContractLineItems(contractId, lastItemId, pageOffset);
        
        vlocity_cmt__ContractLineItem__c lastItem = lineItems.get(lineItems.size()-1);
        paginationInformation.put('lastItemId', lastItem.Id);
        paginationInformation.put('recordNumber', recordNumber += pageOffset);
        
        output.put('tokenMap', extractContractLineItemDetails(lineItems));
        output.put('tokenDataQueryInfo', paginationInformation);
        output.put('hasMoreTokenData', (totalItems > recordNumber ? true : false));
        
        System.debug('getContractItemsTokenData:output -> ' + output);
        System.debug('getContractItemsTokenData:success -> ' + success);
        return success;
    }
    
    /**
   
     */
    private List<vlocity_cmt__ContractLineItem__c> getContractLineItems(Id contractId, Id lastItemId, Integer pageOffset)
    {
        List<vlocity_cmt__ContractLineItem__c> lineItems = null;
        if (lastItemId == null)
        {
            lineItems = Database.query(QUERY_INITIAL_CONTRACT_LINES);
        }
        else 
        {
            lineItems = Database.query(QUERY_SUCCEEDING_CONTRACT_LINES);
        }

        System.debug('getContractLineItems() lineItems -> ' + lineItems);           
        return lineItems;
    }
    
    /**
     * 
     */
    private Map<String, Object> extractContractLineItemDetails(List<vlocity_cmt__ContractLineItem__c> lineItems) 
    {
        List<Map<String, Object>> lineItemDetails = new List<Map<String, Object>>();  
        
        for (vlocity_cmt__ContractLineItem__c lineItem : lineItems)
        {
            
            String quantity = String.valueOf(lineItem.get(NAMESPACE_PREFIX + 'Quantity__c'));
            String oneTimeTotal = String.valueOf(lineItem.get(NAMESPACE_PREFIX + 'OneTimeTotal__c'));
            String recurringTotal = String.valueOf(lineItem.get(NAMESPACE_PREFIX + 'RecurringTotal__c'));
            
            quantity = (null==quantity) ? '' : quantity;
            oneTimeTotal = (null==oneTimeTotal) ? '' : oneTimeTotal;
            recurringTotal = (null==recurringTotal) ? '' : recurringTotal;
            
            Map<String, Object> lineItemDetail = new Map<String, Object>();
            lineItemDetail.put('name', String.valueOf(lineItem.get('Name')));
            lineItemDetail.put('quantity', quantity);
            lineItemDetail.put('oneTimeTotal', oneTimeTotal);
            lineItemDetail.put('recurringTotal', recurringTotal);
            
            lineItemDetails.add(lineItemDetail);
        }
        
        Map<String, Object> tokenData = new Map<String, Object>();
        tokenData.put('line_item', lineItemDetails);
        
        return tokenData;
    }
    
    /**
     *
     */
    private Boolean updateHasMoreData(Map<String, Object> pageInfo) 
    {
        Integer totalItems = (Integer) pageInfo.get('totalItems');
        Integer recordNumber = (Integer) pageInfo.get('recordNumber');
        
        Boolean hasMoreData = totalItems > recordNumber ? true : false;
        
        System.debug('updateHasMoreData:hasMoreData -> ' + hasMoreData);
        return hasMoreData;
    }
    
    /**
     *
     */
    private void updatePageOffset(Map<String, Object> pageInfo) 
    {
        Integer pageOffset = (Integer) pageInfo.get('pageOffset');
        Integer recordNumber = (Integer) pageInfo.get('recordNumber');
        
        Integer nextPageOffset = recordNumber + pageOffset;
        
        System.debug('updatePageOffset:nextPageOffset -> ' + nextPageOffset);
        pageInfo.put('recordNumber', nextPageOffset);
    } 
    
    /**
     *
     */
    private Map<String, Object> initializePaginationInfo(Id contractId) 
    { 
        Integer totalItems = countContractItems(contractId);
            
        Map<String, Object> paginationInformation = new Map<String, Object>();
        paginationInformation.put('queryHeader', true);
        paginationInformation.put('queryLine', true);
        paginationInformation.put('recordNumber', 0);
        paginationInformation.put('pageOffset', DEFAULT_PAGE_OFFSET);
        paginationInformation.put('totalItems', totalItems);
        
        System.debug('initializePaginationInfo:paginationInformation -> ' + paginationInformation);
        return paginationInformation;
    }
    
    /**
     *
     */
    private Integer countContractItems(Id contractId) 
    {
        Integer contractItems = Database.countQuery(COUNT_CONTRACT_LINES);
        
        System.debug('countContractItems:contractItems -> ' + contractItems);
        return contractItems;
    }

    /**
     *
     */
    class CC7CustomHybridTokenDataExtractorException extends Exception {
        
    }
}