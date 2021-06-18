global with sharing class ContractCustomDocumentSectionExample implements vlocity_cmt.VlocityOpenInterface{
    public Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        if(methodName == 'buildDocumentSectionContent')
        { 
                buildDocumentSectionContent(inputMap, outMap, options); 
        }       
          return success; 
  }
        
    private void buildDocumentSectionContent (Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){                 
          String contextObjName = (String) inputMap.get('contextObjName');          
          Id contractId = (Id) inputMap.get('contextObjId'); 
          List<SObject> lineItems = (List<SObject>) inputMap.get('items');
          String docStyle = (String) inputMap.get('documentFontStyle');
          
          System.debug(' IN TEST CLASS context object is '+contextObjName);
          System.debug(' IN TEST CLASS context Id is '+contractId);
          System.debug(' IN TEST CLASS lineItems are '+lineItems);
          System.debug(' IN TEST CLASS doc style is  '+docStyle);
          
          //Prepare header
          Map<String, String> headerMap = new Map<String, String> ();
          headerMap.put('1', 'Product');
          headerMap.put('2', 'Quantity');
          headerMap.put('3', 'One Time Charge');
                    
          String tableStyle = 'border: .5px solid #cccccc;width: 100%;';
          String headerStyle='border-bottom: 1px solid #cccccc;border-right: 1px solid #cccccc;';          
          String tableHeaderStyle='font-size:9pt;font-family:Arial,sans-serif;background-color:#66cc00;';
          headerStyle=headerStyle+tableHeaderStyle;
        
          String content = '<p> <table style=\"'+tableStyle+'\">';
          content +='<thead><tr>';
          for(String key: headerMap.keySet()){               
              content +='<th style=\"'+headerStyle+'\">';
              content +='<viawrapper>'+headerMap.get(key)+'</viawrapper></th>';
          }
          content +='</tr></thead>';
          
          //prepare body
          Map<String, List<Map<String, String>>> dataMap = new Map<String, List<Map<String, String>>>();
          dataMap = prepareData(lineItems);
            
          String tableCellStyle='font-size:9pt;font-family:Arial,sans-serif;';
          String bodyStyle='<td style=\"'+tableCellStyle;
          content +='<tbody>';
          for(String key : dataMap.keySet()){
            content+='<tr>';
            content+=bodyStyle+'\">';
            content+='<viawrapper>'+key+'</viawrapper></td></tr>';
            
            List<Map<String, String>> rowData = dataMap.get(key);
            
            for(Map<String, String> eachRow : rowData){
              content+='<tr>';
              for(String header : headerMap.keySet()){
                content+=bodyStyle+' padding-left: 30px;\">';
                content+='<viawrapper>'+eachRow.get(headerMap.get(header))+'</viawrapper></td>';
              }
              content+='</tr>';
            }
          }
          
          content +='</tbody></table></p>';
          System.debug(' content is '+content);
          outMap.put('sectionContent', content);
    }
    
    private Map<String, List<Map<String, String>>> prepareData (List<SObject> items){
      String nameSpaceprefix = 'vlocity_cmt__';
      Map<String, List<Map<String, String>>> statusMap = new Map<String, List<Map<String, String>>> ();
      for(SObject item : items){
        String status = (String) item.get(nameSpaceprefix+'Status__c');
        if(statusMap.get(status) !=null){
          Map<String, String> newdata = new Map<String, String> ();
          newdata.put('Product', (String) item.get('Name'));
          newdata.put('Quantity', String.valueOf(item.get(nameSpaceprefix+'Quantity__c')));
          Decimal numValue = (Decimal) item.get(nameSpaceprefix+'OneTimeTotal__c');
          numValue = Decimal.valueOf(Math.roundToLong(numValue * 100)) / 100;
              String sValue = (numValue.setScale(2) + (numValue >= 0 ? 0.001 : -0.001)).format();           
          String cc= '$';
          String chargeStr = cc +''+sValue.substring(0, sValue.length() - 1);                  
          newdata.put('One Time Charge', chargeStr); 
          
          statusMap.get(status).add(newdata);
        }
        else{
          List<Map<String, String>> itemList = new List<Map<String, String>> ();
          Map<String, String> newdata = new Map<String, String> ();
          newdata.put('Product', (String) item.get('Name'));
          newdata.put('Quantity', String.valueOf(item.get(nameSpaceprefix+'Quantity__c')));
          Decimal numValue = (Decimal) item.get(nameSpaceprefix+'OneTimeTotal__c');
          numValue = Decimal.valueOf(Math.roundToLong(numValue * 100)) / 100;
              String sValue = (numValue.setScale(2) + (numValue >= 0 ? 0.001 : -0.001)).format();           
          String cc= '$';
          String chargeStr = cc +''+sValue.substring(0, sValue.length() - 1);          
          newdata.put('One Time Charge', chargeStr); 
          itemList.add(newdata);
          statusMap.put(status, itemList);
        }
      }
      System.debug('Status Map '+statusMap);
      return statusMap;
    }
}