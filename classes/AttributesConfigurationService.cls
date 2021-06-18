public class AttributesConfigurationService {
	


	public static void configureAttributes(List<vlocity_cmt.JSONRecord> itemRecords, Set<Id> itemIds) {
		if(itemRecords == null || itemRecords.isEmpty()) return;

		for(vlocity_cmt.JSONRecord itemRecord : itemRecords) {
			updateOliAttrsJSONValues(itemRecord, itemIds);
		}
	}



	private static void updateOliAttrsJSONValues (vlocity_cmt.JSONRecord record, Set<Id> itemIds) {
        
        String currentOliId ;
        if(record.fields.containskey('Id') && record.fields.get('Id') instanceOf vlocity_cmt.JSONField) {
                vlocity_cmt.JSONField oliIdfield = (vlocity_cmt.JSONField )record.fields.get('Id');
                currentOliId = (String)oliIdfield.value;
        }		
        if(itemIds != null && currentOliId != null && itemIds.contains(currentOliId) && record.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_ATTRIBUTE_CATEGORIES_RESULT) != null){
            vlocity_cmt.JSONResult result = record.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_ATTRIBUTE_CATEGORIES_RESULT);
            for(vlocity_cmt.JSONRecord itmRcd : result.records) {
            	if(itmRcd == null || itmRcd.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_ATTRIBUTES_RESULT) == null) continue;
                vlocity_cmt.JSONResult jsonProdAttrnodeResult = itmRcd.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_ATTRIBUTES_RESULT);
                for(vlocity_cmt.JSONRecord jsonAttrsWrapper : jsonProdAttrnodeResult.records) {
                	vlocity_cmt.JSONAttribute jsonAttr = (vlocity_cmt.JSONAttribute)jsonAttrsWrapper;
                	jsonAttr.readOnly = true;
                	if(jsonAttr.values == null) continue;
                	for(vlocity_cmt.JSONAttribute.JSONValue jsonvalue : jsonAttr.values) {
                	 	jsonvalue.disabled = true;
                	}  
                }
            }	
        }
        if (record.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_LINEITEMS_RESULT) != null) {
            vlocity_cmt.JSONResult result = record.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_LINEITEMS_RESULT);
            for(vlocity_cmt.JSONRecord itmRcd : result.records) {
                updateOliAttrsJSONValues(itmRcd, itemIds);
            }
    
        }

        if (record.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_PRODUCTGROUPS_RESULT) != null) {
            vlocity_cmt.JSONResult result = record.nameResult.get(vlocity_cmt.JSONResult.JSON_KEY_PRODUCTGROUPS_RESULT);
            for(vlocity_cmt.JSONRecord itmRcd : result.records) {
                updateOliAttrsJSONValues(itmRcd, itemIds);
            }
    
        }
    }
}