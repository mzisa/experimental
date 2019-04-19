public class ExportToJsonButtonController {
    private final ApexPages.StandardController theController;
    
    public ExportToJsonButtonController(ApexPages.StandardController stdController) {
        theController = stdController;
	}
    
	public void autoRun() {
        String theId = ApexPages.currentPage().getParameters().get('id');
        AccountForJson.doSerialize(new AccountForJson(theId));
	}
}