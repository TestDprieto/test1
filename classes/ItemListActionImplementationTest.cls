@isTest
private class ItemListActionImplementationTest
{
	private static testMethod void testMove() {
        
        List<SObject> sObjectList = createData();

        ItemListActionImplementation svc = new ItemListActionImplementation();
        Test.startTest();

        Map<String, Object> input = new  Map<String, Object>();
        Map<String, Object> output = new  Map<String, Object>();
        Map<String, Object> flowMap = new  Map<String, Object>();

        String splitMapping = 'MOVE FROM item\r\nList TO newItemList WHERE vlocity_cmt__ProvisioningStatus__c = New;\r\n';
        splitMapping += 'move from itemList to \ndeleteItemList where vlocity_cmt__ProvisioningStatus__c = Deleted\n;\n';
        splitMapping += 'MOVE FROM itemList TO active\r\nItemList WHERE vlocity_cmt__Provisio\r\nningStatus__c = Active\n;';
        splitMapping += 'MOVE FROM itemList TO changed\nItemList WHERE vlocity_cmt__ProvisioningStatus__c = Changed;\n';
        splitMapping += 'COPY FROM active\r\nItemList TO itemList;\n';
        input.put('customActionInput', splitMapping);

        flowMap.put('itemList', sObjectList);
        input.put('flowMap',flowMap);
        svc.invokeMethod('executeCustomAction', input, output,null);

        // For MOVE, we expect some items to be moved to their corresponding item lists based on the field criteria
        List<SObject> listToTest = (List<SObject>)flowMap.get('itemList');
        System.assert(listToTest != null && listToTest.size() == 2);
        System.assert((String)listToTest[0].get('vlocity_cmt__ProvisioningStatus__c') == 'InProgress');
        System.assert((String)listToTest[1].get('vlocity_cmt__ProvisioningStatus__c') == 'Active');
        listToTest = (List<SObject>)flowMap.get('newItemList');
        System.assert(listToTest != null && listToTest.size() == 2);
        System.assert((String)listToTest[0].get('vlocity_cmt__ProvisioningStatus__c') == 'New');
        System.assert((String)listToTest[1].get('vlocity_cmt__ProvisioningStatus__c') == 'New');
        listToTest = (List<SObject>)flowMap.get('deleteItemList');
        System.assert(listToTest != null && listToTest.size() == 1);
        System.assert((String)listToTest[0].get('vlocity_cmt__ProvisioningStatus__c') == 'Deleted');
        listToTest = (List<SObject>)flowMap.get('activeItemList');
        System.assert(listToTest != null && listToTest.size() == 1);
        System.assert((String)listToTest[0].get('vlocity_cmt__ProvisioningStatus__c') == 'Active');
        listToTest = (List<SObject>)flowMap.get('changedItemList');
        System.assert(listToTest != null && listToTest.size() == 1);
        System.assert((String)listToTest[0].get('vlocity_cmt__ProvisioningStatus__c') == 'Changed');

        Test.stopTest();
    }

    private static testMethod void testCopy() {
        
        List<SObject> sObjectList = createData();

        ItemListActionImplementation svc = new ItemListActionImplementation();
        Test.startTest();

        Map<String, Object> input = new  Map<String, Object>();
        Map<String, Object> output = new  Map<String, Object>();
        Map<String, Object> flowMap = new  Map<String, Object>();

        String splitMapping = 'COPY from item\r\nList TO copiedItemList;\r\n';
        splitMapping += 'COPY FROM copiedItemList TO \ndeleteItemList WHERE vlocity_cmt__ProvisioningStatus__c = Deleted\n;\n';
        splitMapping += 'COPY FROM copiedItemList TO nonDeletedItemList WHERE vlocity_cmt__ProvisioningStatus__c != Deleted\n;\n';
        input.put('customActionInput', splitMapping);

        flowMap.put('itemList', sObjectList);
        input.put('flowMap',flowMap);
        svc.invokeMethod('executeCustomAction', input, output,null);

        // For MOVE, we expect some items to be moved to their corresponding item lists based on the field criteria
        List<SObject> listToTest = (List<SObject>)flowMap.get('itemList');
        System.assert(listToTest != null && listToTest.size() == 6);
        listToTest = (List<SObject>)flowMap.get('copiedItemList');
        System.assert(listToTest != null && listToTest.size() == 6);
        listToTest = (List<SObject>)flowMap.get('nonDeletedItemList');
        System.assert(listToTest != null && listToTest.size() == 5);
        listToTest = (List<SObject>)flowMap.get('deleteItemList');
        System.assert(listToTest != null && listToTest.size() == 1);
        System.assert((String)listToTest[0].get('vlocity_cmt__ProvisioningStatus__c') == 'Deleted');

        Test.stopTest();
    }

    private static testMethod void testBadMapping() {
        
        List<SObject> sObjectList = createData();

        ItemListActionImplementation svc = new ItemListActionImplementation();
        Test.startTest();

        Map<String, Object> input = new  Map<String, Object>();
        Map<String, Object> output = new  Map<String, Object>();
        Map<String, Object> flowMap = new  Map<String, Object>();

        String splitMapping = 'COPYALL FROM item\r\nList TO copiedItemList;\r\n';
        input.put('customActionInput', splitMapping);

        flowMap.put('itemList', sObjectList);
        input.put('flowMap',flowMap);
        svc.invokeMethod('executeCustomAction', input, output,null);

        System.assert(output.get('hasErrors') != null && (Boolean)output.get('hasErrors')==true);
        System.assert(output.get('error') != null && ((String)output.get('error')).contains('Unsupported action: COPYALL'));

        splitMapping = 'COPY FROM item\r\n;List TO copiedItemList;\r\n';
        input.put('customActionInput', splitMapping);

        svc.invokeMethod('executeCustomAction', input, output,null);
        System.assert(output.get('hasErrors') != null && (Boolean)output.get('hasErrors')==true);
        System.assert(output.get('error') != null && ((String)output.get('error')).contains('Unsupported mapping format: COPY FROM item'));

        Test.stopTest();
    }

