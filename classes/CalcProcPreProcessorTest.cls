@isTest(seeAllData=false)
public class CalcProcPreProcessorTest{ 
 
  static testMethod void testWithInternalVals(){ 

      setupData();

      // Start Test
      test.startTest();
                         
      CalcProcPreProcessor preProcSvc = new CalcProcPreProcessor();

      try {
        // cause an exception to test exception handling
        preProcSvc.invokeMethod('calculate', null, null, null);  
      } catch (Exception e) {
         System.assert(e instanceof System.NullPointerException);
      } 

      Map<String,Object> inputMap = new Map<String, Object>();
      Map<String,Object> outMap = new Map<String, Object>();
      Map<String,Object> options = new Map<String, Object>();

      preProcSvc.invokeMethod('calculate', inputMap, outMap, options);
      
      Map<String, Object> result = (Map<String, Object>)inputMap.get('data');
      System.assert(result != null && result.size() == 2);

      for (Object res : result.values()) {
         Map<String, Object> row = (Map<String, Object>)res;
         if (row.get('FUEL_TYPE') != null) {
            // GEN_OUTLET has display text 2 Outlets and internal value 2_Internal
            System.assert((String)row.get('GEN_OUTLET') == '2_Internal');
            // GEN_COLOR has no internal value so it should return the display text
            System.assert((String)row.get('GEN_COLOR') == 'Red');
         }
      }

      // Stop Test
      test.stopTest();
  }

  static testMethod void testWithDisplayText(){ 

      setupData();

      vlocity_cmt__CpqConfigurationSetup__c configSetup = new vlocity_cmt__CpqConfigurationSetup__c(Name='CPPreProcUseDisplayText', vlocity_cmt__SetupValue__c='True');
      insert configSetup;

      // Start Test
      test.startTest();
                         
      CalcProcPreProcessor preProcSvc = new CalcProcPreProcessor();

      Map<String,Object> inputMap = new Map<String, Object>();
      Map<String,Object> outMap = new Map<String, Object>();
      Map<String,Object> options = new Map<String, Object>();

      preProcSvc.invokeMethod('calculate', inputMap, outMap, options);
      
      Map<String, Object> result = (Map<String, Object>)inputMap.get('data');
      System.assert(result != null && result.size() == 2);

      for (Object res : result.values()) {
         Map<String, Object> row = (Map<String, Object>)res;
         if (row.get('FUEL_TYPE') != null) {
            // GEN_OUTLET has display text 2 Outlets and internal value 2_Internal
            System.assert((String)row.get('GEN_OUTLET') == '2 Outlets');
            // GEN_COLOR has no internal value
            System.assert((String)row.get('GEN_COLOR') == 'Red');
         }
      }

      // Stop Test
      test.stopTest();
  }

