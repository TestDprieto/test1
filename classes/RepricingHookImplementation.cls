global with sharing class RepricingHookImplementation implements vlocity_cmt.VlocityOpenInterface
{
    global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)  
    {
         if (methodName == 'repriceLineItems.PostInvoke') {
             //System.debug('input: ' + JSON.serialize(input));
             //System.debug('output: ' + JSON.serialize(output));
             //System.debug('options: ' + JSON.serialize(options));
             repriceLineItems_PostInvoke(methodName, input, output, options);
             return true;
         }
         return false;
    }


    private void repriceLineItems_PostInvoke(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) 
    {
        List<SObject> objList = (List<SObject>)input.get('objectList');
        if (objList != null && !objList.isEmpty())
        {
            Id orderId = null;
            SObject obj = objList[0];
            if (obj.Id.getSObjectType() == OrderItem.sObjectType)
            {
                SObject item = [SELECT Id, OrderId from OrderItem where Id =: obj.Id LIMIT 1];
                if (item != null)
                {
                    orderId = (Id)item.get('OrderId');                      
                }
            }
            else if (obj.Id.getSObjectType() == Order.sObjectType)
            {
                orderId = obj.Id;
            }            
            if (orderId != null)
            {
                System.debug('orderId: ' + orderId);
                Map<String, Object> appInput = new Map<String, Object>();
                Map<String, Object> appOutput = new Map<String, Object>();
                Map<String, Object> appOptions = new Map<String, Object>();
                appInput.put('cartId', String.valueOf(orderId));
                appInput.put('price', true);
                appInput.put('validate', false);
                vlocity_cmt.CpqAppHandler appHandler = new vlocity_cmt.CpqAppHandler();
                appHandler.invokeMethod('getCartsItems', appInput, appOutput, appOptions);
            }
        }
    }

}