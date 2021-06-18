public with sharing class EvaluateAttributeFilters {
	
	private static Set<String> headerObjects = new Set<String>{'Opportunity', 'Quote', 'Order'};
	private static Set<String> itemObjects = new Set<String>{'OpportunityLineItem', 'QuoteLineItem', 'OrderItem'};
	private static SObjectType parentObjectTypeForPage;
	private static SObjectType lineItemTypeForPage;
	public static Set<Id> qualifiedObjectIds;


	public static void evaluateFilters(Id cartId) {
		//get Entity filter ids

		getObjectType(cartId);
		List<Id> objectItemIds = new List<Id>();
		List<vlocity_cmt__EntityFilter__c> entityFilters = [Select Id, vlocity_cmt__FilterOnObjectName__c FROM vlocity_cmt__EntityFilter__c Where Name like 'CMT_AttributesReadOnly%' AND vlocity_cmt__IsActive__c = true];
		List<Id> filterHeaderIds = new List<Id>();
		List<Id> filterItemIds = new List<Id>();
		for(vlocity_cmt__EntityFilter__c entityFilter : entityFilters) {
			if(entityFilter.vlocity_cmt__FilterOnObjectName__c != null && headerObjects.contains(entityFilter.vlocity_cmt__FilterOnObjectName__c))
				filterHeaderIds.add(entityFilter.Id);
			else if (entityFilter.vlocity_cmt__FilterOnObjectName__c != null && itemObjects.contains(entityFilter.vlocity_cmt__FilterOnObjectName__c))	
				filterItemIds.add(entityFilter.Id);
		}

		System.debug('filterHeaderIds ::::' + filterHeaderIds);
		System.debug('filterItemIds ::::' + filterItemIds);
		if(filterHeaderIds.isEmpty() && filterItemIds.isEmpty()) return;
		// run objects against all filters

		Map<Id, Set<Id>> filterIdToContextObjectIds;
		Map<Id, Set<Id>> filterIdToContextItemIds;
		Map<Id, Set<Id>> orderIdToItemIds = new Map<Id, Set<Id>>();
		vlocity_cmt.EntityFilterSupport filterEvaluator = new vlocity_cmt.EntityFilterSupport();
		if(!filterHeaderIds.isEmpty()) {
			Map<String, Object> filterInputVars = new Map<String, Object>();
			Map<String, Object> filterOutputVars = new Map<String, Object>();
			filterInputVars.put('objectIds', new List<Id>{cartId});
			filterInputVars.put('entityFilterIds', filterHeaderIds);
			filterEvaluator.invokeMethod('executeFilters',filterInputVars, filterOutputVars, null);
			filterIdToContextObjectIds = (Map<Id, Set<Id>>)filterOutputVars.get('filterIdToObjectIds');
			System.debug('filterIdToContextObjectIds ::::' + filterIdToContextObjectIds);
		}

		if(!filterItemIds.isEmpty()) {

			String query = 'SELECT Id FROM '+ lineItemTypeForPage + ' WHERE ' + parentObjectTypeForPage + 'Id = :cartId';
			for(SObject so : Database.query(query)) {
				objectItemIds.add((Id)so.get('Id'));
			}

			if(!objectItemIds.isEmpty()) {	
				Map<String, Object> filterInputVars = new Map<String, Object>();
				Map<String, Object> filterOutputVars = new Map<String, Object>();
				filterInputVars.put('objectIds', objectItemIds);
				filterInputVars.put('entityFilterIds', filterItemIds);
				filterEvaluator.invokeMethod('executeFilters',filterInputVars, filterOutputVars, null);
				filterIdToContextItemIds = (Map<Id, Set<Id>>)filterOutputVars.get('filterIdToObjectIds');
				System.debug('filterIdToContextItemIds ::::' + filterIdToContextItemIds);
			}
		}

		if((filterIdToContextObjectIds == null || filterIdToContextObjectIds.isEmpty()) && (filterIdToContextItemIds == null || filterIdToContextItemIds.isEmpty())) return;    // no filtered items
		qualifiedObjectIds = new Set<Id>();
		qualifiedObjectIds.addAll(objectItemIds);
		//get the intersection objects between the different filters
		if(filterIdToContextObjectIds == null) {
			Set<Id> itemIds = new Set<Id>();
			for(Object obj : filterIdToContextItemIds.values()) {
				itemIds.addAll((Set<Id>)obj);
			}
			qualifiedObjectIds.retainAll(itemIds);
		} else {
			if(filterIdToContextItemIds == null) return;
			Set<Id> allObjectIds = new Set<Id>();
			Set<Id> allItemIds = new Set<Id>();
			Set<Id> filteredItemIds = new Set<Id>();
			for(Object obj : filterIdToContextObjectIds.values()) {
				allObjectIds.addAll((Set<Id>)obj);
			}
			for(Object obj : filterIdToContextItemIds.values()) {
				allItemIds.addAll((Set<Id>)obj);
			}
			for(Id objId : allObjectIds) {
				Set<Id> origItemIds = orderIdToItemIds.get(objId);
				for(Id itemId : allItemIds) {
					if(origItemIds.contains(itemId))
						filteredItemIds.add(itemId);
				}
			}
			qualifiedObjectIds.retainAll(filteredItemIds);
		}
		
		if(qualifiedObjectIds.isEmpty()) return;   // nothing qualified

	}

	private static void getObjectType (Id cartId) {
        parentObjectTypeForPage = cartId.getSObjectType();
        if (parentObjectTypeForPage == Order.SObjectType)
        {
            lineItemTypeForPage = OrderItem.SObjectType;
        }
        else if (parentObjectTypeForPage == Quote.SObjectType)
        {
            lineItemTypeForPage = QuoteLineItem.SObjectType;
        }
        else if (parentObjectTypeForPage == Opportunity.SObjectType)
        {
            lineItemTypeForPage = OpportunityLineItem.SObjectType;
        }
    }
}