  static testMethod void testPostProcessor() { 

      setupData();

      vlocity_cmt__CpqConfigurationSetup__c configSetup = new vlocity_cmt__CpqConfigurationSetup__c(Name='CPPostProcOrderDRBundle', vlocity_cmt__SetupValue__c='SaveOrderItem');
      insert configSetup;

      Map<String, Object> dataSet = new Map<String, Object>();
      Map<String, Object> data = new Map<String, Object>();
      data.put('Quantity', 1.00);
      data.put('RecurringListPrice', 0.00);
      data.put('OneTimeListPrice', 99.99);
      data.put('RecurringManualDiscountPercent', 0.00);
      data.put('RecurringTotal', 0.00);
      data.put('Product', 'Office Internet Solution');
      data.put('OneTimeManualDiscountPercent', 0.00);
      data.put('UploadSpeed', '25Mbps');
      data.put('Download_Speed', '50Mbps - $50.00');
      data.put('ServiceCat', 'Internet');
      data.put('OneTimeTotal', 99.99);
      data.put('ID', '80236000000CuW4AAK');

      dataSet.put('80236000000CuW4AAK', data);

      data = new Map<String, Object>();
      data.put('Quantity', 1.00);
      data.put('RecurringListPrice', 0.00);
      data.put('OneTimeListPrice', 99.99);
      data.put('RecurringManualDiscountPercent', 50.00);
      data.put('RecurringTotal', 0.00);
      data.put('Product', 'Office Internet Solution');
      data.put('OneTimeManualDiscountPercent', 0.00);
      data.put('UploadSpeed', '25Mbps');
      data.put('Download_Speed', '100Mbps - $75.00');
      data.put('ServiceCat', 'Internet;Cable');
      data.put('OneTimeTotal', 75.00);
      data.put('ID', '80236000000CuW3AAK');

      dataSet.put('80236000000CuW3AAK', data);

      // Start Test
      test.startTest();
           
      CalcProcPostProcessor postProcSvc = new CalcProcPostProcessor();

      Map<String,Object> inputMap = new Map<String, Object>();
      Map<String,Object> outMap = new Map<String, Object>();
      Map<String,Object> options = new Map<String, Object>();

      List<Object> outputList = new List<Object>();
      List<Object> dataList = new List<Object>();
      Map<String, Object> objData = new Map<String, Object>();
      objData.put('OneTimeTotal', 50.00);
      objData.put('RecurringCalculatedPrice', 37.50);
      objData.put('AttributeBasedPricing__OverridePrice', 50.00);
      objData.put('ID', '80236000000CuW4AAK');
      dataList.add(objData);      
      vlocity_cmt.PricingCalculationService.CalculationProcedureResults calcProcResults = new vlocity_cmt.PricingCalculationService.CalculationProcedureResults(dataList, new Map<String, Object>());
      outputList.add(calcProcResults);
      outMap.put('output', outputList);
      postProcSvc.invokeMethod('calculate', inputMap, outMap, options);

      // test with existing data set
      vlocity_cmt.FlowStaticMap.flowMap.put('CalcProcPreProcessor_DataSetKey','OrderItemAttr_DataSet');
      vlocity_cmt.FlowStaticMap.flowMap.put('OrderItemAttr_DataSet', dataSet);
      postProcSvc.invokeMethod('calculate', inputMap, outMap, options);

      // Stop Test
      test.stopTest();
  }

  static testMethod void testDRBundleAction() { 

      setupData();

      // Start Test
      test.startTest();
           
      List<DRBundleAction.DRBundleActionRequest> requests = new List<DRBundleAction.DRBundleActionRequest>();
      DRBundleAction.DRBundleActionRequest req = new DRBundleAction.DRBundleActionRequest();
      req.bundleName = 'OrderItemAttr';
      req.action = 'Load';
      requests.add(req);

      DRBundleAction.execute(requests);

      String result = (String)vlocity_cmt.FlowStaticMap.flowMap.get('OrderItemAttr_Load');
      System.assert(String.isNotBlank(result));
      System.debug('OrderItemAttr_Load result: ' + result);

      Map<String, Object> saveObjects = new Map<String, Object>();
      Map<String, Object> objData = new Map<String, Object>();
      objData.put('OneTimeTotal', 50.00);
      objData.put('RecurringCalculatedPrice', 37.50);
      objData.put('AttributeBasedPricing__OverridePrice', 50.00);
      objData.put('ID', '80236000000CuW4AAK');

      saveObjects.put('80236000000CuW4AAK', objData);

      objData = new Map<String, Object>();
      objData.put('OneTimeTotal', 75.00);
      objData.put('RecurringCalculatedPrice', 37.50);
      objData.put('AttributeBasedPricing__OverridePrice', 75.00);
      objData.put('ID', '80236000000CuW3AAK');

      saveObjects.put('80236000000CuW3AAK', objData);

      vlocity_cmt.FlowStaticMap.flowMap.put('SaveOrderItem_Save', saveObjects);

      req.bundleName = 'SaveOrderItem';
      req.action = 'Save';

      DRBundleAction.execute(requests);

      // test for blank parent
      vlocity_cmt.FlowStaticMap.flowMap.remove('parent');
      req.bundleName = 'OrderItemAttr';
      req.action = 'Load';

      DRBundleAction.execute(requests);

      // Stop Test
      test.stopTest();
  }

