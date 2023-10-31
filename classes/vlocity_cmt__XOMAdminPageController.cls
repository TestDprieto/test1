/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XOMAdminPageController {
    global String debugLogsUIUrl {
        get;
    }
    global Boolean isDeltaTrackingEnabled {
        get;
    }
    global Boolean isInsurance {
        get;
    }
    global Boolean isThorEnabled {
        get;
    }
    global String labelsServicesUrl {
        get;
    }
    global String monitoringUIUrl {
        get;
    }
    global String namespacePrefix {
        get;
    }
    global String uiServicesUrl {
        get;
    }
    global XOMAdminPageController() {

    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> abortOrchFutureDatedJobs() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Map<String,Object>> calcScopeForSyncDelta() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Integer checkOdinConfig() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Boolean cleanupSyncDelta() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static void configureOdin(Integer mode) {

    }
    @AuraEnabled
    @RemoteAction
    global static void createDataRaptorBundlesForBackSync() {

    }
    @AuraEnabled
    @RemoteAction
    global static Boolean ensureGlobalKeys() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Integer ensureGlobalKeysBatch(Integer idx) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Map<String,Object>> getCountsForSyncDelta() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static AsyncApexJob getJobStatus(String jobClassName) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Profile> getProfileDetails() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static void populateSyncDelta(String request) {

    }
    @AuraEnabled
    @RemoteAction
    global static void refreshCustomLabelsCache(List<String> customLabels) {

    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> restartSyncDeltaJob() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static void scheduleJeopardyManagementJobs() {

    }
    @AuraEnabled
    @RemoteAction
    global static void scheduleOrchFutureDatedJobs() {

    }
    @AuraEnabled
    @RemoteAction
    global static void scheduleOrchestrationRecoveryJobs() {

    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> scheduleSyncDeltaJobForType(String sObjectType, Integer batchSize) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> startJob(String jobName) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> stopJob(String jobName) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Boolean updateOrchQueuesCnt() {
        return null;
    }
}
