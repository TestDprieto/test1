global with sharing class OrderPdfControllerUnmanaged {
	public Order order {get; set;}
  
	public ID orderId {get;set;}
	public String dateTmStr {get;set;}
	
	public String pdfFileName {get;set;}
	public string doSave{get;set;}
	public string ignoredColumns{get;set;}
	
	public string documentLogoUrl {get;set;}
	public List<pLineItem> lineItems {get;set;}
	ApexPages.Standardcontroller cont;
	
	global OrderPdfControllerUnmanaged(ApexPages.StandardController stdController) {
		cont = stdController;
        this.order = (Order)stdController.getRecord();
        orderId = order.Id;

		initializeData();
	//System.debug('::::AfterInitializeData');
    } 
	
	public void initializeData()
	{
		//if (initializedData) return;
		//initializedData = true;
		
       // ignoredColumns = { 'IsDeleted','CreatedDate','CreatedById','LastModifiedDate','LastModifiedById','SystemModstamp','LastActivityDate','CleanStatus' };

		order = getOrder();
		lineItems = getLineItems();	
		
	
	}	
	
	public Order getOrder()
	{
		//Logger.err('getOrder');
       // Set<String> ignoredColumns = new Set<String>{ };

		
        String query = 'Select ';
        Boolean firstField = true;
		for (Schema.SObjectField field : Order.getSobjectType().getDescribe().fields.getMap().values())
        {
           // if (!ignoredColumns.contains(String.valueOf(field)))
           // {
                if (!firstField)
                {
                    query += ',';
                }

                query += String.valueOf(field);

                firstField = false;
            //}
        } 

		query += ',Account.Name';
		query += ',LastModifiedBy.FirstName,LastModifiedBy.LastName';
		query += ',LastModifiedBy.Email';
		query += ',BillToContact.FirstName,BillToContact.LastName';
		query += ',ShipToContact.FirstName,ShipToContact.LastName';
        query += ' FROM Order' ;
        query += ' WHERE Id = \'' + order.Id + '\'';
        query += ' LIMIT ' + 1;
       
        return Database.query(query); 
        
	}
	 
	public List<pLineItem> getLineItems() 
     {	
		//Logger.err('getLineItems');
    	//String nsp = ApplicationUtilities.getNamespacePrefix();
    		if(lineItems == null) {
				lineItems = new List<pLineItem>();
				for (OrderItem li: [Select Id,
        						vlocity_cmt__LineNumber__c,
        						PriceBookEntry.Product2.Name,
        						PriceBookEntry.Product2.ProductCode,
        						PriceBookEntry.Product2.Id,
        						ListPrice,
        						UnitPrice,
        						Quantity,
                                vlocity_cmt__OneTimeCharge__c,
        						vlocity_cmt__OneTimeCalculatedPrice__c,
        						vlocity_cmt__OneTimeManualDiscount__c,
        						vlocity_cmt__OneTimeDiscountPrice__c,
        						vlocity_cmt__OneTimeTotal__c,
        						
        						vlocity_cmt__RecurringCharge__c,
        						vlocity_cmt__RecurringCalculatedPrice__c,
        						vlocity_cmt__RecurringManualDiscount__c,
        						vlocity_cmt__RecurringDiscountPrice__c,
        						vlocity_cmt__RecurringTotal__c,

        						vlocity_cmt__ProvisioningStatus__c,
        						vlocity_cmt__ServiceAccountId__r.Name,
        						vlocity_cmt__BillingAccountId__r.Name,
        						vlocity_cmt__JSONAttribute__c
        						FROM OrderItem 
        						WHERE OrderId = :order.Id  
        						ORDER BY vlocity_cmt__LineNumber__c])  {
    	 				lineItems.add(new pLineItem(li));
   					 }
    		}  
			return lineItems;
    }		

	// pLineItem is wrapper	
	public class pLineItem {
		public OrderItem li {get; set;}
		public String indentSpace {get; set;}
	
	// Constructor for pLineItem
		public pLineItem(OrderItem ordItem) {
			li = ordItem;
	
			if (li.vlocity_cmt__LineNumber__c == null){
	System.debug('::::In if null');	
				indentSpace='';
			}
			else{
	System.debug('::::LineNumber:'+ li.vlocity_cmt__LineNumber__c + ':end');	
				integer sz = li.vlocity_cmt__LineNumber__c.countMatches('.');
		
				if (sz > 0){
				//indentSpace = '&nbsp;';
					sz *= 3;
					indentSpace = padSpace(sz);
					indentSpace += '&bull;&nbsp;';
				} else {
					indentSpace='';
				}
			}
		}
	}

	public static String padSpace(Integer i) {
		String str = '';

		for( integer j=0; j < i; j++) {
			str += '&nbsp;' ;
		}
	System.debug('::::str:'+ str + 'end');			
		return str;
	} 		

	public PageReference savePdf(){
      if(doSave == 'No'){
        return null;
      }
          
         initializeData();
System.debug('::::AfterInitializeData');

      PageReference pagePdf = new PageReference('/apex/OrderPdf');
System.debug('::::in savePDF');
          pagePdf.getParameters().put('id', Order.Id);
          pagePdf.getParameters().put('doSave', 'No');
          Blob pdfPageBlob;
          if (Test.isRunningTest()){
          		String strUrlUTF8 = EncodingUtil.urlEncode('Test', 'UTF-8');
          		
          		pdfPageBlob = Blob.valueOf(strUrlUTF8);
 System.debug('Blob: [' + pdfPageBlob.toString() + ']');
          } else {
          	   	pdfPageBlob = pagePdf.getContentAsPDF();
          }
          
          Datetime dateTm = Datetime.now();
		  dateTmStr = dateTm.format();
          pdfFileName = 'PDF_' + dateTmStr + '.pdf';
                 
          Attachment a = new Attachment();
          a.Body = pdfPageBlob;
          a.ParentID = Order.Id;
          a.Name = pdfFileName;
          a.Description = 'PDF';
          insert a;
      return new PageReference('/' + Order.Id);
      //return pageRef;
    }		

		

}