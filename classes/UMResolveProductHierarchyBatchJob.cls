/*
 TO RUN THIS batch job FROM ANONYMOUS MODE  paste this code :


 String query = ' SELECT ParentProductId__c , ';
        query         += '         ChildProductId__c ';
        query        += ' FROM     ProductChildItem__c WHERE IsRootProductChildItem__c = false AND IsOverride__c = false';
        query        += '  AND ParentProductId__c != NULL AND ChildProductId__c != NULL';
        UMResolveProductHierarchyBatchJob resolveProductHierarchy = new UMResolveProductHierarchyBatchJob(query, '',true, 0);
        Database.executeBatch(resolveProductHierarchy,2000);

*/

public with sharing class UMResolveProductHierarchyBatchJob implements Database.Batchable<sObject>, Database.Stateful {
	public final String installerEmail;
	public Id jobId;
	public Boolean needsAnotherPass;
	public final String query;
	public final Id recordTypeId;
	public Integer passesCount;
	
	public UMResolveProductHierarchyBatchJob(String query, String installerEmail, Boolean removeOldRecords, Integer passesCount){
		
		this.recordTypeId = Schema.SObjectType.vlocity_cmt__DataStore__c.getRecordTypeInfosByName().get('Product Hierarchy').getRecordTypeId();
		this.query = query;
		this.installerEmail = installerEmail;	
		this.needsAnotherPass = false;	
		this.passesCount = passesCount;
		//delete old values
		if(removeOldRecords){
			delete[SELECT Id FROM vlocity_cmt__DataStore__c WHERE RecordTypeId =: recordTypeId];
			
		}
		
	}
	
	public Database.QueryLocator start(Database.BatchableContext BC){
		this.jobId = BC.getJobId();
		return Database.getQueryLocator(query);
		
	}
	
	public void execute(Database.BatchableContext BC, List<sObject> scope){
		resolveProductHierearchyItems(BC, scope);
		
	}
	
	public void finish(Database.BatchableContext BC){
		if(passesCount < 20 && needsAnotherPass){
			passesCount++;
			//start another batch to resolve any missing items
			String query = ' SELECT vlocity_cmt__ParentProductId__c , ';
			query 		+= ' 		vlocity_cmt__ChildProductId__c ';
			query		+= ' FROM 	vlocity_cmt__ProductChildItem__c WHERE vlocity_cmt__IsRootProductChildItem__c = false AND vlocity_cmt__IsOverride__c = false';
			query		+= '  AND vlocity_cmt__ParentProductId__c != NULL AND vlocity_cmt__ChildProductId__c != NULL';
			UMResolveProductHierarchyBatchJob resolveProductHierarchy = new UMResolveProductHierarchyBatchJob(query, '', false, passesCount);
			Database.executeBatch(resolveProductHierarchy, 2000);
			

		} else {
			AsyncApexJob job = [SELECT Id, 
									   Status, 
									   NumberOfErrors, 
									   JobItemsProcessed, 
									   TotalJobItems,
									   CreatedBy.Email
							    FROM AsyncApexJob 
							    WHERE Id = :bc.getJobId()];
			// send status email to user's email
			String userEmail = String.isNotBlank(installerEmail)?installerEmail:Job.CreatedBy.Email;
			if (String.isNotBlank(userEmail)) {			
				Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
				String[] toAddresses = new String[] {userEmail};
				mail.setToAddresses(toAddresses);
				mail.setSubject('Vlocity Product Hierarchy Batch Job  (' + bc.getJobId() + ') ' + job.Status);
				mail.setPlainTextBody('The batch Apex job processed ' + job.TotalJobItems +
									  ' batches with ' + job.NumberOfErrors + ' failures.');
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });	
			}
		
		}
		
	}
	
	// bind attribute values to sobject fields
	public void resolveProductHierearchyItems(Database.BatchableContext BC, List<sObject> scope){
        		/********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************

		Map<Id, List<vlocity_cmt__ProductChildItem__c>> childProductIdToPciList = new Map<Id, List<vlocity_cmt__ProductChildItem__c>>();
		Set<Id> productIds = new Set<Id>();
		for(sObject item : scope){
			vlocity_cmt__ProductChildItem__c pci = (vlocity_cmt__ProductChildItem__c) item;
			productIds.add(pci.vlocity_cmt__ParentProductId__c);
			productIds.add(pci.vlocity_cmt__ChildProductId__c);
			if(childProductIdToPciList.get(pci.vlocity_cmt__ChildProductId__c) == null){
				childProductIdToPciList.put(pci.vlocity_cmt__ChildProductId__c,new List<vlocity_cmt__ProductChildItem__c>());
				
			}
			
			childProductIdToPciList.get(pci.vlocity_cmt__ChildProductId__c).add(pci);
			
		}
		
		Map<Id, vlocity_cmt__DataStore__c> productIdToPhiMap = new Map<Id, vlocity_cmt__DataStore__c>();
		Map<Id, Set<String>> contextProductIdToPciIds = new Map<Id, Set<String>>();
		for(vlocity_cmt__DataStore__c phi :[SELECT vlocity_cmt__ProductId__c, vlocity_cmt__Value__c, vlocity_cmt__Key__c FROM vlocity_cmt__DataStore__c WHERE vlocity_cmt__ProductId__c IN :productIds AND RecordTypeId =: recordTypeId]){
			productIdToPhiMap.put(phi.vlocity_cmt__ProductId__c, phi);
			contextProductIdToPciIds.put(phi.vlocity_cmt__ProductId__c, new Set<String>(phi.vlocity_cmt__Value__c.split(',')));
		}
		
		//Map<Id, Set<String>> contextProductIdToPciIds = new Map<Id, Set<String>>();
		for(sObject item : scope){
			vlocity_cmt__ProductChildItem__c pci = (vlocity_cmt__ProductChildItem__c) item;
			if(productIdToPhiMap.get(pci.vlocity_cmt__ChildProductId__c) != null && productIdToPhiMap.get(pci.vlocity_cmt__ChildProductId__c).vlocity_cmt__Value__c != null){
				if(contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c) == null){
					contextProductIdToPciIds.put(pci.vlocity_cmt__ChildProductId__c, new Set<String>());
				}
				
				contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c).addAll(productIdToPhiMap.get(pci.vlocity_cmt__ChildProductId__c).vlocity_cmt__Value__c.split(','));
				
			}
			resolveHighestPCI(childProductIdToPciList, contextProductIdToPciIds, pci);
			
		}
		
		List<vlocity_cmt__DataStore__c> itemsToUpdate = new List<vlocity_cmt__DataStore__c>();
		
		for(Id productId : contextProductIdToPciIds.keyset()){
			vlocity_cmt__DataStore__c productphi = productIdToPhiMap.get(productId);
			Set<String> pciIds = contextProductIdToPciIds.get(productId);
			if(productphi == null){
				vlocity_cmt__DataStore__c productHierarchyItems = new vlocity_cmt__DataStore__c();
				productHierarchyItems.vlocity_cmt__ProductId__c = productId;
				productHierarchyItems.RecordTypeId = this.recordTypeId;
				productHierarchyItems.vlocity_cmt__Key__c = productId;
				List<String> pciIdsList = new List<String>(pciIds);
				productHierarchyItems.vlocity_cmt__Value__c = String.join(pciIdsList,',');
				itemsToUpdate.add(productHierarchyItems);
				needsAnotherPass = true;
			} else {
				Set<String> existingIds = new Set<String>(productphi.vlocity_cmt__Value__c.split(','));
				Set<String> newIds = pciIds;
				if(newIds.isEmpty() || newIds.equals(existingIds)){
					continue;	
					
				} else if(newIds.size() < existingIds.size() && existingIds.containsAll(newIds)){
					continue;
					
				}
				
				newIds.addAll(existingIds);
				List<String> pciIdsList = new List<String>(newIds);
				productphi.vlocity_cmt__Value__c = String.join(pciIdsList,',');
				itemsToUpdate.add(productphi);
				needsAnotherPass = true;
				
			}
			
		}
		
		upsert itemsToUpdate;
		********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************/
		
	} 
	
	private void resolveHighestPCI(Map<Id, List<vlocity_cmt__ProductChildItem__c>> childProductIdToPciList, Map<Id, Set<String>> contextProductIdToPciIds, vlocity_cmt__ProductChildItem__c pci){
				/********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************

		if(contextProductIdToPciIds.get(pci.vlocity_cmt__ParentProductId__c) == null){
            contextProductIdToPciIds.put(pci.vlocity_cmt__ParentProductId__c, new Set<String>());
            
        } 
        
        contextProductIdToPciIds.get(pci.vlocity_cmt__ParentProductId__c).add(pci.Id);
        if(contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c) != null){
        	contextProductIdToPciIds.get(pci.vlocity_cmt__ParentProductId__c).addAll(contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c));
        	
        }
            
        if(childProductIdToPciList.get(pci.vlocity_cmt__ParentProductId__c) == null){
        	if(childProductIdToPciList.get(pci.vlocity_cmt__ParentProductId__c) == null){
	            if(contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c) == null)
	            return;
	            
	            if(contextProductIdToPciIds.get(pci.vlocity_cmt__ParentProductId__c) == null){
	                contextProductIdToPciIds.put(pci.vlocity_cmt__ParentProductId__c, contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c));
	                
	            } else {
	                contextProductIdToPciIds.get(pci.vlocity_cmt__ParentProductId__c).addAll(contextProductIdToPciIds.get(pci.vlocity_cmt__ChildProductId__c));
	                
	            }
	                
				return;
				
	        }
	        
        }
		
		for(vlocity_cmt__ProductChildItem__c parentPCI : childProductIdToPciList.get(pci.vlocity_cmt__ParentProductId__c)){
			if(contextProductIdToPciIds.get(parentPCI.vlocity_cmt__ParentProductId__c) == null){
				contextProductIdToPciIds.put(parentPCI.vlocity_cmt__ParentProductId__c, new Set<String>());
				
			}
			
			contextProductIdToPciIds.get(parentPCI.vlocity_cmt__ParentProductId__c).add(parentPCI.Id);
			if(contextProductIdToPciIds.get(parentPCI.vlocity_cmt__ChildProductId__c) != null){
            	contextProductIdToPciIds.get(parentPCI.vlocity_cmt__ParentProductId__c).addAll(contextProductIdToPciIds.get(parentPCI.vlocity_cmt__ChildProductId__c));
            	   
            }
            
			resolveHighestPCI(childProductIdToPciList, contextProductIdToPciIds, parentPCI);
		
		}
		 ********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************/

	}
}