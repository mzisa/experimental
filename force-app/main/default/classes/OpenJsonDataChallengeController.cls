public class OpenJsonDataChallengeController {
	@RemoteAction
	public static List<ArticoloComplexJson> getFattureComplete() {
		PageReference pr = new PageReference('/resource/TestJsonComplex/TestResponse/FatturaJsonComplex.json');
        String requestBody = pr.getContent().toString();
		List<ArticoloComplexJson> retValue = ManageJsonStringChallenge.responseManager(requestBody);
		return retValue;
	}
}