/**
 * This is sample implementation for 'PostChangeHandler'..
 * :-postChangeForQuote
 * It shows how to access the created quote and modify the fields as per the requirement.
 * postChangeForOrder:-
 * It shows how to access the created order and modify the fields as per the requirement
 * 
 */
global with sharing class SamplePostChangeHandlerImplementation  implements vlocity_cmt.VlocityOpenInterface{
    global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)  {
            if (methodName.equals('postChangeForQuote')){
                return postChangeForQuote(input,output,options);
            }else if (methodName.equals('postChangeForOrder')){
                return postChangeForOrder(input,output,options);
            }
            return false;
        }
    private Boolean postChangeForQuote(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options){
        try{
            Id createdQuoteId = (Id)input.get('createdObjectId');
            List<Quote> createdQuoteList = [SELECT Id, Name, vlocity_cmt__TrackingNumber__c FROM Quote WHERE Id = :createdQuoteId];
            
            //Changing a sample field Tracking Number
            if(createdQuoteList != null) {
                Quote createdQuote = createdQuoteList[0];
                createdQuote.vlocity_cmt__TrackingNumber__c = '1000000';
                update createdQuote;
            }
            return true;
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage());
        }
        return false;
    }

    private Boolean postChangeForOrder(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options){
        try{
            Id createdOrderId = (Id)input.get('createdObjectId');
            List<Order> createdOrderList = [SELECT Id, Name, vlocity_cmt__TrackingNumber__c FROM Order WHERE Id = :createdOrderId];
            
            //Changing a sample field  Tracking Number
            if(createdOrderList != null) {
                Order createdOrder = createdOrderList[0];
                createdOrder.vlocity_cmt__TrackingNumber__c = '1000000';
                update createdOrder;
            }
            return true;
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage());
        }
        return false;
    }
}