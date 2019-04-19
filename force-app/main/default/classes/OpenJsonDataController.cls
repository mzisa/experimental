public class OpenJsonDataController {
	@RemoteAction
	public static List<ArticoloJson> getFattureComplete() {
		PageReference pr = new PageReference('/resource/TestJson/TestResponse/Fatture.json');
        String requestBody = pr.getContent().toString();
		List<ArticoloJson> retValue = ManageJsonString.responseManager(requestBody);
		return retValue;
	}
}