  private static void setupData()
  {
      vlocity_cmt__TriggerSetup__c myTrigger = new vlocity_cmt__TriggerSetup__c(Name='AllTriggers', vlocity_cmt__IsTriggerOn__c=true);
      insert myTrigger;

      // Create test product
      Product2 testProduct = new Product2(Name = 'Test Product 1');
      testProduct.vlocity_cmt__JSONAttribute__c = '{\"GEN_DESC\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vgrYEAQ\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_COLOR\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Color\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nqJxAAI\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Dropdown\",\"value__c\":null,\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Dropdown\",\"values\":[{\"value\":\"\",\"displayText\":\"Red\",\"id\":1},{\"value\":\"\",\"displayText\":\"White\",\"id\":2},{\"value\":\"\",\"displayText\":\"Blue\",\"id\":3}],\"default\":[{\"value\":\"\",\"displayText\":\"Red\",\"id\":1}]},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005viagEAA\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_OUTLET\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Outlets\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nqK2AAI\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Radiobutton\",\"value__c\":null,\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Radiobutton\",\"values\":[{\"value\":\"1_Internal\",\"displayText\":\"1 Outlet\",\"id\":1},{\"value\":\"2_Internal\",\"displayText\":\"2 Outlets\",\"id\":2},{\"value\":\"3_Internal\",\"displayText\":\"3 Outlets\",\"id\":3},{\"value\":\"4_Internal\",\"displayText\":\"4 Outlets\",\"id\":4}],\"default\":[{\"value\":\"4_Internal\",\"displayText\":\"4 Outlets\",\"id\":4}]},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vialEAA\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_PORTABLE\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Portable\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nqLjAAI\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"Selected\",\"valuedatatype__c\":\"Checkbox\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Checkbox\",\"default\":true},\"$$AttributeDefinitionEnd$$\":null}],\"GEN_TYPE\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vgrOEAQ\",\"attributecategoryid__c\":\"a09610000011pZiAAI\",\"categorycode__c\":\"GEN_TYPE\",\"categoryname__c\":\"GenType\",\"attributeuniquecode__c\":\"FUEL_TYPE\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Fuel Type\",\"displaysequence__c\":\"1\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nnkiAAA\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"Gasoline\",\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"default\":\"Gasoline\"},\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vgrTEAQ\",\"attributecategoryid__c\":\"a09610000011pZiAAI\",\"categorycode__c\":\"GEN_TYPE\",\"categoryname__c\":\"GenType\",\"attributeuniquecode__c\":\"PWR_RATING\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Power\",\"displaysequence__c\":\"1\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001oUIzAAM\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"2000kW\",\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"default\":\"2000kW\"},\"$$AttributeDefinitionEnd$$\":null}]}';
      insert testProduct;

      // Create a Pricebooks
      Pricebook2 standardBook =  new Pricebook2(Id=Test.getStandardPricebookId(), Name = 'StandardPricebook', IsActive = true);
      
      Pricebook2 testPricebook = new Pricebook2(Name = 'TestPricebook', IsActive = true);
      insert testPricebook;
      
      // Create Pricebook entries
      PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardBook.Id,
          Product2Id = testProduct.Id, UnitPrice = 10, IsActive = true, UseStandardPrice = false);
      insert standardPrice;
      
      PricebookEntry testPricebookEntryPlain = new PricebookEntry(Pricebook2Id = testPricebook.Id,
          Product2Id = testProduct.Id, UnitPrice = 11, IsActive = true, UseStandardPrice = false);
      insert testPricebookEntryPlain;
     
      // Create Account
      Account testAccount = new Account();
      testAccount.Name = 'TestAccount';
      //testAccount.SLA__c = 'Platinum';
      insert testAccount;

