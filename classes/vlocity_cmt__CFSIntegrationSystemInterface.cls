/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class CFSIntegrationSystemInterface extends vlocity_cmt.DefaultSystemInterface {
    global CFSIntegrationSystemInterface() {

    }
    global override System.HttpRequest createHttpRequest(String url, String path, String requestPayload) {
        return null;
    }
    global override void executeItem(String url, String path, vlocity_cmt__OrchestrationItem__c item) {

    }
    global override String generatePayload(vlocity_cmt__OrchestrationItem__c item, vlocity_cmt.XOMOrderDomainObject orderObj) {
        return null;
    }
    global virtual String getClassName() {
        return null;
    }
    global virtual String getSuccessStatus() {
        return null;
    }
    global virtual void processCFSResponse(vlocity_cmt__OrchestrationItem__c item, vlocity_cmt.XOMOrderDomainObject orderObj, System.HttpResponse res) {

    }
    global virtual void processRecoverableErrorResponse(vlocity_cmt__OrchestrationItem__c item, vlocity_cmt.XOMOrderDomainObject orderObj, System.HttpRequest req, System.HttpResponse res, vlocity_cmt.DRProcessResult result) {

    }
    global virtual void processResponse(vlocity_cmt__OrchestrationItem__c item, String url, String path, System.HttpResponse res) {

    }
    global override void processResponse(vlocity_cmt__OrchestrationItem__c item, String url, String path, vlocity_cmt.XOMOrderDomainObject orderObj, System.HttpResponse res) {

    }
    global virtual void processStandardErrorResponse(vlocity_cmt__OrchestrationItem__c item, vlocity_cmt.XOMOrderDomainObject orderObj, System.HttpRequest req, System.HttpResponse res) {

    }
    global virtual void processUncaughtErrorResponse(vlocity_cmt__OrchestrationItem__c item, vlocity_cmt.XOMOrderDomainObject orderObj, System.HttpResponse res, vlocity_cmt.DRProcessResult result) {

    }
}
