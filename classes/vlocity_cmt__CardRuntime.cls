/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CardRuntime implements System.Callable, vlocity_cmt.VlocityOpenInterface2 {
    global CardRuntime() {

    }
    global CardRuntime(ApexPages.StandardController stdController) {

    }
    global CardRuntime(Object stdController) {

    }
    @RemoteAction
    global static String createInteractionTopic(Id accountId, String name, Id contextId, Id interactionId) {
        return null;
    }
    @RemoteAction
    global static Object doAsyncInvoke(String sClassName, String sMethodName, String input, String options, String stagingObjectId) {
        return null;
    }
    @RemoteAction
    global static String doEncryptedDatasource(Id objId, String scope) {
        return null;
    }
    @RemoteAction
    global static Object doGenericInvoke(String sClassName, String sMethodName, String input, String options) {
        return null;
    }
    @RemoteAction
    global static String doNamedCredentialCallout(String inputJSON) {
        return null;
    }
    @RemoteAction
    global static String getAccounts() {
        return null;
    }
    @RemoteAction
    global static String getActionDetails(String sObjType, String sFilterContextId, String displayOn, String linkType) {
        return null;
    }
    @RemoteAction
    global static String getActionDetailsByName(String sObjType, String sFilterContextId, String displayOn, String linkType, List<String> actionNames) {
        return null;
    }
    @RemoteAction
    global static String getActionsDetailFromId(String sObjType, String sFilterContextId, String displayOn, String linkType) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<vlocity_cmt__VlocityAction__c> getActionsInfo() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityCard__c> getActiveCardsByNames(List<String> cardNames) {
        return null;
    }
    @RemoteAction
    global static List<String> getActiveTemplateNames() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityAction__c> getAllActionsInfo() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityCard__c> getAllCardDefinitions() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityUILayout__c> getAllLayouts() {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt__VlocityCard__c getCardByGlobalKey(String key) {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt__VlocityCard__c getCardByName(String cardName) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<vlocity_cmt__VlocityCard__c> getCardsByGlobalKeys(List<String> keys) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<vlocity_cmt__VlocityCard__c> getCardsByNames(List<String> cardNames) {
        return null;
    }
    @RemoteAction
    global static String getConsoleCardsAction(String sObjType, String sFilterContextId) {
        return null;
    }
    @RemoteAction
    global static String getCustomLabelValue(String labelName) {
        return null;
    }
    @RemoteAction
    global static String getCustomLabels(List<String> labelNames, String language) {
        return null;
    }
    @RemoteAction
    global static List<CustomPermission> getCustomPermissionsForUser() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static String getCustomSettings(String customSettingName) {
        return null;
    }
    @RemoteAction
    global static Object getDataViaDataRaptor(Map<String,Object> inputMap, String bundleName) {
        return null;
    }
    @RemoteAction
    global static String getDatasourceQuery(String soqlStmt) {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt__VlocityUILayout__c getLayoutByGlobalKey(String key) {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt__VlocityUILayout__c getLayoutById(String id) {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityUILayout__c> getLayoutByName(String layoutName) {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityUILayout__c> getLayout(String searchCriterionType, String searchParam) {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityUILayout__c> getLayoutsByName(List<String> layouts) {
        return null;
    }
    @RemoteAction
    global static Boolean getLegacyOmniStudioUi() {
        return null;
    }
    @RemoteAction
    global static List<NamedCredential> getNamedCredentials() {
        return null;
    }
    @RemoteAction
    global static String getSearchQuery(String soslStmt) {
        return null;
    }
    @RemoteAction
    global static String getStaticResourcesUrl() {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt__VlocityUITemplate__c getTemplate(String templateName) {
        return null;
    }
    @AuraEnabled
    global static String getUrlForAction(String actionId, String contextId, String objType) {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt.UserProfile getUserProfile() {
        return null;
    }
    @RemoteAction
    global static Boolean isCommunity() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> trackVlocityInteraction(String trackingData) {
        return null;
    }
    @RemoteAction
    global static void updateTask(vlocity_cmt.InteractionObj interactionObj, Id interactionId) {

    }
}
