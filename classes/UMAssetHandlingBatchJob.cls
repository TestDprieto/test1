/*
 This batch job should be run only when assets have been either imported or created by
 some external system and they don't have line numbers, rootItemId and ParentItemId populated to them.

 TO RUN THIS batch job FROM ANONYMOUS MODE  paste this code :
	
        UMAssetHandlingBatchJob assetHandlingJob = new UMAssetHandlingBatchJob(AccId);
        Database.executeBatch(assetHandlingJob,100);

*/

/* 

*/

public with sharing class UMAssetHandlingBatchJob implements Database.Batchable<sObject>, Database.Stateful {
	
	private final String query;
	private Id accountId;
	private final Integer levelLength = 4;
	private String nsPrefix = 'vlocity_cmt__';
	
	public UMAssetHandlingBatchJob(Id accountId) {
		
		if(accountId == null) return;
		this.query = 'SELECT Id, vlocity_cmt__LineNumber__c, vlocity_cmt__ParentItemId__c, vlocity_cmt__RootItemId__c From Asset WHERE AccountId = :accountId AND vlocity_cmt__LineNumber__c = NULL';
		this.accountId = accountId;

	}
	
	
	public Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator(query);
		
	}
	
	public void execute(Database.BatchableContext BC, List<sObject> scope){
		handleAssetItems(BC, scope);
		
	}
	
	public void finish(Database.BatchableContext BC){

	}

	private void handleAssetItems(Database.BatchableContext BC, List<sObject> assetItemList) {
		/********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************

		if(assetItemList == null || assetItemList.isEmpty()) return;
		
		Map<String,Map<String,String>> lineNumToRootParentLineNumber = new Map<String, Map<String,String>>();
		String maxLineNum = getMaxParentLineNumber(accountId);
		Map<String, Id> lineNumToId = new Map<String, Id>();
		for(SObject so : assetItemList){
			String lineNum;
			if(so.get(nsPrefix+'LineNumber__c') != null) {
				lineNum = (String)(so.get(nsPrefix+'LineNumber__c'));
			}
			else {
				Integer numLineNum = Integer.valueOf(maxLineNum);
				numLineNum++;
				lineNum = padLeft(numLineNum);
				so.put(nsPrefix+'LineNumber__c', lineNum);
			}
			Id lineItemId = (Id)(so.get('Id'));
			//Map the line number to the Id
			lineNumToId.put(lineNum,lineItemId);	
		}
		
		for(SObject so : assetItemList){
			String lineNum = (String)(so.get(nsPrefix+'LineNumber__c'));
			//Map the lineNum to its rootId and parent line num
			//Eg (001.001.001,{('RootId','001')}
			//Eg (001.001.001,{('ParentId','001.001')}
			Map<String,String> parentLineNumMap = new Map<String,String>();
			if(lineNum != null){
				parentLineNumMap.put('ParentId', getParentLN(lineNum));
				lineNumToRootParentLineNumber.put(lineNum,parentLineNumMap);
				
				//get the root line number from the line number
				String rootLineNum = getRootLineNumber(lineNum);
				lineNumToRootParentLineNumber.get(lineNum).put('RootId',rootLineNum);
			}
		}
		for(SObject so : assetItemList){
			String lineNum = (String)(so.get(nsPrefix+'LineNumber__c'));
			if(lineNum != null && so.get(nsPrefix+'RootItemId__c') == null){
				if(lineNumToRootParentLineNumber != null && lineNumToRootParentLineNumber.containsKey(lineNum)){
					if(lineNumToId != null && lineNumToId.containsKey(lineNumToRootParentLineNumber.get(lineNum).get('RootId'))){
						//get the id for the rootLineNum for the current line item
						Id rootId = lineNumToId.get(lineNumToRootParentLineNumber.get(lineNum).get('RootId'));
						so.put(nsPrefix+'RootItemId__c',rootId);
					}
					if(lineNumToId != null && lineNumToId.containsKey(lineNumToRootParentLineNumber.get(lineNum).get('ParentId'))){
						//get the id for the parentLineNum for the current line item
						Id parentId = lineNumToId.get(lineNumToRootParentLineNumber.get(lineNum).get('ParentId'));
						so.put(nsPrefix+'ParentItemId__c',parentId);
					}
				}
			}	
		}
		update assetItemList;
	 ********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************/

	}
		/********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************

	private String getMaxParentLineNumber(Id objId){
        String maxNum = null;
        String query = 'SELECT MAX(' +
                        nsPrefix+'LineNumber__c' +
                        ')maxLine '+
                        'FROM Asset '+
                        ' WHERE '+
                        ' AccountId = \'' + objId + '\'';
        SObject listMax = Database.query(query);
        if(listMax == null)
        	return '0';
        maxNum = (String)listMax.get('maxLine');
        if(maxNum != null){
            if(maxNum.contains('.'))
                maxNum = (maxNum.split('\\.'))[0];
        }else{
            maxNum = '0';
        }
        return maxNum;
    }	

    private String padLeft(Integer i) {
    	String str = String.valueOf(i);
		while (str.length() < levelLength) {
			str = '0' + str;
		}
		
		return str;
    }	

    private String getParentLN(String ln) {
 
		String retval = ''; 
		Integer lnz;
		String[] lns = ln.split('\\.');
        lnz = lns.size()-1;
        lns.remove(lnz); 
        retval =  String.join(lns,'.');
        return retval;
    }

    private String getRootLineNumber(String lineNum){
		String[] lns = lineNum.split('\\.');
		return lns[0];
	}
		 ********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************/

	
}