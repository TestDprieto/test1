/**
 * Created by somalmac on 6/18/18.
 */
@isTest(SeeAllData=false)
public class CustomPricingPlanStepImplTest {

    private static String namespace = 'vlocity_cmt__';

    // Intitialized in Setup, used throughout
    public static vlocity_cmt__CalculationMatrixVersion__c version;
    public static vlocity_cmt__CalculationMatrix__c parent;
    public static List<vlocity_cmt__CalculationMatrixRow__c> lineItems;
    private static Id orderId;
    private static boolean flag;  //used to upload matrix row data for test1 or test2


    //Testing Price a target using attribute value range
    /*
    Input : "Consumer Landline" order Item which has "Provider" Attribute having "Verizon"
    Output : MRC 300 and NRC 125 and Target Product Name : Path3 (HD TV)
    */
    static private testmethod void test1(){

        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String,Object>();
        Map<String, Object> input = new Map<String, Object>();
        flag = false;

        Test.startTest();
        testProductSetup();
        testMatrixSetup();

        sObject targetProduct = [SELECT Id, Name FROM Product2 WHERE Name = 'HD TV'];
        sObject orderSObject = [SELECT Id FROM Order WHERE Id = :orderId];
        List<SObject> orderItemList = [SELECT   Id, PricebookEntryId, PricebookEntry.Product2.Name, PricebookEntry.Product2.ProductCode, Quantity,
                vlocity_cmt__PricingLogData__c, vlocity_cmt__ProvisioningStatus__c, vlocity_cmt__RecurringCharge__c,
                vlocity_cmt__OneTimeCharge__c, vlocity_cmt__JSONAttribute__c,vlocity_cmt__LineNumber__c
                FROM OrderItem WHERE OrderId = :orderId];

        vlocity_cmt.PricingPlanService.putInPricingContext('Parent', orderSObject);
        vlocity_cmt.PricingPlanService.putInPricingContext('LineItemList', orderItemList);

        input.put('ProcedureName','TargetPathRangePricingDemoProcedureTest');
        input.put('MatrixName','TargetPathRangePricingMatrixTest');
        //input.put('Path1','Triple Play Bundle Small<Consumer Landline');
        //input.put('Path2','Triple Play Bundle Small<Broadband Internet Small');
        input.put('Path3','Triple Play Bundle Small<TV Small<HD TV');
        input.put('RangeFields','Quantity');
        input.put('RangeAttributes','TV Boxes Required');

        CustomPricingPlanStepImpl testing = new CustomPricingPlanStepImpl();
        testing.invokeMethod('GetMatrixPrice',input,output,options);

        for(SObject orderItem : orderItemList){
            if(orderItem.get('vlocity_cmt__RecurringCharge__c')!=null)
            {
                System.assert(orderItem.get('vlocity_cmt__RecurringCharge__c') == 300.00 );
                System.assert(orderItem.get('vlocity_cmt__OneTimeCharge__c') == 125.00 );
            }
        }

        Test.stopTest();
    }

    //Testing Price a target using attribute value range
    /*
    Input : "Broadband Internet Small" order Item which has "Internet Upload Speed;Internet Download Speed"  ......  Default : "80Mbps;16Mbps"
    Output : MRC 25 and NRC 0 and Target Product Name : Path1 (Consumer Product)
    */
    static private testmethod void test2(){

        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String,Object>();
        Map<String, Object> input = new Map<String, Object>();
        flag = true;

        Test.startTest();
        testProductSetup();
        testMatrixSetup();

        sObject targetProduct = [ SELECT Id, Name FROM Product2 WHERE Name = 'Consumer Landline'];
        sObject orderSObject = [SELECT Id FROM Order WHERE Id = :orderId];
        List<SObject> orderItemList = [SELECT   Id, PricebookEntryId, PricebookEntry.Product2.Name, PricebookEntry.Product2.ProductCode, Quantity,
                vlocity_cmt__PricingLogData__c, vlocity_cmt__ProvisioningStatus__c, vlocity_cmt__RecurringCharge__c,
                vlocity_cmt__OneTimeCharge__c, vlocity_cmt__JSONAttribute__c,vlocity_cmt__LineNumber__c
                FROM OrderItem WHERE OrderId = :orderId];

        vlocity_cmt.PricingPlanService.putInPricingContext('Parent', orderSObject);
        vlocity_cmt.PricingPlanService.putInPricingContext('LineItemList', orderItemList);

        input.put('ProcedureName','TargetPathRangePricingDemoProcedureTest');
        input.put('MatrixName','TargetPathRangePricingMatrixTest');
        input.put('Path1','Triple Play Bundle Small<Consumer Landline');
        //input.put('Path2','Triple Play Bundle Small<Broadband Internet Small');
        //input.put('Path3','Triple Play Bundle Small<TV Small<HD TV');
        input.put('RangeFields','Quantity');
        input.put('RangeAttributes','TV Boxes Required');

        CustomPricingPlanStepImpl testing = new CustomPricingPlanStepImpl();
        testing.invokeMethod('GetMatrixPrice',input,output,options);

        for(SObject orderItem : orderItemList){
            if(orderItem.get('vlocity_cmt__RecurringCharge__c')!=null)
            {
                System.assert(orderItem.get('vlocity_cmt__RecurringCharge__c') == 25.00 );
                System.assert(orderItem.get('vlocity_cmt__OneTimeCharge__c') == 0 );
            }
        }

        Test.stopTest();
    }

