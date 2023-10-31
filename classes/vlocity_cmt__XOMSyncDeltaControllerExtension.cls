/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XOMSyncDeltaControllerExtension {
    global Integer catalogSyncEventBatchSize {
        get;
    }
    global Boolean isQueueingEnabled {
        get;
    }
    global String nsp {
        get;
    }
    global String thorSyncUrl {
        get;
    }
    global String uiServicesUrl {
        get;
    }
    @RemoteAction
    global static void commitBatch(List<String> deltaIds) {

    }
    @AuraEnabled
    @RemoteAction
    global static String forceStartCatalogSyncBatchJob() {
        return null;
    }
    @RemoteAction
    global static List<Object> getBatch(Integer batchSize) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> getEnvVariables() {
        return null;
    }
    @RemoteAction
    global static String getExtendedStatus() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static AsyncApexJob getJobStatus() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static vlocity_cmt.XOMSyncDeltaService.Size getNumberOfBatches(Integer batchSize) {
        return null;
    }
}
