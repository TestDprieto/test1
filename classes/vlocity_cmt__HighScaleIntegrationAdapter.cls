/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class HighScaleIntegrationAdapter implements vlocity_cmt.XOMOrchestrationInterfaces.IDeferredUpdater, vlocity_cmt.XOMOrchestrationInterfaces.IHighScaleSystemInterface {
    global HighScaleIntegrationAdapter() {

    }
    global virtual System.HttpResponse executeItem(String url, String path, vlocity_cmt__OrchestrationItem__c item, System.HttpRequest request) {
        return null;
    }
    global virtual void parseResponse(vlocity_cmt__OrchestrationItem__c item, String url, String path, System.HttpResponse response) {

    }
    global virtual void persistOrchestrationItemLogs(List<vlocity_cmt__OrchestrationItem__c> items) {

    }
    global virtual System.HttpRequest prepareRequest(String url, String path, vlocity_cmt__OrchestrationItem__c item) {
        return null;
    }
global class HighScaleSystemIfaceUnrecoverableException extends Exception {
}
}