    static private void testMatrixSetup() {
        insert new vlocity_cmt__TriggerSetup__c(Name = 'AllTriggers', vlocity_cmt__IsTriggerOn__c = true);
        parent = new vlocity_cmt__CalculationMatrix__c(Name = 'TargetPathRangePricingMatrixTest');
        insert parent;

        version = new vlocity_cmt__CalculationMatrixVersion__c(Name = 'TargetPathRangePricingMatrixTest Version', vlocity_cmt__VersionNumber__c = 2,
                vlocity_cmt__IsEnabled__c = false, vlocity_cmt__CalculationMatrixId__c = parent.Id,
                vlocity_cmt__StartDateTime__c = DateTime.now().addDays(-10), vlocity_cmt__EndDateTime__c = DateTime.now().addDays(10),vlocity_cmt__Priority__c = 2);
        insert version;

        //Populating Headers
        lineItems = new List<vlocity_cmt__CalculationMatrixRow__c>();
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"Characteristic Name\",\"label\":null,\"headerType\":\"Input\",\"displayOrder\":1,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"Source Product Code\",\"label\":null,\"headerType\":\"Input\",\"displayOrder\":2,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"Source Product Name\",\"label\":null,\"headerType\":\"Input\",\"displayOrder\":3,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"Characteristic Value\",\"label\":null,\"headerType\":\"Input\",\"displayOrder\":4,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"Quantity\",\"label\":null,\"headerType\":\"Input\",\"displayOrder\":5,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"Target Product Name\",\"label\":null,\"headerType\":\"Output\",\"displayOrder\":6,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"MRC\",\"label\":null,\"headerType\":\"Output\",\"displayOrder\":7,\"dataType\":\"Text\"}'
        ));
        lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id, Name = 'Header',
                vlocity_cmt__InputData__c ='{\"listValues\":null,\"name":\"NRC\",\"label\":null,\"headerType\":\"Output\",\"displayOrder\":8,\"dataType\":\"Text\"}'
        ));
        insert lineItems;

        //Populating Row Data
        lineItems = new List<vlocity_cmt__CalculationMatrixRow__c>();

        if(flag)  //running test2
        {
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"1-10\",\"Characteristic Value\":\"16Mbps;80Mbps\",\"Characteristic Name\":"Internet Upload Speed;Internet Download Speed\",\"Source Product Code\":\"VLO-INT-0001\",\"Source Product Name\":\"Broadband Internet Small\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"0\",\"MRC\":\"15\",\"Target Product Name\":\"Path1\"}'
            ));
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"11-20\",\"Characteristic Value\":\"16Mbps;80Mbps\",\"Characteristic Name\":"Internet Upload Speed;Internet Download Speed\",\"Source Product Code\":\"VLO-INT-0001\",\"Source Product Name\":\"Broadband Internet Small\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"0\",\"MRC\":\"25\",\"Target Product Name\":\"Path1\"}'
            ));
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"1-10\",\"Characteristic Value\":\"18Mbps;90Mbps\",\"Characteristic Name\":"Internet Upload Speed;Internet Download Speed\",\"Source Product Code\":\"VLO-INT-0001\",\"Source Product Name\":\"Broadband Internet Small\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"0\",\"MRC\":\"30\",\"Target Product Name\":\"Path1\"}'
            ));
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"1-10\",\"Characteristic Value\":\"20Mbps;100Mbps\",\"Characteristic Name\":"Internet Upload Speed;Internet Download Speed\",\"Source Product Code\":\"VLO-INT-0001\",\"Source Product Name\":\"Broadband Internet Small\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"0\",\"MRC\":\"35\",\"Target Product Name\":\"Path1\"}'
            ));
        }
        else   //running test1
        {
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"1-10\",\"Characteristic Value\":\"Xfinity\",\"Characteristic Name\":"Provider\",\"Source Product Code\":\"VLO-PHN-0005\",\"Source Product Name\":\"Consumer Landline\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"105\",\"MRC\":\"50\",\"Target Product Name\":\"Path3\"}'
            ));
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"11-20\",\"Characteristic Value\":\"Xfinity\",\"Characteristic Name\":"Provider\",\"Source Product Code\":\"VLO-PHN-0005\",\"Source Product Name\":\"Consumer Landline\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"115\",\"MRC\":\"100\",\"Target Product Name\":\"Path3\"}'
            ));
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"1-10\",\"Characteristic Value\":\"Verizon\",\"Characteristic Name\":"Provider\",\"Source Product Code\":\"VLO-PHN-0005\",\"Source Product Name\":\"Consumer Landline\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"125\",\"MRC\":\"300\",\"Target Product Name\":\"Path3\"}'
            ));
            lineItems.add(new vlocity_cmt__CalculationMatrixRow__c(vlocity_cmt__CalculationMatrixVersionId__c = version.Id,
                    vlocity_cmt__InputData__c ='{\"Quantity\":\"11-20\",\"Characteristic Value\":\"Verizon\",\"Characteristic Name\":"Provider\",\"Source Product Code\":\"VLO-PHN-0005\",\"Source Product Name\":\"Consumer Landline\"}',
                    vlocity_cmt__OutputData__c = '{\"NRC\":\"135\",\"MRC\":\"600\",\"Target Product Name\":\"Path3\"}'
            ));
        }
        insert lineItems;

        lineItems = [SELECT Name, vlocity_cmt__InputData__c, vlocity_cmt__OutputData__c FROM vlocity_cmt__CalculationMatrixRow__c WHERE Name != 'Header'];
        update new vlocity_cmt__CalculationMatrixVersion__c(Id = version.Id, vlocity_cmt__IsEnabled__c = true);

        //service
        vlocity_cmt__CalculationProcedure__c calcProcedure = new vlocity_cmt__CalculationProcedure__c(Name='TargetPathRangePricingDemoProcedureTest');
        insert calcProcedure;

        //Making isEnabled = false due to ERROR="Please add steps before enabling this procedure configuration."
        vlocity_cmt__CalculationProcedureVersion__c procVersion = new vlocity_cmt__CalculationProcedureVersion__c(Name='TargetPathRangePricingDemo V3', vlocity_cmt__VersionNumber__c=2, vlocity_cmt__IsEnabled__c=false,
                vlocity_cmt__CalculationProcedureId__c=calcProcedure.Id, vlocity_cmt__StartDateTime__c = DateTime.now().addDays(-5), vlocity_cmt__EndDateTime__c = DateTime.now().addDays(5), vlocity_cmt__Priority__c=2);
        insert procVersion;

        List<vlocity_cmt__CalculationProcedureStep__c> steps = new List<vlocity_cmt__CalculationProcedureStep__c> ();
        vlocity_cmt__CalculationProcedureStep__c step1 = new vlocity_cmt__CalculationProcedureStep__c (Name='a1L46000001ASQm', vlocity_cmt__Sequence__c=1,vlocity_cmt__Function__c='Matrix Lookup', vlocity_cmt__CalculationMatrixId__c=parent.Id, vlocity_cmt__IsIncludedInResult__c=true, vlocity_cmt__CalculationProcedureVersionId__c= procVersion.Id,
                vlocity_cmt__Input__c='[{\"name\":\"Source Product Name\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"dea1b0\"},{\"name\":\"Source Product Code\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"15e771\"},{\"name\":\"Characteristic Name\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"a81456\"},{\"name\":\"Characteristic Value\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"880c2d\"},{\"name\":\"Quantity\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"94bbbe\"}]',
                vlocity_cmt__OutputMappingJSON__c ='{\"Target Product Name\":\"TargetPathRangePricing__TargetProductName\",\"MRC\":\"TargetPathRangePricing__MRC\",\"NRC\":\"TargetPathRangePricing__NRC\"}',
                vlocity_cmt__OutputJSON__c='[{\"name\":\"Target Product Name\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"fea7df\"},{\"name\":\"MRC\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"7776f5\"},{\"name\":\"NRC\",\"listValues\":null,\"label\":null,\"dataType\":\"Text\",\"columnKey\":\"ac5769\"}]');
        vlocity_cmt__CalculationProcedureStep__c step2 = new vlocity_cmt__CalculationProcedureStep__c (Name='a1L46000001ASQn', vlocity_cmt__Sequence__c=2,vlocity_cmt__Function__c='Calculation', vlocity_cmt__IsIncludedInResult__c=true, vlocity_cmt__CalculationProcedureVersionId__c= procVersion.Id,
                vlocity_cmt__CalculationFormulaLong__c='TargetPathRangePricing__MRC', vlocity_cmt__OutputJSON__c='{\"name\":\"REC_MNTH_STD_PRC\",\"dataType\":\"Currency\",\"alias\":\"REC_MNTH_STD_PRC\"}',
                vlocity_cmt__OutputMappingJSON__c = '{\"REC_MNTH_STD_PRC\":\"REC_MNTH_STD_PRC\"}', vlocity_cmt__CalculationFormulaTags__c='[{\"text\":\"MRC ( TargetPathRangePricing )\",\"alias\":\"TargetPathRangePricing__MRC\",\"userDefined\":false,\"dataType\":\"Text\"}]');
        vlocity_cmt__CalculationProcedureStep__c step3 = new vlocity_cmt__CalculationProcedureStep__c (Name='a1L46000001ASQo', vlocity_cmt__Sequence__c=3,vlocity_cmt__Function__c='Calculation', vlocity_cmt__IsIncludedInResult__c=true, vlocity_cmt__CalculationProcedureVersionId__c= procVersion.Id,
                vlocity_cmt__CalculationFormulaLong__c='TargetPathRangePricing__NRC',vlocity_cmt__OutputMappingJSON__c = '{\"OT_STD_PRC\":\"OT_STD_PRC\"}',
                vlocity_cmt__OutputJSON__c='{\"name\":\"OT_STD_PRC\",\"dataType\":\"Currency\",\"alias\":\"OT_STD_PRC\"}',vlocity_cmt__CalculationFormulaTags__c='[{\"text\":\"MRC ( TargetPathRangePricing )\",\"alias\":\"TargetPathRangePricing__NRC\",\"userDefined\":false,\"dataType\":\"Text\"}]' );
        steps.add(step1);
        steps.add(step2);
        steps.add(step3);
        insert steps;

        List<vlocity_cmt__CalculationProcedureVariable__c> calcProcVariableList = new List<vlocity_cmt__CalculationProcedureVariable__c>{
                new vlocity_cmt__CalculationProcedureVariable__c(name='REC_MNTH_STD_PRC',vlocity_cmt__alias__c='REC_MNTH_STD_PRC',vlocity_cmt__datatype__c='Currency',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='OT_STD_PRC',vlocity_cmt__alias__c='OT_STD_PRC',vlocity_cmt__datatype__c='Currency',vlocity_cmt__defaultValue__c='27',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='Source Product Name',vlocity_cmt__alias__c='SourceProductName',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='Source Product Code',vlocity_cmt__alias__c='SourceProductCode',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='Characteristic Name',vlocity_cmt__alias__c='CharacteristicName',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='Characteristic Value',vlocity_cmt__alias__c='CharacteristicValue',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='Quantity',vlocity_cmt__alias__c='Quantity',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='Target Product Name',vlocity_cmt__alias__c='TargetPathRangePricing__TargetProductName',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='MRC',vlocity_cmt__alias__c='TargetPathRangePricing__MRC',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id),
                new vlocity_cmt__CalculationProcedureVariable__c(name='NRC',vlocity_cmt__alias__c='TargetPathRangePricing__NRC',vlocity_cmt__datatype__c='Text',vlocity_cmt__defaultValue__c='false',vlocity_cmt__CalculationProcedureVersionId__c=procVersion.Id)
                };
        insert calcProcVariableList;

        //Creating and enabling CalculationProcedureVersion
        update new vlocity_cmt__CalculationProcedureVersion__c(Id = procVersion.Id, vlocity_cmt__IsEnabled__c = true);

    }

    //Initializing Product Details
    static private void testProductSetup(){

        vlocity_cmt__TriggerSetup__c itemTrigger = new vlocity_cmt__TriggerSetup__c(Name='AllTriggers', vlocity_cmt__IsTriggerOn__c=true);
        insert itemTrigger;

        List<SObject> sObjList = new List<sObject>();
        Product2 prod1 = new Product2 (Name='Triple Play Bundle Small', ProductCode = 'VLO-BUN-0001');
        sObjList.add(prod1);

        Product2 prod2 = new Product2 (Name='Consumer Landline', ProductCode = 'VLO-PHN-0005');
        sObjList.add(prod2);

        Product2 prod3 = new Product2 (Name='Broadband Internet Small', ProductCode = 'VLO-INT-0001');
        sObjList.add(prod3);

        Product2 prod4 = new Product2 (Name='TV Small', ProductCode = 'VLO-TV-0025');
        sObjList.add(prod4);

        Product2 prod5 = new Product2 (Name='HD TV', ProductCode = 'VLO-TV-0008');
        sObjList.add(prod5);

        insert sObjList;
        sObjList.clear();

        // Create Product Child Item
        vlocity_cmt__ProductChildItem__c pci1 = new vlocity_cmt__ProductChildItem__c();
        pci1.vlocity_cmt__ParentProductId__c = prod1.Id;
        pci1.vlocity_cmt__ChildProductId__c = prod2.Id;
        pci1.Name = 'Test PCI1';
        pci1.vlocity_cmt__Quantity__c = 1.0;
        pci1.vlocity_cmt__MinQuantity__c = 1.0;
        pci1.vlocity_cmt__MaxQuantity__c = 25.0;
        pci1.vlocity_cmt__IsRootProductChildItem__c = false;
        pci1.vlocity_cmt__IsOverride__c = false;
        pci1.vlocity_cmt__ChildLineNumber__c = '0001';
        pci1.vlocity_cmt__IsVirtualItem__c = false;
        sObjList.add(pci1);

        vlocity_cmt__ProductChildItem__c pci2 = new vlocity_cmt__ProductChildItem__c();
        pci2.vlocity_cmt__ParentProductId__c = prod1.Id;
        pci2.vlocity_cmt__ChildProductId__c = prod3.Id;
        pci2.Name = 'Test PCI2';
        pci2.vlocity_cmt__Quantity__c = 1.0;
        pci2.vlocity_cmt__MinQuantity__c = 1.0;
        pci2.vlocity_cmt__MaxQuantity__c = 1.0;
        pci2.vlocity_cmt__IsRootProductChildItem__c = false;
        pci2.vlocity_cmt__IsOverride__c = false;
        pci2.vlocity_cmt__ChildLineNumber__c = '0002';
        pci2.vlocity_cmt__IsVirtualItem__c = false;
        sObjList.add(pci2);

        vlocity_cmt__ProductChildItem__c pci3 = new vlocity_cmt__ProductChildItem__c();
        pci3.vlocity_cmt__ParentProductId__c = prod1.Id;
        pci3.vlocity_cmt__ChildProductId__c = prod4.Id;
        pci3.Name = 'Test PCI3';
        pci3.vlocity_cmt__Quantity__c = 1.0;
        pci3.vlocity_cmt__MinQuantity__c = 1.0;
        pci3.vlocity_cmt__MaxQuantity__c = 1.0;
        pci3.vlocity_cmt__IsRootProductChildItem__c = false;
        pci3.vlocity_cmt__IsOverride__c = false;
        pci3.vlocity_cmt__ChildLineNumber__c = '0003';
        pci3.vlocity_cmt__IsVirtualItem__c = false;
        sObjList.add(pci3);

        vlocity_cmt__ProductChildItem__c pci4 = new vlocity_cmt__ProductChildItem__c();
        pci4.vlocity_cmt__ParentProductId__c = prod3.Id;
        pci4.vlocity_cmt__ChildProductId__c = prod4.Id;
        pci4.Name = 'Test PCI4';
        pci4.vlocity_cmt__Quantity__c = 1.0;
        pci4.vlocity_cmt__MinQuantity__c = 1.0;
        pci4.vlocity_cmt__MaxQuantity__c = 20.0;
        pci4.vlocity_cmt__IsRootProductChildItem__c = false;
        pci4.vlocity_cmt__IsOverride__c = false;
        pci4.vlocity_cmt__ChildLineNumber__c = '0001';
        pci4.vlocity_cmt__IsVirtualItem__c = false;
        sObjList.add(pci4);

        insert sObjList;
        sObjList.clear();

        Pricebook2 standardBook =  new Pricebook2(Id = Test.getStandardPricebookId(), Name = 'TestPricebook5', IsActive = true);
        Pricebook2 testPricebook = new Pricebook2(Name = 'TestPricebook7', IsActive = true);
        insert testPricebook;

        //Inserting into standard Pricebook
        PricebookEntry pbe11 = new PricebookEntry(Pricebook2Id = standardBook.Id,
                Product2Id = prod1.Id, UnitPrice = 10, vlocity_cmt__RecurringPrice__c = 5, IsActive = true);
        sObjList.add(pbe11);

        PricebookEntry pbe12 = new PricebookEntry(Pricebook2Id = standardBook.Id,
                Product2Id = prod2.Id, UnitPrice = 20, vlocity_cmt__RecurringPrice__c = 10, IsActive = true);
        sObjList.add(pbe12);

        PricebookEntry pbe13 = new PricebookEntry(Pricebook2Id = standardBook.Id,
                Product2Id = prod3.Id, UnitPrice = 30, vlocity_cmt__RecurringPrice__c = 15, IsActive = true);
        sObjList.add(pbe13);

        PricebookEntry pbe14 = new PricebookEntry(Pricebook2Id = standardBook.Id,
                Product2Id = prod4.Id, UnitPrice = 40, vlocity_cmt__RecurringPrice__c = 20, IsActive = true);
        sObjList.add(pbe14);

        PricebookEntry pbe15 = new PricebookEntry(Pricebook2Id = standardBook.Id,
                Product2Id = prod5.Id, UnitPrice = 50, vlocity_cmt__RecurringPrice__c = 25, IsActive = true);
        sObjList.add(pbe15);

        //insert sObjList;
        //sObjList.clear();

        //Inserting into Custom Pricebook
        PricebookEntry pbe1 = new PricebookEntry(Pricebook2Id = testPricebook.Id,
                Product2Id = prod1.Id, UnitPrice = 10, vlocity_cmt__RecurringPrice__c = 5, IsActive = true, UseStandardPrice = false);
        sObjList.add(pbe1);

        PricebookEntry pbe2 = new PricebookEntry(Pricebook2Id = testPricebook.Id,
                Product2Id = prod2.Id, UnitPrice = 20, vlocity_cmt__RecurringPrice__c = 10, IsActive = true, UseStandardPrice = false);
        sObjList.add(pbe2);

        PricebookEntry pbe3 = new PricebookEntry(Pricebook2Id = testPricebook.Id,
                Product2Id = prod3.Id, UnitPrice = 30, vlocity_cmt__RecurringPrice__c = 15, IsActive = true, UseStandardPrice = false);
        sObjList.add(pbe3);

        PricebookEntry pbe4 = new PricebookEntry(Pricebook2Id = testPricebook.Id,
                Product2Id = prod4.Id, UnitPrice = 40, vlocity_cmt__RecurringPrice__c = 20, IsActive = true, UseStandardPrice = false);
        sObjList.add(pbe4);

        PricebookEntry pbe5 = new PricebookEntry(Pricebook2Id = testPricebook.Id,
                Product2Id = prod5.Id, UnitPrice = 45, vlocity_cmt__RecurringPrice__c = 25, IsActive = true, UseStandardPrice = false);
        sObjList.add(pbe5);

        insert sObjList;
        sObjList.clear();

        vlocity_cmt__PriceList__c pl1 = new vlocity_cmt__PriceList__c(vlocity_cmt__Pricebook2Id__c = testPricebook.Id, vlocity_cmt__IsActive__c = true, vlocity_cmt__Code__c = 'TestPricebook5');
        insert pl1;

        // Create Object Type
        SObject sObj = [SELECT Id, SobjectType, DeveloperName FROM RecordType WHERE IsActive = TRUE and SobjectType = 'vlocity_cmt__ObjectClass__c' and DeveloperName = 'ObjectType' LIMIT 1];
        vlocity_cmt__ObjectClass__c chargeObjType = new vlocity_cmt__ObjectClass__c(Name = 'Charge', vlocity_cmt__ObjectApiName__c = 'PricingElement__c', RecordTypeId = sObj.Id);
        vlocity_cmt__ObjectClass__c discObjType = new vlocity_cmt__ObjectClass__c(Name = 'Discount', vlocity_cmt__ObjectApiName__c = 'PricingElement__c', RecordTypeId = sObj.Id);

        sObjList.clear();
        sObjList.add(chargeObjType);
        sObjList.add(discObjType);
        insert sObjList;
        sObjList.clear();

        vlocity_cmt__PricingVariable__c oneTimeStdPriceVar = new vlocity_cmt__PricingVariable__c(Name = 'One Time Std Price', vlocity_cmt__Code__c = 'OT_STD_PRC',vlocity_cmt__Aggregation__c = 'Unit',
                vlocity_cmt__ChargeType__c='One-time',vlocity_cmt__IsActive__c = true,vlocity_cmt__Scope__c = 'Line',vlocity_cmt__SubType__c = 'Standard',vlocity_cmt__Type__c = 'Price',
                vlocity_cmt__ValueType__c='Pricing Element',vlocity_cmt__CurrencyType__c='Currency');
        sObjList.add(oneTimeStdPriceVar);

        vlocity_cmt__PricingVariable__c mrcPriceVar = new vlocity_cmt__PricingVariable__c(Name = 'Recurring Monthly Std Price', vlocity_cmt__Code__c = 'REC_MNTH_STD_PRC',vlocity_cmt__Aggregation__c = 'Unit',
                vlocity_cmt__ChargeType__c='Recurring', vlocity_cmt__RecurringFrequency__c ='Monthly',vlocity_cmt__IsActive__c = true,vlocity_cmt__Scope__c = 'Line',vlocity_cmt__SubType__c = 'Standard',vlocity_cmt__Type__c = 'Price',
                vlocity_cmt__ValueType__c='Pricing Element',vlocity_cmt__CurrencyType__c='Currency');
        sObjList.add(mrcPriceVar);
        insert sObjList;
        sObjList.clear();

        insert sObjList;

        // Create Pricing Element
        vlocity_cmt__PricingElement__c pElem1 = new vlocity_cmt__PricingElement__c(Name = 'One Time $100 Standalone Price', vlocity_cmt__ObjectTypeId__c = chargeObjType.Id, vlocity_cmt__Amount__c = 100.00,
                vlocity_cmt__Code__c = 'PELEM1', vlocity_cmt__EffectiveFromDate__c = Datetime.now(), vlocity_cmt__IsActive__c = true, vlocity_cmt__IsReusable__c = true, vlocity_cmt__PricingVariableId__c = oneTimeStdPriceVar.Id, vlocity_cmt__PriceListId__c = pl1.Id);
        vlocity_cmt__PricingElement__c pElem2 = new vlocity_cmt__PricingElement__c(Name = 'MRC $20 Standalone Price', vlocity_cmt__ObjectTypeId__c = chargeObjType.Id, vlocity_cmt__Amount__c = 20.00,
                vlocity_cmt__Code__c = 'PELEM2', vlocity_cmt__EffectiveFromDate__c = Datetime.now(), vlocity_cmt__IsActive__c = true, vlocity_cmt__IsReusable__c = true, vlocity_cmt__PricingVariableId__c = mrcPriceVar.Id, vlocity_cmt__PriceListId__c = pl1.Id);
        vlocity_cmt__PricingElement__c pElem4 = new vlocity_cmt__PricingElement__c(Name = 'One Time $400 Local Price', vlocity_cmt__ObjectTypeId__c = chargeObjType.Id, vlocity_cmt__Amount__c = 400.00,
                vlocity_cmt__Code__c = 'PELEM4', vlocity_cmt__EffectiveFromDate__c = Datetime.now(), vlocity_cmt__IsActive__c = true, vlocity_cmt__IsReusable__c = false, vlocity_cmt__PricingVariableId__c = oneTimeStdPriceVar.Id, vlocity_cmt__PriceListId__c = pl1.Id);
        vlocity_cmt__PricingElement__c pElem5 = new vlocity_cmt__PricingElement__c(Name = 'MRC $50 Local Price', vlocity_cmt__ObjectTypeId__c = chargeObjType.Id, vlocity_cmt__Amount__c = 50.00,
                vlocity_cmt__Code__c = 'PELEM5', vlocity_cmt__EffectiveFromDate__c = Datetime.now(), vlocity_cmt__IsActive__c = true, vlocity_cmt__IsReusable__c = false, vlocity_cmt__PricingVariableId__c = mrcPriceVar.Id, vlocity_cmt__PriceListId__c = pl1.Id);
        sObjList.clear();
        sObjList.add(pElem1);
        sObjList.add(pElem2);
        sObjList.add(pElem4);
        sObjList.add(pElem5);

        insert sObjList;
        sObjList.clear();


        List<vlocity_cmt__PricingElement__c> pricingElement = [SELECT Id, Name FROM vlocity_cmt__PricingElement__c];
        vlocity_cmt__PriceListEntry__c ple1 = new vlocity_cmt__PriceListEntry__c(vlocity_cmt__PriceListId__c=pl1.Id, vlocity_cmt__ProductId__c=prod1.Id, vlocity_cmt__PricingElementId__c = pElem1.Id, vlocity_cmt__EffectiveFromDate__c=Datetime.now(), vlocity_cmt__IsActive__c=true);
        sObjList.add(ple1);
        vlocity_cmt__PriceListEntry__c ple2 = new vlocity_cmt__PriceListEntry__c(vlocity_cmt__PriceListId__c=pl1.Id, vlocity_cmt__ProductId__c=prod2.Id, vlocity_cmt__PricingElementId__c = pElem4.Id, vlocity_cmt__EffectiveFromDate__c=Datetime.now(), vlocity_cmt__IsActive__c=true);
        sObjList.add(ple2);
        vlocity_cmt__PriceListEntry__c ple5 = new vlocity_cmt__PriceListEntry__c(vlocity_cmt__PriceListId__c=pl1.Id, vlocity_cmt__ProductId__c=prod3.Id, vlocity_cmt__PricingElementId__c = pElem1.Id, vlocity_cmt__EffectiveFromDate__c=Datetime.now(), vlocity_cmt__IsActive__c=true);
        sObjList.add(ple5);
        vlocity_cmt__PriceListEntry__c ple7 = new vlocity_cmt__PriceListEntry__c(vlocity_cmt__PriceListId__c=pl1.Id, vlocity_cmt__ProductId__c=prod4.Id, vlocity_cmt__PricingElementId__c = pElem1.Id, vlocity_cmt__EffectiveFromDate__c=Datetime.now(), vlocity_cmt__IsActive__c=true);
        sObjList.add(ple7);
        vlocity_cmt__PriceListEntry__c ple8 = new vlocity_cmt__PriceListEntry__c(vlocity_cmt__PriceListId__c=pl1.Id, vlocity_cmt__ProductId__c=prod5.Id, vlocity_cmt__PricingElementId__c = pElem1.Id, vlocity_cmt__EffectiveFromDate__c=Datetime.now(), vlocity_cmt__IsActive__c=true);
        sObjList.add(ple8);

        insert sObjList;
        sObjList.clear();

        //Creating PricingVariableBinding
        vlocity_cmt__PricingVariableBinding__c pvb1 = new vlocity_cmt__PricingVariableBinding__c(Name='One Time Std Price - OrderItem',vlocity_cmt__DestinationSObjectType__c='OrderItem',
                vlocity_cmt__DestinationFieldApiName__c = 'OneTimeCharge__c', vlocity_cmt__PricingVariableId__c = oneTimeStdPriceVar.Id);
        sObjList.add(pvb1);
        vlocity_cmt__PricingVariableBinding__c pvb2 = new vlocity_cmt__PricingVariableBinding__c(Name='Recurring Monthly Std Price - OrderItem',vlocity_cmt__DestinationSObjectType__c='OrderItem',
                vlocity_cmt__DestinationFieldApiName__c = 'RecurringCharge__c', vlocity_cmt__PricingVariableId__c = mrcPriceVar.Id);
        sObjList.add(pvb2);

        insert sObjList;
        sObjList.clear();

        Account a = new Account(Name='Account Test');
        insert a;

        vlocity_cmt__InterfaceImplementation__c iit1 = new vlocity_cmt__InterfaceImplementation__c (Name='PricingInterface');
        insert iit1;
        vlocity_cmt__InterfaceImplementationDetail__c iid1 = new vlocity_cmt__InterfaceImplementationDetail__c (Name = 'PricingElementServiceImplementation',
                vlocity_cmt__InterfaceId__c=iit1.Id, vlocity_cmt__IsActive__c=true);
        insert iid1;

        vlocity_cmt__InterfaceImplementation__c intImpl = new vlocity_cmt__InterfaceImplementation__c (Name='TightestMatchInterface');
        insert intImpl;

        vlocity_cmt__InterfaceImplementationDetail__c iit004_001 = new vlocity_cmt__InterfaceImplementationDetail__c
                (Name = 'TightestMatchServiceImplementation', vlocity_cmt__InterfaceId__c=intImpl.Id, vlocity_cmt__IsDefault__c=true,vlocity_cmt__IsActive__c=true);
        insert iit004_001;

        vlocity_cmt__TriggerSetup__c myTrigger = new vlocity_cmt__TriggerSetup__c(Name='AllTriggers', vlocity_cmt__IsTriggerOn__c=true);
        insert myTrigger;
        vlocity_cmt__InterfaceImplementation__c iit = new vlocity_cmt__InterfaceImplementation__c (Name='ContextRuleService');
        insert iit;
        List<vlocity_cmt__InterfaceImplementationDetail__c> iidList = new List<vlocity_cmt__InterfaceImplementationDetail__c> ();
        vlocity_cmt__InterfaceImplementationDetail__c iit_001 = new vlocity_cmt__InterfaceImplementationDetail__c  (Name = 'ContextRuleService', vlocity_cmt__InterfaceId__c=iit.Id, vlocity_cmt__IsDefault__c=true,vlocity_cmt__IsActive__c=true);

        iidList.add(iit_001);
        insert iidList;


        Order testOrder = new Order(Name='Test Order',EffectiveDate=System.today(),status='Draft',AccountId = a.Id, vlocity_cmt__PriceListId__c = pl1.Id, Pricebook2Id = testPricebook.Id);
        insert testOrder;
        orderId = testOrder.Id;

        List<priceBookEntry> priceBookEntry = [SELECT Id FROM PricebookEntry WHERE Product2Id =: prod1.Id];
        Id priceBookEntryId = priceBookEntry[0].Id;

        OrderItem orderItem = new OrderItem();
        orderItem.OrderId = testOrder.Id;
        orderItem.PricebookEntryId = pbe1.Id;
        orderItem.Quantity = 1;
        orderItem.vlocity_cmt__LineNumber__c = '0001';
        orderItem.UnitPrice = 100;
        orderItem.vlocity_cmt__ProvisioningStatus__c = 'New';
        sObjList.add(orderItem);

        //OrderItem Name : Consumer
        //Attributes : Verizon ..... Default Value : Verizon
        OrderItem orderItem2 = new OrderItem();
        orderItem2.OrderId = testOrder.Id;
        orderItem2.PricebookEntryId = pbe2.Id;
        orderItem2.Quantity = 1.0;
        orderItem2.vlocity_cmt__LineNumber__c = '0001.0001';
        orderItem2.UnitPrice = 100;
        orderItem2.vlocity_cmt__ProvisioningStatus__c = 'New';
        orderItem2.vlocity_cmt__JSONAttribute__c = '{\"VLO-PRO-0015\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrteAAC\",\"attributeid__c\":\"a1S46000000NqHeEAK\",\"attributecategoryid__c\":\"a1R46000000S2KWEA0\",\"categorycode__c\":\"VLO-PRO-0015\",\"categoryname__c\":\"Logistics\",\"attributeuniquecode__c\":\"ATTRIBUTE-124\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"4\",\"attributefilterable__c\":true,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"Provider\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":23,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhxAEAS\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Radiobutton\",\"value__c\":\"Verizon\",\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Radiobutton\",\"default\":[{\"value\":\"Verizon\",\"id\":2,\"displayText\":\"Verizon\"}],\"values\":[{\"value\":\"ATT\",\"id\":1,\"displayText\":\"AT&T\"},{\"value\":\"Verizon\",\"id\":2,\"displayText\":\"Verizon\"},{\"value\":\"Xfinity\",\"id\":3,\"displayText\":\"Xfinity\"}],\"selectedItem\":{\"value\":\"Verizon\",\"id\":2,\"displayText\":\"Verizon\"}},\"$$AttributeDefinitionEnd$$\":null}]}';
        sObjList.add(orderItem2);

        //OrderItem Name : Broadband Internet Small
        //Attributes : Internet Upload Speed;Internet Download Speed  ......  Default : 80Mbps;16Mbps
        OrderItem orderItem3 = new OrderItem();
        orderItem3.OrderId = testOrder.Id;
        orderItem3.PricebookEntryId = pbe3.Id;
        orderItem3.Quantity = 15.0;
        orderItem3.vlocity_cmt__LineNumber__c = '0001.0002';
        orderItem3.UnitPrice = 100;
        orderItem3.vlocity_cmt__ProvisioningStatus__c = 'New';
        orderItem3.vlocity_cmt__JSONAttribute__c= '{\"INTERNET-CAT1\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrttAAC\",\"attributeid__c\":\"a1S46000000O2fqEAC\",\"attributecategoryid__c\":\"a1R46000000ths0EAA\",\"categorycode__c\":\"INTERNET-CAT1\",\"categoryname__c\":\"Internet\",\"attributeuniquecode__c\":\"ATTRIBUTE-1200\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"attributecloneable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Internet Download Speed\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":1,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwvEAC\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Dropdown\",\"value__c\":\"80Mbps\",\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Dropdown\",\"default\":[{\"value\":\"80Mbps\",\"id\":8,\"displayText\":\"80Mbps\"}],\"values\":[{\"value\":\"20Mbps\",\"id\":2,\"displayText\":\"20Mbps\"},{\"value\":\"100Mbps\",\"id\":10,\"displayText\":\"100Mbps\"},{\"value\":\"60Mbps\",\"id\":6,\"displayText\":\"60Mbps\"},{\"value\":\"40Mbps\",\"id\":4,\"displayText\":\"40Mbps\"},{\"value\":\"90Mbps\",\"id\":9,\"displayText\":\"90Mbps\"},{\"value\":\"50Mbps\",\"id\":5,\"displayText\":\"50Mbps\"},{\"value\":\"10Mbps\",\"id\":1,\"displayText\":\"10Mbps\"},{\"value\":\"30Mbps\",\"id\":3,\"displayText\":\"30Mbps\"},{\"value\":\"80Mbps\",\"id\":8,\"displayText\":\"80Mbps\"},{\"value\":\"70Mbps\",\"id\":7,\"displayText\":\"70Mbps\"}],\"selectedItem\":{\"value\":\"80Mbps\",\"id\":8,\"displayText\":\"80Mbps\"}},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrttAAC\",\"attributeid__c\":\"a1S46000000O2g0EAC\",\"attributecategoryid__c\":\"a1R46000000ths0EAA\",\"categorycode__c\":\"INTERNET-CAT1\",\"categoryname__c\":\"Internet\",\"attributeuniquecode__c\":\"ATTRIBUTE-1270\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"attributecloneable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Internet Upload Speed\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":1,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwwEAC\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Dropdown\",\"value__c\":\"16Mbps\",\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Dropdown\",\"default\":[{\"value\":\"16Mbps\",\"id\":8,\"displayText\":\"16Mbps\"}],\"values\":[{\"value\":\"8Mbps\",\"id\":4,\"displayText\":\"8Mbps\"},{\"value\":\"14Mbps\",\"id\":7,\"displayText\":\"14Mbps\"},{\"value\":\"12Mbps\",\"id\":6,\"displayText\":\"12Mbps\"},{\"value\":\"4Mbps\",\"id\":2,\"displayText\":\"4Mbps\"},{\"value\":\"18Mbps\",\"id\":9,\"displayText\":\"18Mbps\"},{\"value\":\"6Mbps\",\"id\":3,\"displayText\":\"6Mbps\"},{\"value\":\"2Mbps\",\"id\":1,\"displayText\":\"2Mbps\"},{\"value\":\"16Mbps\",\"id\":8,\"displayText\":\"16Mbps\"},{\"value\":\"10Mbps\",\"id\":5,\"displayText\":\"10Mbps\"},{\"value\":\"20Mbps\",\"id\":10,\"displayText\":\"20Mbps\"}],\"selectedItem\":{\"value\":\"16Mbps\",\"id\":8,\"displayText\":\"16Mbps\"}},\"$$AttributeDefinitionEnd$$\":null}]}';
        sObjList.add(orderItem3);

        //OrderItem Name : TV Small
        OrderItem orderItem4 = new OrderItem();
        orderItem4.OrderId = testOrder.Id;
        orderItem4.PricebookEntryId = pbe4.Id;
        orderItem4.Quantity = 1.0;
        orderItem4.vlocity_cmt__LineNumber__c = '0001.0003';
        orderItem4.UnitPrice = 100;
        orderItem4.vlocity_cmt__ProvisioningStatus__c = 'New';
        sObjList.add(orderItem4);

        //OrderItem Name : HD TV
        //Attributes : TV Content; TV Boxes Required .... Default : HD;4
        OrderItem orderItem5 = new OrderItem();
        orderItem5.OrderId = testOrder.Id;
        orderItem5.PricebookEntryId = pbe5.Id;
        orderItem5.Quantity = 5.0;
        orderItem5.vlocity_cmt__LineNumber__c = '0001.0003.0001';
        orderItem5.UnitPrice = 100;
        orderItem5.vlocity_cmt__ProvisioningStatus__c = 'New';
        orderItem5.vlocity_cmt__JSONAttribute__c= '{\"VLO-PRO-0015\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NqHbEAK\",\"attributecategoryid__c\":\"a1R46000000S2KWEA0\",\"categorycode__c\":\"VLO-PRO-0015\",\"categoryname__c\":\"Logistics\",\"attributeuniquecode__c\":\"ATTRIBUTE-123\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"Part Number\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":23,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwREAS\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":null,\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"value\":null},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NqHdEAK\",\"attributecategoryid__c\":\"a1R46000000S2KWEA0\",\"categorycode__c\":\"VLO-PRO-0015\",\"categoryname__c\":\"Logistics\",\"attributeuniquecode__c\":\"ATTRIBUTE-125\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"3\",\"attributefilterable__c\":true,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"Supplier\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":23,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwdEAC\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":null,\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"value\":null},\"$$AttributeDefinitionEnd$$\":null}],\"VLO-PRO-0006\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NqIkEAK\",\"attributecategoryid__c\":\"a1R46000000S2M3EAK\",\"categorycode__c\":\"VLO-PRO-0006\",\"categoryname__c\":\"Cloud Services\",\"attributeuniquecode__c\":\"ATTRIBUTE-089\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":false,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"Storage Space\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":14,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwWEAS\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":null,\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"value\":null},\"$$AttributeDefinitionEnd$$\":null}],\"VLO-PRO-0003\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NsE0EAK\",\"attributecategoryid__c\":\"a1R46000000S3Z8EAK\",\"categorycode__c\":\"VLO-PRO-0003\",\"categoryname__c\":\"Mobile Handset\",\"attributeuniquecode__c\":\"ATTRIBUTE-064\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"attributecloneable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Device Manufacturer\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":11,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwMEAS\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":null,\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"value\":null},\"$$AttributeDefinitionEnd$$\":null}],\"VLO-PRO-0002\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NqIgEAK\",\"attributecategoryid__c\":\"a1R46000000S2LZEA0\",\"categorycode__c\":\"VLO-PRO-0002\",\"categoryname__c\":\"TV Technology\",\"attributeuniquecode__c\":\"ATTRIBUTE-019\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"2\",\"attributefilterable__c\":true,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"TV Connection\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":10,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwbEAC\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":null,\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"value\":null},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NqIhEAK\",\"attributecategoryid__c\":\"a1R46000000S2LZEA0\",\"categorycode__c\":\"VLO-PRO-0002\",\"categoryname__c\":\"TV Technology\",\"attributeuniquecode__c\":\"ATTRIBUTE-044\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"3\",\"attributefilterable__c\":false,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"TV Boxes Required\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":10,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"ishidden__c\":false,\"valueinnumber__c\":4,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhwcEAC\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"4\",\"valuedatatype__c\":\"Number\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Number\",\"default\":\"4\",\"value\":4},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t46000003GrtPAAS\",\"attributeid__c\":\"a1S46000000NqIfEAK\",\"attributecategoryid__c\":\"a1R46000000S2LZEA0\",\"categorycode__c\":\"VLO-PRO-0002\",\"categoryname__c\":\"TV Technology\",\"attributeuniquecode__c\":\"ATTRIBUTE-018\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"attributecloneable__c\":false,\"isactive__c\":true,\"attributedisplayname__c\":\"TV Content\",\"displaysequence__c\":\"null\",\"categorydisplaysequence__c\":10,\"customconfiguitemplate__c\":null,\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"ishidden__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a1Q46000000RhweEAC\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Dropdown\",\"value__c\":\"HD\",\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Dropdown\",\"default\":[{\"value\":\"HD\",\"id\":2,\"displayText\":\"HD\"}],\"values\":[{\"value\":\"SD\",\"id\":1,\"displayText\":\"SD\"},{\"value\":\"HD\",\"id\":2,\"displayText\":\"HD\"}],\"selectedItem\":{\"value\":\"HD\",\"id\":2,\"displayText\":\"HD\"}},\"$$AttributeDefinitionEnd$$\":null}]}';
        sObjList.add(orderItem5);

        insert sObjList;
        sObjList.clear();

        // Create Pricing Plan
        vlocity_cmt__PricingPlan__c plan = new vlocity_cmt__PricingPlan__c(Name = 'Default Pricing Plan', vlocity_cmt__Code__c = 'DEFAULT_PRICING_PLAN', vlocity_cmt__IsActive__c = true);
        insert plan;

        //PricingPlanStep__c planStep11 = new PricingPlanStep__c(Name = 'Target Pricing Demo', ImplementationName__c = 'CustomPricingPlanStepImpl', IsActive__c = true, MethodName__c = 'GetMatrixPrice', Sequence__c = 101.0, PricingPlanId__c = plan.Id);
        //PricingPlanStep__c planStep12 = new PricingPlanStep__c(Name = 'Target Path Range Pricing Demo', ImplementationName__c = 'CustomPricingPlanStepImpl', IsActive__c = true, MethodName__c = 'GetMatrixPrice', Sequence__c = 102.0, PricingPlanId__c = plan.Id);
        vlocity_cmt__PricingPlanStep__c planStep13 = new vlocity_cmt__PricingPlanStep__c(Name = 'Target Path Pricing Demo', vlocity_cmt__ImplementationName__c = 'CustomPricingPlanStepImpl', vlocity_cmt__IsActive__c = true, vlocity_cmt__MethodName__c = 'GetMatrixPrice', vlocity_cmt__Sequence__c = 103.0, vlocity_cmt__PricingPlanId__c = plan.Id);
        //PricingPlanStep__c planStep14 = new PricingPlanStep__c(Name = 'Attribute Matrix Pricing Demo', ImplementationName__c = 'CustomPricingPlanStepImpl', IsActive__c = true, MethodName__c = 'GetMatrixPrice', Sequence__c = 104.0, PricingPlanId__c = plan.Id);

        //sObjList.add(planStep11);
        //sObjList.add(planStep12);
        sObjList.add(planStep13);
        //sObjList.add(planStep14);
        insert sObjList;
        sObjList.clear();

    }
}