      // Create Order
      Order order = new Order(Name='Test Order',EffectiveDate=System.today(),status='Draft',AccountId = testAccount.Id, Pricebook2Id=testPricebook.Id);
      insert order;

      // Create Order Items
      OrderItem orderItem = new OrderItem(OrderId=order.Id, PricebookEntryId = testPricebookEntryPlain.Id,
       vlocity_cmt__LineNumber__c = '0002', Quantity = 3.0, UnitPrice = 270000.0, vlocity_cmt__ProvisioningStatus__c = 'New');
      orderItem.vlocity_cmt__JSONAttribute__c = '{\"GEN_DESC\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vgrYEAQ\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_COLOR\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Color\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nqJxAAI\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Dropdown\",\"value__c\":null,\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Dropdown\",\"values\":[{\"value\":\"\",\"displayText\":\"Red\",\"id\":1},{\"value\":\"\",\"displayText\":\"White\",\"id\":2},{\"value\":\"\",\"displayText\":\"Blue\",\"id\":3}],\"default\":[{\"value\":\"\",\"displayText\":\"Red\",\"id\":1}]},\"$$hashKey\":\"06Q\",\"Name\":\"Color\",\"Code\":\"GEN_COLOR\",\"Filterable\":true,\"SegmentValue\":\"Red\",\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005viagEAA\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_OUTLET\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Outlets\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nqK2AAI\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Radiobutton\",\"value__c\":null,\"valuedatatype__c\":\"Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Picklist\",\"uiDisplayType\":\"Radiobutton\",\"values\":[{\"value\":\"1_Internal\",\"displayText\":\"1 Outlet\",\"id\":1,\"$$hashKey\":\"072\"},{\"value\":\"2_Internal\",\"displayText\":\"2 Outlets\",\"id\":2,\"$$hashKey\":\"073\"},{\"value\":\"3_Internal\",\"displayText\":\"3 Outlets\",\"id\":3,\"$$hashKey\":\"074\"},{\"value\":\"4_Internal\",\"displayText\":\"4 Outlets\",\"id\":4,\"$$hashKey\":\"075\"}],\"default\":[{\"value\":\"4_Internal\",\"displayText\":\"4 Outlets\",\"id\":4}],\"selectedItem\":{\"value\":\"2_Internal\",\"displayText\":\"2 Outlets\",\"id\":2,\"$$hashKey\":\"073\"}},\"$$hashKey\":\"06R\",\"Name\":\"Outlets\",\"Code\":\"GEN_OUTLET\",\"Filterable\":true,\"SegmentValue\":\"4 Outlets\",\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vialEAA\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_PORTABLE\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Portable\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nqLjAAI\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"Selected\",\"valuedatatype__c\":\"Checkbox\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Checkbox\",\"default\":true,\"value\":false},\"$$hashKey\":\"06S\",\"Name\":\"Portable\",\"Code\":\"GEN_PORTABLE\",\"Filterable\":true,\"SegmentValue\":\"Yes\",\"$$AttributeDefinitionEnd$$\":null}],\"GEN_TYPE\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vgrOEAQ\",\"attributecategoryid__c\":\"a09610000011pZiAAI\",\"categorycode__c\":\"GEN_TYPE\",\"categoryname__c\":\"GenType\",\"attributeuniquecode__c\":\"FUEL_TYPE\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Fuel Type\",\"displaysequence__c\":\"1\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001nnkiAAA\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"Gasoline\",\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"default\":\"Gasoline\",\"value\":\"Gasoline\"},\"$$hashKey\":\"07D\",\"Name\":\"Fuel Type\",\"Code\":\"FUEL_TYPE\",\"Filterable\":true,\"SegmentValue\":\"Gasoline\",\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6wAAC\",\"attributeid__c\":\"a0A61000005vgrTEAQ\",\"attributecategoryid__c\":\"a09610000011pZiAAI\",\"categorycode__c\":\"GEN_TYPE\",\"categoryname__c\":\"GenType\",\"attributeuniquecode__c\":\"PWR_RATING\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Power\",\"displaysequence__c\":\"1\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":false,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000001oUIzAAM\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":null,\"value__c\":\"2000kW\",\"valuedatatype__c\":\"Text\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Text\",\"default\":\"2000kW\",\"value\":\"750kW\"},\"$$hashKey\":\"07E\",\"Name\":\"Power\",\"Code\":\"PWR_RATING\",\"Filterable\":true,\"SegmentValue\":\"2000kW\",\"$$AttributeDefinitionEnd$$\":null}]}';

