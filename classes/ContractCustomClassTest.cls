@isTest
private with sharing class ContractCustomClassTest {
	private static testMethod void testCustomClass(){
		Account acct = new Account(name='Test');
		insert acct;
		
		Contract cont = new Contract (name='Test',AccountId=acct.Id);
		insert cont;
		
		vlocity_cmt__ContractLineItem__c line1 = new vlocity_cmt__ContractLineItem__c(Name='line1', vlocity_cmt__LineStatus__c='Active', vlocity_cmt__Quantity__c=1, vlocity_cmt__OneTimeTotal__c=1000, vlocity_cmt__ContractId__c=cont.Id);
		vlocity_cmt__ContractLineItem__c line2 = new vlocity_cmt__ContractLineItem__c(Name='line2', vlocity_cmt__LineStatus__c='Active', vlocity_cmt__Quantity__c=1, vlocity_cmt__OneTimeTotal__c=2000, vlocity_cmt__ContractId__c=cont.Id);
		vlocity_cmt__ContractLineItem__c line3 = new vlocity_cmt__ContractLineItem__c(Name='line3', vlocity_cmt__LineStatus__c='Inactive', vlocity_cmt__Quantity__c=1, vlocity_cmt__OneTimeTotal__c=3000, vlocity_cmt__ContractId__c=cont.Id);
		vlocity_cmt__ContractLineItem__c line4 = new vlocity_cmt__ContractLineItem__c(Name='line4', vlocity_cmt__LineStatus__c='Inactive', vlocity_cmt__Quantity__c=1, vlocity_cmt__OneTimeTotal__c=3000, vlocity_cmt__ContractId__c=cont.Id);
		
		List<vlocity_cmt__ContractLineItem__c> lineList = new List<vlocity_cmt__ContractLineItem__c> ();
		lineList.add(line1);
		lineList.add(line2);
		lineList.add(line3);
		lineList.add(line4);
		insert lineList;
		
		Test.startTest();
		String className='ContractCustomDocumentSectionExample';
		Type classType = Type.forName(className);
        //if classType is null, check if the class exists or not and what is the nameSpaceprefix
        if(classType == null){
     	  String customNameSpacePrefix;
     	  List<ApexClass> classList = [SELECT Name, NameSpacePrefix FROM ApexClass WHERE Name=:className LIMIT 1];
          if(classList.size() > 0){                   
		     customNameSpacePrefix = classList[0].NameSpacePrefix;
		     System.debug('class found, name space is '+customNameSpacePrefix);
		     if(customNameSpacePrefix == null || customNameSpacePrefix.equals('')){
		         customNameSpacePrefix = '';
		     }
		     classType=Type.forName(customNameSpacePrefix, className);
     	  } 
       }
       if(classType !=null){
          Map<String, Object> inputMap = new Map<String, Object> ();
          Map<String, Object> outputMap = new Map<String, Object> ();
          Map<String, Object> options = new Map<String, Object> ();
          vlocity_cmt.VlocityOpenInterface vpsi = (vlocity_cmt.VlocityOpenInterface)classType.newInstance();  
          inputMap.put('contextObjName', 'Contract');          
          inputMap.put('contextObjId', cont.Id); 
          inputMap.put('items', lineList);
          inputMap.put('documentFontStyle', 'Aria, times, serif');
          vpsi.invokeMethod('buildDocumentSectionContent',inputMap, outputMap, options);
          String sectionContent = (String) outputMap.get('sectionContent');
          
          System.assertNotEquals(sectionContent, null);
       }		
       
       Test.stopTest();
	
	}

}