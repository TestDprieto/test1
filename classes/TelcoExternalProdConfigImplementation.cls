/**
 * This is sample implementation for 'PreConfigureHandler'..
 * CONFIGURE:-
 * It shows how to access the attribute runtime info in a list of productwrapper and hide/disable it.
 * It also shows how to remove a line item while configuring a product using this hook
 * RECONFIGURE:-
 * While reconfiguring the changes made in configuring can be reverted...
 * Refer: - OM-684 & OM-685
 */
global with sharing class TelcoExternalProdConfigImplementation  implements vlocity_cmt.VlocityOpenInterface{
	global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)	{
			if (methodName.equals('configureProduct')){
				return configureProduct(input,output,options);
			}else if (methodName.equals('reConfigureProduct')){
				return reConfigureProduct(input,output,options);
			}else if (methodName.equals('configureProductForHybrid')){
				return reConfigureProduct(input,output,options);
			}
			return false;
		}

	private Boolean configureProduct(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options){
		List<vlocity_cmt.ProductWrapper> modProdDefn = new List<vlocity_cmt.ProductWrapper>();
		try{
			List<vlocity_cmt.ProductWrapper> productDefinition = (List<vlocity_cmt.ProductWrapper>)input.get('productDefinition'); // this is the only
			//by default initialize with the supplied prodDefn..who know...!!!
			modProdDefn = productDefinition;
			// product id is = 01t28000000nGKq
			
			
			Integer toRemove = 1;
			/********************************************************/
			 /*  for test coverage issues we will assume there will be only 2 prdocuts which has all the attributes populated correctly */
			 // attribute changes will be applied to the first product...
			 // and second product will be removed.
			 // Please consult Engineering in case of any issues while referring this Sample Code...:)
			 /*************************************************************/

			 		
					vlocity_cmt.ProductWrapper tempWrap = modProdDefn.get(0);
					String jsonAttr = tempWrap.JSONAttribute;
					Map<String,Object> attrObj = (Map<String,Object>)JSON.deserializeUntyped(jsonAttr);
					for(String key1 : attrObj.keySet()){
						
						List<Object> temp2 = (List<Object>)attrObj.get(key1);
						Map<String,Object> attributeRunTimeInfo = null;
						List<Object> attrValues = null;
						Map<String,Object> tempV2  = null;
						for(Object temp3 : temp2){
							Map<String,Object> finalAttr = (Map<String,Object> ) temp3;
							if( ((String)finalAttr.get('attributedisplayname__c')) == 'PickRadio'){ //disabling one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV3 : attrValues){
									tempV2 = (Map<String,Object> )tempV3;

									if( ((String)tempV2.get('displayText')) == 'Egg1')
									{
										tempV2.put('isreadonly__c', true);
										
									}
								}
							}else if ( ((String)finalAttr.get('attributedisplayname__c')) == 'MultiPickCheck'){// hiding one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									tempV2 = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Bread2')
									{
										tempV2.put('ishidden__c', true);
										
									}
								}
							}else if ( ((String)finalAttr.get('attributedisplayname__c')) == 'pickDrop'){// hiding one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									tempV2 = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Milk3')
									{
										tempV2.put('isreadonly__c', true);
										
									}
								}
							}else if ( ((String)finalAttr.get('attributedisplayname__c')) == 'MultiPickDrop'){// hiding one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									tempV2 = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Egg4')
									{
										tempV2.put('ishidden__c', true);
										
									}
								}
							}
							

						}
					}
					// update prod definnition...
					tempWrap.JSONAttribute = JSON.serialize(attrObj);
				
				
			modProdDefn.remove(toRemove);
			output.put('productDefinition',modProdDefn);
			return true;
		}catch(Exception e){
			System.debug(LoggingLevel.ERROR, e.getMessage());
		}
		return false;
	}

	private Boolean configureProductForHybrid(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options){
		List<SObject> modProdDefn = new List<SObject>();
		try{
			List<SObject> productDefinition = (List<SObject>)input.get('items'); // this is the only
			//by default initialize with the supplied items..who know...!!!
			modProdDefn = productDefinition;
			// product id is = 01t28000000nGKq
			
			
			Integer toRemove = 1;
			/********************************************************/
			 /*  for test coverage issues we will assume there will be only 2 prdocuts which has all the attributes populated correctly */
			 // attribute changes will be applied to the first product...
			 // and second product will be removed.
			 // Please consult Engineering in case of any issues while referring this Sample Code...:)
			 /*************************************************************/

			 		
					SObject tempWrap = modProdDefn.get(0);
					String jsonAttr = (String)tempWrap.get('vlocity_cmt__JSONAttribute__c');
					Map<String,Object> attrObj = (Map<String,Object>)JSON.deserializeUntyped(jsonAttr);
					for(String key1 : attrObj.keySet()){
						
						List<Object> temp2 = (List<Object>)attrObj.get(key1);
						Map<String,Object> attributeRunTimeInfo = null;
						List<Object> attrValues = null;
						Map<String,Object> tempV2  = null;
						for(Object temp3 : temp2){
							Map<String,Object> finalAttr = (Map<String,Object> ) temp3;
							if( ((String)finalAttr.get('attributedisplayname__c')) == 'PickRadio'){ //disabling one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV3 : attrValues){
									tempV2 = (Map<String,Object> )tempV3;

									if( ((String)tempV2.get('displayText')) == 'Egg1')
									{
										tempV2.put('isreadonly__c', true);
										
									}
								}
							}else if ( ((String)finalAttr.get('attributedisplayname__c')) == 'MultiPickCheck'){// hiding one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									tempV2 = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Bread2')
									{
										tempV2.put('ishidden__c', true);
										
									}
								}
							}else if ( ((String)finalAttr.get('attributedisplayname__c')) == 'pickDrop'){// hiding one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									tempV2 = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Milk3')
									{
										tempV2.put('isreadonly__c', true);
										
									}
								}
							}else if ( ((String)finalAttr.get('attributedisplayname__c')) == 'MultiPickDrop'){// hiding one of the picklist values..
								attributeRunTimeInfo = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								attrValues = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									tempV2 = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Egg4')
									{
										tempV2.put('ishidden__c', true);
										
									}
								}
							}
							

						}
					}
					// update prod definnition...
					tempWrap.put('vlocity_cmt__JSONAttribute__c',JSON.serialize(attrObj));
				
				
			modProdDefn.remove(toRemove);
			output.put('productDefinition',modProdDefn);
			return true;
		}catch(Exception e){
			System.debug(LoggingLevel.ERROR, e.getMessage());
		}
		return false;
	}

	private Boolean reConfigureProduct(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options){
		List<vlocity_cmt.ProductWrapper> modProdDefn = new List<vlocity_cmt.ProductWrapper>();
		try{
			List<vlocity_cmt.ProductWrapper> productDefinition = (List<vlocity_cmt.ProductWrapper>)input.get('productDefinition');
			//by default initialize with the supplied prodDefn..who know...!!!
			modProdDefn = productDefinition;
			vlocity_cmt.ProductWrapper tempWrap = modProdDefn.get(0);
					String jsonAttr = tempWrap.JSONAttribute;
					Map<String,Object> attrObj = (Map<String,Object>)JSON.deserializeUntyped(jsonAttr);
					for(String key1 : attrObj.keySet()){
						
						List<Object> temp2 = (List<Object>)attrObj.get(key1);
						for(Object temp3 : temp2){
							Map<String,Object> finalAttr = (Map<String,Object> ) temp3;
							if ( ((String)finalAttr.get('attributedisplayname__c')) == 'pickDrop'){// hiding one of the picklist values..
								Map<String,Object> attributeRunTimeInfo  = (Map<String,Object>)finalAttr.get('attributeRunTimeInfo');
								List<Object> attrValues  = (List<Object>)attributeRunTimeInfo.get('values');
								for(Object tempV4 : attrValues){
									Map<String,Object> tempV2   = (Map<String,Object> )tempV4;

									if( ((String)tempV2.get('displayText')) == 'Milk3')
									{
										tempV2.put('isreadonly__c', false);
										
									}
								}
							}
							

						}
					}
					// update prod definnition...
					tempWrap.JSONAttribute = JSON.serialize(attrObj);
			
			output.put('productDefinition',modProdDefn);
			return true;
		}catch(Exception e){
			System.debug(LoggingLevel.ERROR, e.getMessage());
		}
		return false;
	}
}