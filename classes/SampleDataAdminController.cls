global with sharing class SampleDataAdminController {
    private static String plainNamespace = null;
    public SampleDataAdminController(){
    }
    
    @RemoteAction
    public static Map<String, Object> invokeMethod(String data){

        //System.debug('***data ' + data);
        String drBundle;
        String drBundleResource = 'VLC_SampleDR_OrderItemAttr';
        Map<String, Object> currentStatus = new Map<String, Object>();
        String bundleNamespace = getNamespace();
        List<StaticResource> sr;
        if (String.isNotBlank(bundleNamespace))
            sr = [SELECT Name, Id, Body FROM StaticResource WHERE name =: drBundleResource and NamespacePrefix =: bundleNamespace Limit 1];            
        else
            sr = [SELECT Name, Id, Body FROM StaticResource WHERE name =: drBundleResource Limit 1 ];
        if (sr.size() != 0)
            drBundle = sr[0].Body.toString();
        
        if (drBundle != null) {  
            // Retrieve the namespace of the Vlocity package containing DRDataPackRunnerController class
            String nameSpacePrefix = '';            
            List<ApexClass> classList = [SELECT Name, NameSpacePrefix FROM ApexClass WHERE Name='DRDataPackRunnerController' LIMIT 1];
            if (classList.size() == 0){                               
                if (String.isBlank(nameSpacePrefix)) {
                    currentStatus.put('hasErrors', true);
                    currentStatus.put('errorMessage', 'Error: Namespace for DRDataPackRunnerController not found.');
                    return currentStatus;
                }
            }
            else
                nameSpacePrefix = classList[0].NameSpacePrefix;

            // Replace the vlocity_namespace placeholders with the Vlocity package namespace found
            drBundle = drBundle.replace('%vlocity_namespace%', nameSpacePrefix);
            drBundle = '{\"VlocityDataPackData\": ' + drBundle +  '}';
            System.debug('drBundle ' + drBundle);
            currentStatus = vlocity_cmt.DRDataPackRunnerController.runImport(drBundle);
            System.debug('currentStatus ' + currentStatus);
            do
            {
                currentStatus = vlocity_cmt.DRDataPackRunnerController.runImport(JSON.serialize(currentStatus));
                System.debug('currentStatus ' + JSON.serialize(currentStatus));
            }
            while (currentStatus.get('Status') == 'Ready' || currentStatus.get('Status') == 'InProgress');
            System.debug('done status ' + JSON.serialize(currentStatus));
            currentStatus.put('hasErrors', true);
            currentStatus.put('errorMessage', 'Done. ' + 'Status: ' + currentStatus.get('Status'));
            return currentStatus;
            //System.debug('getAllDataPackData: ' + DRDataPackRunnerController.getAllDataPackData((String)currentStatus.get('VlocityDataPackId')));
        }
        else {
            currentStatus.put('hasErrors', true);
            currentStatus.put('errorMessage', 'Error: '+drBundleResource+' with namespace '+bundleNamespace+' not found.');
        }
        return currentStatus;
    }
    
    @RemoteAction
    public static String getAllCMDataPacks()
    {
    	System.debug(logginglevel.ERROR, '***Get all CM datapacks... ');
    	String dataPackNP = getNamespace();
    	List<StaticResource> cmResources = new List<StaticResource>();
        if (String.isNotBlank(dataPackNP))
            cmResources = [SELECT Name, Id FROM StaticResource WHERE name like 'VLC_SampleCM_%' and NamespacePrefix = :dataPackNP];            
        else
            cmResources = [SELECT Name, Id FROM StaticResource WHERE name like 'VLC_SampleCM_%'];
        return JSON.serialize(cmResources);
    }
    
    @RemoteAction 
    public static Map<String, Object> importCMData(String srName)
    {
    	System.debug(logginglevel.ERROR, '***Importing CMdata ');
        Map<String, Object> currentStatus = new Map<String, Object>();
        String bundleNamespace = getNamespace();
        List<StaticResource> cmResource = new List<StaticResource>();
        if (String.isNotBlank(bundleNamespace))
            cmResource = [SELECT Name, Id, Body FROM StaticResource WHERE name= :srName and NamespacePrefix =: bundleNamespace Limit 1];            
        else
            cmResource = [SELECT Name, Id, Body FROM StaticResource WHERE name= :srName Limit 1];
        if ( cmResource != null && cmResource.size() > 0)
        {
        	 // Retrieve the namespace of the Vlocity package containing DRDataPackRunnerController class
            String nameSpacePrefix = 'vlocity_cmt';            
                         
    		String datapack = cmResource[0].Body.toString();
    		
    		if(String.isNotBlank(datapack))
    		{
    			System.debug(logginglevel.ERROR, 'Importing ' + srName);
    			
    			// Replace the vlocity_namespace placeholders with the Vlocity package namespace found
	            datapack = datapack.replace('%vlocity_namespace%', nameSpacePrefix);
	            datapack = '{\"VlocityDataPackData\": ' + datapack +  '}';
	            
	            currentStatus = vlocity_cmt.DRDataPackRunnerController.runImport(datapack);
	            System.debug(logginglevel.ERROR, 'Importing first batch ' + srName + ' currentStatus ' + JSON.serialize(currentStatus));
	            do
	            {
	                currentStatus = vlocity_cmt.DRDataPackRunnerController.runImport(JSON.serialize(currentStatus));
	                System.debug(logginglevel.ERROR, 'Importing ' + srName + ' currentStatus ' + JSON.serialize(currentStatus));
	            }
	            while (currentStatus.get('Status') == 'Ready' || currentStatus.get('Status') == 'InProgress');
	            System.debug(logginglevel.ERROR, 'done status ' + JSON.serialize(currentStatus));	      
		        currentStatus.put('hasErrors', true);
            	currentStatus.put('errorMessage',  'Done importing ' + srName + '. Status: ' + currentStatus.get('Status'));
           		return currentStatus;               
        	}
        	else
        	{
    			System.debug(logginglevel.ERROR, srName + 'has no contents.');
    			currentStatus.put('hasErrors', true);
            	currentStatus.put('errorMessage',  srName + 'has no contents.'); 
            	return currentStatus;  			
        	} 	       	        	
        }
        else
        {
        	currentStatus.put('hasErrors', true);
        	currentStatus.put('errorMessage', 'Error: No static resource named ' + srName + 'with namespace '+bundleNamespace+' found.');
        }
    	return currentStatus;
    }  

    private static String getNamespace()
    {       
        if (plainNamespace == null)
        {
            String withDotNotation = SampleDataAdminController.class.getName();          
            if (withDotNotation.contains('.'))
                plainNamespace = withDotNotation.substringBefore('.');
            else
                plainNamespace = ''; 
        }
        return plainNamespace;   
    }  
}