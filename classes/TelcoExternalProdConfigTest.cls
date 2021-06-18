@isTest(seeAllData=false)
public with sharing class TelcoExternalProdConfigTest {
	
	private static testMethod void testProdConfig(){
		Test.startTest();
		TelcoExternalProdConfigImplementation tecloImp = new TelcoExternalProdConfigImplementation();
		List<vlocity_cmt.ProductWrapper> productDefinition = new List<vlocity_cmt.ProductWrapper>();
		vlocity_cmt.ProductWrapper first = new vlocity_cmt.ProductWrapper();
		vlocity_cmt.ProductWrapper sec = new vlocity_cmt.ProductWrapper();
		Map<String,Object> input1 = new Map<String,Object>();
		Map<String,Object> output = new Map<String,Object>();
		List<Object> temp1 = new List<Object>();
		temp1.add(createAttrRun('PickRadio','Egg1'));
		temp1.add(createAttrRun('MultiPickCheck','Bread2'));
		temp1.add(createAttrRun('pickDrop','Milk3'));
		temp1.add(createAttrRun('MultiPickDrop','Egg4'));
		Map<String,Object> temp2 = new Map<String,Object>();
		temp2.put('key1',temp1);
		first.JSONAttribute = JSON.serialize(temp2);
		productDefinition.add(first);
		productDefinition.add(sec);
		input1.put('productDefinition', productDefinition);
		tecloImp.invokeMethod('configureProduct',input1,output,null);
		tecloImp.invokeMethod('reConfigureProduct',input1,output,null);
		Test.stopTest();
	}
	private static Map<String,Object> createAttrRun(String displayN,String actVal){
		Map<String,Object> temp1 = new Map<String,Object>();
		temp1.put('displayText',actVal);
		Map<String,Object> temp2 = new Map<String,Object>();
		temp2.put('values',new List<Object>{temp1});
		Map<String,Object> temp3 = new Map<String,Object>();
		temp3.put('attributeRunTimeInfo',temp2);
		temp3.put('attributedisplayname__c',displayN);
		return temp3;
				
}
}