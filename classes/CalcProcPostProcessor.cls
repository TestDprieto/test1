global with sharing class CalcProcPostProcessor implements vlocity_cmt.VlocityOpenInterface {

    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        try {
            if(methodName == 'calculate') {             

                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor inputMap ' + inputMap);
                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor outMap ' + outMap);
                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor options ' + options);
                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor FlowStaticMap.flowMap ' + vlocity_cmt.FlowStaticMap.flowMap);

                  SObject parent = (SObject)vlocity_cmt.FlowStaticMap.flowMap.get('parent');
                  String parentObjName;
                  String parentId;
                  if (parent != null) {
                      parentId = String.valueOf(parent.Id);
                      parentObjName = parent.getSObjectType().getDescribe().getName();
                  }
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor parentId ' + parentId);
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor parentObjName ' + parentObjName);

                  if (String.isBlank(parentId) || String.isBlank(parentObjName)) {
                      System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor parentId or parentObjName is blank.');
                      return true;
                  }
                  String outputBundle = getConfigurationValue('CPPostProc'+parentObjName+'DRBundle');
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor outputBundle ' + outputBundle);

                  if (String.isBlank(outputBundle)) {
                      System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor outputBundle is blank.');
                      return true;
                  }
                  
                  List<Object> outputList = (List<Object>)outMap.get('output');
                  List<Object> objectList;
                  if (outputList != null && !outputList.isEmpty()) {
                      vlocity_cmt.PricingCalculationService.CalculationProcedureResults calcProcResults = (vlocity_cmt.PricingCalculationService.CalculationProcedureResults)outputList[0];
                      objectList = calcProcResults.calculationResults;                      
                  }

                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor modifiedRecords to save ' + JSON.serializePretty(objectList));

                  if (objectList != null && !objectList.isEmpty()) {
                      String inputBundleDataSetKey = (String)vlocity_cmt.FlowStaticMap.flowMap.get('CalcProcPreProcessor_DataSetKey');
                      Map<String, Object> dataSet = (Map<String, Object>)vlocity_cmt.FlowStaticMap.flowMap.get(inputBundleDataSetKey);
                      // Sync the result set to the data set
                      if (dataSet != null && !dataSet.isEmpty()) {
                        for (Object obj : objectList) {
                            Map<String, Object> row = (Map<String, Object>)obj;
                            Map<String, Object> dataSetRow = (Map<String, Object>)dataSet.get((String)row.get('ID'));
                            if (dataSetRow != null) {
                                for (String rowKey : row.keySet()) {
                                    if (rowKey != 'ID') {
                                      dataSetRow.put(rowKey, row.get(rowKey));  
                                    }                                    
                                }
                            }                          
                        }
                        //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor updated DataSet ' + inputBundleDataSetKey + JSON.serializePretty(dataSet));
                        vlocity_cmt.FlowStaticMap.flowMap.put(inputBundleDataSetKey, dataSet);
                      }
                      String saveBundleKey = outputBundle+'_Save';
                      Map<String, Object> currentSaveList = (Map<String, Object>)vlocity_cmt.FlowStaticMap.flowMap.get(saveBundleKey);
                      if (currentSaveList == null) {
                          currentSaveList = new Map<String, Object>();
                          for (Object objToSave : objectList) {
                              Map<String, Object> objToSaveMap = (Map<String, Object>)objToSave;
                              if (objToSaveMap.get('ID') != null) {
                                  currentSaveList.put((String)objToSaveMap.get('ID'), objToSaveMap);
                              }
                          }
                      }
                      else {
                          for (Object objToSave : objectList) {
                              Map<String, Object> objToSaveMap = (Map<String, Object>)objToSave;
                              Map<String, Object> currentObj = (Map<String, Object>)currentSaveList.get((String)objToSaveMap.get('ID'));
                              if (currentObj != null) {                                  
                                  for (String key : objToSaveMap.keySet()) {
                                      currentObj.put(key, objToSaveMap.get(key));
                                  }                                  
                              }
                              else {
                                  currentSaveList.put((String)objToSaveMap.get('ID'), objToSave);
                              }
                          }
                      }
                      vlocity_cmt.FlowStaticMap.flowMap.put(saveBundleKey, currentSaveList);
                      //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPostProcessor ' + saveBundleKey + ': ' + JSON.serializePretty(currentSaveList));

                  } 

              }
          } catch(Exception e){
              System.debug(LoggingLevel.ERROR, 'Exception is '+e);
              System.debug(LoggingLevel.ERROR, 'Exception stack trace '+e.getStackTraceString());
              success=false;
              throw e;
         }

        return success;        
    }
    
    private String getConfigurationValue(String setupName) {
        vlocity_cmt__CpqConfigurationSetup__c cpqSetup = vlocity_cmt__CpqConfigurationSetup__c.getInstance(setupName); 
        String retval = null;
        if (cpqSetup != null 
              && cpqSetup.vlocity_cmt__SetupValue__c != null
              && cpqSetup.vlocity_cmt__SetupValue__c.length() > 0) {
            retval = cpqSetup.vlocity_cmt__SetupValue__c;          
        }  
        return retval;
    }    
}