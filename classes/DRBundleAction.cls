global with sharing class DRBundleAction {
    @InvocableMethod(label='Execute')
    global static List<DRBundleActionResult> execute(List<DRBundleActionRequest> requests) {
        try {
            //System.debug(LoggingLevel.ERROR, ' ---- DRBundleActionRequests: ' + requests);
            if(requests != null && requests[0]!= null){
                if(requests[0].action != null && requests[0].bundleName != null){
                    if (requests[0].action == 'Load') {
                        SObject parent = (SObject)vlocity_cmt.FlowStaticMap.flowMap.get('parent');
                        String parentObjName;
                        String parentId;
                        if (parent != null) {
                            parentId = String.valueOf(parent.Id);
                            parentObjName = parent.getSObjectType().getDescribe().getName();
                        }
                        //System.debug(LoggingLevel.ERROR, ' ---- DRBundleAction parentId ' + parentId);
                        //System.debug(LoggingLevel.ERROR, ' ---- DRBundleAction parentObjName ' + parentObjName);

                        if (String.isBlank(parentId)) {
                            System.debug(LoggingLevel.ERROR, ' ---- DRBundleAction parentId is blank.');
                            DRBundleActionResult result = new DRBundleActionResult();
                            result.error = 'parentId is blank';
                            result.hasErrors = true;
                            return new List<DRBundleActionResult>{result};
                        }
                        RestRequest req = new RestRequest();
                        RestResponse res = new RestResponse();

                        req.requestURI = '/v2/DataRaptor/' + requests[0].bundleName + '/';
                        req.addParameter('Id', parentId);

                        RestContext.request = req;
                        RestContext.response = res;

                        vlocity_cmt.DRRestResourceV2.doGet();

                        String resBody = res.responseBody.toString();

                        //System.debug(LoggingLevel.ERROR, ' ---- DRBundleAction DR LOGGER output is ' + resBody);

                        vlocity_cmt.FlowStaticMap.flowMap.put(requests[0].bundleName + '_Load', resBody);
                    }
                    else if (requests[0].action == 'Save') {                        
                        Map<String, Object> objectsToSave = (Map<String, Object>)vlocity_cmt.FlowStaticMap.flowMap.remove(requests[0].bundleName + '_Save');
                        //System.debug(LoggingLevel.ERROR, '---- DRBundleAction objectsToSave ' + JSON.serializePretty(objectsToSave));
                        if (objectsToSave != null && !objectsToSave.isEmpty()) {
                            List<Object> objectList = objectsToSave.values();
                            // set up the request object
                            RestRequest req = new RestRequest();
                            RestResponse res = new RestResponse();

                            req.requestURI = '/v2/DataRaptor/';

                            RestContext.request = req;
                            RestContext.response = res;

                            Map<String, Object> postData = new Map<String, Object>{
                            'bundleName' => requests[0].bundleName,
                            'objectList' => objectList,
                            'bulkUpload' => false
                            };
                            String reqData = JSON.serialize(postData);
                            //System.debug(LoggingLevel.ERROR, '---- DRBundleAction reqData ' + reqData);
                            req.requestBody = Blob.valueOf(reqData);

                            vlocity_cmt.DRRestResourceV2.doPost();

                            String resBody = res.responseBody.toString();

                            //System.debug(LoggingLevel.ERROR, ' ---- DRBundleAction DR Post result ' + resBody);
                        }                        
                    }
                }
            }  
        } catch(Exception e){
              System.debug(LoggingLevel.ERROR, 'Exception is '+e);
              System.debug(LoggingLevel.ERROR, 'Exception stack trace '+e.getStackTraceString());
              DRBundleActionResult result = new DRBundleActionResult();
              result.error = 'Exception: ' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
              result.hasErrors = true;
              return new List<DRBundleActionResult>{result};
         }      
        return new List <DRBundleActionResult>();
    }
    
    global class DRBundleActionRequest {
        
        @InvocableVariable(required=true)
        global String bundleName;

        @InvocableVariable(required=true)
        global String action;
        
    }

    global class DRBundleActionResult {
        @InvocableVariable
        global String error;
        
        @InvocableVariable
        global Boolean hasErrors;

    }
    
    global class DRBundleActionException extends Exception {}
}