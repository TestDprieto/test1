global with sharing class CPQPostHookImplementation implements vlocity_cmt.VlocityOpenInterface{


    global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)  {

             if( methodName.equalsIgnoreCase('postCartsItems.PostInvoke')) {
         
                 postCartsItems_PostInvoke(methodName, input, output,options);
                 return true;
             }

             if( methodName.equalsIgnoreCase('getCartsItems.PostInvoke')) {
         
                 postCartsItems_PostInvoke(methodName, input, output,options);
                 return true;
             }

             if( methodName.equalsIgnoreCase('getCartsItemsById.PostInvoke')) {
         
                 postCartsItems_PostInvoke(methodName, input, output,options);
                 return true;
             }

             if( methodName.equalsIgnoreCase('cloneItems.PostInvoke')) {
         
                 postCartsItems_PostInvoke(methodName, input, output,options);
                 return true;
             }

             if( methodName.equalsIgnoreCase('expandItems.PostInvoke')) {
         
                 postCartsItems_PostInvoke(methodName, input, output,options);
                 return true;
             }

             return false;

    }


    private void postCartsItems_PostInvoke(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) {
        /********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************

        System.debug('Entering HERE!!!');
        if(output == null || output.get(vlocity_cmt.JSONResult.JSON_KEY_RESULT) == null) return;
        vlocity_cmt.JSONResult result = (vlocity_cmt.JSONResult)output.get(vlocity_cmt.JSONResult.JSON_KEY_RESULT);
        if(result.records == null || result.records.isEmpty()) return;

        Id cartId = (Id)input.get('cartId');
        //Evaluating Filters
        EvaluateAttributeFilters.evaluateFilters(cartId);
        System.debug('ITEM IDS ARE :: '+EvaluateAttributeFilters.qualifiedObjectIds);
        if(EvaluateAttributeFilters.qualifiedObjectIds == null || EvaluateAttributeFilters.qualifiedObjectIds.isEmpty()) return; // no filtered items for action to be applied
        // applying action i.e. hiding all attributes
        AttributesConfigurationService.configureAttributes(result.records, EvaluateAttributeFilters.qualifiedObjectIds);
        System.debug('EXITING HERE!!!');
        ********************* SAMPLE CODE  DELETE THE COMMENT TO ACTIVATE THIS CODE ********************/

    }

}