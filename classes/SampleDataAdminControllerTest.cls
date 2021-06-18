@isTest(seeAllData=false)
public with sharing class SampleDataAdminControllerTest {
    static testMethod void testDRImport(){
        vlocity_cmt.CorePostInstallClass.runDev2ProdInserts();
        vlocity_cmt__TriggerSetup__c myTrigger = new vlocity_cmt__TriggerSetup__c(Name='AllTriggers', vlocity_cmt__IsTriggerOn__c=true);
        insert myTrigger;
        Test.startTest();
        
        SampleDataAdminController.invokeMethod('VLC_SampleDR_OrderItemAttr');

        Test.stopTest();
    }
    static testMethod void testCMImport(){
        vlocity_cmt.CorePostInstallClass.runDev2ProdInserts();
        vlocity_cmt__TriggerSetup__c myTrigger = new vlocity_cmt__TriggerSetup__c(Name='AllTriggers', vlocity_cmt__IsTriggerOn__c=true);
        insert myTrigger;

        Test.startTest();
        String cmPacks = SampleDataAdminController.getAllCMDataPacks();
        System.debug(cmPacks);
        Map<String, Object> result = SampleDataAdminController.importCMData('VLC_SampleCM_ActivateContractAction');
        System.debug(result);
        SampleDataAdminController dataAdmin = new SampleDataAdminController();
        result = SampleDataAdminController.importCMData('VLC_SampleCM_Blah');
        System.debug(result);
        Test.stopTest();
    }
}