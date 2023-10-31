/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class OrchestrationPlanControllerExtension {
    global String nsp {
        get;
    }
    global OrchestrationPlanControllerExtension() {

    }
    global OrchestrationPlanControllerExtension(ApexPages.StandardController controller) {

    }
    @RemoteAction
    global static vlocity_cmt.OrchestrationPlanControllerExtension.OrchestrationItemView getOrchestrationItem(Id itemId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static vlocity_cmt.OrchestrationPlanControllerExtension.OrchestrationPlanView getOrchestrationPlan(Id planId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static String getOrchestrationPlanId(String contextId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static String getOrchestrationPlanName(String planId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> getOrderDetails(Id orderId) {
        return null;
    }
global class CalendarInfo {
    @AuraEnabled
    global List<BusinessHours> businessHours;
    @AuraEnabled
    global List<Holiday> holidays;
    global CalendarInfo() {

    }
}
global class OrchestrationItemDepView {
    global String externalOrchItemName {
        get;
        set;
    }
    global String externalOrderNumber {
        get;
        set;
    }
}
global class OrchestrationItemView {
    @AuraEnabled
    global Id additionalId;
    @AuraEnabled
    global String additionalName;
    @AuraEnabled
    global String customTaskExecutionUrl;
    @AuraEnabled
    global List<vlocity_cmt.OrchestrationPlanControllerExtension.OrchestrationItemDepView> depObjs;
    @AuraEnabled
    global List<Id> deps;
    @AuraEnabled
    global String dueDate;
    @AuraEnabled
    global Boolean hasExternalDep;
    @AuraEnabled
    global Id id;
    @AuraEnabled
    global Boolean isPointOfNoReturn;
    @AuraEnabled
    global String name;
    @AuraEnabled
    global Id orderId;
    @AuraEnabled
    global Map<String,Object> parameters;
    @AuraEnabled
    global Id planDefId;
    @AuraEnabled
    global String startDate;
    @AuraEnabled
    global String state;
    @AuraEnabled
    global String translatedState;
    @AuraEnabled
    global String type;
}
global class OrchestrationPlanView {
    @AuraEnabled
    global vlocity_cmt.OrchestrationPlanControllerExtension.CalendarInfo calendarInfo;
    @AuraEnabled
    global List<vlocity_cmt.OrchestrationPlanControllerExtension.OrchestrationItemView> items;
    @AuraEnabled
    global Map<String,Object> planViewSettings;
    @AuraEnabled
    global List<vlocity_cmt.OrchestrationPlanControllerExtension.SwimlaneView> swimlanes;
    @AuraEnabled
    global String topicName;
}
global class SwimlaneView {
    @AuraEnabled
    global Id orderId;
    @AuraEnabled
    global String orderName;
    @AuraEnabled
    global Id planDefId;
    @AuraEnabled
    global String planDefName;
    @AuraEnabled
    global Integer showOrder;
    @AuraEnabled
    global String showOrderStr;
}
}
