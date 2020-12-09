/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class OmniScriptDesignerController {
    @RemoteAction
    global static System.PageReference ActivateVersion(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static String BuildJSONV3(String sId, String scriptState, Boolean bPreview, String multiLangCode) {
        return null;
    }
    @RemoteAction
    global static String BuildJSONWithPrefillV2(String sType, String sSubType, String sLang, String pfBundle, String drParams, String multiLangCode) {
        return null;
    }
    @RemoteAction
    global static System.PageReference CreateVersion(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static System.PageReference DeactivateVersion(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static List<Database.DeleteResult> DeleteElement(String elementId) {
        return null;
    }
    @RemoteAction
    global static System.PageReference DeleteOmniScript(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static void EnsureDocumentUploads() {

    }
    @RemoteAction
    global static List<Document> GetAllDocuments() {
        return null;
    }
    @RemoteAction
    global static List<Map<String,String>> GetAllObjects() {
        return null;
    }
    @RemoteAction
    global static List<Document> GetDocuments() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__Element__c> GetElements(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static List<Document> GetEmailDocuments() {
        return null;
    }
    @RemoteAction
    global static List<EmailTemplate> GetEmailTemplates() {
        return null;
    }
    @RemoteAction
    global static List<Map<String,Object>> GetExternalObjects() {
        return null;
    }
    @RemoteAction
    global static Map<String,Map<String,Object>> GetFieldsForObject(String interfaceObjectName) {
        return null;
    }
    @RemoteAction
    global static List<String> GetMatrixHeaders(String matrixName) {
        return null;
    }
    @RemoteAction
    global static Set<String> GetMatrixNames() {
        return null;
    }
    @RemoteAction
    global static Map<String,Object> GetObjectsWithExternalFields() {
        return null;
    }
    @RemoteAction
    global static vlocity_cmt__OmniScript__c GetOmniScript(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static Map<String,Set<String>> GetOmniScriptTypes(Boolean isProcedure) {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__OmniScript__c> GetReusableOmniScripts() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityScheduledJob__c> GetScheduledJobs() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__DRBundle__c> LoadDataRaptorBundles() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityDocuSignTemplate__c> LoadDocuSignTemplates() {
        return null;
    }
    @RemoteAction
    global static List<System.SelectOption> LoadElementTypes() {
        return null;
    }
    @RemoteAction
    global static List<System.SelectOption> LoadIntegrationProcedureElementTypes() {
        return null;
    }
    @RemoteAction
    global static Map<String,String> LoadIntegrationProcedureKeys2() {
        return null;
    }
    @RemoteAction
    global static Set<String> LoadIntegrationProcedureKeys() {
        return null;
    }
    @RemoteAction
    global static List<System.SelectOption> LoadLanguages() {
        return null;
    }
    @RemoteAction
    global static String LoadPropertySetForElement(String elementType, Boolean isProcedure) {
        return null;
    }
    @RemoteAction
    global static Map<String,List<String>> LoadScriptElementTypes() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__VlocityUITemplate__c> LoadVlocityUITemplates() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__OmniScript__c> QueryOmniScriptKeys(Boolean isProcedure, Boolean isReusable) {
        return null;
    }
    @RemoteAction
    global static Database.UpsertResult SaveElement(Map<Object,Object> elementJson) {
        return null;
    }
    @RemoteAction
    global static Database.UpsertResult SaveOmniScript(Map<Object,Object> omniScriptJson) {
        return null;
    }
    @RemoteAction
    global static String ViewFullDataJson(String omniSriptId) {
        return null;
    }
    @RemoteAction
    global static String getCustomLabels(List<String> labelNames, String language) {
        return null;
    }
    @RemoteAction
    global static String getKnowledgeArticles(String keyword, String publishStatus, String langCode) {
        return null;
    }
    @RemoteAction
    global static Map<String,String> getLanguageCodeMap() {
        return null;
    }
    @RemoteAction
    global static List<vlocity_cmt__DRBundle__c> getMatchingDRBundles(String name, List<String> types) {
        return null;
    }
    @RemoteAction
    global static Object testIntegrationProcedure(String procedureAPIName, String input, Map<String,Object> options) {
        return null;
    }
    @RemoteAction
    global static void updateScriptLastPreviewPage(Id omniId, String newLastPreviewPage) {

    }
    @RemoteAction
    global static List<Document> uploadDocument(String encBody, String name, String type) {
        return null;
    }
    @RemoteAction
    global static List<String> vlocityFormulaParserFunctions() {
        return null;
    }
}
