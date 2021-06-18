global with sharing class CPQSubmitFlowImplementation implements vlocity_cmt.VlocityOpenInterface{
    global Flow.Interview.CPQSubmitFlow myFlow {get; set;}
	global Boolean invokeMethod(String methodName, 
		Map<String, Object> input, 
		Map<String, Object> output, 
		Map<String, Object> options)	
	{
		if (methodName.equals('cpqSubmit')){
			return cpqSubmit(input,output);
		}
		return false;
	}
    public Boolean cpqSubmit(	Map<String, Object> inp, 
								Map<String, Object> outp  ){
		Map<String, Object> myMap = new Map<String, Object>();
		Map<String, Object> inputMap = new Map<String, Object>();
		InputMap.put('objectId', inp.get('objectId'));
		InputMap.put('action', inp.get('action'));
		vlocity_cmt.FlowStaticMap.flowMap.put('inputMap', inputMap);
		myFlow = new Flow.Interview.CPQSubmitFlow(myMap);
      
		try {
			myFlow.start();
			Object oc = (Object)vlocity_cmt.FlowStaticMap.flowMap.get('objectCopier');
			outp.put('objectCopier',oc);
		    return true; 
		} catch (System.FlowException e){
			System.debug(LoggingLevel.ERROR, 'System.FlowException: ' + e);
			return null;
		}		
	}
}