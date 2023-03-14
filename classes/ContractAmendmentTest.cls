@isTest
public class ContractAmendmentTest{
   static testMethod void testCreateDocument(){  
       Account acct = new Account(Name='Test');
       insert acct;
       
       Contract newContract = new Contract(Name='Test', AccountId=acct.Id);
       insert newContract;
       vlocity_cmt__ContractVersion__c version = new vlocity_cmt__ContractVersion__c (Name='Test', vlocity_cmt__ContractId__c=newContract.Id);
       insert version;
       
       vlocity_cmt__DocumentTemplate__c docTemplate1 = new vlocity_cmt__DocumentTemplate__c();
       docTemplate1.Name = 'Test Document Template';
       docTemplate1.vlocity_cmt__IsActive__c=true;
       docTemplate1.vlocity_cmt__ApplicableTypes__c='Opportunity; Order';
       insert docTemplate1;
       
       test.startTest();
       
       Type t = Type.forName('CreateAmendmentDocument');
       vlocity_cmt.VlocityOpenInterface vpsi = (vlocity_cmt.VlocityOpenInterface)t.newInstance();
       
       Map<String, Object> inputMap = new Map<String, Object>();
       Map<String, Object> outputMap = new Map<String, Object>();
       Map<String, Object> optionsMap = new Map<String, Object>();
       
       vpsi.invokeMethod('getDocxTemplate', inputMap, outputMap, optionsMap); 
       String relsXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'+
            '<Relationships '+
                'xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'+
                '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>'+
                '<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings" Target="webSettings.xml"/>'+
                '<Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footnotes" Target="footnotes.xml"/>'+
                '<Relationship Id="rId6" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/endnotes" Target="endnotes.xml"/>'+
                '<Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/>'+
                '<Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/>'+
                '<Relationship Id="rId9" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>'+
                '<Relationship Id="rId10" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>'+
                '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>'+
                '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>'+
            '</Relationships>';
       inputMap.put('relXml', relsXml);
       Map<String, Object> innerMap = new Map<String, Object>();
       innerMap.put('Id', docTemplate1.Id);
       List<Object> templateList = new List<Object>();
       templateList.add(innerMap);
       Map<String, Object> docTempMap = new Map<String, Object>();
       docTempMap.put('DocumentTemplate', templateList);
       inputMap.put('PickTemplate', docTempMap);
       inputMap.put('DRId_vlocity_cmt__ContractVersion__c', version.Id);
       inputMap.put('DRId_Contract', newContract.Id);
            
       vpsi.invokeMethod('createWordDoc', inputMap, outputMap, optionsMap); 
       
       try{
           vpsi.invokeMethod('attachDocx', inputMap, outputMap, optionsMap); 
           }catch(Exception e){
           }
       
       test.stopTest();
   }
}