      insert orderItem;

      orderItem = new OrderItem(OrderId=order.Id, PricebookEntryId = testPricebookEntryPlain.Id,
       vlocity_cmt__LineNumber__c = '0001', Quantity = 1.0, UnitPrice = 5000.0, vlocity_cmt__ProvisioningStatus__c = 'New');
      orderItem.vlocity_cmt__JSONAttribute__c = '{\"GEN_DESC\":[{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6iAAC\",\"attributeid__c\":\"a0A61000005vgrYEAQ\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_COLOR\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Color\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000002GQ2rAAG\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Dropdown\",\"value__c\":null,\"valuedatatype__c\":\"Multi Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Multi Picklist\",\"uiDisplayType\":\"Dropdown\",\"values\":[{\"value\":\"RED_INT\",\"displayText\":\"Red\",\"id\":1,\"$$hashKey\":\"06E\"},{\"value\":\"WHITE_INT\",\"displayText\":\"White\",\"id\":2,\"$$hashKey\":\"06F\"},{\"value\":\"BLUE_INT\",\"displayText\":\"Blue\",\"id\":3,\"$$hashKey\":\"06G\"}],\"default\":[{\"value\":\"RED_INT\",\"displayText\":\"Red\",\"id\":1}],\"selectedItems\":[{\"value\":\"RED_INT\",\"displayText\":\"Red\",\"id\":1,\"$$hashKey\":\"06E\"},{\"value\":\"BLUE_INT\",\"displayText\":\"Blue\",\"id\":3,\"$$hashKey\":\"06G\"}]},\"$$hashKey\":\"067\",\"Name\":\"Color\",\"Code\":\"GEN_COLOR\",\"Filterable\":true,\"SegmentValue\":\"Red\",\"$$AttributeDefinitionEnd$$\":null},{\"$$AttributeDefinitionStart$$\":null,\"objectid__c\":\"01t61000000Hm6iAAC\",\"attributeid__c\":\"a0A61000005viagEAA\",\"attributecategoryid__c\":\"a09610000011pckAAA\",\"categorycode__c\":\"GEN_DESC\",\"categoryname__c\":\"GenDesc\",\"attributeuniquecode__c\":\"GEN_OUTLET\",\"attributeconfigurable__c\":true,\"attributedisplaysequence__c\":\"1\",\"attributefilterable__c\":true,\"isactive__c\":true,\"attributedisplayname__c\":\"Outlets\",\"displaysequence__c\":\"2\",\"formatmask__c\":null,\"hasrule__c\":false,\"isconfigurable__c\":true,\"valueinnumber__c\":null,\"objecttype__c\":\"Product2\",\"querycode__c\":null,\"isreadonly__c\":false,\"isquerydriven__c\":false,\"querylabel__c\":null,\"id\":\"a0861000002GQ31AAG\",\"isrequired__c\":false,\"rulemessage__c\":null,\"uidisplaytype__c\":\"Checkbox\",\"value__c\":null,\"valuedatatype__c\":\"Multi Picklist\",\"valuedescription__c\":null,\"attributeRunTimeInfo\":{\"dataType\":\"Multi Picklist\",\"uiDisplayType\":\"Checkbox\",\"values\":[{\"value\":\"\",\"displayText\":\"1 Outlet\",\"id\":1,\"$$hashKey\":\"06K\",\"checked\":true},{\"value\":\"\",\"displayText\":\"2 Outlets\",\"id\":2,\"$$hashKey\":\"06L\",\"checked\":false},{\"value\":\"\",\"displayText\":\"3 Outlets\",\"id\":3,\"$$hashKey\":\"06M\",\"checked\":false},{\"value\":\"\",\"displayText\":\"4 Outlets\",\"id\":4,\"$$hashKey\":\"06N\",\"checked\":false}],\"default\":[{\"value\":\"\",\"displayText\":\"1 Outlet\",\"id\":1}]},\"$$hashKey\":\"068\",\"Name\":\"Outlets\",\"Code\":\"GEN_OUTLET\",\"Filterable\":true,\"SegmentValue\":\"1 Outlet\",\"$$AttributeDefinitionEnd$$\":null}]}';

