public class OpenXmlDataController {
	@RemoteAction
	public static List<Articolo> getFattureComplete() {
		PageReference pr = new PageReference('/resource/TestXml/TestResponse/dataset.xml');
        String requestBody = pr.getContent().toString();
		List<Articolo> retValue = ManageXmlString.responseManager(requestBody,'record');
		return retValue;
	}
}