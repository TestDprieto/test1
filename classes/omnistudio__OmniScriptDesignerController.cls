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
    @AuraEnabled
    @RemoteAction
    global static List<Document> GetAllDocuments() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Map<String,String>> GetAllObjects() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Document> GetDocuments() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> GetElements2(String omniScriptId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> GetElements(String omniScriptId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Document> GetEmailDocuments() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<EmailTemplate> GetEmailTemplates() {
        return null;
    }
    @RemoteAction
    global static List<Map<String,Object>> GetExternalObjects() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Map<String,Object>> GetFieldsForObject(String interfaceObjectName) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> GetIPElements(String procedureId) {
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
    global static SObject GetOmniScript(String omniScriptId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static SObject GetOmniScript2(String omniScriptId) {
        return null;
    }
    @RemoteAction
    global static Map<String,Set<String>> GetOmniScriptTypes(Boolean isProcedure) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> GetReusableOmniScripts2() {
        return null;
    }
    @RemoteAction
    global static List<SObject> GetReusableOmniScripts() {
        return null;
    }
    @RemoteAction
    global static List<omnistudio__VlocityScheduledJob__c> GetScheduledJobs() {
        return null;
    }
    @AuraEnabled
    global static Map<String,List<String>> LoadAvailableScriptTypes() {
        return null;
    }
    @AuraEnabled
    global static Map<String,List<String>> LoadAvailableScriptTypes(Boolean isProcedure) {
        return null;
    }
    @RemoteAction
    global static List<SObject> LoadDataRaptorBundles2() {
        return null;
    }
    @RemoteAction
    global static List<SObject> LoadDataRaptorBundles() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> LoadDocuSignTemplates2() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<omnistudio__VlocityDocuSignTemplate__c> LoadDocuSignTemplates() {
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
    @AuraEnabled
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
    @AuraEnabled
    @RemoteAction
    global static Map<String,List<String>> LoadScriptElementTypes() {
        return null;
    }
    @RemoteAction
    global static List<SObject> LoadVlocityUITemplates() {
        return null;
    }
    @RemoteAction
    global static List<SObject> QueryOmniScriptKeys2(Boolean isProcedure, Boolean isReusable) {
        return null;
    }
    @RemoteAction
    global static List<SObject> QueryOmniScriptKeys(Boolean isProcedure, Boolean isReusable) {
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
    @AuraEnabled
    @RemoteAction
    global static String ViewFullDataJson(String omniScriptId) {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> cloneElement(String omniscriptId, String elementName) {
        return null;
    }
    @AuraEnabled
    global static Object createNewVersion(Id omniScriptId) {
        return null;
    }
    @AuraEnabled
    global static Object createNewVersionOfOS(String omniScriptId) {
        return null;
    }
    @AuraEnabled
    global static Map<String,List<SObject>> deleteElement2(String omniscriptId, String elementName) {
        return null;
    }
    @AuraEnabled
    global static Map<String,List<SObject>> deleteElement(String omniscriptId, String elementName) {
        return null;
    }
    @AuraEnabled
    global static List<Object> getCoreFlexCards() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static String getCustomLabels(List<String> labelNames, String language) {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> getDesignerCustomizations(String designerCustomizationType) {
        return null;
    }
    @AuraEnabled
    global static List<Map<String,Object>> getDynamicElements() {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> getElementTypes() {
        return null;
    }
    @AuraEnabled
    global static List<Object> getIntegrationProcedures() {
        return null;
    }
    @RemoteAction
    global static String getKnowledgeArticles(String keyword, String publishStatus, String langCode) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,String> getLanguageCodeMap() {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> getMatchingDRBundles2(String name, List<String> types) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<Object> getMatchingDRBundles3(String name, List<String> types) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static List<SObject> getMatchingDRBundles(String name, List<String> types) {
        return null;
    }
    @AuraEnabled
    global static List<Object> getMatrixNamesLwc() {
        return null;
    }
    @AuraEnabled
    global static String getNamespaceOfFirstInstalledPackageIfNotThis() {
        return null;
    }
    @AuraEnabled
    global static Object getNonOmniScriptLwcs(String nextUrl) {
        return null;
    }
    @AuraEnabled
    global static String getOmniLWCCompilerUrl() {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> getOmniProcessElementDesignerCustomization(String designerCustomizationType, List<String> elementIds) {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> getOmniScriptElementsWarning(String designerCustomizationType, String omniScriptId) {
        return null;
    }
    @AuraEnabled
    @RemoteAction
    global static Map<String,Object> getOmniScriptsWarningsByJsonString(String designerCustomizationTypeAndOmniScriptsListMap) {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> getOmniScriptsWarnings(Map<String,Object> designerCustomizationTypeAndOmniScriptsListMap) {
        return null;
    }
    @AuraEnabled
    global static List<SObject> getReusableOmniScriptsLwc2() {
        return null;
    }
    @AuraEnabled
    global static List<SObject> getReusableOmniScriptsLwc() {
        return null;
    }
    @RemoteAction
    global static List<Object> getVlocityScheduledJob() {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> insertNewElement(String omniscriptId, String type, String name, String parentElementId, Integer order, Integer width, Boolean isCancelAction) {
        return null;
    }
    @AuraEnabled
    global static Boolean isInsidePckg() {
        return null;
    }
    @AuraEnabled
    global static Map<String,Object> moveElement(String omniscriptId, String elementId, String parentElementId, Integer order) {
        return null;
    }
    @RemoteAction
    global static Object testIntegrationProcedure(String procedureAPIName, String input, Map<String,Object> options) {
        return null;
    }
    @RemoteAction
    global static void updateScriptLastPreviewPage(Id omniId, String newLastPreviewPage) {

    }
    @AuraEnabled
    @RemoteAction
    global static List<Document> uploadDocument(String encBody, String name, String type) {
        return null;
    }
    @RemoteAction
    global static List<String> vlocityFormulaParserFunctions() {
        return null;
    }
}
