global with sharing class CustomPricingPlanStepImpl implements vlocity_cmt.VlocityOpenInterface {

    global Boolean invokeMethod (String methodName,
                                 Map<String, Object> input,
                                 Map<String, Object> output,
                                 Map<String, Object> options)
    {
        if (methodName == 'GetMatrixPrice')
        {
            getMatrixPrice(input, output, options);
        }

        return true;
    }

    private void getMatrixPrice(Map<String, Object> input,
                                Map<String, Object> output,
                                Map<String, Object> options)
    {
        SObject parent = (SObject)vlocity_cmt.PricingPlanService.getFromPricingContext('Parent');
        List<SObject> itemList = (List<SObject>)vlocity_cmt.PricingPlanService.getFromPricingContext('LineItemList');

        // Do nothing if there are no items
        if (itemList == null || itemList.isEmpty()) return;

        // If this is the first getMatrixPrice step, clear the external price flag
        Boolean clearExternalPriceFlag = (Boolean)vlocity_cmt.PricingPlanService.getFromPricingContext('ClearExternalPriceFlag');
        System.debug('ClearExternalPriceFlag: ' + clearExternalPriceFlag);
        if (clearExternalPriceFlag == null)
        {
            clearExternalPriceFlag = true;
            // Do not clear the external price flag for subsequent calls to getMatrixPrice
            vlocity_cmt.PricingPlanService.putInPricingContext('ClearExternalPriceFlag', false);
        }

        Map<String, object> priceHelperInput = new Map<String, object>();
        Map<String, object> priceHelperOutput = new Map<String, object>();
        Map<String, object> priceHelperOptions = new Map<String, object>();
        priceHelperInput.put('Parent', parent);
        priceHelperInput.put('ItemList', itemList);
        priceHelperInput.put('ClearExternalPriceFlag', clearExternalPriceFlag);
        priceHelperInput.putAll(input);

        // create the matrix input rows from the itemList
        PricingPlanHelper priceHelper = new PricingPlanHelper();
        priceHelper.invokeMethod('GetCalculationProcedurePrice', priceHelperInput, priceHelperOutput, priceHelperOptions);

        if (priceHelperOutput.get('error') != null)
        {
            output.put('error', priceHelperOutput.get('error'));
        }
    }
}