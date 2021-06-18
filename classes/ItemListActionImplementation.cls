global with sharing class ItemListActionImplementation implements vlocity_cmt.VlocityOpenInterface {

    global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)  {
        Boolean success = true;
        try {
            if (methodName == 'executeCustomAction') {                
                doAction(input, output, options);
            }
        } 
        catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'StackTrace: ' + e.getStackTraceString());
            success = false;
            output.put('error', e.getMessage() + ' StackTrace: ' + e.getStackTraceString());
            output.put('hasErrors', true);
        }
        return success; 
    }

    // Action line format: [COPY or MOVE] FROM SourceList TO TargetList [WHERE namespace__FieldName [= or !=] FieldValue];
    // NOTE: Semi-colon at the end of the line is required to separate each statement.
    //       Spaces are required to separate each statement token.
    // Example: MOVE FROM itemList TO deleteList WHERE vlocity_cmt__ProvisioningStatus__c = Delete;
    //          COPY FROM itemList TO newList;
    // The first line specifies to move all items that have ProvisioningStatus__c = Delete from itemList to deleteList. 
    // The items are REMOVED from itemList.
    // The second specifies to copy all items from itemList to newList. Items are in BOTH lists.
    // Actions are executed in sequence. In the example, newList will not contain any items with 
    // ProvisioningStatus__c = Delete because they were moved due to the first action line. 
    private void doAction(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) {
        System.debug(':::ItemListActionImplementation - doAction');
        String customActionInput, customActionOptions;
        Map<String,Object> flowMap = (Map<String,Object>)input.get('flowMap');
        if (flowMap == null) flowMap = vlocity_cmt.FlowStaticMap.flowMap;
        //System.debug(':::flowMap before action '+flowMap);
        customActionInput = (String)input.get('customActionInput');
        customActionOptions = (String)input.get('customActionOptions');
        System.debug(':::customActionInput: ' + customActionInput);
        System.debug(':::customActionOptions: ' + customActionOptions);
        List<String[]> defnList;            
        if (String.isNotBlank(customActionInput)) {                
            defnList = getDefinitionList(customActionInput);
        }
        if (defnList != null && !defnList.isEmpty()) {
            //System.debug(':::defnList '+defnList);            
            for (Integer i = 0; i < defnList.size(); i++) {
                String[] defn = defnList[i];
                System.debug(':::defn ' + defn);
                if (defn.size() == 9) {
                    processDefinition(flowMap, defn[0], defn[2], defn[4], defn[6], defn[7], defn[8]);
                }
                else if (defn.size() == 5) {
                    processDefinition(flowMap, defn[0], defn[2], defn[4], null, null, null);
                }                
            }
        }
        //System.debug(':::flowMap after action ' + flowMap);
    }

    private void processDefinition(Map<String,Object> flowMap, String action, String sourceListName, 
                                   String targetListName, String fieldName, String operator, String fieldValue) {
        // Get the SourceList
        List<SObject> sourceList = (List<SObject>)flowMap.get(sourceListName);
        if (sourceList != null) {
            // Get the TargetList
            List<SObject> targetList = (List<SObject>)flowMap.get(targetListName);
            if (targetList == null) {
                targetList = new List<SObject>();
                flowMap.put(targetListName, targetList);
            }
            // Check if field criteria is defined
            Boolean checkField = String.isNotBlank(fieldName);
            Integer i = 0;
            String objFieldValue;
            while (i < sourceList.size()) {
                SObject sourceObj = sourceList[i];
                if (checkField) {
                    try {
                        objFieldValue = String.valueOf(sourceObj.get(fieldName));
                    } catch (Exception e) {
                        System.debug(LoggingLevel.ERROR, 'Error: ' + e.getMessage());
                        break;
                    }
                }
                if (action == 'MOVE') {
                    if (!checkField || 
                        (operator == '=' && (fieldValue == objFieldValue)) ||
                        (operator == '!=' && (fieldValue != objFieldValue))) {
                        targetList.add(sourceObj);
                        sourceList.remove(i);
                    }
                    else {                        
                        i++;
                    }
                }
                else if (action == 'COPY') {
                    if (!checkField ||  
                        (operator == '=' && (fieldValue == objFieldValue)) ||
                        (operator == '!=' && (fieldValue != objFieldValue))) {
                        targetList.add(sourceObj);
                    }
                    i++;
                }
                else {
                    // unsupported action, should not reach here, continue
                    i++;
                }
            }
            System.debug(':::sourceList ' + sourceListName + ' ' + sourceList);
            System.debug(':::targetList ' + targetListName + ' ' + targetList);
        }        
    }

    private List<String[]> getDefinitionList(String customActionInput) {
        List<String[]> defnList = new List<String[]>();
        customActionInput = customActionInput.replaceAll('[\r\n]','');
        String[] splitDefinitions = customActionInput.split(';');
        String defn, action, operator;
        for (Integer i = 0; i < splitDefinitions.size(); i++) {
            defn = splitDefinitions[i].trim().replaceAll('\\s+',',');
            if (String.isNotBlank(defn)) {
                String[] defnInfo = defn.split(',');
                if (defnInfo.size() == 9) {
                    action = defnInfo[0];
                    operator = defnInfo[7];
                }
                else if (defnInfo.size() == 5) {
                    action = defnInfo[0];
                }
                else {
                    System.debug(LoggingLevel.ERROR, 'Unsupported mapping format: ' + splitDefinitions[i] + ';');
                    System.debug(LoggingLevel.ERROR, 'Mapping format should be: [COPY or MOVE] FROM SourceList TO TargetList [WHERE namespace__FieldName [= or !=] FieldValue];');
                    throw new ItemListActionImplementationException('Unsupported mapping format: ' + splitDefinitions[i] + ';');
                } 
                if (action != 'MOVE' && action != 'COPY') {                    
                    throw new ItemListActionImplementationException('Unsupported action: ' + action + 
                        ' for definition: ' + defn);    
                }
                if (operator != null && operator != '=' && operator != '!=') {
                    throw new ItemListActionImplementationException('Unsupported operator: ' + operator + 
                        ' for definition: ' + defn);
                }
                defnList.add(defnInfo);
            }
        }
        return defnList;
    }

    global class ItemListActionImplementationException extends Exception{}
}