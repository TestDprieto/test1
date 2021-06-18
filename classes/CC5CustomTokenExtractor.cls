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


 * CC5CustomTokenExtractor
 *
 *
 * Sample implementation that can be used to create custom extraction of Contract and
 * ContractLineItems using two separate DataRaptor Extractors.
 */
global with sharing class CC5CustomTokenExtractor implements vlocity_cmt.VlocityOpenInterface2 
{
    /**
     * Limit support to contract lines to 2000. 
     * Contract lines exceeding 2000 will throw exception.
     */
    private static final Integer MAXIMUM_ALLOWABLE_LINE_ITEMS = 2000;
    
    /**
     * Message used when DataRaptor processing encountered any error
     */
    private static final String ERROR_DR_MESSAGE = 'Error encountered while processing request. Please check log for details.';
    
    /**
     * Message used when contract line items exceed 2000 rows
     */
    private static final String ERROR_DATASET = 'Dataset exceeds maximum allowable line items.';

    /**
     * Message used when method name supplied is not 'getTokenData'
     */
    private static final String ERROR_UNSUPPORTED = 'Unsupported method. Only method [getTokenData] is supported.';

    /**
     * Specify the DataRaptor Extractor for header data
     */
    private static final String DR_EXTRACT_HEADER = 'CC5 Header Extract';

    /**
     * Specify the DataRaptor Extractor for contract lines data
     */
    private static final String DR_EXTRACT_LINEITEMS = 'CC5 Line Extract';

    /**
     * Specify the namespace prefix of deployed package
     */
    private static final String NAMESPACE_PREFIX = 'vlocity_cmt__';
    
    /**
     * 
     */
    private static final String COUNT_CONTRACT_LINES;
    
    /**
     * 
     */
    private static final String QUERY_DRMAP_ITEM;
     
    /**
     * Initialize queries to be used to include namespace prefix
     */
    static
    {
        String queryContractLines = 
            'SELECT count() ' +
            'FROM $nmspc$ContractLineItem__c ' +
            'WHERE IsDeleted!=true AND $nmspc$ContractId__c=:contractId';
        
        COUNT_CONTRACT_LINES = queryContractLines.replace('$nmspc$', NAMESPACE_PREFIX);
        
        String queryDrMapItem = 
            'SELECT Id, $nmspc$FilterValue__c ' +
            'FROM $nmspc$DRMapItem__c ' +
            'WHERE $nmspc$FilterOperator__c=\'LIMIT\' AND Name=:extractDR';
        
        QUERY_DRMAP_ITEM = queryDrMapItem.replace('$nmspc$', NAMESPACE_PREFIX);
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
            throw new CustomTokenDataExtractorException(ERROR_UNSUPPORTED);
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
        if (countContractItems(contractId) > MAXIMUM_ALLOWABLE_LINE_ITEMS)
        {
            throw new CustomTokenDataExtractorException('Dataset exceeds maximum allowable line items.');
        }
        
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
        
        /**
         * TODO: DataRaptor is submitted as input parameter, but is not actually used in this method.
         *       Do we remove or retain reference?
         */
        Map<String, Object> dataRaptorMap = (Map<String, Object>) input.get('dataRaptorMap');
        
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
            throw new CustomTokenDataExtractorException(ERROR_DR_MESSAGE);
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
        
        Map<String, Object> paginationInformation = 
            (Map<String, Object>) Json.deserializeUntyped((String) input.get('tokenDataQueryInfo'));
        
        /**
         * TODO: DataRaptor is submitted as input parameter, but is not actually used in this method.
         *       Do we remove or retain reference?
         */
        Map<String, Object> dataRaptorMap = (Map<String, Object>) input.get('dataRaptorMap');
        
        Id contractId = (Id) input.get('contextId');
        Integer recordNumber = (Integer) paginationInformation.get('recordNumber');
        
        List<Map<String, Object>> DRinputs = new List<Map<String, Object>>();
        Map<String, Object> DRinput = new Map<String, Object>();
        
        DRinput.put('Id', contractId);     
        DRinput.put('recordNumber', recordNumber);
        DRinputs.add(DRinput);
        
        vlocity_cmt.DRProcessResult drProcessResult = vlocity_cmt.DRGlobal.process(DRInputs, DR_EXTRACT_LINEITEMS);   
        System.debug('getContractItemsTokenData:drProcessResult -> ' + drProcessResult);
       
        if (!drProcessResult.hasErrors())
        {
            if (!paginationInformation.containsKey('pageOffset')) 
            {
                Integer pageOffset = getPageOffset(DR_EXTRACT_LINEITEMS);
                paginationInformation.put('pageOffset', pageOffset);
            }
            
            updatePageOffset(paginationInformation);
            
            Boolean hasMoreData = updateHasMoreData(paginationInformation);
            
            output.put('tokenMap', drProcessResult.toJson());
            output.put('tokenDataQueryInfo', paginationInformation);
            output.put('hasMoreTokenData', hasMoreData);
            
            success = true;
        }
        else 
        {
            throw new CustomTokenDataExtractorException(ERROR_DR_MESSAGE);
        }
                
        System.debug('getContractItemsTokenData:output -> ' + output);
        System.debug('getContractItemsTokenData:success -> ' + success);
        return success;
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
        paginationInformation.put('totalItems', totalItems);
        
        System.debug('initializePaginationInfo:paginationInformation -> ' + paginationInformation);
        return paginationInformation;
    }

    /**
     * 
     */
    private Integer getPageOffset(String extractDR) 
    {
        vlocity_cmt__DRMapItem__c mapItem = Database.query(QUERY_DRMAP_ITEM);
        Integer pageOffset = Integer.valueOf(mapItem.get(NAMESPACE_PREFIX + 'FilterValue__c'));

        System.debug('getPageOffset:pageOffset -> ' + pageOffset);
        return pageOffset;
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
    class CustomTokenDataExtractorException extends Exception {
        
    }
}