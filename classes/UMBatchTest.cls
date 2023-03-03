@isTest
public with sharing class UMBatchTest {
    static testMethod void myUnitTest1() {
        UMBatchTest instance = new UMBatchTest();
        try {
            instance.test1();
            
        } catch (Exception ex) {
            System.Debug('ERROR: ' + ex.getMessage());
        }
    }
    public void test1() { 
        test.startTest();
        List<Product2> productList = new List<Product2>();
        for(Integer index = 1; index < 400; index ++){
            Product2 prodcutSO = new Product2(Name = 'testProduct' + index);
            productList.add(prodcutSO);
            
        }
        
        insert productList;
        List<vlocity_cmt__ProductChildItem__c> pciList = new List<vlocity_cmt__ProductChildItem__c>();
        for(Integer index = 0; index < 200; index ++){
            vlocity_cmt__ProductChildItem__c pciSO = new vlocity_cmt__ProductChildItem__c();
            pciSO.vlocity_cmt__ParentProductId__c = productList[index].Id;
            pciSO.vlocity_cmt__ChildProductId__c = productList[index + 1].Id;
            pciSO.vlocity_cmt__Quantity__c = 1.0;
            pciSO.vlocity_cmt__MinQuantity__c = 0.0;
            pciSO.vlocity_cmt__MaxQuantity__c = 5.0;
            pciSO.vlocity_cmt__IsRootProductChildItem__c = false;
            pciSO.vlocity_cmt__IsOverride__c = false;
            pciSO.vlocity_cmt__ChildLineNumber__c = '0001';
            pciList.add(pciSO);
            
        }
        insert pciList;
        for(Integer index = 0; index < 4; index ++){
            UMResolveProductHierarchyBatchJob resolveProductHierarchy = new UMResolveProductHierarchyBatchJob('', '', false, 0);
            List<vlocity_cmt__ProductChildItem__c> subList = new List<vlocity_cmt__ProductChildItem__c>();
            Integer innerIndexStart = index * 50;
            for(Integer innerIndex = innerIndexStart; innerIndex < innerIndexStart + 50; innerIndex ++){
                subList.add(pciList[innerIndex]);               

            }
            
            resolveProductHierarchy.resolveProductHierearchyItems(null, subList);       
        
        }
        
        List<vlocity_cmt__ProductChildItem__c> pciList2 = new List<vlocity_cmt__ProductChildItem__c>();
        vlocity_cmt__ProductChildItem__c pciSO1 = new vlocity_cmt__ProductChildItem__c();
        pciSO1.vlocity_cmt__ParentProductId__c = productList[300].Id;
        pciSO1.vlocity_cmt__ChildProductId__c = productList[301].Id;
        pciSO1.vlocity_cmt__Quantity__c = 1.0;
        pciSO1.vlocity_cmt__MinQuantity__c = 0.0;
        pciSO1.vlocity_cmt__MaxQuantity__c = 5.0;
        pciSO1.vlocity_cmt__IsRootProductChildItem__c = false;
        pciSO1.vlocity_cmt__IsOverride__c = false;
        pciSO1.vlocity_cmt__ChildLineNumber__c = '0001';
        insert pciSO1;
        
        vlocity_cmt__ProductChildItem__c pciSO2 = new vlocity_cmt__ProductChildItem__c();
        pciSO2.vlocity_cmt__ParentProductId__c = productList[300].Id;
        pciSO2.vlocity_cmt__ChildProductId__c = productList[302].Id;
        pciSO2.vlocity_cmt__Quantity__c = 1.0;
        pciSO2.vlocity_cmt__MinQuantity__c = 0.0;
        pciSO2.vlocity_cmt__MaxQuantity__c = 5.0;
        pciSO2.vlocity_cmt__IsRootProductChildItem__c = false;
        pciSO2.vlocity_cmt__IsOverride__c = false;
        pciSO2.vlocity_cmt__ChildLineNumber__c = '0002';
        insert pciSO2;
        UMResolveProductHierarchyBatchJob resolveProductHierarchy = new UMResolveProductHierarchyBatchJob('', '', false, 0);
        resolveProductHierarchy.resolveProductHierearchyItems(null, new List<vlocity_cmt__ProductChildItem__c>{pciSO1, pciSO2});
        
        
        vlocity_cmt__ProductChildItem__c pciSO3 = new vlocity_cmt__ProductChildItem__c();
        pciSO3.vlocity_cmt__ParentProductId__c = productList[300].Id;
        pciSO3.vlocity_cmt__ChildProductId__c = productList[303].Id;
        pciSO3.vlocity_cmt__Quantity__c = 1.0;
        pciSO3.vlocity_cmt__MinQuantity__c = 0.0;
        pciSO3.vlocity_cmt__MaxQuantity__c = 5.0;
        pciSO3.vlocity_cmt__IsRootProductChildItem__c = false;
        pciSO3.vlocity_cmt__IsOverride__c = false;
        pciSO3.vlocity_cmt__ChildLineNumber__c = '0003';
        insert pciSO3;
        
        vlocity_cmt__ProductChildItem__c pciSO4 = new vlocity_cmt__ProductChildItem__c();
        pciSO4.vlocity_cmt__ParentProductId__c = productList[300].Id;
        pciSO4.vlocity_cmt__ChildProductId__c = productList[303].Id;
        pciSO4.vlocity_cmt__Quantity__c = 1.0;
        pciSO4.vlocity_cmt__MinQuantity__c = 0.0;
        pciSO4.vlocity_cmt__MaxQuantity__c = 5.0;
        pciSO4.vlocity_cmt__IsRootProductChildItem__c = false;
        pciSO4.vlocity_cmt__IsOverride__c = false;
        pciSO4.vlocity_cmt__ChildLineNumber__c = '0004';
        insert pciSO4;
        
        resolveProductHierarchy = new UMResolveProductHierarchyBatchJob('', '', false, 0);
        resolveProductHierarchy.resolveProductHierearchyItems(null, new List<vlocity_cmt__ProductChildItem__c>{pciSO3, pciSO4});
        

        
    }  
}