    private static List<SObject> createData() {
         // Create Products
        Product2 p1 = new Product2(Name='Medical PPO 200');
        Product2 p2 = new Product2(Name='Medical PPO 300');
        Product2 p3 = new Product2(Name='Dental PPO 200');
        Product2 p4 = new Product2(Name='Vision PPO 200');
        List<Product2> prodList = new List<Product2> ();
        prodList.add(p1);
        prodList.add(p2);
        prodList.add(p3);
        prodList.add(p4);
        insert prodList;
        // Create Price book and Price book entries
        Pricebook2 standardBook =  new Pricebook2(Id=Test.getStandardPricebookId(), Name = 'StandardPricebook', IsActive = true);
      
        Pricebook2 testPricebook = new Pricebook2(Name = 'TestPricebook', IsActive = true);
        insert testPricebook;
        
        // Create Pricebook entries
        List<PricebookEntry> stdpbEntryList = new List<PricebookEntry>();
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p1.Id, UnitPrice = 10, IsActive = true, UseStandardPrice = false));
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p2.Id, UnitPrice = 20, IsActive = true, UseStandardPrice = false));
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p3.Id, UnitPrice = 30, IsActive = true, UseStandardPrice = false));
        stdpbEntryList.add(new PricebookEntry(Pricebook2Id = standardBook.Id, Product2Id = p4.Id, UnitPrice = 40, IsActive = true, UseStandardPrice = false));

        insert stdpbEntryList;
        
        List<PricebookEntry> testpbEntryList = new List<PricebookEntry>();
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p1.Id, UnitPrice = 11, IsActive = true, UseStandardPrice = false));
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p2.Id, UnitPrice = 22, IsActive = true, UseStandardPrice = false));
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p3.Id, UnitPrice = 33, IsActive = true, UseStandardPrice = false));
        testpbEntryList.add(new PricebookEntry(Pricebook2Id = testPricebook.Id, Product2Id = p4.Id, UnitPrice = 44, IsActive = true, UseStandardPrice = false));

        insert testpbEntryList;
        /*
        PricebookEntry standardPricebookEntry = new PricebookEntry(Pricebook2Id =standardBook.Id , Product2Id = product.Id, UnitPrice = 100, IsActive = true, UseStandardPrice = false);
        insert standardPricebookEntry;
        */
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        insert testAccount;
        
        Order testOrder = new Order();
        testOrder.AccountId = testAccount.Id; 
        testOrder.Pricebook2Id = testPricebook.Id;
        testOrder.Name = 'TestOrderHeader';
        testOrder.EffectiveDate = system.today();
        testOrder.Status = 'Draft';
        testOrder.ShippingPostalCode = '94549';
        testOrder.ShippingState = 'NY';
        insert testOrder;
        
        List<OrderItem> orderItems = new List<OrderItem>();
        
        OrderItem testOrderItem2 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0001',
          PricebookEntryId = testpbEntryList[1].Id, Quantity = 2, UnitPrice = 22,vlocity_cmt__ProvisioningStatus__c = 'New', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10);
        orderItems.add(testOrderItem2);
        
        OrderItem testOrderItem3 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0002',
          PricebookEntryId = testpbEntryList[2].Id, Quantity = 3, UnitPrice = 33,vlocity_cmt__ProvisioningStatus__c = 'InProgress', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
        orderItems.add(testOrderItem3);
        
        OrderItem testOrderItem4 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0003',
          PricebookEntryId = testpbEntryList[3].Id, Quantity = 4, UnitPrice = 44,vlocity_cmt__ProvisioningStatus__c = 'Active', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
        orderItems.add(testOrderItem4);

        OrderItem testOrderItem5 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0004',
          PricebookEntryId = testpbEntryList[3].Id, Quantity = 5, UnitPrice = 55,vlocity_cmt__ProvisioningStatus__c = 'Changed', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
        orderItems.add(testOrderItem5);

        OrderItem testOrderItem6 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0006',
          PricebookEntryId = testpbEntryList[0].Id, Quantity = 1, UnitPrice = 11,vlocity_cmt__ProvisioningStatus__c = 'Deleted', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10 );
        orderItems.add(testOrderItem6);

        OrderItem testOrderItem7 = new OrderItem(OrderId = testOrder.Id,vlocity_cmt__LineNumber__c = '0007',
          PricebookEntryId = testpbEntryList[1].Id, Quantity = 1, UnitPrice = 66,vlocity_cmt__ProvisioningStatus__c = 'New', 
          vlocity_cmt__RecurringManualDiscount__c=10, vlocity_cmt__OneTimeManualDiscount__c=10);
        orderItems.add(testOrderItem7);
                
        insert orderItems;
         
        List<ID> orderItemIds = new List<ID>();
        for (OrderItem orderItem : orderItems) {    
            orderItemIds.add(orderItem.Id);
        }

        List<SObject> sObjectList = [SELECT Id, OrderId, PricebookEntryId, PricebookEntry.Product2Id , vlocity_cmt__LineNumber__c, Quantity, UnitPrice, vlocity_cmt__ProvisioningStatus__c, vlocity_cmt__RecurringManualDiscount__c,  vlocity_cmt__OneTimeManualDiscount__c FROM OrderItem WHERE Id IN :orderItemIds];

        return sObjectList;
    }
}