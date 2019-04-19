public class ManageJsonStringChallenge {
	public static List<ArticoloComplexJson> responseManager(String response) {
        List<ArticoloComplexJson> output = (List<ArticoloComplexJson>) System.JSON.deserialize(response, List<ArticoloComplexJson>.class);
        return output;
    }
}