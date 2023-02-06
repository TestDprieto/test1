public with sharing class QueryAttributeTestClass implements vlocity_cmt.VlocityOpenInterface {
	public Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)	{
		if (methodName.equals('queryTestMethod')) {
			return queryTestMethod(input,output,options);
		} else if (methodName.equals('queryPhoneNumbers')) {
			return queryPhoneNumbers(input,output,options);
		} else if (methodName.equals('queryZipcodes')) {
			return queryZipcodes(input,output,options);
		}
		return true;
	}

	private Boolean queryTestMethod(Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionsMap) {
		List<String> resultList = new List<String>();
		resultList.add('Query result 1');
		resultList.add('Query result 2');
		resultList.add('Query result 3');
		resultList.add('Query result 4');
		resultList.add('Query result 5');
		resultList.add('Query result 6');

		outputMap.put('values', resultList);
		return true;
	}

	private Boolean queryPhoneNumbers(Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionsMap) {
		List<String> resultList = new List<String>();
		resultList.add('415-123-4567');
		resultList.add('415-234-5678');
		resultList.add('415-345-6789');
		resultList.add('415-456-7890');
		resultList.add('650-123-4567');
		resultList.add('650-234-5678');
		resultList.add('650-345-6789');
		resultList.add('650-456-7890');

		outputMap.put('values', resultList);
		return true;
	}

	private Boolean queryZipcodes(Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionsMap) {
		List<String> resultList = new List<String>();
		resultList.add('95135');
		resultList.add('12345');
		resultList.add('85281');
		resultList.add('43567');
		resultList.add('34123');
		resultList.add('94040');
		resultList.add('22312');
		resultList.add('78678');
		resultList.add('87454');
		resultList.add('65221');

		outputMap.put('values', resultList);
		return true;
	}
}