      insert orderItem;

      // Create DataRaptor bundle
      List<vlocity_cmt__DRBundle__c> intProcs = new List<vlocity_cmt__DRBundle__c>{
        new vlocity_cmt__DRBundle__c(Name='OrderItemAttr', vlocity_cmt__DRMapName__c='OrderItemAttr',vlocity_cmt__InterfaceObject__c='JSON', vlocity_cmt__Type__c='Extract (JSON)', vlocity_cmt__IsDefaultForInterface__c=false, vlocity_cmt__IsProcessSuperBulk__c=false, vlocity_cmt__IgnoreErrors__c=true, vlocity_cmt__ProcessNowThreshold__c = -1)
      };

      insert intProcs;

      //String nsPrefix = ApplicationUtilities.getNameSpacePrefix();
      List<List<Object>> filterMappings = new List<List<Object>> {
        new List<Object>{ 1.0, 'Detail:Item Attr', null, null, 'OrderItem:vlocity_cmt__JSONAttribute__c' , null, null},
        new List<Object>{ 1.0, 'ID', null, null, 'OrderItem:Id' , null, null},
        new List<Object>{ 0.0, 'OrderItem', null, null, null , null, null},
        new List<Object>{ 1.0, 'Detail:Quantity', null, null, 'OrderItem:Quantity' , null, null},
        new List<Object>{ 0.0, 'OrderItem', '=', 'Id', 'OrderId' , 1.0, 'OrderItem'},
        new List<Object>{ 1.0, 'Detail:UnitPrice', null, null, 'OrderItem:ListPrice' , null, null}
      };

      addFilterMapping('OrderItemAttr', filterMappings);

      // Setup input bundle configuration
      vlocity_cmt__CpqConfigurationSetup__c configSetup = new vlocity_cmt__CpqConfigurationSetup__c(Name='CPPreProcOrderDRBundle', vlocity_cmt__SetupValue__c='OrderItemAttr');
      insert configSetup;

      vlocity_cmt.FlowStaticMap.flowMap.put('parent', order);
  }

  private static void addFilterMapping(String name, List<List<Object>> mappingLists)
  {
    List<vlocity_cmt__DRMapItem__c> mapping = new List<vlocity_cmt__DRMapItem__c>();
    Integer i = 0, creation = 0;

    for (List<Object> mappingValues : mappingLists)
    {
      i++;
      mapping.add(new vlocity_cmt__DRMapItem__c(
        Name = name,
        vlocity_cmt__MapId__c = name + '_F' + i,
        vlocity_cmt__DomainObjectCreationOrder__c = (Double)mappingValues[0],
        vlocity_cmt__DomainObjectFieldAPIName__c = (String)mappingValues[1], 
        vlocity_cmt__FilterOperator__c = (String)mappingValues[2],
        vlocity_cmt__FilterValue__c =  (String)mappingValues[3],
        vlocity_cmt__InterfaceFieldAPIName__c = (String)mappingValues[4],
        vlocity_cmt__InterfaceObjectLookupOrder__c = (Double)mappingValues[5],
        vlocity_cmt__InterfaceObjectName__c=(String)mappingValues[6],
        vlocity_cmt__DomainObjectAPIName__c = 'JSON'
      ));
    }
    insert mapping;
  }
}