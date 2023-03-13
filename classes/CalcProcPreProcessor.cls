/***
* @group Implementations
*
* @description loosely typed interface VlocityOpenInterface<br>
* <1>Intro and Purpose:  A Calculation Procedure Pre-Processor class is required to implement VlocityOpenInterface and is invoked directly. <br>
*    The CalcProcPreProcessor class is invoked to add or modify input data to the Calculation Procedure. <br>
*    This class is used for attribute based pricing. Opportunity, Quote, or Order line items are priced according to their attribute values. <br>
*    The price calculations are made by a calculation procedure which uses a pricing matrix containing attribute value combinations to match <br>
*    an output used in the calculation. This class invokes the DataRaptor input bundle extract directly to manipulate the extract output<br>
*    to conform to the input format expected by the attribute based pricing matrix. <br>
* <2>Triggering the Interface: <br>
*    a. Define a Calculation Procedure and an Attribute based Pricing Matrix.<br>
*       - Important: Set the name of this class CalcProcPreProcessor as the PreProcessor Class Name in the Calculation Procedure.<br>
*       - Important: Ensure the Calculation Procedure does NOT have an Input DataRaptor Bundle parameter.<br>
*    b. Define a DataRaptor bundle that extracts Opportunity, Quote, or Order items to be priced.<br>
*    c. Define a DataRaptor bundle to save the price calculation to the line items. Set the name as the Output DataRaptor Bundle <br>
*       to the Calculation Procedure defined in step a.<br>
*    d. Define CPQ Configuration Setup custom setting with the name of the bundle and the parent object context<br>
*       in the following format: CPPreProc{ParentObjectName}DRBundle where {ParentObjectName} is Opportunity, Quote, or Order<br>
*       For example: For Order, the custom setting is: CPPreProcOrderDRBundle, and the Setup Value = name of the DataRaptor bundle in step b.<br>
*    e. Define a Pricing Rule that references the Calculation Procedure in step a.<br>
*    f. Enable the PricingRulesFlow flow and reference the Pricing Rule in the RuleAction step for the corresponding object context; e.g. Order, etc.<br>
*    g. Set the PricingRulesFlowImplementation as the active implementation for the PricingInterface.<br>
*/
global with sharing class CalcProcPreProcessor implements vlocity_cmt.VlocityOpenInterface {
    
    private Boolean useDisplayText = false;

    /**
    * @description  This method is invoked directly by the Calculation Procedure <br>
    * @param methodName (String)  various methods: <br>
    *  - 'calculate' - this method is required by the Calculation Procedure. This method will add its data to the<br>
    *    inputMap to be used by the Calculation Procedure. This method assumes PricingRulesFlowImplementation is invoked and will retrieve<br>
    *    its required context inputs from the FlowStaticMap.<br>
    * @param inputMap (Map&lt;String, Object&gt;) - used to add objects with the 'data' key.<br>
    * @param outputMap (Map&lt;String, Object&gt;) - not currently used
    * @param optionsMap (Map&lt;String, Object&gt;) - not currently used
    * @return Boolean  
    */
   global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        try {
            if(methodName == 'calculate') {             

                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor inputMap ' + inputMap);
                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor options ' + options);

                  SObject parent = (SObject)vlocity_cmt.FlowStaticMap.flowMap.get('parent');
                  String parentObjName;
                  String parentId;
                  if (parent != null) {
                      parentId = String.valueOf(parent.Id);
                      parentObjName = parent.getSObjectType().getDescribe().getName();
                  }
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor parentId ' + parentId);
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor parentObjName ' + parentObjName);

                  if (String.isBlank(parentId) || String.isBlank(parentObjName)) {
                      return true;
                  }
                  String inputBundle = getConfigurationValue('CPPreProc'+parentObjName+'DRBundle');
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor inputBundle ' + inputBundle);                  

                  if (String.isBlank(inputBundle)) {
                      return true;
                  }
                  
                  String useDisplayTextCfg = getConfigurationValue('CPPreProcUseDisplayText');
                  System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor CPPreProcUseDisplayText ' + useDisplayTextCfg);

                  if (!String.isBlank(useDisplayTextCfg) && useDisplayTextCfg == 'True') {
                      this.useDisplayText = true;
                  }

                  String inputBundleInputKey = inputBundle + '_Load';
                  String inputBundleDataSetKey = inputBundle + '_DataSet';
                  String resBody = (String)vlocity_cmt.FlowStaticMap.flowMap.get(inputBundleInputKey);

                  if (resBody == null) {
                      System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor resBody is null, loading...');
                      RestRequest req = new RestRequest();
                      RestResponse res = new RestResponse();

                      req.requestURI = '/v2/DataRaptor/' + inputBundle + '/';
                      req.addParameter('Id', parentId);
                  
                      RestContext.request = req;
                      RestContext.response = res;

                      vlocity_cmt.DRRestResourceV2.doGet();

                      resBody = res.responseBody.toString();
                      vlocity_cmt.FlowStaticMap.flowMap.put(inputBundleInputKey, resBody);
                      //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor DR LOGGER output is ' + resBody);
                  }

                  Map<String, Object> data;
                  data = (Map<String, Object>)vlocity_cmt.FlowStaticMap.flowMap.get(inputBundleDataSetKey);
                  if (data == null) {
                      System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor creating ' + inputBundleDataSetKey);
                      data = new Map<String, Object>();
                      Object drResult = JSON.deserializeUntyped(resBody);
                      if (drResult instanceof List<Object>) {
                          List<Object> resultList = (List<Object>)drResult;
                          for (Object obj : resultList) {
                              Map<String, Object> result = (Map<String, Object>)obj; 
                              processData(result, data);                                                   
                          }
                          inputMap.put('data', data);
                      }
                      else if (drResult instanceof Map<String, Object>) {
                          Map<String, Object> result = (Map<String, Object>)drResult; 
                          processData(result, data);
                          inputMap.put('data', data);
                      }
                      vlocity_cmt.FlowStaticMap.flowMap.put(inputBundleDataSetKey, data);
                      vlocity_cmt.FlowStaticMap.flowMap.put('CalcProcPreProcessor_DataSetKey', inputBundleDataSetKey);
                  }
                  else {
                      inputMap.put('data', data);
                  }
                  
                  //System.debug(LoggingLevel.ERROR, ' ---- CalcProcPreProcessor data input to procedure ' +  JSON.serializePretty(data));
                  //System.debug(LoggingLevel.ERROR, ' ---- inputMap after DR is ' + inputMap);
              }
          } catch(Exception e){
              System.debug(LoggingLevel.ERROR, 'Exception is '+e);
              System.debug(LoggingLevel.ERROR, 'Exception stack trace '+e.getStackTraceString());
              success=false;
              throw e;
         }

        return success;        
    }

    private void processData(Map<String, Object> result,  Map<String, Object> data) {
        String rowKey = (String)result.get('ID');
        Map<String, Object> row = new Map<String, Object>();
        data.put(rowKey, row);
        Object detailNode = result.get('Detail');
        if (detailNode instanceof List<Object>) {
            List<Object> detailList = (List<Object>)detailNode;
            for (Object obj : detailList) {
                Map<String, Object> detail = (Map<String, Object>)obj; 
                processDetail(detail, row);
            }
        }
        else if (detailNode instanceof Map<String, Object>) {
            Map<String, Object> detail = (Map<String, Object>)result.get('Detail');
            processDetail(detail, row);
        }        
    }

    private void processDetail(Map<String, Object> detail, Map<String, Object> row) {
        if (detail != null) {                                                          
            for (String key : detail.keySet()) {
                // Check for the attribute JSON string
                if (key == 'Item Attr') {
                    Object itemAttrsJSON = detail.get('Item Attr');
                    if (itemAttrsJSON instanceof String) {
                        getAttributes((String)itemAttrsJSON, row);
                    }                                        
                    else if (itemAttrsJSON instanceof List<Object>)
                        System.debug(LoggingLevel.ERROR,'itemAttrsJSON is a List<Object> was expecting a String.');
                    else if (itemAttrsJSON instanceof Map<String, Object>)
                        System.debug(LoggingLevel.ERROR,'itemAttrsJSON is a Map<String, Object> was expecting a String.');
                    detail.remove('Item Attr');
                }
                else {
                    row.put(key, detail.get(key));
                }
            }                              
        } 
    }

    /**
     * Extracts all attributes and values from the attribute JSON and adds them to the matrix row
     */
    private void getAttributes(String prodAttrJSON, Map<String, Object> rowMap)
    {
        if (String.isBlank(prodAttrJSON)) {
            return;
        }

        Object jsonAttr = JSON.deserializeUntyped(prodAttrJSON);

        if (jsonAttr instanceof List<Object>) {
            System.debug(LoggingLevel.ERROR,'jsonAttr is a List<Object>');
            return;
        }
        else if (jsonAttr == null) {
            System.debug(LoggingLevel.ERROR,'jsonAttr is null');
            return;
        }

        Map<String, Object> attrMap = (Map<String, Object>)jsonAttr;
        for (String key : attrMap.keySet()) 
        {
            Object attrs = attrMap.get(key);
            if (attrs instanceof List<Object>) 
            {
                List<Object> attrList = (List<Object>)attrs;
                for (Object attr : attrList) {
                    Map<String, Object> attrInfo = (Map<String,Object>)attr;
                    String attrCode = (String)attrInfo.get('attributeuniquecode__c');
                    Map<String, Object> attributeRunTimeInfo =  (Map<String, Object>)attrInfo.get('attributeRunTimeInfo');
                    
                    if (attributeRunTimeInfo == null) {
                        System.debug('attributeRunTimeInfo is null for ' + attrInfo);
                        continue;
                    }
                       
                    String dataType = (String)attributeRunTimeInfo.get('dataType');
                    
                    if (dataType == null) {
                        System.debug(LoggingLevel.ERROR,'Unable to find the dataType for attribute code ' + attrCode);
                        continue;                        
                    }
                    
                    //get initial value
                    Object propertyValue = attributeRunTimeInfo.get('value');
                    if (propertyValue == null) {
                        propertyValue = attributeRunTimeInfo.get('default');                       
                    }

                    try {
                        String normDataType = dataType.toLowerCase();
                        if (normDataType == 'multi picklist') {
                            propertyValue = attributeRunTimeInfo.get('selectedItems');
                            if (propertyValue == null || ((List<Object>) propertyValue).isEmpty()) {
                                List<Object> values = (List<Object>)attributeRunTimeInfo.get('default');
                                String valuesDelimited = '';
                                for (Integer index = 0; index < values.size(); index ++) {
                                    Map<String, Object> value = (Map<String, Object>)values[index];
                                    valuesDelimited += getPropertyValue(value) + ';';                                    
                                }
                                if (valuesDelimited.length() > 0) {
                                    propertyValue = valuesDelimited.subString(0,valuesDelimited.length()-1);
                                    rowMap.put(attrCode, propertyValue);
                                }                                
                            } else {
                                List<Object> values = (List<Object>)propertyValue;
                                String valuesDelimited = '';
                                for (Integer index = 0; index < values.size(); index ++) {
                                    Map<String, Object> value = (Map<String, Object>)values[index];
                                    valuesDelimited += getPropertyValue(value) + ';';                                    
                                }
                                if (valuesDelimited.length() > 0) {
                                    propertyValue = valuesDelimited.subString(0,valuesDelimited.length()-1);
                                    rowMap.put(attrCode, propertyValue);
                                }                                
                            }
                        } else if (normDataType == 'picklist') {
                            propertyValue = attributeRunTimeInfo.get('selectedItem');
                            if (propertyValue == null) {
                                List<Object> values = (List<Object>)attributeRunTimeInfo.get('default');
                                if (values != null && !values.isEmpty()) {
                                    String valuesDelimited = null;
                                    Map<String, Object> value = (Map<String, Object>)values[0];
                                    valuesDelimited = getPropertyValue(value);
                                    propertyValue = valuesDelimited;
                                    rowMap.put(attrCode, propertyValue);
                                }                                
                            } else {
                                //System.debug('propertyValue is ' + propertyValue);
                                if (propertyValue instanceof Map<String, Object>) {
                                    Map<String, Object> value = (Map<String, Object>)propertyValue;
                                    propertyValue = getPropertyValue(value);
                                }
                                else if (propertyValue instanceof String) {
                                    propertyValue = getPropertyValue2(attributeRunTimeInfo.get('values'), (String)propertyValue);
                                    //System.debug('getPropertyValue2 returned ' + propertyValue);
                                }
                                rowMap.put(attrCode, propertyValue);
                            }                            
                        } else {
                            rowMap.put(attrCode, propertyValue);
                        }
                    } catch (Exception e) {
                        System.debug(LoggingLevel.ERROR,'Exception:::::' + e);
                        System.debug(LoggingLevel.ERROR,'Exception stack trace:::::' + e.getStackTraceString());
                        throw e;
                    }                    
                }
            }
            else if (attrs instanceof Map<String, Object>)
                System.debug(LoggingLevel.ERROR,'attrs is a Map<String, Object>');
        }        
    }
    
    private String getPropertyValue2(Object valuesList, String propertyValue) {
        //System.debug('valuesList ' + valuesList);
        if (valuesList instanceof List<Object>) {
            List<Object> objList = (List<Object>)valuesList;
            String internalVal, displayVal; 
            for (Object obj : objList) {
                if (obj instanceof Map<String, Object>) {
                    Map<String, Object> valueMap = (Map<String, Object>)obj;
                    internalVal = String.valueOf(valueMap.get('value'));
                    displayVal = String.valueOf(valueMap.get('displayText'));
                    if (internalVal == propertyValue || displayVal == propertyValue) {
                        if (this.useDisplayText) {
                            return displayVal;
                        }
                        else {
                            if (String.isBlank(internalVal))
                                return displayVal;
                            else
                                return internalVal;
                        }
                    }
                }
            }
        }
        return propertyValue;
    }

    private String getPropertyValue(Map<String, Object> valueMap) {
        if (this.useDisplayText) {
            return String.valueOf(valueMap.get('displayText'));
        }     
        String propertyValue = String.valueOf(valueMap.get('value'));
        if (String.isBlank(propertyValue)) {
            propertyValue = String.valueOf(valueMap.get('displayText'));
        }
        return propertyValue;
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