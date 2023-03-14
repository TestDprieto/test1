global with sharing class CreateAmendmentDocument implements vlocity_cmt.VlocityOpenInterface{
      public Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        if(methodName == 'createWordDoc')
        { 
                createWordDoc(inputMap, outMap, options); 
        }
        else if(methodName == 'getDocxTemplate')
        { 
                getDocxTemplate(inputMap, outMap, options); 
        }
        
        else if(methodName == 'attachDocx')
        { 
                attachDocx(inputMap, outMap, options); 
        }
       
          return success; 
   }
        
    private void createWordDoc (Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){        
        System.debug(' In createWordDoc, inputMap is '+inputMap);
        String nameSpaceprefix = 'vlocity_cmt__';
        //create document
        String relsXml=(String) inputMap.get('relXml');
        System.debug(' relsXml is '+relsXml);
        if(inputMap.get('PickTemplate') !=null){
              Map<String, Object> docTemplate =(Map<String, Object>) inputMap.get('PickTemplate');
              if(docTemplate !=null){
                  List<Object> templateObj = (List<Object>) docTemplate.get('DocumentTemplate');
                  
                  if(templateObj !=null && templateObj.size()>0){
                      Map<String, Object> template = (Map<String, Object>) templateObj[0];
                      Id templateId = (Id) template.get('Id');
                      Id contractVersionId = (Id) inputMap.get('DRId_'+nameSpaceprefix+'ContractVersion__c');
                      if(contractVersionId==null){
                          Id contractId = (Id) inputMap.get('DRId_Contract');
                          List<vlocity_cmt__ContractVersion__c> versionList = [Select Id from vlocity_cmt__ContractVersion__c where vlocity_cmt__ContractId__c=:contractId and vlocity_cmt__Status__c='Active'];
                          if(versionList !=null && versionList.size()>0){
                            contractVersionId = versionList[0].Id;                      
                          }
                      }
                  
                      System.debug('Template Id is '+templateId +' version Id is '+contractVersionId);
                      vlocity_cmt.ContractDocumentDisplayController.createContractSections(templateId, contractVersionId);              
                      outMap.put('doc', vlocity_cmt.ContractDocumentCreationController.getContractVersionDocument(contractVersionId, relsXml));
                  }
             }
        }
    }
    
    private void getDocxTemplate (Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){        
               
        outMap.put('relXml',vlocity_cmt.ContractDocumentCreationController.getDocxTemplate());
    }
    
    private void attachDocx (Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options){        
        System.debug(' In attachDocx, inputMap is '+inputMap);
        String nameSpaceprefix = 'vlocity_cmt__';
        Id contractVersionId = (Id) inputMap.get('DRId_'+nameSpaceprefix+'ContractVersion__c');
        if(contractVersionId==null){
              Id contractId = (Id) inputMap.get('DRId_Contract');
              List<vlocity_cmt__ContractVersion__c> versionList = [Select Id from vlocity_cmt__ContractVersion__c where vlocity_cmt__ContractId__c=:contractId and vlocity_cmt__Status__c='Active'];
              if(versionList !=null && versionList.size()>0){
                 contractVersionId = versionList[0].Id;                     
              }
        }
        
        String data = (String) inputMap.get('contractData');
        vlocity_cmt.ContractDocumentCreationController.saveDocx(contractVersionId, data);
    }
    
}