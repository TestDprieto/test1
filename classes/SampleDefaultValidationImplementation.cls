global with sharing class SampleDefaultValidationImplementation  implements vlocity_cmt.GlobalInterfaces.ProductValidationInterface
{

	public static void validateLineItems(List<vlocity_cmt.ItemWrapper> itemsList){
		// NO OP	
		
	system.debug(':::Executed SampleDefaultValidationImplementation');	
	}
}